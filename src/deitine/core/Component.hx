package deitine.core;

import deitine.core.Entity;

import tannus.io.Signal;
import tannus.io.EventDispatcher;
import tannus.ds.Destructible;

class Component extends EventDispatcher implements Destructible {
	/* Constructor Function */
	public function new(e : Entity):Void {
		super();

		owner = e;
		
		owner.on('update', (function(x) update()));
		addSignals([
			'destroy',
			'update'
		]);

		var h = function(x) {
			day();
		};
		owner.on('day', h);
		on('destroy', function(x) owner.off('day', h));
	}

/* === Instance Methods === */

	/**
	  * Monitor [this] 
	  */
	public function day():Void {
		trace('Component captured the "day" event');
	}

	/**
	  * Delete [this] Component
	  */
	public function destroy():Void {
		dispatch('destroy', null);
	}

	/**
	  * Update [this] Component
	  */
	public function update():Void {
		dispatch('update', null);
	}

/* === Instance Fields === */

	public var owner : Entity;
}
