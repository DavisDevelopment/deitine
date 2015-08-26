package deitine.npc;

import deitine.npc.Human;
import deitine.npc.Village;
import deitine.npc.Purchase;
import deitine.ds.Action;
import deitine.core.Engine;

class CreateFollower extends Purchase {
	/* Constructor Function */
	public function new():Void {
		super();

		price = 50;
		name = 'Create Follower';
		description = 'Using your diving power, you breathe life into a new person';
		throttle = 800;
	}
}
