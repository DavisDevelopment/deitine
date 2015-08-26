package deitine.npc;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.io.EventDispatcher;
import tannus.ds.Maybe;
import tannus.ds.Object;

import deitine.ds.Action;
import deitine.ds.Inventory;
import deitine.core.Entity;
import deitine.core.EntityContainer;
import deitine.time.GameDate;
import deitine.npc.Human;
import deitine.npc.Profession;

using StringTools;
using Lambda;

class Village extends EntityContainer {
	/* Constructor Function */
	public function new(p : Int):Void {
		super();

		villagers = new Array();

		for (i in 0...p) {
			addVillager(Human.create());
		}

		engine.onsave.on( save );
		engine.onload.on( load );
	}

/* === Instance Methods === */

	/**
	  * Occurs every 'day' (in game time)
	  */
	override public function day(d : GameDate):Void {
		super.day(d);
		
		for (v in villagers) {
			v.day( d );
		}

		var income = new Inventory({});
		engine.player.inv.append( income );

		calculateIncome( income );

		engine.player.acceptInventory( income );
	}

	/**
	  * Add a Villager into [this] Village
	  */
	public inline function addVillager(h : Human):Void {
		villagers.push( h );
	}

	/**
	  * Remove a Villager from [this] Village
	  */
	public inline function removeVillager(h : Human):Void {
		villagers.remove( h );
	}

	/**
	  * Get the overall income of the Village
	  */
	public function calculateIncome(inc : Inventory):Inventory {
		for (v in villagers)
			v.income( inc );

		return inc;
	}

	/**
	  * Save [this] Village
	  */
	public function save(data : Object):Void {
		data['village'] = villagers.map(function(v) return v.data());
	}

	/**
	  * Load [this] Village
	  */
	public function load(data : Object):Void {
		if (data == null)
			return ;
		var datas:Array<HumanData> = cast data['village'];
		villagers = datas.map(function(d) {
			return new Human( d );
		});
		trace('Village Loaded!');
	}

	/**
	  * Get Villagers by Profession
	  */
	public function getByProfession(p : Profession):Array<Human> {
		return villagers.filter(function(v) {
			return (v.profession == p);
		});
	}

/* === Computed Instance Fields === */

	/**
	  * The population of [this] VIllage
	  */
	public var population(get, never) : Int;
	private inline function get_population() return villagers.length;

/* === Instance Fields === */

	private var villagers : Array<Human>;
}
