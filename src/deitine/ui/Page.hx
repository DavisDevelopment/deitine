package deitine.ui;

import tannus.html.Element;
import tannus.ds.Object;
import tannus.ds.Maybe;
import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.io.EventDispatcher;

import deitine.ds.State;
import deitine.core.Player;
import deitine.core.Engine;
import deitine.npc.Village;

import foundation.Pane;

class Page extends EventDispatcher {
	/* Constructor Function */
	public function new():Void {
		super();

		content = new Pane();
		cache = false;
		styleContent();

		addSignals([
			'open',
			'reopen',
			'close'
		]);

		state = new State();
		state.set('opened', false);
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
		if (cache && state.get('opened')) {
			dispatch('reopen', null);
		}
		else {
			dispatch('open', null);
		}
		state.set('opened', true);
	}

	/**
	  * Close [this] Page
	  */
	public function close():Void {
		(cache?content.detach:content.destroy)();
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

	/**
	  * Whether [this] Page is minimized right now
	  */
	public var minimized(get, never):Bool;
	private inline function get_minimized() {
		return (active != this && cache);
	}

/* === Instance Fields === */

	private var state : State;
	private var content : Pane;
	private var cache : Bool;

/* === Static Fields === */

	/* The currently open Page */
	public static var active : Null<Page>;
}
