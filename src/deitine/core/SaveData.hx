package deitine.core;

import tannus.chrome.Storage.local in storage;
import tannus.ds.Object;

import haxe.Serializer.run in encode;
import haxe.Unserializer.run in decode;

class SaveData {
	/* Constructor Function */
	public function new(n:String, ?state:Object):Void {
		name = n;
		data = (state!=null?state:{});
	}

/* === Instance Methods === */

	/**
	  * Save [this] Data
	  */
	public function save(done : Void->Void):Void {
		var sd:Object = new Object({});
		sd[name] = serialize();
		storage.set(sd, done);
	}

	/**
	  * Load [this] Data
	  */
	public function load(done : Object->Void):Void {
		storage.get(name, function(d : Object) {
			var sd:String = Std.string(d[name] || '');
			if (sd == '') {
				done(null);
			} else {
				var tdata = unserialize(sd);
				data = tdata;
				done( data );
			}
		});
	}

	/**
	  * Serialize [this] Data
	  */
	private inline function serialize():String {
		return encode(data);
	}

	/**
	  * Deserialize some Data
	  */
	private inline function unserialize(s : String):Dynamic {
		return decode(s);
	}

/* === Instance Fields === */

	public var data : Object;
	public var name : String;
}
