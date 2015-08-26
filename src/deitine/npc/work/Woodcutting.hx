package deitine.npc.work;

import deitine.npc.work.Job;
import deitine.ds.Inventory;

class Woodcutting extends Job {

/* === Instance Fields === */

	/**
	  * Perform [this] Job
	  */
	override public function perform(i : Inventory):Void {
		i.contribute(Wood, 2);
	}
}
