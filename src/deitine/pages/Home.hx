package deitine.pages;

import deitine.ui.*;
import foundation.*;

import deitine.npc.tasks.*;

class Home extends Page {
	/* Constructor Function */
	public function new():Void {
		super();
		
		panes = new SplitPane([20, 80]);
		left = panes.pane(0);
		right = panes.pane(1);
		on('open', function(x) content.activate());

		build();
	}

/* === Instance Methods === */

	/**
	  * Build [this] Page
	  */
	private function build():Void {
		var h:Heading = new Heading(2, 'Deitine Home');
		h.textAlign = Center;
		h.fontFamily = 'Impact';
		append( h );
		append( panes );

		sidebar();

		var inv:Inventory = player.attach(Inventory);
		on('close', function(n) player.detach(inv));
		right.append(inv.table);

		var stats:Stats = village.attach(Stats);
		on('close', function(n) village.detach(stats));
		right.append(stats.table);
	}

	/**
	  * Build the 'side bar' Button Group
	  */
	private function sidebar():Void {
		/* Create the Button Group */
		var group = new foundation.ButtonGroup();
		group.vertical = true;
		left.append( group );

		/* Create the 'Create Follower' Button */
		var newVillager = new PurchaseButton(CreateFollower);
		newVillager.tiny = true;
		group.addButton( newVillager );

		/* Create the 'Create Priest' Button */
		var newPriest = new PurchaseButton(CreatePriest);
		newPriest.tiny = true;
		group.addButton( newPriest );

		/*
		var newGame = new CooldownButton('New Game', 1);
		newGame.tooltip = 'Start a Fresh Game';
		newGame.tiny = true;
		group.addButton( newGame );
		newGame.on('click', function(e) {
			tannus.chrome.Storage.local.clear(function() {
				untyped {
					chrome.runtime.reload();
				};
			});
		});
		*/
	}

/* === Instance Fields === */

	private var panes : SplitPane;
	private var left : Pane;
	private var right : Pane;
}
