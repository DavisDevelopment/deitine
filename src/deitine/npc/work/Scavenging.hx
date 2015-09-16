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
		var mat = inv.materials;

		var mats:Array<Material> = cast Material.all();
		var finds:Int = [0, (3 * human.level * days)].randint();
		
		while (finds > 1) {
			var q:Int = [0, finds].randint();
			mat.contribute(mats.choice(), q);
			finds -= q;
		}

		human.giveXp();
	}

	override private function get_xp() return 5;
}
