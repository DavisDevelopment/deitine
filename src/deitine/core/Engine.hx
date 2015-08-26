package deitine.core;

import tannus.io.Signal;
import tannus.io.Ptr;
import tannus.io.EventDispatcher;
import tannus.ds.Promise;
import tannus.ds.promises.*;
import tannus.ds.Object;

import deitine.time.Clock;
import deitine.time.GameDate;
import deitine.core.Entity;
import deitine.core.Player;

using Lambda;

class Engine extends EventDispatcher {
	/* Constructor Function */
	public function new():Void {
		super();

		if (instance == null) {
			clock = new Clock(8 * 1000);
			date = new GameDate(0, 0, 0);
			launch = new Signal();
			shutdown = new Signal();
			onsave = new Signal();
			onload = new Signal();
			tick = new Signal();
			entities = new Array();

			instance = this;
			player = new Player();
			attach( player );

			__init();
		}
		else throw 'EngineError: Cannot create multiple instances of deitine.core.Engine!';
	}

/* === Instance Methods === */

	/**
	  * Initialize [this] Engine
	  */
	private function __init():Void {
		clock.onTick( clockTick );
	}

	/**
	  * Start [this] Engine
	  */
	public function start():Void {
		clock.start();

		launch.call( this );
	}

	/**
	  * Stop [this] Engine
	  */
	public function stop():Void {
		clock.stop();

		for (e in entities) {
			e.destroy();
		}

		shutdown.call( this );
	}

	/**
	  * Save [this] Game
	  */
	public function save():Void {
		var state:Object = {
			'saved_at': (Std.int(Date.now().getTime()))
		};
		onsave.call( state );
		var data:SaveData = new SaveData('deitine', state);
		data.save(function() {
			trace('Game Saved!');
		});
	}

	/**
	  * Load [this] Game
	  */
	public function load(done : Void->Void):Void {
		var sd = new SaveData('deitine');
		sd.load(function(data) {
			onload.call( data );
			if (data != null)
				makeupdays(data['saved_at']);
			done();
		});
	}

	/**
	  * Catch up the days
	  */
	public function makeupdays(ms : Int):Void {
		var now:Int = Std.int(Date.now().getTime());
		var dif:Int = (now - ms);
		trace( dif );
		var days:Int = Math.round(Math.abs(dif / 8000));
		trace('$days have passed since you last visited us');

		for (i in 0...days) {
			for (e in entities) {
				e.day( date );
			}
		}
	}

	/**
	  * Attach some Entity to [this] Engine
	  */
	public function attach(child : Entity):Void {
		if (!entities.has( child ))
			entities.push( child );
	}

	/**
	  * Obtain an Array of all Entities attached to [this] Engine
	  */
	private function getAll():Array<Entity> {
		var all:Array<Entity> = new Array();
		for (e in entities) {
			if (Std.is(e, EntityContainer)) {
				all = all.concat(cast(e, EntityContainer).children);
				all.push( e );
			}
			else
				all.push( e );
		}
		return all;
	}

	/**
	  * Query [this] Engine using an ORegEx
	  */
	public function query(q : String):Array<Entity> {
		return getAll().filter(function(e) return (new Object(e)).is(q));
	}

	/**
	  * Method called for each 'tick' of [clock]
	  */
	private function clockTick(d : Int):Void {
		date.minutes += 60;

		for (child in entities) {
			child.day( date );
		}

		tick.call( date );
		save();
	}

/* === Instance Fields === */

	private var clock : Clock;
	private var entities : Array<Entity>;

	public var player : Player;
	public var date : GameDate;
	public var launch : Signal<Engine>;
	public var shutdown : Signal<Engine>;
	public var tick : Signal<GameDate>;
	public var onsave : Signal<Object>;
	public var onload : Signal<Object>;

/* === Static Fields === */

	public static var instance : Null<Engine> = null;
}
