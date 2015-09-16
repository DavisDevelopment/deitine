package deitine.ui;

import foundation.*;
import tannus.html.Element;

class Nav extends List {
	/* Constructor Function */
	public function new():Void {
		super();
		styling();
	}

/* === Instance Methods === */

	/**
	  * Handle the styling for [this] Widget
	  */
	private function styling():Void {
		addClass('deitine-menu');

		var s = el.style;
		s += {
			'list-style': 'none',
			'text-align': 'center',
			'font-size': '135%',
			'font-family': 'Impact',
			'margin': 0,
			'padding': 0
		};
	}

	/**
	  * Add a Link to [this] Nav
	  */
	override public function addItem(item : Dynamic):Element {
		var li = super.addItem(item);
		var s = li.style;

		s['display'] = 'inline';
		s['padding-left'] = '6px';
		s['padding-right'] = '6px';

		var e:Element = li.find('*');
		e.style.writeObject({
			'margin-left': 6,
			'margin-right': 6
		});
		giveBorders();

		return li;
	}

	private function giveBorders() {
		var lis = el.find('li');
		var notlast = lis.filter(':not(:last-child)');
		lis.css('border-right', 'none');
		notlast.css('border-right', 'solid black 1px');
	}

/* === Instance Fields === */

}
