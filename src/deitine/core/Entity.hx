package deitine.core;

import tannus.io.Ptr;
import tannus.io.Getter;
import tannus.io.Signal;
import tannus.io.EventDispatcher;
import tannus.nore.Selector in Sel;
import tannus.ds.Destructible;

import deitine.time.GameDate;
import deitine.core.Engine;
import deitine.core.Component;
import deitine.ds.State;

class Entity extends EventDispatcher implements Destructible {
	/* Constructor Function */
	public function new():Void {
		super();
		state = new State();
		components = new Array();

		addSignal('day');
		addSignal('update');
	}

/* === Instance Methods === */

	/**
	  * Method fired every in-game day
	  */
	public function day(date : GameDate):Void {
		dispatch('day', date);
	}

	/**
	  * Update [this] Entity
	  */
	public function update():Void {
		dispatch('update', null);
	}

	/**
	  * Delete [this] Entity
	  */
	public function destroy():Void {
		for (c in components) {
			c.destroy();
		}
	}

	/**
	  * Determine whether [this] Entity matches the given ORegEx
	  */
	public function is(sel : String):Bool {
		return (new Sel(sel)).test( this );
	}

	/**
	  * Attach a Component to [this]
	  */
	public function attach<T:Component>(klass : Class<T>):T {
		var comp:T = Type.createInstance(klass, [this]);
		components.push(cast comp);
		return comp;
	}

	/**
	  * Detach a Component from [this]
	  */
	public function detach(comp : Component):Bool {
		var had:Bool = components.remove(comp);
		if (had)
			comp.destroy();
		return had;
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
	private var components : Array<Component>;
}
