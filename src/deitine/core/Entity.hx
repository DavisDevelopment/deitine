package deitine.core;

import tannus.io.Ptr;
import tannus.io.Getter;
import tannus.io.Signal;
import tannus.io.EventDispatcher;
import tannus.nore.Selector in Sel;

import deitine.time.GameDate;
import deitine.core.Engine;
import deitine.ds.State;

class Entity extends EventDispatcher {
	/* Constructor Function */
	public function new():Void {
		super();
		state = new State();
	}

/* === Instance Methods === */

	/**
	  * Method fired every in-game day
	  */
	public function day(date : GameDate):Void {
		trace('Another day ends..');
	}

	/**
	  * Determine whether [this] Entity matches the given ORegEx
	  */
	public function is(sel : String):Bool {
		return (new Sel(sel)).test( this );
	}

/* === Computed Instance Fields === */

	/**
	  * The engine
	  */
	public var engine(get, never):Engine;
	private inline function get_engine() return cast Engine.instance;

/* === Instance Fields === */

	private var id : String;
	private var state : State;
}
