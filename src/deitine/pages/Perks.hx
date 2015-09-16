package deitine.pages;

import deitine.ds.Perk;
import deitine.npc.Player;
import deitine.ui.*;
import foundation.*;

import tannus.io.Ptr;
import tannus.html.Win;

class Perks extends Page {
	/* Constructor Function */
	public function new():Void {
		super();

		var tit:String = '';
		_title = Ptr.create( tit );
		_title.attach( win.document.title );

		items = new Grid( 3 );
		heading = new Heading( 1 );
		_title.attach( heading.text );

		title = 'Perks';

		on('open', function(x) build());
	}

/* === Instance Methods === */

	/**
	  * Build [this] Page
	  */
	private function build():Void {
		append( heading );
		append( items );

	}

	/**
	  * Build the widget for a Perk
	  */
	private function perk(p : Class<Perk>) {
		var m = new Panel();
		var n = new Heading(5, p.name);
		m.append( n );

		return m;
	}

/* === Computed Instance Fields === */

	/**
	  * The title of [this] Page
	  */
	public var title(get, set):String;
	private inline function get_title() return _title.get();
	private inline function set_title(v) return _title.set( v );

/* === Instance Fields === */

	private var _title : Ptr<String>;
	public var items : Grid;
	public var heading : Heading;

	private var win:Win = {Win.current;};
}
