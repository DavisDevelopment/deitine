package deitine.ds.inv;

import tannus.ds.Obj;
import tannus.ds.Object;
import tannus.ds.Dict;

import deitine.ds.Material;

class Materials {
	/* Constructor Function */
	public function new(?o : Object):Void {
		if (o == null)
			o = {};
		data = new Map();

		stick = (o['stick'] || 0);
		flint = (o['flint'] || 0);
		lstrip = (o['leather_strip'] || 0);
	}

/* === Instance Methods === */

	/**
	  * Consume some material
	  */
	public function consume(m:Material, amount:Int):Bool {
		if (data[m] >= amount) {
			data[m] -= amount;
			return true;
		}
		else
			return false;
	}

	/**
	  * Contribute some material
	  */
	public function contribute(m:Material, amount:Int):Void {
		data[m] += amount;
	}

	/**
	  * Check the stock of the given Material
	  */
	public function stock(m : Material):Int {
		return data[m];
	}

	/**
	  * Assimilate another set of Materials
	  */
	public function absorb(other : Materials):Void {
		for (k in other.data.keys()) {
			data[k] += other.data[k];
		}
	}

	/**
	  * Copy [this]
	  */
	public function clone():Materials {
		return new Materials( data );
	}


/* === Computed Instance Fields === */

	public var stick(get, set):Int;
	private inline function get_stick() return data.get(Stick);
	private inline function set_stick(v) return (data[Stick] = v);

	public var flint(get, set):Int;
	private inline function get_flint() return data.get(Flint);
	private inline function set_flint(v) return (data[Flint] = v);
	
	public var lstrip(get, set):Int;
	private inline function get_lstrip() return data.get(LeatherStrip);
	private inline function set_lstrip(v) return (data[LeatherStrip] = v);

/* === Instance Fields === */

	private var data : Map<String, Int>;
}
