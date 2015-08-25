package deitine.npc;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.ds.Maybe;

import deitine.core.Entity;
import deitine.time.GameDate;
import deitine.npc.HumanData;
import deitine.ds.Income;

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
		super.day(d);
	}

	/**
	  * Get the 'Income' of [this] Human
	  */
	public function income():Income {
		var i = new Income();

		i.addFaith( faith );

		return i;
	}

/* === Computed Instance Fields === */

	/**
	  * Get the faith-output of [this] Human
	  */
	public var faith(get, never):Int;
	private inline function get_faith():Int {
		return base_faith;
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
