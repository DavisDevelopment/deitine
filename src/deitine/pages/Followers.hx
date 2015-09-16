package deitine.pages;

import deitine.ui.*;
import tannus.nore.Selector;
import deitine.npc.Human;
import foundation.*;

using StringTools;
using tannus.ds.StringUtils;

@:access(deitine.npc.Village)
class Followers extends Page {
	public function new():Void {
		super();

		cache = true;
		panes = new SplitPane([25, 75]);
		fpanes = new Array();

		on('open', untyped build);
	}

/* === Instance Methods === */

	/**
	  * Initialize the content of [this] Page
	  */
	private function build():Void {
		var h = new Heading(2, 'Followers of [your name]');
		h.fontFamily = 'Impact';
		h.textAlign = Center;
		append( h );

		var nav = new Nav();
		var hl = new Link('Home', '#home');
		nav.addItem( hl );
		hl.on('click', function(e) {
			var hp = new Home();
			hp.open();
		});

		var fl = new Link('Followers', '#followers');
		nav.addItem( fl );

		append( nav );
		append( panes );
		sidebar();
		list();

		Selector.helper('male', function(o:Human, args) return (o.gender == Male));
		Selector.helper('female', function(o:Human, args) return (o.gender == Female));
	}

	/**
	  * Build the side-bar
	  */
	private function sidebar():Void {
		var pane = panes.pane( 0 );
		var h = new Heading(4, 'Search Followers');
		pane.append( h );
		h.textAlign = Center;

		var box = new TextInput();
		box.placeholder = 'filter followers';
		var change = box.change();
		change.on(function(ov, nv) {
			/* Search Term has just been removed */
			if (ov != '' && nv == '') {
				for (p in fpanes)
					p.el.css('display', 'block');
			}
			else if (nv.startsWith('~')) {
				try {
					var sel:Selector<Human> = nv.substring(1);
					for (p in fpanes) {
						var v:Human = cast p.meta('follower');
						p.el.css('display', 'none');
						if (sel.test( v ))
							p.el.css('display', 'block');
					}
				} 
				catch (err : String) {
					for (p in fpanes)
						p.el.css('display', 'block');
				}
			}
			else {
				var term:String = nv.trim().toLowerCase();
				for (p in fpanes) {
					var v:Human = cast p.meta('follower');
					p.el.css('display', 'none');
					var show:Bool = false;
					if (v.profession.toString().toLowerCase().startsWith(term)) {
						show = true;
					}
					else {
						var names = v.name.toLowerCase().split(' ');
						for (n in names) {
							if (n.has(term))
								show = true;
						}
					}

					if (show)
						p.el.css('display', 'block');
				}
			}
		});
		pane.append( box );
	}

	/**
	  * Build the Followers list
	  */
	private function list():Void {
		var pane = panes.pane( 1 );
		var ppl = village.villagers;

		for (v in ppl) {
			var vpane = followerPane( v );
			pane.append( vpane );
			fpanes.push( vpane );
		}
	}

	/**
	  * Build the Follower widget
	  */
	@:access(deitine.npc.Human)
	private function followerPane(v : Human) {
		var pane = new Panel();
		pane.meta('follower', v);
		pane.styles.backgroundColor(v.gender?'#87CEFA':'#FFB6C1');
		var ps = pane.el.style;
		ps['clear'] = 'both';

		var name = new Heading(5);
		name.text = '${v.name} #${v.id}';
		name.styles.float(Left);
		pane.append( name );

		/*
		var wacts = new Pane();
		wacts.el.style.writeObject({
			'float': 'right',
			'transform': 'scale(0.8)',
			'position': 'relative',
			'top': '-9px'
		});
		var actions = new foundation.SplitButton('actions');
		actions.tiny = true;
		actions.styles.float(Right);
		var lvlup = actions.addButton('level up (${50 * v.level}fp)');
		lvlup.on('click', function(e) {
			if (player.inv.stock(Faith) >= (50 * v.level)) {
				v.giveXp((50 * v.level) - v.xp);
				player.inv.consume(Faith, (50 * v.level));
			}
		});

		var kill = actions.addButton('kill');
		kill.on('click', function(e) {
			v.die();
		});

		wacts.append(actions);
		pane.append(wacts);
		*/

		var lvlup = new Button('level up (${50 * v.level}fp)');
		var desc = new Heading(5);

		function updatePane(x : Human) {
			desc.text = 'Level ${v.level} ${v.profession}';
			lvlup.text = 'level up (${50 * v.level}fp)';
			lvlup.disabled = (player.inv.stock(Faith) < (50 * v.level));
		}

		lvlup.styles.float( Right );
		lvlup.tiny = true;
		lvlup.on('click', function(e) {
			if (player.inv.stock(Faith) >= (50 * v.level)) {
				v.giveXp((50 * v.level) - v.xp);
				player.inv.consume(Faith, (50 * v.level));
			}
			updatePane(v);
		});
		lvlup.el.style.writeObject({
			'transform': 'scale(0.9)',
			'position': 'relative',
			'top': '-9px'
		});
		pane.append(lvlup);

		desc.text = 'Level ${v.level} ${v.profession}';
		desc.styles.float(Right);
		pane.append( desc );

		ps['width'] = '100%';
		ps['min-height'] = '40px';
		ps['padding'] = '10px';
		ps['margin-top'] = ps['margin-bottom'] = '8px';

		v.on('day', updatePane);
		on('close', function(x) {
			v.off('day', updatePane);
		});
		v.on('death', function(x) {
			v.off('day', updatePane);
			pane.destroy();
		});

		return pane;
	}

/* === Instance Fields === */
	
	private var panes : SplitPane;
	private var fpanes : Array<Panel>;
}
