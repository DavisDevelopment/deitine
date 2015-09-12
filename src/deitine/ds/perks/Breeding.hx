package deitine.ds.perks;

import deitine.core.Player;
import deitine.npc.Village;
import deitine.ds.perks.ConditionalPerk;


@:access(deitine.npc.Village)
class Breeding extends ConditionalPerk {
	/* Constructure Function */
	public function new():Void {
		super();

		name = 'breeding';
		description = 'Teach the Villagers how to reproduce on their own';
	}

/* === Instance Methods === */

	/**
	  * Called when [this] Perk takes effect
	  */
	override public function affect():Void {
		deitine.npc.Human.breedable = true;
	}

/* === Static Fields === */

	private static inline var BREED_POP:Int = 65;

/* === Static Methods === */

	/**
	  * Check whether [this] Perk is active yet
	  */
	public static function met():Bool {
		return (Player.instance.village.population >= BREED_POP);
	}

	public static function __init__():Void {
		ConditionalPerk.all.push( Breeding );
	}
}
