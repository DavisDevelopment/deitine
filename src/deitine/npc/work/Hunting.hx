package deitine.npc.work;

import deitine.npc.work.Job;
import deitine.ds.Inventory;

import Math.*;

class Hunting extends Job {

/* === Instance Fields === */

	/**
	  * Perform [this] Job
	  */
	override public function perform(i:Inventory, days:Int):Void {
		/* Number of kills */
		var kills:Int = floor(stats.awareness.level + stats.productivity.of(stats.awareness.level));
		trace('Hunter got $kills kills today');
		var gxp:Int = floor(pow((kills * 4), 1.32));
		gxp += floor(100 / stats.intelligence.level);
		trace('and gained ${gxp}xp for it');
		stats.awareness.give_xp( gxp );
		//- weight of items gained from each kill
		var weight:Int = 2;
		//- maximum weight which can be carried
		var carry:Int = stats.max_carry;
		//- clamp [kills] to prevent surpassing the carry weight
		if (kills * weight > carry) {
			kills = floor(carry / weight);
		}
		//- total weight of loot
		var tWeight:Int = (kills * weight);
		
		//- if Human had to strain to carry back the items
		//- train the strength skill
		if (tWeight >= carry/2) {
			stats.strength.give_xp(tWeight);
		}

		/*
		   Contribute the items gained
		 */
		i.contribute(Meat, kills);
		i.contribute(Leather, kills);
	}

	override private function get_xp():Int {
		return 10;
	}
}
