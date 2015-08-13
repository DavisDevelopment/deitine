package deitine.npc;

using Lambda;
using StringTools;
using tannus.ds.StringUtils;

@:forward
abstract HumanName (THumanName) from THumanName {
	/* Constructor Function */
	public inline function new(first:String, middle:String, last:String):Void {
		this = {
			'first': first,
			'middle': middle,
			'last': last
		};
	}

/* === Implicit Casting === */

	/**
	  * To String
	  */
	@:to
	public inline function toString():String {
		return ([this.first, this.middle, this.last].join(' '));
	}

	/**
	  * From String
	  */
	@:from
	public static function fromString(sn : String):HumanName {
		var bits:Array<String> = sn.split(' ').map(StringTools.trim).filter(function(s) return (s != ''));
		switch (bits) {
			case [first, middle, last]:
				return new HumanName(first, middle, last);

			default:
				throw 'Cannot create HumanName from "$sn"!';
		}
	}
}

typedef THumanName = {
	var first : String;
	var middle : String;
	var last : String;
};
