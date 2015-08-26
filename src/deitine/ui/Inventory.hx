package deitine.ui;

import deitine.ui.KVTable;
import deitine.core.Component;
import deitine.core.Entity;
import deitine.core.Player;
import deitine.npc.Village;

class Inventory extends Component {
	/* Constructor Function */
	public function new(e : Entity):Void {
		super( e );
		player = cast e;
		table = new KVTable();
		table.appendTo('body');
		table.activate();
	}

/* === Instance Methods === */

	/**
	  * Method invoked daily
	  */
	override public function day():Void {
		super.day();
		showInventory();
	}

	/**
	  * Update [this] Component
	  */
	override public function update():Void {
		super.update();
		showInventory();
	}

	/**
	  * Do things with the Widget
	  */
	private function showInventory():Void {
		table.write(player.inventory);
	}

/* === Instance Fields === */

	private var village : Village;
	private var player : Player;
	private var table : KVTable;
}
