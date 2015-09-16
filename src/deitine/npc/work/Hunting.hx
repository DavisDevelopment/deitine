package deitine.npc.work;

import deitine.npc.work.Job;
import deitine.ds.Inventory;

class Hunting extends Job {

/* === Instance Fields === */

	/**
	  * Perform [this] Job
	  */
	override public function perform(i:Inventory, days:Int):Void {
		/* Amount gained from each kill */
		var amount:Int = Std.int(((2 * human.level) * days) / 2);

		/* For each Kill, 2 Meat & 2 Leather are gained */
		i.meat += amount;
		i.leather += amount;

		/* The Hunter gains experience from these kills */
		human.giveXp();
	}

	override private function get_xp():Int {
		return 10;
	}
}
