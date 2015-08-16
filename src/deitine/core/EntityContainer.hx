package deitine.core;

import deitine.core.Entity;

using Lambda;

class EntityContainer extends Entity {
	/* Constructor Function */
	public function new():Void {
		super();
		children = new Array();
	}

/* === Instance Methods === */

	/**
	  * Check whether [e] is a child of [this]
	  */
	public function hasChild(e : Entity):Bool 
		return children.has( e );

	/**
	  * Add [child] as a child of [this] Container
	  */
	public function addChild(child : Entity):Void {
		if (!children.has(child))
			children.push( child );
	}

	/**
	  * Remove [child] from [this]
	  */
	public function removeChild(child : Entity):Bool {
		return children.remove( child );
	}

/* === Instance Fields === */

	public var children : Array<Entity>;
}
