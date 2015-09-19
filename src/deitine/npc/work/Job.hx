package deitine.npc.work;

import tannus.math.TMath.*;

import deitine.npc.Human;
import deitine.npc.HumanStats in Stats;
import deitine.npc.Profession;
import deitine.ds.Inventory;
import tannus.math.Percent;

using tannus.math.TMath;

class Job {
	/* Constructor Function */
	public function new(h : Human):Void {
		human = h;
	}

/* === Instance Methods === */

	/**
	  * Perform [this] Job
	  */
	public function perform(inv:Inventory, days:Int):Void {
		null;
	}

	/**
	  * Determine whether the Human will do their Job today
	  */
	public function will_perform():Bool {
		/* too tired || too hungry */
		var h = stats.hunger;
		var t = stats.exhaustion;
		var fatigue:Percent = lerp(min(h, t), max(h, t), 0.5);
		return (fatigue.of(1) < 0.5);
	}

/* === Computed Instance Fields === */

	/**
	  * Experience Points gained each time [this] Job is performed
	  */
	public var xp(get, never):Int;
	private function get_xp():Int {
		return 0;
	}

	/* reference to the Human's Stats */
	private var stats(get, never):Stats;
	private inline function get_stats() return human.stats;

/* === Instance Fields === */

	public var human : Human;
}
