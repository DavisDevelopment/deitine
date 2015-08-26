package deitine.npc;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.ds.Maybe;

import deitine.core.Entity;
import deitine.time.GameDate;
import deitine.npc.HumanData;
import deitine.ds.Inventory;
import deitine.npc.Profession;
import deitine.npc.work.Job;

using tannus.math.RandomTools;

class Human extends Entity {
	/* Constructor Function */
	public function new(data : HumanData):Void {
		super();

		base_faith = state.field('base_faith');
		base_faith &= data.base_faith;

		_prof = state.field('profession');
		_prof &= data.profession;

		current_age = state.field('current_age');
		current_age &= data.current_age;

		max_age = data.max_age;
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
	}

	/**
	  * Get the 'Income' of [this] Human
	  */
	public function income(inc : Inventory):Inventory {
		var job:Job = profession.getConstructor()(this);
		job.perform( inc );
		inc.contribute(Faith, faith);
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
			'current_age': current_age
		};
	}

	/**
	  * [this] Human dies
	  */
	public function die():Void {
		engine.player.village.removeVillager( this );
	}

/* === Computed Instance Fields === */

	/**
	  * Get the faith-output of [this] Human
	  */
	public var faith(get, never):Int;
	private inline function get_faith():Int {
		return base_faith.get();
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

/* === Instance Fields === */

	private var base_faith : Ptr<Int>;
	private var current_age : Ptr<Int>;
	private var max_age : Int;
	private var _prof : Ptr<Profession>;

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
			'max_age': ([75, 105].randint() * 365)
		};
		return new Human( data );
	}
}
