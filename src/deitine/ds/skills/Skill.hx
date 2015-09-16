package deitine.ds.skills;

import tannus.ds.Value;
import tannus.math.Percent;

class Skill {
	/* Constructor Function */
	public function new(lvl:Int=1, xp:Int=0):Void {
		level = lvl;
		points = xp;
	}

/* === Instance Methods === */

	/**
	  * Calculate how many points are needed to advance to the next level
	  */
	private function nextLevel():Int {
		return (65 * level);
	}

	/**
	  * Earn some points for [this] Skill
	  */
	public function addXp(n : Int):Bool {
		points += n;
		var max = nextLevel();
		if (points >= max) {
			points -= max;
			level_up();
			return true;
		}
		return false;
	}

	/**
	  * Advance [this] Skill to the next Level
	  */
	private function level_up():Void {
		level++;
	}

/* === Computed Instance Fields === */

	public var progress(get, never):Percent;
	private function get_progress() {
		return Percent.percent(points, nextLevel());
	}

/* === Instance Fields === */

	public var level : Int;
	private var points : Int;
}
