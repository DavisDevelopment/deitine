package deitine.npc.tasks;

import deitine.npc.Human;
import deitine.npc.Village;
import deitine.npc.Purchase;
import deitine.ds.Action;
import deitine.core.Engine;

class CreateFollower extends Purchase {
	/* Constructor Function */
	public function new():Void {
		super();

		name = 'Create Follower';
		description = 'Using your diving power, you breathe life into a new person';
		throttle = 1000;
	}

	/**
	  * Perform [this] Action
	  */
	override public function action(done : Void->Void):Void {
		village.addVillager(Human.create());
		player.faith -= price;
		name = 'Create Follower (${price}fp)';
		done();
	}
	
	/**
	  * Get [this]'s Price
	  */
	override private function get_price():Int {
		return ((village.population - 24) * 15);
	}
}
