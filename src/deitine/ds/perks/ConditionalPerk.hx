package deitine.ds.perks;

import deitine.ds.Perk;
import deitine.core.Player;

class ConditionalPerk extends Perk {
	/* Constructor Function */
	public function new():Void {
		super();

		affect();
	}

/* === Instance Methods === */

	/**
	  * Method invoked when [this] Perk actually starts doing something *
	  */
	override public function affect():Void {
		null;
	}

/* === Static Methods === */

	public static function met():Bool {
		return false;
	}
}
