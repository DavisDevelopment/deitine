package deitine.items;

@:enum
abstract Resource (String) from String to String {
/* === Constructs === */
	
	var Food = 'food';
	var Fur = 'fur';
	var Wood = 'wood';
	
/* === Fields === */

	/* reference to [this] as a Resource */
	private var self(get, never):Resource;
	private inline function get_self() return this;

	/* the name of [this] Resource */
	public var name(get, never):String;
	private inline function get_name() return this;

	/* the value of [this] Resource */
	public var value(get, never) : Int;
	private function get_value():Int {
		switch (self) {
			case Food:
				return 15;

			case Fur:
				return 30;

			case Wood:
				return 10;
		}
	}
}
