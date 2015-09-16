package deitine.npc;

import tannus.internal.CompileTime in Ct;
import tannus.math.Random;

import deitine.npc.Gender;

using tannus.ds.StringUtils;

@:expose('Names')
class Names {

	/**
	  * Generate a random gender-specific name
	  */
	public static function generate(gender : Gender):String {
		var n:Array<String> = new Array();
		var r = new Random();

		n.push(r.choice(gender?male:female).capitalize());
		n.push(r.choice(gender?male:female).capitalize());
		n.push(r.choice(last).capitalize());

		return n.join(' ');
	}

/* === Fields and Initialization Stuff === */

	private static var all:Array<Array<String>>;
	private static var male:Array<String>;
	private static var female:Array<String>;
	private static var last:Array<String>;

	public static function __init__():Void {
		var raw = Ct.readLines('deitine/src/assets/names.txt');
		male = raw.slice(0, raw.indexOf('---'));
		raw = raw.slice(raw.indexOf('---')+1);
		female = raw.slice(0, raw.indexOf('---'));
		raw = raw.slice(raw.indexOf('---')+1);
		last = raw;
		raw = null;
	}
}
