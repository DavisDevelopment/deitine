package deitine.core;

import deitine.core.Engine;
import deitine.core.Entity;
import deitine.npc.Village;
import deitine.ds.Income;

import tannus.ds.Object;

class Player extends Entity {
	/* Constructor Function */
	public function new():Void {
		super();

		village = (cast engine.query('"deitine.npc.Village"')[0]);
		faith = 0;
	}

/* === Instance Methods === */

	/**
	  * Assimilate some Income into [this]
	  */
	public function acceptIncome(inc : Income):Void {
		faith += inc.getFaith();
	}

	/**
	  * Method to be invoked daily
	  */
	override public function day(g : deitine.time.GameDate):Void {
		if (village == null)
			village = (cast engine.query('"deitine.npc.Village"')[0]);
		dispatch('day', g);
	}

/* === Computed Instance Fields === */

	/**
	  * The number of Followers [this] God has
	  */
	public var followers(get, never):Int;
	private inline function get_followers() return village.population;

	/**
	  * Inventory
	  */
	public var inventory(get, never):Object;
	private function get_inventory():Object {
		return {
			'followers': followers,
			'faith' : faith
		};
	}

/* === Instance Fields === */

	public var village : Village;
	public var faith : Int;
}
