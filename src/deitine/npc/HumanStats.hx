package deitine.npc;

import tannus.math.TMath in Nums;

class HumanStats {
	/* Constructor Function */
	public function new():Void {
		happiness = 0;
		exhaustion = 0;
	}

/* === Computed Instance Fields === */

	/**
	  * Whether the Human is happy
	  */
	public var happy(get, never) : Bool;
	private inline function get_happy() return (happiness >= 0);

	/**
	  * Whether the Human is tired
	  */
	public var tired(get, never) : Bool;
	private inline function get_tired() return (exhaustion > TIRED_THRESHOLD);

/* === Instance Fields === */

	/* The 'happiness' attribute of a Human */
	public var happiness : Int;

	/* The exhaustion attribute of a Human */
	public var exhaustion : Int;

/* === Constants === */

	private static inline var TIRED_THRESHOLD:Int = 10;
}
