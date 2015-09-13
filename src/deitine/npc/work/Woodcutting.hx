package deitine.npc.work;

import deitine.npc.work.Job;
import deitine.ds.Inventory;

class Woodcutting extends Job {

/* === Instance Fields === */

	/**
	  * Perform [this] Job
	  */
	override public function perform(i:Inventory, days:Int):Void {
		/* Lumberjack collects 2 Wood for each day */
		i.wood += ((2 * human.level) * days);
	
		/* This tires him, so he must eat */
		var eaten:Bool = i.consume(Meat, days);
		if (!eaten)
			human.stats.happiness -= 2;

		human.xp += human.job_xp;
	}
}
