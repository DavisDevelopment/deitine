package deitine.npc;

import tannus.math.TMath in Nums;

import deitine.ds.skills.*;

import haxe.Serializer;
import haxe.Unserializer;

class HumanStats {
	/* Constructor Function */
	public function new():Void {
		strength = new Skill( Strength );
		speed = new Skill( Speed );
		awareness = new Skill( Awareness );
		intelligence = new Skill( Intelligence );
		charisma = new Skill( Charisma );

		doubt = 0;
		happiness = 0;
		exhaustion = 0;
	}

	/**
	  * Serialize Stats
	  */
	@:keep
	public function hxSerialize(s : Serializer) {
		var add = s.serialize.bind();
		add(doubt);
		add(happiness);
		add(exhaustion);
		add(hunger);

		add(strength);
		add(speed);
		add(awareness);
		add(intelligence);
		add(charisma);
	}

	/**
	  * Deserialize Stats
	  */
	@:keep
	public function hxUnserialize(u : Unserializer) {
		var g = u.unserialize.bind();

		doubt = g();
		happiness = g();
		exhaustion = g();
		hunger = g();

		strength = g();
		speed = g();
		awareness = g();
		intelligence = g();
		charisma = g();
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

	/* == Mental State == */

	/* How doubtful the Human is */
	public var doubt : Int;

	/* The 'happiness' attribute of a Human */
	public var happiness : Int;

	/* The exhaustion attribute of a Human */
	public var exhaustion : Int;
	
	/* How hungry the Human is */
	public var hunger : Int;

	/* == Skills == */

	/* How Strong the Human is */
	public var strength : Skill;

	/* How Fast the Human is */
	public var speed : Skill;

	/* How alert the Human is */
	public var awareness : Skill;
	
	/* How intelligent the Human is */
	public var intelligence : Skill;

	/* How charismatic the Human is */
	public var charisma : Skill;

/* === Constants === */

	private static inline var TIRED_THRESHOLD:Int = 5;
}
