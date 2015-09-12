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

		engine.onload.on(function(data) {
			if (data == null) 
				return ;
			inv = data['player'];
		});

		instance = this;

		addPerk( Breeding );
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
	  * Get a reference to a Perk, queried by Class
	  */
	private function getPerkByClass(klass : Class<Perk>):Null<Perk> {
		var perk:Perk = Type.createInstance(klass, []);
		return getPerkByName(perk.name);
	}

	/**
	  * Add a new Perk to the List
	  */
	public function addPerk(k : Class<Perk>) {
		var p:Perk = Type.createInstance(k, []);
		if (k == ConditionalPerk) {
			var met:Void->Bool = Reflect.getProperty(cast k, 'met');

			on('day', function(n) {
				if (met()) {
					trace('Shit is going on');
					p.affect();
				}
				perks.push( p );
			});
		}
		else {
			p.affect();
			perks.push( p );
		}
	}

	/**
	  * Check whether the Player has the given Perk
	  */
	public function hasPerk(nam : Dynamic):Bool {
		if (Std.is(nam, String)) {
			return (getPerkByName(cast nam) != null);
		}
		else {
			var tn:String = Tt.typename( nam );
			switch ( tn ) {
				case 'Class<deitine.ds.Perk>':
					return (getPerkByClass(cast nam) != null);

				case (_ => n) if (n.startsWith('Class<deitine.ds.perks.')):
					return (getPerkByClass(cast nam) != null);

				default:
					return false;
			}
		}
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
	public var perks : Array<Perk>;

/* === Static Fields === */

	public static var instance : Player;
}
