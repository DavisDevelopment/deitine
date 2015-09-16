package deitine.storage;

import tannus.ds.Object;
import deitine.storage.*;

@:forward
abstract StateManager (IStateManager) from IStateManager {
	/* Constructor Function */
	public inline function new (ig : IStateManager):Void {
		this = ig;
	}

/* === Statics === */

	/**
	  * Create a new GameSaver
	  */
	public static inline function create():StateManager {
		#if (js && chromeapp)
			return new ChromeStateManager();
		#else
			#error
		#end
	}
}
