package deitine.ui;

import tannus.html.Element;
import tannus.ds.Object;
import tannus.ds.Maybe;
import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.io.EventDispatcher;

import deitine.core.Player;
import deitine.core.Engine;
import deitine.npc.Village;

import foundation.Pane;

class Page extends EventDispatcher {
	/* Constructor Function */
	public function new():Void {
		super();

		content = new Pane();
		styleContent();

		addSignals([
			'open',
			'close'
		]);
	}

/* === Instance Methods === */

	/**
	  * Open [this] Page
	  */
	public function open():Void {
		if (active != null) {
			active.close();
		}
	
		content.appendTo('body');
		content.activate();
		active = this;
		dispatch('open', null);
	}

	/**
	  * Close [this] Page
	  */
	public function close():Void {
		content.destroy();
		dispatch('close', null);
		active = null;
	}

	/**
	  * Append something to [this] Page
	  */
	public function append(child : Dynamic):Void {
		content.append( child );
	}

	/**
	  * Apply styles to the main content of [this] Page
	  */
	private function styleContent():Void {
		var s = content.el.style;
		s += {
			'width': '100%',
			'height': '100%'
		};
	}

/* === Computed Instance Fields === */

	/**
	  * References to the Player
	  */
	public var player(get, never):Player;
	private inline function get_player() return Player.instance;

	/**
	  * Reference to the Engine
	  */
	public var engine(get, never):Engine;
	private inline function get_engine() return Engine.instance;

	/**
	  * Reference to the Village
	  */
	public var village(get, never):Village;
	private inline function get_village() return player.village;

/* === Instance Fields === */

	private var content : Pane;

/* === Static Fields === */

	/* The currently open Page */
	public static var active : Null<Page>;
}
