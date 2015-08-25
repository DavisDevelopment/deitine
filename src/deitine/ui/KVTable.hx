package deitine.ui;

import tannus.ds.Maybe;
import tannus.ds.Object;

import foundation.Pane;
import foundation.Span;

import deitine.ui.KVRow in Row;

class KVTable extends Pane {
	/* Constructor Function */
	public function new():Void {
		super();
		rows = new Array();

		styles.border('solid', '#000000', 2);
		styles.padding( 5 );
	}

/* === Instance Methods === */

	/**
	  * Add a row to [this] KVTable
	  */
	public function addRow(name:String, ?val:String):Row {
		var row:Row = new Row(name, val);
		rows.push( row );
		append( row );
		return row;
	}

	/**
	  * Get a Row by name
	  */
	public function getRow(name : String):Null<Row> {
		for (row in rows) {
			if (row.name == name)
				return row;
		}
		return null;
	}

	/**
	  * Delete a Row by name
	  */
	public function deleteRow(name : String):Bool {
		var row:Null<Row> = getRow(name);
		if (row == null) {
			return false;
		} else {
			rows.remove( row );
			row.destroy();
			return true;
		}
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
		var mrow:Maybe<Row> = getRow(name);
		var row:Row = (mrow || addRow(name));

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

	public var rows : Array<Row>;
}
