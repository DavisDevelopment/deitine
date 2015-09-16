package deitine.ds.skills;

import tannus.ds.Value;
import tannus.io.Struct;
import tannus.math.Percent;

import deitine.ds.skills.SkillType;

import haxe.Serializer;
import haxe.Unserializer;

class Skill {
	/* Constructor Function */
	public function new(kind:SkillType, ?lvl:Int, ?xp:Int):Void {
		type = kind;
		level = (lvl!=null ? lvl : 15);
		points = (xp!=null ? xp  : 0);
	}

/* === Instance Methods === */

	/**
	  * Calculate how many points are needed to advance to the next level
	  */
	private function nextLevel():Int {
		return Std.int(improve_mult() * Math.pow(level, 1.95) + improve_offset());
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

	/**
	  * Get the improvement-multiplier for [this] Skill
	  */
	private inline function improve_mult():Float {
		return (2);
	}

	/**
	  * get the improvement-offset for [this] Skill
	  */
	private inline function improve_offset():Float {
		return 0;
	}

/* === Computed Instance Fields === */

	/* Progress towards the next level */
	public var progress(get, never):Percent;
	private function get_progress() {
		return Percent.percent(points, nextLevel());
	}

/* === Instance Fields === */

	/* The current level of [this] Skill */
	public var level : Int;

	/* The number of points toward the next level */
	private var points : Int;

	/* The type of Skill [this] is */
	public var type : SkillType;
}
