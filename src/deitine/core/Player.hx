package deitine.core;

import deitine.core.Engine;
import deitine.core.Entity;
import deitine.npc.Village;
import deitine.npc.Profession;
import deitine.ds.Inventory;

import deitine.ds.Perk;
import deitine.ds.perks.*;

import tannus.ds.Object;
import tannus.ds.EitherType;
import tannus.internal.TypeTools in Tt;

import Std.*;

using StringTools;

class Player extends Entity {
	/* Constructor Function */
	public function new():Void {
		super();

		inv = new Inventory({});
		perks = new Array();

		engine.onsave.on( save );

		engine.onload.on( load );

		instance = this;

		mentionPerks();
	}

/* === Instance Methods === */

	/**
	  * update [this] Player
	  */
	override public function update():Void {
		super.update();
	}

	/**
	  * Perform checks for all relevant Perks, to ensure that they're referenced
	  */
	private function mentionPerks():Void {
		null;
	}

	/**
	  * Assimilate some Income into [this]
	  */
	public function acceptInventory(inc : Inventory):Void {
		inv.faith += inc.faith;
		inv.wood += inc.wood;
		inv.meat += inc.meat;
		inv.leather += inc.leather;
	}

	/**
	  * Method to be invoked daily
	  */
	override public function day(g : deitine.time.GameDate):Void {
		dispatch('day', g);

		update();
	}

	/**
	  * Save [this] Player
	  */
	public function save(data : Object):Void {
		data['player'] = {
			'inventory': inv.toObject(),
			'perks': perks
		};
	}

	/**
	  * Load [this] Player
	  */
	public function load(data : Object):Void {
		if (data == null)
			return ;
		/* Load the Player's Inventory */
		data = data['player'];
		inv = new Inventory(cast data['inventory']);

		/* Load the Player's perks */
		perks = new Array();
		var savedPerks:Null<Array<String>> = cast data['perks'];
		if (savedPerks != null) {
			for (name in savedPerks) {
				trace('Loading $name perk');
				addPerk(EPerk.Normal(name));
			}
		}
	}

	/**
	  * Get a reference to a Perk, queried by name
	  */
	private function getPerkByName(name : String):Null<Perk> {
		for (p in perks)
			if (p.name == name.toLowerCase())
				return p;
		return null;
	}

	/**
	  * Add a new Perk to the List
	  */
	public function addPerk(k : Perk) {
		perks.push(k);
	}

	/**
	  * Check whether the Player has the given Perk
	  */
	public function hasPerk(nam : Dynamic):Bool {
		for (p in perks)
			if (p.name == nam)
				return true;
		return false;
	}

/* === Computed Instance Fields === */

	/**
	  * The Player's Village
	  */
	public var village(get, never):Village;
	private function get_village():Village {
		return Village.instance;
	}

	/**
	  * The number of Followers [this] God has
	  */
	public var followers(get, never):Int;
	private inline function get_followers() return village.population;

	/**
	  * The Player's Faith
	  */
	public var faith(get, set):Int;
	private inline function get_faith() return inv.faith;
	private inline function set_faith(v : Int) return (inv.faith = v);

	/**
	  * Inventory
	  */
	public var inventory(get, never):Object;
	private function get_inventory():Object {
		var base:Object = {
			'followers': followers,
		};

		base += inv.toObject();
		return base;
	}

/* === Instance Fields === */

	public var inv : Inventory;
	public var perks : Array<Perk>;

/* === Static Fields === */

	public static var instance : Player;
}
