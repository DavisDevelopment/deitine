package deitine.npc;

import deitine.time.GameDate;

import deitine.npc.HumanName;
import deitine.npc.Gender;

@:forward
abstract HumanData (THumanData) from THumanData {
	/* Constructor Function */
	public inline function new(td : THumanData) {
		this = td;
	}

/* === Instance Fields === */

	/**
	  * The name of [this] Human
	  */
	public var name(get, set):HumanName;
	private inline function get_name() return HumanName.fromString( this.name );
	private inline function set_name(v : HumanName):HumanName {
		this.name = v.toString();
		return name;
	}

	/**
	  * The date-of-birth of [this] Human
	  */
	public var birth_date(get, set):GameDate;
	private inline function get_birth_date():GameDate {
		return this.birth_date;
	}
	private inline function set_birth_date(v : GameDate):GameDate {
		this.birth_date = v;
		return birth_date;
	}
}

typedef THumanData = {
	var id : String;
	var gender : Gender;
	var name : String;
	var birth_date : Int;
};
