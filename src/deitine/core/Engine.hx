package deitine.core;

import tannus.io.Signal;
import tannus.io.Ptr;
import tannus.io.EventDispatcher;
import tannus.ds.Promise;
import tannus.ds.promises.*;

import deitine.time.Clock;
import deitine.time.GameDate;

class Engine extends EventDispatcher {
	/* Constructor Function */
	public function new():Void {
		super();

		if (instance == null) {
			clock = new Clock( SECOND );
			date = new GameDate(0, 0, 0);
			launch = new Signal();
			shutdown = new Signal();
			tick = new Signal();

			instance = this;

			__init();
		}
		else throw 'EngineError: Cannot create multiple instances of deitine.core.Engine!';
	}

/* === Instance Methods === */

	/**
	  * Initialize [this] Engine
	  */
	private function __init():Void {
		clock.onTick( clockTick );
	}

	/**
	  * Start [this] Engine
	  */
	public function start():Void {
		clock.start();

		launch.call( this );
	}

	/**
	  * Stop [this] Engine
	  */
	public function stop():Void {
		clock.stop();

		shutdown.call( this );
	}

	/**
	  * Method called for each 'tick' of [clock]
	  */
	private function clockTick(d : Int):Void {
		date.minutes += 1;

		tick.call( date );
	}

/* === Instance Fields === */

	private var clock : Clock;

	public var date : GameDate;
	public var launch : Signal<Engine>;
	public var shutdown : Signal<Engine>;
	public var tick : Signal<GameDate>;

/* === Static Fields === */

	public static var instance : Null<Engine> = null;

	public static var SECOND:Int = 1000;
}
