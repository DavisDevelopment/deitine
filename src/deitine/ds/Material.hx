package deitine.ds;

import tannus.io.Asserts.assert;

@:enum
abstract Material (String) to String {
/* === Constructs === */

	/* Wooden Sticks */
	var Stick = 'stick';

	/* Strips of Leather */
	var LeatherStrip = 'leather strip';
	
	/* Flint, for making pointy things */
	var Flint = 'flint';

	/* Array of All Valid Constructs */
	private static inline function all():Array<String> {
		return [
			'stick',
			'flint',
			'leather strip'
		];
	}
/* === Fields and Methods === */

	/* The name of [this] Material */
	public var name(get, never):String;
	private inline function get_name() return this;

	/**
	  * Cast FROM String
	  */
	@:from
	public static function fromString(s : String):Material {
		assert(Lambda.has(all(), s), 'TypeError: Cannot create Material from $s');
		return cast s;
	}
}
