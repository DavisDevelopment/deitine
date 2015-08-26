package deitine.ds;

import tannus.ds.Object;
import tannus.io.Ptr;

import deitine.ds.Resource;

import haxe.macro.Expr;

@:forward
abstract Inventory (Inv) from Inv {
	/* Constructor Function */
	public inline function new(o : Object):Void {
		this = {
			'faith' : (o['faith'] || 0),
			'wood' : (o['wood'] || 0),
			'meat' : (o['meat'] || 0),
			'leather' : (o['leather'] || 0)
		};
	}

/* === Instance Methods === */

	/**
	  * Add [count] amount of [res] Resource to [this] Income
	  */
	public function contribute(res:Resource, count:Int):Void {
		var field = resourceField(res);
		field.value += count;
	}

	/**
	  * Use [count] amount of [res] Resource
	  */
	public function consume(res:Resource, count:Int):Bool {
		var field = resourceField(res);
		if (field.value >= count) {
			field.value -= count;
			return true;
		} else {
			if (this.parent != null) {
				return this.parent.consume(res, count);
			} else return false;
		}
	}

	/**
	  * Append some other Inventory to [this] one
	  */
	public inline function append(child : Inventory):Void {
		child.parent = new Inventory(this);
	}

	/**
	  * Get the sum of [this] Inventory and another
	  */
	@:op(A + B)
	public function plus(other : Inventory):Inventory {
		var a:Object = new Object(this);
		var b:Object = new Object(other);
		var c:Object = new Object({});
		for (k in a.keys) {
		}
		return new Inventory(c);
	}

	/**
	  * Increment [this] Inventory by another
	  */
	@:op(A += B)
	public inline function increment(other : Inventory):Inventory {
		this = cast (new Inventory(this) + other);
		return cast this;
	}

	/**
	  * Cast [this] to an Object
	  */
	public inline function toObject():Object {
		return new Object(this).clone();
	}

/* === Instance Utility Methods === */

	/**
	  * Get a Pointer to the field associated with the given Resource
	  */
	private function resourceField(r : Resource):Ptr<Int> {
		switch (r) {
			case Faith:
				return Ptr.create(this.faith);

			case Wood:
				return Ptr.create(this.wood);

			case Meat:
				return Ptr.create(this.meat);

			case Leather:
				return Ptr.create(this.leather);

			default:
				throw new js.Error('No field for deitine.ds.Income associated with $r!');
		}
	}
}

private typedef Inv = {
	@:optional var parent : Inventory;
	var faith : Int;
	var wood : Int;
	var meat : Int;
	var leather : Int;
};
