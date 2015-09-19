package deitine.ds;

import tannus.ds.Value;
import tannus.ds.Ref;

@:forward
abstract Perk (CPerk) {
	public inline function new(cp : CPerk) {
		this = cp;
	}

	@:from
	public static inline function fromEp(v : EPerk):Perk {
		return new Perk(new CPerk( v ));
	}
}

class CPerk {
	public function new(e : EPerk):Void {
		eperk = e;
		pcache = Ref.create(eperk.getParameters());

		info = data[data.length - 1];
		
		if (info == null)
			info = {
				'level': 1,
				'level_price': 400
			};
	}

/* === Instance Methods === */

/* === Computed Instance Fields === */

	private var data(get, never):Array<Dynamic>;
	private inline function get_data() return pcache.get();

	public var name(get, never):String;
	private inline function get_name() return data[0];

/* === Instance Fields === */

	private var eperk : EPerk;
	private var pcache : Ref<Array<Dynamic>>;
	
	public var info : PerkInfo;
}

enum EPerk {
	Normal(name:String, ?info:PerkInfo);
	
	Paid(name:String, price:Int, ?info:PerkInfo);
}

typedef PerkInfo = {
	var level : Int;
	var level_price : Int;
};

class OldPerk {
	/* Constructor Function */
	public function new():Void {
		max_level = 80;
		level = 1;
	}

/* === Instance Methods === */

	/**
	  * Invoke the effects caused by [this] Perk
	  */
	public function affect():Void {
		trace('We\'re sorry, but this is not implemented');
	}

/* === Instance Fields === */

	public var name : String;
	public var description : String;

	private var lelveled : Bool;
	private var max_level : Int;
	private var level : Int;
}
