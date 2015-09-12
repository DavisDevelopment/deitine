package deitine.ds;

class Perk {
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
