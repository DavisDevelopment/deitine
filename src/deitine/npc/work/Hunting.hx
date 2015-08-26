package deitine.npc.work;

import deitine.npc.work.Job;
import deitine.ds.Inventory;

class Hunting extends Job {

/* === Instance Fields === */

	/**
	  * Perform [this] Job
	  */
	override public function perform(i : Inventory):Void {
		i.contribute(Meat, 1);
		i.contribute(Leather, 1);
	}
}
