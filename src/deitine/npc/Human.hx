package deitine.npc;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.ds.Maybe;

import deitine.core.Entity;
import deitine.time.GameDate;
import deitine.npc.HumanData;

class Human extends Entity {
	/* Constructor Function */
	public function new(data : HumanData):Void {
		super();

		base_faith = data.base_faith;
	}

/* === Instance Methods === */

	/**
	  * Method to be invoked daily
	  */
	override public function day(d : GameDate):Void {
		trace('Villager has lived for a day');
	}

/* === Instance Fields === */

	private var base_faith : Int;

/* === Static Methods === */

	/**
	  * Create a new Human
	  */
	public static function create():Human {
		var r = new tannus.math.Random();

		var data = {
			'base_faith': r.randint(1, 3)
		};
		return new Human( data );
	}
}
