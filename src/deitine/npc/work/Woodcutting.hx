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
		i.contribute(Wood, (2 * human.level) * days);
	
		/* This tires him, so he must eat */
		var eaten:Bool = i.consume(Meat, days);

		human.xp += human.job_xp;
	}

	private var days_wo_food:Int = 0;
}
