package deitine.npc.tasks;

import deitine.npc.Purchase;

class CreatePriest extends Purchase {
	/* Constructor Function */
	public function new():Void {
		super();

		name = 'Create Priest';
		description = 'Blessed with knowledge of your wishes, increasing the faith of those around him';
		throttle = (30 * 1000);
	}

	/**
	  * Create a new Priest
	  */
	override public function action(done : Void->Void):Void {
		var p = Human.create();
		p.profession = Priest;
		village.addVillager( p );
		player.faith -= price;
		done();
	}

	/**
	  * The price of [this] Purchase
	  */
	override private function get_price():Int {
		return 4000;
	}
}
