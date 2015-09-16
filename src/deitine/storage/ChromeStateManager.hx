package deitine.storage;

import deitine.storage.IStateManager;
import tannus.chrome.Storage.local in area;
import tannus.ds.Object;

import haxe.Serializer;
import haxe.Unserializer;

class ChromeStateManager implements IStateManager {
	public function new():Void {
		
	}

	/**
	  * Persist the game-state to memory
	  */
	public function save(o:Object, done:Void->Void):Void {
		var s = new Serializer();
		s.useCache = true;
		s.useEnumIndex = true;
		s.serialize( o );
		var od:Object = {};
		od[NAME] = s.toString();
		area.set(od, done);
	}

	/**
	  * Load the game-state from memory
	  */
	public function load(cb : Null<Object>->Void):Void {
		area.get(NAME, function(res : Null<Object>) {
			if (res != null && res.exists(NAME))
				res = Unserializer.run(res[NAME]);
			cb( res );
		});
	}

	private static inline var NAME:String = 'deitine';
}
