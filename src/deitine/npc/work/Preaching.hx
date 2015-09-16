package deitine.npc.work;

import deitine.npc.work.Job;
import deitine.npc.Village;
import deitine.npc.Village.instance in village;
import deitine.npc.Profession;
import deitine.ds.Inventory;

@:access(deitine.npc.Village)
class Preaching extends Job {
	/**
	  * Perform [this] Job
	  */
	override public function perform(i:Inventory, days:Int):Void {
		super.perform(i, days);
	}

	override private function get_xp():Int {
		return village.population;
	}
}
