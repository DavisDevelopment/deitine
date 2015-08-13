package deitine.time;

import haxe.Timer;
import tannus.io.Signal;
import tannus.ds.Maybe;

class Clock {
	/* Constructor Function */
	public function new(framerate : Int):Void {
		rate = framerate;
		tick = new Signal();
		lastTick = null;
		timer = null;
	}

/* === Instance Methods === */

	/**
	  * Start [this] Clock
	  */
	public function start():Void {
		timer = new Timer(rate);
		timer.value.run = run;
	}

	/**
	  * Stop [this] Clock
	  */
	public function stop():Void {
		if (timer.exists)
			timer.value.stop();
	}

	/**
	  * Listen for "tick" events on [this] Clock
	  */
	public inline function onTick(action : Int->Void):Void {
		tick.listen( action );
	}

	/**
	  * Listen only for the next "tick" event
	  */
	public inline function onNextTick(action : Int->Void) tick.once(action);

	/**
	  * Method called for every "tick" of [this] Clock
	  */
	private function run():Void {
		var delta:Int = (lastTick.exists?(lastTick.value - currentTime):0);
		tick.call( delta );
		lastTick = currentTime;
	}

/* === Computed Instance Fields === */

	/**
	  * The current time
	  */
	private var currentTime(get, never):Int;
	private inline function get_currentTime() return (Math.round(Date.now().getTime()));

/* === Instance Fields === */

	private var rate : Int;
	public var tick : Signal<Int>;
	private var lastTick : Maybe<Int>;
	private var timer : Maybe<Timer>;
}
