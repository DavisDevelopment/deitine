package deitine.ui;

import deitine.ui.KVTable;
import deitine.core.Component;
import deitine.core.Entity;
import deitine.core.Player;
import deitine.npc.Village;

using deitine.ds.Formatting;
using StringTools;

class Inventory extends Component {
	/* Constructor Function */
	public function new(e : Entity):Void {
		super( e );
		player = cast e;
		table = new KVTable();
		table.heading.text = 'Inventory';
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
		village = player.village;
		showInventory();
	}

	/**
	  * Do things with the Widget
	  */
	private function showInventory():Void {
		var inv = player.inv;
		
		/* The Total Population of the Village */
		table.set('followers', village.population.prettyInt());

		/* The Total Faith Points the Player has */
		table.set('faith', inv.faith.prettyInt());

		/* The Supplies the Village Has */
		table.set('food', inv.meat.prettyInt());
		table.set('wood', inv.wood.prettyInt());
		table.set('leather', inv.leather.prettyInt());
	}

/* === Instance Fields === */

	private var village : Village;
	private var player : Player;
	public var table : KVTable;
}
