package deitine.pages;

import deitine.ui.*;
import foundation.*;

import deitine.ds.Perk;
import deitine.npc.tasks.*;

import deitine.ds.Perk;
import deitine.ds.perks.*;

class Home extends Page {
	/* Constructor Function */
	public function new():Void {
		super();
		
		panes = new SplitPane([20, 80]);
		left = panes.pane(0);
		right = panes.pane(1);

		on('open', untyped onopen);
	}

/* === Instance Methods === */

	/**
	  * Handle the opening of [this] Page
	  */
	private function onopen():Void {
		build();
		content.activate();
	}

	/**
	  * Build [this] Page
	  */
	private function build():Void {
		var h:Heading = new Heading(2, 'Deitine Home');
		h.textAlign = Center;
		h.fontFamily = 'Impact';
		append( h );
		village.on('update', function(x) {
			if (village.stopped) {
				h.text = 'Game has Stopped Due to Lag :c';
				h.textColor = '#FF0000';
			}
		});

		var nav:Nav = new Nav();
		append( nav );
		
		var homeLink = new Link('Home', '#home');
		homeLink.textColor = '#666';
		nav.addItem(homeLink);

		var follLink = new Link('Followers', '#followers');
		follLink.textColor = '#666';
		follLink.on('click', function(e) {
			trace('Opening Followers page..');
			var fp = new Followers();
			fp.open();
		});
		nav.addItem(follLink);

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

		/*
		   if the Player has the Breeding Perk, give them Buttons for each Profession
		 */
		if (player.hasPerk('breeding')) {
			/* Create the 'Create Villager' Button */
			var newVillager = new PurchaseButton(CreateFollower);
			newVillager.tiny = true;
			group.addButton( newVillager );

			/* Create the 'Create Lumberjack' Button */
			var newJack = new PurchaseButton(CreateWoodcutter);
			newJack.tiny = true;
			group.addButton( newJack );

			/* Create the 'Create Hunter' Button */
			var newHunter = new PurchaseButton(CreateHunter);
			newHunter.tiny = true;
			group.addButton( newHunter );

			/* Create the 'Create Priest' Button */
			var newPriest = new PurchaseButton(CreatePriest);
			newPriest.tiny = true;
			group.addButton( newPriest );

		}

		/* Otherwise, just Button for a Villager and a Priest will be given */
		else {
			/* Create the 'Create Follower' Button */
			var newVillager = new PurchaseButton(CreateFollower);
			newVillager.tiny = true;
			group.addButton( newVillager );

			/* Create the 'Create Priest' Button */
			var newPriest = new PurchaseButton(CreatePriest);
			newPriest.tiny = true;
			group.addButton( newPriest );
		}

		var newGame = new Button('New Game');
		newGame.tiny = true;
		group.addButton( newGame );
		newGame.on('click', function(e) {
			tannus.chrome.Storage.local.clear(function() {
				tannus.chrome.Runtime.reload();
			});
		});
	}

/* === Instance Fields === */

	private var panes : SplitPane;
	private var left : Pane;
	private var right : Pane;
}
