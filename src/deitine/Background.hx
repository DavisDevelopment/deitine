package deitine;

import tannus.io.Ptr;
import tannus.ds.Object;
import tannus.html.WindowMessager in Socket;

import chrome.Runtime.onLaunch in onlaunch;
import chrome.Windows.create in createWin;

class Background {
	/* Constructor Function */
	public function new():Void {
		trace('Deitine doing stuff');
		onlaunch( launch );
	}

	/**
	  * Method invoked when [this] Application is launched
	  */
	public function launch(data : Object):Void {
		var options:Dynamic = {
			'state' : 'maximized',
			'focused' : true
		};

		createWin('pages/game.html', options, function( win ) {
			trace( win );
			var socket = new Socket();
			socket.connectWindow(win.contentWindow, handleComms.bind(socket));
			var w:tannus.html.Win = win.contentWindow;
			win.onClosed.addListener(function() {
				trace('Window is closing..');
				socket.send('event:close', null);
			});
		});
	}

	/**
	  * Method which handles communication with the game-window
	  */
	public function handleComms(s : Socket):Void {
		s.send('cheeks', [1, 2, 3, 4], function(res) {
			trace('GOT RESPONSE: $res');
		});
	}

/* === Static Methods === */

	/* Main Function */
	public static function main():Void {
		var bg = new Background();
	}
}
