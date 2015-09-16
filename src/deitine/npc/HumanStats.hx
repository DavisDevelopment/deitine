package deitine.npc;

import tannus.math.TMath in Nums;

import deitine.ds.skills.*;

class HumanStats {
	/* Constructor Function */
	public function new():Void {
		strength = new Skill();

		doubt = 0;
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

	/* How doubtful the Human is */
	public var doubt : Int;

	/* How Strong the Human is */
	public var strength : Skill;

	/* The 'happiness' attribute of a Human */
	public var happiness : Int;

	/* The exhaustion attribute of a Human */
	public var exhaustion : Int;
	
	/* How hungry the Human is */
	public var hunger : Int;

/* === Constants === */

	private static inline var TIRED_THRESHOLD:Int = 5;
}
