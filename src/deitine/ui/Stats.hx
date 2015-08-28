package deitine.ui;

import foundation.Heading;
import deitine.ui.KVTable;

import deitine.core.Component;
import deitine.core.Entity;
import deitine.core.Player;
import deitine.npc.Village;
import deitine.npc.Profession;

using StringTools;
using deitine.ds.Formatting;

class Stats extends Component {
	/* Constructor Function */
	public function new(e : Entity):Void {
		super( e );

		village = cast e;
		table = new KVTable();
		table.heading.text = 'Stats';

		table.activate();
	}

/* === Instance Methods === */

	/**
	  * Every Day
	  */
	override public function day():Void {
		super.day();

		stats();
	}

	/**
	  * When we update
	  */
	override public function update():Void {
		super.update();

		stats();
	}

	/**
	  * Counts the number of Villagers of a given Profession
	  */
	private inline function num(p : Profession):Int {
		return (village.getByProfession( p ).length);
	}

	/**
	  * Display the Statistics
	  */
	private function stats():Void {
		
		/* The Number of Priests */
		table.set('priests', num(Priest).prettyInt());
		
		/* The Number of Woodcutters */
		table.set('lumberjacks', num(Woodcutter).prettyInt());

		/* The Number of Hunters */
		table.set('hunters', num(Hunter).prettyInt());

	}

/* === Instance Fields === */

	private var village : Village;
	public var table : KVTable;
}
