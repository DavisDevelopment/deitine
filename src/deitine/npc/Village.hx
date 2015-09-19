package deitine.npc;

import tannus.io.Ptr;
import tannus.nore.Selector;
import tannus.io.Signal;
import tannus.io.EventDispatcher;
import tannus.ds.Maybe;
import tannus.ds.Object;
import tannus.math.Percent;
import tannus.math.TMath in Nums;
import tannus.internal.CompileTime in Ct;

import deitine.Utils;
import deitine.ds.Action;
import deitine.ds.Inventory;
import deitine.core.Entity;
import deitine.core.EntityContainer;
import deitine.time.GameDate;
import deitine.npc.Human;
import deitine.npc.Profession;
import deitine.ds.perks.*;
import deitine.core.Player.instance in player;

using StringTools;
using Lambda;

class Village extends EntityContainer {
	/* Constructor Function */
	public function new():Void {
		super();

		stopped = false;
		villagers = new Array();
		daily_income = new Inventory({});

		engine.onsave.on( save );
		engine.onload.on( load );

		instance = this;
		addSignal('update');
	}

/* === Instance Methods === */

	/**
	  * Occurs every 'day' (in game time)
	  */
	override public function day(d : GameDate):Void {
		super.day(d);
		if (stopped)
			return ;
		var ctime = Ct.time({
			daily_income.reset();
			
			/* compute day for all Villagers */
			var vtimes:Array<Int> = new Array();
			var mult:Int = 0;

			for (v in villagers) {
				vtimes.push(Ct.time({
					v.day(d);
					v.work(daily_income, engine.daysSinceLastPlayed);
				}));

				if (v.profession == Priest) {
					mult += (5 * v.level);
					v.giveXp();
				}
			}
			var avgtime = Nums.average(vtimes);
			trace('Villagers took an average of ${avgtime}ms to compute a day');

			var bonus:Percent = new Percent(mult);
			daily_income.faith += Std.int(bonus.of(daily_income.faith));

			player.inv.absorb( daily_income );
			trace(daily_income.toObject());
		});

		if (ctime > 4000) {
			stopped = true;
		}
		dispatch('update', null);
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
	  * Save [this] Village
	  */
	public function save(data : Object):Void {
		var dat:Array<Dynamic> = new Array();
		for (v in villagers) {
			v.dispatch('saving', data);
			dat.push(v.data());
		}
		data['village'] = dat;
	}

	/**
	  * Load [this] Village
	  */
	public function load(data : Object):Void {
		if (data == null)
			return ;
		var datas:Null<Array<HumanData>> = cast data['village'];
		if (datas != null) {
			villagers = datas.map(function(d) {
				return new Human( d );
			});
		}
		else {
			villagers = new Array();
			addVillager(Human.create());
		}
	}

	/**
	  * Get Villagers by Profession
	  */
	public function getByProfession(p : Profession):Array<Human> {
		return villagers.filter(function(v) {
			return (v.profession == p);
		});
	}

	/**
	  * Get Villagers by Name
	  */
	public function getByName(n : String):Array<Human> {
		var res:Array<Human> = new Array();
		var patt = new tannus.io.RegEx(new EReg(n, 'i'));

		for (h in villagers) {
			if (patt.match(h.name))
				res.push( h );
		}

		return res;
	}

	/**
	  * Get Villagers by ORegEx
	  */
	public function query(sel : Selector<Human>):Array<Human> {
		return villagers.filter( sel );
	}

/* === Computed Instance Fields === */

	/**
	  * The population of [this] VIllage
	  */
	public var population(get, never) : Int;
	private inline function get_population() return villagers.length;

/* === Instance Fields === */

	public var stopped : Bool;
	private var villagers : Array<Human>;
	public var daily_income : Inventory;

	public static var instance : Village;
}
