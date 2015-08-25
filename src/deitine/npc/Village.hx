package deitine.npc;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.io.EventDispatcher;
import tannus.ds.Maybe;

import deitine.ds.Action;
import deitine.ds.Income;
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

		for (i in 0...p) {
			addVillager(Human.create());
		}
	}

/* === Instance Methods === */

	/**
	  * Occurs every 'day' (in game time)
	  */
	override public function day(d : GameDate):Void {
		super.day(d);
		
		for (v in villagers) {
			v.day( d );
		}

		var income = calculateIncome();
		engine.player.acceptIncome( income );
	}

	/**
	  * Add a Villager into [this] Village
	  */
	public inline function addVillager(h : Human):Void {
		villagers.push( h );
	}

	/**
	  * Get the overall income of the Village
	  */
	public function calculateIncome():Income {
		var inc:Income = new Income();

		for (v in villagers)
			inc += v.income();

		return inc;
	}

/* === Computed Instance Fields === */

	/**
	  * The population of [this] VIllage
	  */
	public var population(get, never) : Int;
	private inline function get_population() return villagers.length;

/* === Instance Fields === */

	private var villagers : Array<Human>;
}
