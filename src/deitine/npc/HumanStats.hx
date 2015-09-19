package deitine.npc;

import tannus.math.TMath in Nums;
import tannus.math.Percent;
import tannus.math.Random;
import tannus.ds.IntRange;
import tannus.ds.FloatRange;

import deitine.ds.skills.*;
import deitine.core.Caps.*;

import haxe.Serializer;
import haxe.Unserializer;

using tannus.math.TMath;

class HumanStats {
	/* Constructor Function */
	public function new(human : Human):Void {
		var r:Random = new Random();
		
		strength = new Skill(human);
		speed = new Skill(human);
		awareness = new Skill(human);
		intelligence = new Skill(human);
		charisma = new Skill(human);

		doubt = 0;
		exhaustion = 0;
		hunger = 0;

		instability = new Percent(r.randint(0, MAX_VARIATION));
		rationality = new Percent(r.randint(0, MAX_STAT_BASE));
		happiness = new Percent(r.randint(0, MAX_STAT_BASE));
		productivity = new Percent(r.randint(0, MAX_STAT_BASE));
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
		add(instability);
		add(rationality);
		add(productivity);

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
		instability = g();
		rationality = g();
		productivity = g();

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
	private inline function get_happy() return (happiness.value >= 0);

	/**
	  * Whether the Human is tired
	  */
	public var tired(get, never) : Bool;
	private inline function get_tired() return (exhaustion > TIRED_THRESHOLD);

	/**
	  * Maximum amount that the Human can carry
	  */
	public var max_carry(get, never) : Int;
	private inline function get_max_carry() {
		return (strength.level * 10);
	}

/* === Instance Fields === */

	/* == Mental State == */

	/* How doubtful the Human is */
	public var doubt : Int;

	/* The exhaustion attribute of a Human */
	public var exhaustion : Int;
	
	/* How hungry the Human is */
	public var hunger : Int;

	/* how productive the Human is */
	public var productivity : Percent;
	
	/* The 'happiness' attribute of a Human */
	public var happiness : Percent;

	/* The 'instability' of a Human */
	public var instability : Percent;

	/* How 'rational' the Human is */
	public var rationality : Percent;

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
	private static inline var MAX_VARIATION:Int = 50;
}
