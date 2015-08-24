package deitine.ui;

import tannus.io.Ptr;
import tannus.io.Signal;
import tannus.ds.Object;
import tannus.math.Percent;
import tannus.graphics.Color;

import foundation.Button;
import deitine.time.Cooldown;
import Math.floor;

class CooldownButton extends Button {
	/* Constructor Function */
	public function new(txt:String, cd:Int):Void {
		super( txt );
		
		cooldown = new Cooldown( cd );

		enabledColor = '#008CBA';
		disabledColor = enabledColor.lighten( 23 );
		
		_events();
	}

/* === Instance Methods === */

	/**
	  * Method which creates event-handlers on [this] Widget
	  */
	private function _events():Void {
		addSignals(['cooldownstart', 'cooldownend']);

		on('click', _handle_click);
		el.css('background', enabledColor);

		on('cooldownstart', untyped set_disabled.bind(true));
		on('cooldownend', untyped set_disabled.bind(false));

		cooldown.complete.on(function(x) dispatch('cooldownend', null));
		cooldown.step.on(function(s) {
			setProgress(new Percent(100 - s.progress.value));
		});
	}

	/**
	  * Handle 'click' events
	  */
	private function _handle_click(event : Object):Void {
		if (!cooling) {
			dispatch('cooldownstart', null);
			cooldown.start();
		}
	}

	/**
	  * Stuff
	  */
	private function setProgress(prog : Percent):Void {
		var l:Int = floor(prog.value);
		var r:Int = floor(100 - prog.value);

		var lingrad:String = 'linear-gradient(90deg, $disabledColor $l%, $enabledColor $l%)';
		el.css('background', lingrad);
	}

/* === Computed Instance Fields === */

	public var cooling(get, never):Bool;
	private inline function get_cooling() return cooldown.running;

/* === Instance Fields === */

	/* How long it takes for [this] Button to become re-enabled */
	public var cooldown : Cooldown;
	public var enabledColor : Color;
	public var disabledColor : Color;
}
