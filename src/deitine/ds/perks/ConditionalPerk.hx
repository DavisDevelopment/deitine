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

	/* Array of all subclasses of [this] */
	public static var all:Array<Class<ConditionalPerk>>;

	/**
	  * Get all ConditionalPerks that are unmet AND the Player doesn't have
	  */
	public static function getMet():Array<Class<ConditionalPerk>> {
		var res = new Array();
		for (c in all) {
			var met:Bool = cast Reflect.callMethod(c, Reflect.getProperty(c, 'met'), []);
			if (met && !Player.instance.hasPerk(c)) {
				res.push( c );
			}
		}
		return res;
	}

	/**
	  * Initialize this class
	  */
	public static function __init__():Void {
		all = new Array();
	}
}
