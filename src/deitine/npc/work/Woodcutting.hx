package deitine.npc.work;

import tannus.math.TMath in Nums;

import deitine.npc.work.Job;
import deitine.ds.Inventory;

import Math.*;
import tannus.math.TMath.*;

class Woodcutting extends Job {

/* === Instance Fields === */

	/**
	  * Perform [this] Job
	  */
	override public function perform(i:Inventory, days:Int):Void {
		/* Lumberjack collects 2 Wood for each day */
		
		//- maximum weight that the Human can carry
		var carry = stats.max_carry;
		//- damage to trees per swing
		var dps:Int = (human.stats.strength.level);
		//- number of wood which can be carried
		var mwood:Int = (3 * ceil(15 / dps));
		//- total weight of the maximum yield
		var w:Int = (mwood * 1);
		
		//- clamp the yield to the maximum subset of it which can be carried home
		if (carry < (mwood * w)) {
			mwood = clamp(mwood, 0, floor(carry / w));
		}

		//- reap the XP rewards
		human.stats.strength.give_xp(2 * mwood);
		//- contribute the chopped-down wood to the Village
		i.contribute(Wood, mwood);
	}

	override private function get_xp():Int {
		return 10;
	}
}
