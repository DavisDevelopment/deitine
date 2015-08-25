package deitine.npc;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.io.EventDispatcher;
import tannus.ds.Maybe;

import deitine.ds.Action;
import deitine.core.Entity;
import deitine.core.EntityContainer;
import deitine.time.GameDate;
import deitine.npc.Human;

using StringTools;
using Lambda;

class Village extends EntityContainer {
	/* Constructor Function */
	public function new(p : Int):Void {
		super();

		villagers = new Array();
		_pop = state.field('population');
		_pop.set( p );

		for (i in 0...p) {
			addVillager(Human.create());
		}
	}

/* === Instance Methods === */

	/**
	  * Occurs every 'day' (in game time)
	  */
	override public function day(d : GameDate):Void {
		trace('Day has passed');
		for (v in villagers) {
			v.day( d );
		}
	}

	/**
	  * Add a Villager into [this] Village
	  */
	public inline function addVillager(h : Human):Void {
		villagers.push( h );
	}

/* === Computed Instance Fields === */

	/**
	  * The population of [this] VIllage
	  */
	public var population(get, set) : Int;
	private inline function get_population() return _pop.get();
	private inline function set_population(v : Int) {
		return _pop.set(v);
	}

/* === Instance Fields === */

	private var _pop : Ptr<Int>;
	private var villagers : Array<Human>;
}
