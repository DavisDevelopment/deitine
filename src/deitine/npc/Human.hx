package deitine.npc;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.ds.Maybe;
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

		stats = data.stats;
		trace( stats );

		base_faith = state.field('base_faith');
		base_faith &= data.base_faith;

		_prof = state.field('profession');
		_prof &= data.profession;

		current_age = state.field('current_age');
		current_age &= data.current_age;

		lvl = state.field('lvl');
		lvl &= data.level;

		exp = state.field('xp');
		exp &= data.experience;

		max_age = data.max_age;

		/* == Breeding == */
		since_last_breed = 0;
	}

/* === Instance Methods === */

	/**
	  * Method to be invoked daily
	  */
	override public function day(d : GameDate):Void {
		age += 1;
		if (age >= max_age) {
			die();
		}

		/* Breeding System */
		if (breedable) {
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
	}

	/**
	  * Get the 'Income' of [this] Human
	  */
	public function income(inc:Inventory, days:Int=1):Inventory {
		var job:Job = profession.getConstructor()(this);
		job.perform(inc, days);
		inc.contribute(Faith, (faith * days));
		
		/* Whether [this] Human has enough wood to warm themselves */
		var warm:Bool = inc.consume(Wood, 2);
		if (!warm) {
			stats.happiness -= 2;
		}

		return inc;
	}

	/**
	  * Do job
	  */
	public function work(i : Inventory):Void {
		trace('A $profession has done their job today');
	}

	/**
	  * Get the data for [this] Human
	  */
	public function data():HumanData {
		return {
			'base_faith': base_faith,
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
		var priests = engine.player.village.getByProfession(Priest);
		var base:Int = base_faith.get();
		for (p in priests) {
			base += p.level;
		}
		return base;
	}

	/**
	  * Get/Set the Profession of [this] Human
	  */
	public var profession(get, set):Profession;
	private inline function get_profession() return _prof.get();
	private inline function set_profession(v : Profession) return _prof.set( v );

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
		var max_xp:Int = (200 * level);

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

	private var base_faith : Ptr<Int>;
	private var current_age : Ptr<Int>;
	private var lvl : Ptr<Int>;
	private var exp : Ptr<Int>;
	private var max_age : Int;
	private var _prof : Ptr<Profession>;

	/* == Perk-Specific Fields == */
	private var since_last_breed : Int;

	public var stats : Stats;

/* ==== Static Fields === */

	/* Whether Humans can Breed on their own */
	public static var breedable:Bool = false;

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
