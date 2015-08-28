package deitine.ds;

import tannus.io.Ptr;
import tannus.io.Signal2;
import tannus.ds.tuples.Tup2;
import tannus.ds.Object;

using Lambda;

class State {
	/* Constructor Function */
	public function new():Void {
		change = new Signal2();
		data = new Map();
	}

/* === Instance Methods === */

	/**
	  * Query whether [this] State has field [name]
	  */
	public function has(name : String):Bool {
		return data.exists(name);
	}

	/**
	  * Delete field [name] from [this] State
	  */
	public function delete(name : String):Bool {
		if (has(name)) {
			data.remove(name);
			change.call(name, DeleteField);
			return true;
		} else return false;
	}

	/**
	  * Get the value of field [name] of [this] State
	  */
	public function get<T>(name : String):Null<T> {
		if (has(name)) {
			var v:Dynamic = data.get(name);
			var _s:String = haxe.Json.stringify(v);
			defer({
				var n:String = haxe.Json.stringify(v);
				if (n != _s) 
					change.call(name, ChangeField(haxe.Json.parse(_s), v));
			});
			return (untyped v);
		} else return null;
	}

	/**
	  * Set the value of field [name]
	  */
	public function set<T>(name:String, value:T):T {
		if (has(name)) {
			var old:Dynamic = data.get(name);
			data.set(name, value);
			change.call(name, ChangeField(old, value));
			return get(name);
		} else {
			data.set(name, value);
			change.call(name, CreateField( value ));
			return get(name);
		}
	}

	/**
	  * Watch for changes to [this] State
	  */
	public function watch<T>(name:String, func:Change<T>->Void):Void {
		var test:String->Change<T>->Bool = (function(n, c) return (n == name));
		
		change.when(cast test, cast function(n, chng:Change<T>):Void {
			func( chng );
		});
	}

	/**
	  * Obtain a Pointer to a field of [this] State
	  */
	public function field<T>(name : String):Ptr<T> {
		return new Ptr(get.bind(name), set.bind(name));
	}

	/**
	  * Extract some data from [this] State as an Object
	  */
	public function extract(?keys:Array<String>):Object {
		if (keys == null)
			keys = [for (k in data.keys()) k];
		var o:Object = {};
		for (k in keys) {
			o[k] = data[k];
		}
		return o;
	}

	/**
	  * Defer an action until the end of the current Stack
	  */
	private static macro function defer(action) {
		return macro {
			js.Browser.window.setTimeout(function() {
				$action;
			}, 1);
		};
	}

/* === Instance Fields === */

	public var change : Signal2<String, Change<Dynamic>>;
	private var data : Map<String, Dynamic>;
}

enum Change<T> {
	CreateField(value : T);
	ChangeField(oval:T, nval:T);
	DeleteField;
}
