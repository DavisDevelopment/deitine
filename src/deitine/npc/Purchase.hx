package deitine.npc;

import deitine.npc.Human;
import deitine.npc.Village;
import deitine.ds.Action;
import deitine.core.Engine;

class Purchase extends Action {
	/* Constructor Function */
	public function new():Void {
		super();

		price = 0;
		name = 'A Purchase';
		description = 'Some generic purhcase';
		throttle = 1200;
	}

/* === Instance Methods === */

	/**
	  * Buy shit
	  */ public function buy():Void {
		if (doable()) {
			this.run();
		}
	}

	/**
	  * Perform [this] Action
	  */
	override public function action(done : Void->Void):Void {
		village.addVillager(Human.create());
		player.faith -= price;
		done();
	}

	/**
	  * Whether [this] Action can be done
	  */
	override public function doable():Bool {
		return (player.faith >= price);
	}

/* === Computed Instance Fields === */

	public var village(get, never):Village;
	private inline function get_village() return (cast Engine.instance.query('"deitine.npc.Village"')[0]);

	public var player(get, never):deitine.core.Player;
	private inline function get_player() return Engine.instance.player;

	/**
	  * The price of [this] Purchase
	  */
	public var price(get, set):Int;
	private function get_price():Int {
		return _price;
	}
	private function set_price(v : Int):Int {
		return (_price = v);
	}

/* === Instance Fields === */

	private var _price : Int;
	public var name : String;
	public var description : String;
	public var throttle : Int;
}
