package deitine.ui;

import tannus.ds.Maybe;
import tannus.ds.Object;

import foundation.Pane;
import foundation.Span;
import foundation.Heading;

import deitine.ui.KVRow in Row;

class KVTable extends Pane {
	/* Constructor Function */
	public function new():Void {
		super();
		rows = new Map();
		heading = new Span('Title');
		var s = heading.el.style;
		s += {
			'display': 'block',
			'margin-left': 'auto',
			'margin-right': 'auto',
			'position': 'relative',
			'top': '-8px',
			'z-index': '10',
			'font-size': '15px',
			'width': 'auto'
		};
		heading.textAlign = Center;
		append( heading );

		styles.border('solid', '#000000', 2);
		styles.padding( 5 );
		styles.marginTop = 25;
	}

/* === Instance Methods === */

	/**
	  * Add a row to [this] KVTable
	  */
	public function addRow(name:String, ?val:String):Row {
		var row:Row = new Row(name, val);
		rows[name] = row;
		append( row );
		return row;
	}

	/**
	  * Get a Row by name
	  */
	public function getRow(name : String):Null<Row> {
		return rows[name];
	}

	/**
	  * Delete a Row by name
	  */
	public function deleteRow(name : String):Bool {
		return rows.remove(name);
	}

	/**
	  * Gets a Row by name, creating it if necessary
	  */
	public inline function row(name : String):Row {
		var r = getRow(name);
		if (r == null)
			r = addRow(name);
		return r;
	}

	/**
	  * Get the value of a Row, if it exists
	  */
	public function get(name : String):Null<String> {
		var row = getRow(name);
		if (row == null)
			return null;
		else 
			return row.value;
	}

	/**
	  * Set the value of a Row, if it exists
	  */
	public function set(name:String, value:String):String {
		var row:Null<Row> = getRow(name);
		if (row == null)
			row = addRow(name);

		return (row.value = value);
	}

	/**
	  * Set many values at once
	  */
	public function write(o : Object):Void {
		for (k in o.keys) {
			set(k, o[k]);
		}
	}

/* === Instance Fields === */

	public var rows : Map<String, Row>;
	public var heading : Span;
}
