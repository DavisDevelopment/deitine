package deitine.ui;

import deitine.npc.Purchase;
import deitine.ui.CooldownButton;

@:access(deitine.npc.Purchase)
class PurchaseButton extends CooldownButton {
	/* Constructor Function */
	public function new(kl : Class<Purchase>):Void {
		super('?', 1000);

		purchase = Type.createInstance(kl, []);
		purchase.nam.attach( this.text );
		originalDescription = purchase.description;
		cooldown.duration = purchase.throttle;
		text = purchase.name;
		tooltip = purchase.description;

		on('mouseenter', function(x) update());
		on('mouseleave', function(x) update());

		on('click', buy);

		on('activate', function(x) {
			update();
		});
	}

/* === Instance Methods === */

	/**
	  * Update [this] Button
	  */
	private function update():Void {
		purchase.description = (purchase.doable()?originalDescription:'Not enough faith!');
		tooltip = purchase.description;
		text = purchase.name;
		purchase.player.update();
	}

	/**
	  * Make [this] Purchase
	  */
	public function buy(e : Dynamic):Void {
		this.cooldown.complete.once(function(x) {
			update();
		});
		purchase.buy();
	}

/* === Instance Fields === */

	public var purchase : Purchase;
	private var originalDescription : String;
}
