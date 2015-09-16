package deitine.ds;

import deitine.ds.Material;

@:enum
abstract Resource (String) to String {
	/* Faith, for stuff */
	var Faith = 'faith';

	/* Wood, for building things */
	var Wood = 'wood';

	/* Meat, for eating */
	var Meat = 'meat';

	/* Leather, for clothing */
	var Leather = 'leather';

	/**
	  * Resource FROM String
	  */
	@:from
	public static inline function fromString(s : String):Resource {
		return cast s;
	}
}
