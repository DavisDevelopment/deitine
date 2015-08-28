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

/* === Instance Fields === */

	public var human : Human;
}
