package deitine.npc.work;

import tannus.math.TMath in Nums;

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
		var strengthLvlUp:Bool = human.stats.strength.addXp( 10 );
		if (strengthLvlUp)
			human.giveXp(10 * human.stats.strength.level);
	
		human.giveXp();
	}

	override private function get_xp():Int {
		return 10;
	}
}
