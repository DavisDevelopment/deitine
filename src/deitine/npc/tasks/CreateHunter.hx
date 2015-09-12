package deitine.npc.tasks;

import deitine.npc.Purchase;

class CreateHunter extends Purchase {
	/* Constructor Function */
	public function new():Void {
		super();

		name = 'Create Hunter';
		description = 'Using your divine power, you breathe life into a new Hunter';
		throttle = 1500;
	}

	/**
	  * Create a new Priest
	  */
	override public function action(done : Void->Void):Void {
		var p = Human.create();
		p.profession = Hunter;
		village.addVillager( p );
		player.faith -= price;
		done();
	}

	/**
	  * The price of [this] Purchase
	  */
	override private function get_price():Int {
		return ((village.population - 24) * 20);
	}
}
