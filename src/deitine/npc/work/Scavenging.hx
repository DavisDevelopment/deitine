package deitine.npc.work;

import deitine.npc.work.Job;
import deitine.ds.Inventory;
import deitine.ds.Material;

import tannus.math.Random;

using tannus.math.RandomTools;

@:access(deitine.ds.Material)
class Scavenging extends Job {
	/**
	  * Perform Scavenging
	  */
	override public function perform(inv:Inventory, days:Int):Void {
		null;
	}

	override private function get_xp() return 5;
}
