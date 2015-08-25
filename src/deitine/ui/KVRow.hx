package deitine.ui;

import tannus.ds.Maybe;

import foundation.Pane;
import foundation.Span;

class KVRow extends Pane {
	/* Constructor Function */
	public function new(k:String, ?v:Maybe<String>):Void {
		super();

		ename = new Pane();
		ename.text = k;
		ename.styles.float( Left );

		evalue = new Pane();
		evalue.text = (v || '?');
		evalue.styles.float( Right );

		clear = new Pane();
		clear.el.css('clear', 'both');

		append(ename);
		append(evalue);
		append(clear);

		var s = el.style;
		s['width'] = '100%';
	}

/* === Computed Instance Fields === */

	/**
	  * The name of [this] Row
	  */
	public var name(get, never):String;
	private inline function get_name() return ename.text;

	/**
	  * The value of [this] Row
	  */
	public var value(get, set):String;
	private inline function get_value() return evalue.text;
	private inline function set_value(v : String) return (evalue.text = v);

/* === Instance Fields === */

	private var ename : Pane;
	private var evalue : Pane;
	private var clear : Pane;
}
