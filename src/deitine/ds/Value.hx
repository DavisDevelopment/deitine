package deitine.ds;

import tannus.io.Signal;
import tannus.io.Ptr;

@:forward(map, mapFor)
abstract Value<T> (CValue<T>) {
	/* Constructor Function */
	public inline function new(v : T):Void {
		this = new CValue(v);
	}

/* === Instance Methods === */

	/**
	  * Get modified Value
	  */
	@:to
	public inline function get():T return this.get();
}

class CValue<T> {
	/* Constructor Function */
	public function new(v : T):Void {
		base = v;
		current = base;
		mods = new Array();
	}

/* === Instance Methods === */

	/**
	  * Add a Mod to [this] Value
	  */
	private inline function add(m : Mod<T>) mods.push( m );

	/**
	  * Reset [this] Value
	  */
	private inline function reset() {
		current = base;
	}

	/**
	  * Add a Mapper to [this] Value
	  */
	public function map(f : Mapper<T>):Void {
		add(Map( f ));
	}

	/**
	  * Add a timed Mapper to [this] Value
	  */
	public function mapFor(f:Mapper<T>, life:Int):Void {
		var now:Float = (Date.now().getTime());
		add(TimedMap(Map(f), now, life));
	}

	/**
	  * Get the modified value of [this]
	  */
	public function get():T {
		reset();
		for (m in mods)
			apply( m );
		return current;
	}

	/**
	  * Apply a Modifier to [this] Value
	  */
	private function apply(m : Mod<T>):Void {
		switch (m) {
			case Map( f ):
				current = f(current);

			case TimedMap(m, born, life):
				var now:Float = (Date.now().getTime());
				if (Math.round(now - born) > life) {
					apply( m );
				}

			default:
				null;
		}
	}

/* === Instance Fields === */

	private var base : T;
	private var current : T;
	private var mods : Array<Mod<T>>;
}

/**
  * enum of Value modifiers
  */
enum Mod<T> {
	/* Functional Mapping of a Value */
	Map(f : Mapper<T>);

	/* Map, but with a lifespan */
	TimedMap(m:Mod<T>, born:Float, lifespan:Int);
}

/* Typedef for a value-mapping Function */
private typedef Mapper<T> = T -> T;
