package deitine.npc;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.ds.Maybe;
import tannus.ds.Value;
import tannus.ds.Ref;
import tannus.math.Percent;
import tannus.math.Random;

import deitine.core.Entity;
import deitine.time.GameDate;
import deitine.npc.HumanData;
import deitine.ds.Inventory;
import deitine.npc.Profession;
import deitine.npc.work.Job;
import deitine.npc.HumanStats in Stats;

using tannus.math.RandomTools;

class Human extends Entity {
	/* Constructor Function */
	public function new(data : HumanData):Void {
		super();

		//- Create the Human's Stats
		stats = data.stats;

		//- Human's total faith (as a Value)
		state.set('faith', data.base_faith);
		vfaith = Value.create(state.get('faith'));

		//- Human's profession
		profession = data.profession;
		state.set('profession', profession);

		//- Human's Job
		job = profession.getConstructor()(this);

		//- Human's current age
		current_age = state.field('current_age');
		current_age &= data.current_age;

		//- Human's current level
		lvl = state.field('lvl');
		lvl &= data.level;

		//- Human's current xp
		exp = state.field('xp');
		exp &= data.experience;

		//- Human's maximum age
		max_age = data.max_age;

		/* == Breeding == */
		since_last_breed = 0;

		/* == Initialization Methods == */
		prepareValues();
	}

/* === Instance Methods === */
	
	/**
	  * Prepare all Values associated with [this] Human
	  */
	private function prepareValues():Void {
		null;
	}

	/**
	  * Method to be invoked daily
	  */
	override public function day(d : GameDate):Void {
		/* Increase human's age by one day */
		/*
		age += 1;
		if (age >= max_age) {
			die();
		}
		*/

		/* Breeding System */
		if (engine.player.hasPerk('breeding')) {
			if (since_last_breed == 30) {
				/* A 1 in 10 chance to become pregnant */
				var preggers:Bool = ([0, 10].randint() == 1);

				if (preggers) {
					var vill:deitine.npc.Village = cast engine.query('deitine.npc.Village')[0];
					var child:Human = create();
					child.profession = profession;
					vill.addVillager( child );
				}
			}
			else 
				since_last_breed++;
		}

		/* Contribute daily income */
		var inv:Inventory = engine.player.inv;
		work(inv, engine.daysSinceLastPlayed);

		/* == End of Day Stuff == */
		sleep();
	}

	/**
	  * Have [this] Human perform their Job
	  */
	public function work(inc:Inventory, days:Int=1):Inventory {

		job.perform(inc, days);
		inc.faith += (faith * days);
		
		return inc;
	}

	/**
	  * Human goes to bed
	  */
	private function sleep():Void {
		stats.exhaustion -= 2;
	}

	/**
	  * Get the data for [this] Human
	  */
	public function data():HumanData {
		return {
			'base_faith': state.get('faith'),
			'profession': profession,
			'max_age': max_age,
			'current_age': current_age,
			'level': level,
			'experience': 0,
			'stats': stats
		};
	}

	/**
	  * [this] Human dies
	  */
	public function die():Void {
		engine.player.village.removeVillager( this );
	}

	/**
	  * [this] Human has reached the next level
	  */
	public function levelUp():Void {
		dispatch('level-up', level);
		lvl.value += 1;

		trace('A $profession has leveled up to level $level!');
	}

/* === Computed Instance Fields === */

	/**
	  * Get the faith-output of [this] Human
	  */
	public var faith(get, never):Int;
	private function get_faith():Int {
		return vfaith;
	}

	/**
	  * Get/Set the Profession of [this] Human
	  */
	/*
	public var profession(get, set):Profession;
	private inline function get_profession() return _prof.get();
	private inline function set_profession(v : Profession) return _prof.set( v );
	*/

	/**
	  * Get the age of [this] Human (in days)
	  */
	public var age(get, set):Int;
	private inline function get_age() return current_age.get();
	private inline function set_age(v : Int) return current_age.set( v );

	/**
	  * The level of [this] Human
	  */
	public var level(get, never):Int;
	private inline function get_level() return lvl.get();

	/**
	  * The number of xp (experience points) [this] Human has
	  */
	public var xp(get, set) : Int;
	private function get_xp():Int {
		return exp;
	}
	private function set_xp(v : Int):Int {
		var max_xp:Int = (20 * level);

		if (v >= max_xp) {
			v -= max_xp;
			levelUp();
		}
		return (exp &= v);
	}

	/**
	  * Get the xp gained by doing one's Job
	  */
	public var job_xp(get, never) : Int;
	private function get_job_xp():Int {
		return 10;
	}

/* === Instance Fields === */

	private var vfaith : Value<Int>;
	private var current_age : Ptr<Int>;
	private var lvl : Ptr<Int>;
	private var exp : Ptr<Int>;
	private var max_age : Int;

	/* == Perk-Specific Fields == */
	private var since_last_breed : Int;

	public var stats : Stats;
	public var job : Job;
	public var profession : Profession;

/* ==== Static Fields === */

/* === Static Methods === */

	/**
	  * Create a new Human
	  */
	public static function create():Human {
		var r = new tannus.math.Random();

		var data = {
			'base_faith': r.randint(1, 3),
			'profession': Profession.random(),
			'current_age': 0,
			'max_age': ([75, 105].randint() * 365),
			'level': 1,
			'experience': 0,
			'stats' : new Stats()
		};

		/* Ensure that the randomly selected Profession is a valid choice */
		while (data.profession == Profession.Priest) {
			data.profession = Profession.random();
		}

		return new Human( data );
	}
}
