package deitine.ui;

import deitine.ui.KVTable;
import deitine.core.Component;
import deitine.core.Entity;
import deitine.core.Player;
import deitine.npc.Village;
import deitine.npc.Village.instance in village;

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

		update();
	}

/* === Instance Methods === */

	/**
	  * Method invoked daily
	  */
	override public function day():Void {
		super.day();
		update();
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
		var inv = player.inv;
		
		/* The Total Population of the Village */
		var foll = table.row('followers');
		foll.value = village.population.prettyInt();
		foll.tooltip = 'Number of people who worship you';

		/* The Total Faith Points the Player has */
		var fp = table.row('faith');
		fp.value = inv.faith.prettyInt();
		fp.tooltip = '${village.daily_income.faith}fp / day';

		/* The Supplies the Village Has */
		var food = table.row('food');
		food.value = inv.meat.prettyInt();
		food.tooltip = '${village.daily_income.meat} / day';

		var wood = table.row('wood');
		wood.value = inv.wood.prettyInt();
		wood.tooltip = '${village.daily_income.wood} / day';

		var lethr = table.row('leather');
		lethr.value = inv.leather.prettyInt();
		lethr.tooltip = '${village.daily_income.leather} / day';

		table.set('sticks', inv.materials.stick.prettyInt());
		table.set('flint', inv.materials.flint.prettyInt());
		table.set('leather strips', inv.materials.lstrip.prettyInt());
	}

	/**
	  * 
	  */

/* === Instance Fields === */

	private var player : Player;
	public var table : KVTable;
}
