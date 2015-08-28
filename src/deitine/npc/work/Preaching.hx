package deitine.npc.work;

import deitine.npc.work.Job;
import deitine.npc.Village;
import deitine.npc.Profession;
import deitine.ds.Inventory;

@:access(deitine.npc.Village)
class Preaching extends Job {
	/**
	  * Perform [this] Job
	  */
	override public function perform(i : Inventory):Void {
		i.consume(Meat, 1);
		var village:Village = cast human.engine.query('deitine.npc.Village')[0];
		for (v in village.villagers) {
			if (v.profession != Profession.Priest) {
			}
		}
	}
}
