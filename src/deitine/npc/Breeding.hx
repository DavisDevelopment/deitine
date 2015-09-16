package deitine.npc;

import tannus.math.Random;
import deitine.npc.Village.instance in village;

class Breeding {
	/**
	  * Request a pregnancy
	  */
	public static function requestPreg():Bool {
		if (village.population < 1000) {
			var rand = new Random();
			var x = rand.randint(0, 10);
			var y = rand.randint(0, 10);
			return (x == y);
		}
		else {
			return false;
		}
	}
}
