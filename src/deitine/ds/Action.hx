package deitine.ds;

import tannus.ds.Task;

class Action extends Task {
	/* Constructor Function */
	public function new():Void {
		super();
	}

/* === Instance Methods === */

	/**
	  * Checks whether [this] Action can currently be performed
	  */
	public function doable():Bool {
		return true;
	}
}
