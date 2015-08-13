package deitine.npc;

import tannus.internal.CompileTime.readFile;

import deitine.npc.Gender;
import deitine.npc.HumanName;

using Lambda;
using StringTools;
using tannus.ds.StringUtils;
using tannus.math.RandomTools;

class Names {
/* === Static Methods === */

	/**
	  * Get a random first-name
	  */
	public static function randomFirst(g : Gender):String {
		return ([male, female][g].choice()).capitalize();
	}

/* === Static Fields === */

	private static var raw:Array<String> = {readFile('deitine/src/assets/names.txt').toString().split('---');};
	private static var male:Array<String> = {raw[0].split('\n').filter(function(n) return (n != ''));};
	private static var female:Array<String> = {raw[1].split('\n').filter(function(n) return (n != ''));};
	private static var last:Array<String>;
}
