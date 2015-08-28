package deitine.core;

import deitine.core.Engine;
import deitine.core.Entity;
import deitine.npc.Village;
import deitine.npc.Profession;
import deitine.ds.Inventory;

import tannus.ds.Object;

class Player extends Entity {
	/* Constructor Function */
	public function new():Void {
		super();

		inv = new Inventory({});
		engine.onsave.on( save );

		engine.onload.on(function(data) {
			if (data == null) 
				return ;
			inv = data['player'];
		});

		instance = this;
	}

/* === Instance Methods === */

	/**
	  * Assimilate some Income into [this]
	  */
	public function acceptInventory(inc : Inventory):Void {
		trace( inc );
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
	}

	/**
	  * Save [this] Player
	  */
	public function save(data : Object):Void {
		data['player'] = inv;
	}

/* === Computed Instance Fields === */

	/**
	  * The Player's Village
	  */
	public var village(get, never):Village;
	private function get_village():Village {
		return cast engine.query('deitine.npc.Village')[0];
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

/* === Static Fields === */

	public static var instance : Player;
}
