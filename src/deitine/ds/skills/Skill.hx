package deitine.ds.skills;

import tannus.ds.Value;
import tannus.io.Struct;
import tannus.io.Signal;
import tannus.math.Percent;

import deitine.npc.Human;
import deitine.ds.skills.SkillType;

import haxe.Serializer;
import haxe.Unserializer;

class Skill {
	/* Constructor Function */
	public function new(h:Human, ?lvl:Int, ?xp:Int):Void {
		human = h;
		level = (lvl!=null ? lvl : 15);
		points = (xp!=null ? xp  : 0);
		levelIncreased = new Signal();
	}

/* === Instance Methods === */

	/**
	  * Calculate how many points are needed to advance to the next level
	  */
	private function next_level():Int {
		return Math.floor(improve_mult() * Math.pow(level, 1.95) + improve_offset());
	}

	/**
	  * Earn some points for [this] Skill
	  */
	public function give_xp(n : Int):Bool {
		points += n;
		var max = next_level();
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
		levelIncreased.call( level );
		trace('Human levelled up a Skill!');
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

	/**
	  * serialize [this] Skill
	  */
	@:keep
	private function hxSerialize(s : Serializer):Void {
		var add = s.serialize.bind(_);

		add(level);
		add(points);
	}

	/**
	  * unserialize [this] Skill
	  */
	@:keep
	private function hxUnserialize(u : Unserializer):Void {
		var get = u.unserialize.bind();
		
		levelIncreased = new Signal();
		level = get();
		points = get();
	}

/* === Computed Instance Fields === */

	/* Progress towards the next level */
	public var progress(get, never):Percent;
	private function get_progress() {
		return Percent.percent(points, next_level());
	}

/* === Instance Fields === */

	/* The current level of [this] Skill */
	public var level : Int;

	/* The number of points toward the next level */
	private var points : Int;

	/* Signal which emits when the [level] of [this] Skill is increased */
	public var levelIncreased : Signal<Int>;

	/* The Human that [this] Skill is attached to */
	private var human : Human;
}
