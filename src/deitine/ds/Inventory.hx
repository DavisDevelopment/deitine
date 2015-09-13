package deitine.ds;

import tannus.ds.Object;
import tannus.ds.Obj;
import tannus.io.Ptr;

import deitine.ds.Resource;
import deitine.ds.State;

import haxe.macro.Expr;
import haxe.macro.Context;

#if macro
using haxe.macro.ExprTools;
#end

@:forward
abstract Inventory (Invent) from Invent to Invent {
	/* Constructor Function */
	public inline function new(o : Object) {
		this = new Invent({
			'faith' : (o['faith'] || 0),
			'wood' : (o['wood'] || 0),
			'meat' : (o['meat'] || 0),
			'leather' : (o['leather'] || 0)
		});
	}
}

private class Invent {
	public function new(i : Inv):Void {
		inv = i;
		oinv = inv;
	}

/* === Instance Methods === */

	/**
	  * Add some Resource to [this] Inventory
	  */
	public function contribute(res:Resource, count:Int):Void {
		var key:String = resname(res);
		oinv[key] += count;
	}

	/**
	  * Use some Resource
	  */
	public function consume(res:Resource, count:Int):Bool {
		var key:String = resname( res );
		if (oinv[key] >= count) {
			oinv[key] -= count;
			return true;
		}
		return false;
	}

	/**
	  * Copy [this] Inventory
	  */
	public function clone():Inventory {
		var copy = new Inventory({});
		
		copy.faith = faith;
		copy.wood = wood;
		copy.meat = meat;
		copy.leather = leather;

		return cast copy;
	}

	/**
	  * Get the underlying Inv instance
	  */
	public function getInv():Inv return inv;

	/**
	  * Get the field-name for the given Resource
	  */
	private static function resname(r : Resource):String {
		return (switch ( r ) {
			case Faith:
				'faith';
			case Wood:
				'wood';
			case Meat:
				'meat';
			case Leather:
				'leather';

			default:
				throw 'Newp';
		});
	}

	/**
	  * Cast to Object
	  */
	public function toObject():Object {
		return cast inv;
	}

/* === Computed Instance Fields === */

	public var faith(get, set):Int;
	private inline function get_faith() return inv.faith;
	private inline function set_faith(v) return (inv.faith = v);

	public var wood(get, set):Int;
	private inline function get_wood() return inv.wood;
	private inline function set_wood(v) return (inv.wood = v);
	
	public var meat(get, set):Int;
	private inline function get_meat() return inv.meat;
	private inline function set_meat(v) return (inv.meat = v);

	public var leather(get, set):Int;
	private inline function get_leather() return inv.leather;
	private inline function set_leather(v) return (inv.leather = v);

/* === Instance Fields === */

	private var inv : Inv;
	private var oinv : Obj;
}

private typedef Inv = {
	@:optional var parent : Invent;
	var faith : Int;
	var wood : Int;
	var meat : Int;
	var leather : Int;
};
