package deitine.ds.perks;

import deitine.ds.Perk;

class PaidPerk extends Perk {
	/* Constructor Function */
	public function new():Void {
		super();
		
		price = 0;
	}

/* === Instance Methods === */

	/**
	  * Methods invoked when a Perk is purchased
	  */
	public function buy():Void {
		trace('Purchased $name for ${price}fp');
	}

/* === Instance Fields === */

	public var price : Int;
}
