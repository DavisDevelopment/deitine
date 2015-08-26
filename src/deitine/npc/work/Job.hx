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
	public function perform(inv : Inventory):Void {
		trace('A ${human.profession} is doing his job');
	}

/* === Instance Fields === */

	public var human : Human;
}
