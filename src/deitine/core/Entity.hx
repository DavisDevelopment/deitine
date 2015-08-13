package deitine.core;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.io.EventDispatcher;

import deitine.time.GameDate;
import deitine.core.Engine;

class Entity extends EventDispatcher {
	/* Constructor Function */
	public function new():Void {
		super();
	}

/* === Instance Methods === */

	/**
	  * Method fired every time the Engine 'update's
	  */
	public function tick(date : GameDate):Void {
		null;
	}

/* === Computed Instance Fields === */

	/**
	  * The engine
	  */
	public var engine(get, never):Engine;
	private inline function get_engine() return cast Engine.instance;

/* === Instance Fields === */

	private var id : String;
}
