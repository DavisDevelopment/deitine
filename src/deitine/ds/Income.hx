package deitine.ds;

import tannus.ds.Object;

import deitine.ds.CountedResource in Resource;

import haxe.macro.Expr;

abstract Income (Array<Resource>) {
	/* Constructor Function */
	public inline function new(?res : Array<Resource>):Void {
		this = (res!=null?res:[]);
	}

/* === Instance Fields === */

	/**
	  * Get the total count of a certain Resource
	  */
	private function count(name : String):Int {
		var n:Int = 0;
		for (e in iterator()) {
			if (Type.enumConstructor(e) == name)
				n += cast e.getParameters()[0];
		}
		return n;
	}

	/**
	  * Append a Resource to [this]
	  */
	private inline function add(res : Resource):Void {
		this.push(res);
	}

	/**
	  * Get the amount of faith in [this] Income
	  */
	public inline function getFaith():Int {
		return count('Faith');
	}

	/**
	  * Add Faith
	  */
	public inline function addFaith(n : Int):Void {
		add(Faith(n));
	}

	/**
	  * Iterate over [this] Income
	  */
	public inline function iterator():Iterator<Resource> {
		return this.iterator();
	}

	/**
	  * Add two incomes together
	  */
	@:op(A + B)
	public inline function plus(other : Income):Income {
		return new Income(this.concat(cast other));
	}

	/**
	  * Increment [this] Income by another
	  */
	@:op(A += B)
	public inline function increment(other : Income):Income {
		this = (this.concat(other));
		return cast this;
	}

	/**
	  * Cast to an Object
	  */
	@:to
	public inline function toObject():Object {
		return {
			'faith': getFaith()
		};
	}
}
