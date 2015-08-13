package deitine.npc;

import deitine.time.GameDate;
import deitine.core.Entity;

import deitine.npc.HumanName;
import deitine.npc.HumanData;
import deitine.npc.Gender;

using tannus.math.RandomTools;

class Human extends Entity {
	/* Constructor Function */
	public function new(dat : HumanData):Void {
		super();

		id = dat.id;
		trace(dat.name);
		name = dat.name;
		gender = dat.gender;
		birth_date = dat.birth_date;
	}

/* === Instance Methods === */

	/**
	  * Actions to take per-frame
	  */
	override public function tick(date : GameDate):Void {
		null;
	}

/* === Computed Instance Fields === */

	/**
	  * The data of [this] Human
	  */
	public var data(get, never):HumanData;
	private inline function get_data() {
		return new HumanData({
			'id': id,
		       	'gender': gender,
			'name': name.toString(),
		        'birth_date': birth_date.toInt()
		});
	}

/* === Instance Fields === */

	public var gender : Gender;
	public var name : HumanName;
	public var birth_date : GameDate;

/* === Static Methods === */

	/**
	  * Create a new Human
	  */
	public static function create():Human {
		var g:Gender = [Male, Female].choice();
		var data:HumanData = new HumanData({
			'name': [Names.randomFirst( g ), Names.randomFirst(g), 'Doe'].join(' '),
		    	'gender': g,
		    	'id': '1',
		    	'birth_date': deitine.core.Engine.instance.date.toInt()
		});

		return new Human( data );
	}
}
