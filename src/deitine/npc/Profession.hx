package deitine.npc;

import deitine.npc.work.*;

using tannus.math.RandomTools;

@:enum
abstract Profession (Int) from Int to Int {
/* === Constructs === */

	var Priest = 0;
	var Woodcutter = 1;
	var Hunter = 2;
	var Scavenger = 3;

/* === Methods === */

	/**
	  * Cast [this] Profession to a String
	  */
	@:to
	public inline function toString():String {
		var p:Profession = this;
		return switch ( p ) {
			case Priest: 'Priest';
			case Woodcutter: 'Woodcutter';
			case Hunter: 'Hunter';
			case Scavenger: 'Scavenger';
		}
	}

	/**
	  * Get the class for [this] Profession
	  */
	public inline function getClass():Class<Job> {
		var p:Profession = this;
		switch ( p ) {
			case Priest:
				return Preaching;

			case Woodcutter:
				return Woodcutting;

			case Hunter:
				return Hunting;

			case Scavenger:
				return Scavenging;

			default:
				return Job;
		}
	}

	/**
	  * Get the constructor function for the Class for [this] Profession
	  */
	public inline function getConstructor():Human->Job {
		var klass = getClass();
		var arrf = Type.createInstance.bind(klass, _);
		return untyped Reflect.makeVarArgs(arrf);
	}

	/**
	  * Get all Constructs of [this] Enum
	  */
	public static inline function all():Array<Profession> {
		return [
			Priest,
			Woodcutter,
			Hunter,
			Scavenger
		];
	}

	/**
	  * Pick a Random Profession
	  */
	public static inline function random():Profession {
		return all().choice();
	}
}
