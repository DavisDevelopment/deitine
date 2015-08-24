package deitine.time;

import tannus.math.Percent;
import tannus.io.Signal;

import tannus.ds.tuples.Tup2;

import haxe.Timer;

class Cooldown {
	/* Constructor Function */
	public function new(d : Int):Void {
		duration = d;
		running = false;
		step = new Signal();
		complete = new Signal();
		cancel = new Signal();
	}

/* === Instance Methods === */

	/**
	  * Start the Cooldown
	  */
	public function start():Void {
		if (!running) {
			start_ms = ms();
			running = true;
			timer = new Timer( 75 );
			timer.run = _tick;
		}
	}

	/**
	  * Abort the cooldown
	  */
	public function stop():Void {
		if (running) {
			running = false;
			timer.stop();
			cancel.call(ms());
		}
	}

	/**
	  * Do per-tick stuff
	  */
	private function _tick():Void {
		var p:Percent = Percent.percent((ms() - start_ms), duration);
		var r:Int = (duration - (ms() - start_ms));
		
		if (p.value >= 100) {
			timer.stop();
			running = false;
			complete.call(ms());
		}
		else {
			step.call(new CdStatus(p, r));
		}
	}

	/**
	  * Get milliseconds
	  */
	private inline function ms():Int return Math.floor(Date.now().getTime());

/* === Instance Fields === */

	public var duration : Int;
	public var running : Bool;
	public var step : Signal<CdStatus>;
	public var complete : Signal<Int>;
	public var cancel : Signal<Int>;

	private var timer : Timer;
	private var start_ms : Int;
}

/* Abstract type to represent the 'status' of [this] Cooldown */
abstract CdStatus (Tup2<Percent, Int>) {
	public inline function new(p:Percent, r:Int):Void this = new Tup2(p, r);

	public var progress(get, never):Percent;
	private inline function get_progress() return this._0;

	public var remaining(get, never):Int;
	private inline function get_remaining() return this._1;
}
