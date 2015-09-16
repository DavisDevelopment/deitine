package deitine.npc.work;

import deitine.npc.Human;
import deitine.npc.Profession;
import deitine.ds.Inventory;

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

/* === Computed Instance Fields === */

	/**
	  * Experience Points gained each time [this] Job is performed
	  */
	public var xp(get, never):Int;
	private function get_xp():Int {
		return 0;
	}

/* === Instance Fields === */

	public var human : Human;
}
