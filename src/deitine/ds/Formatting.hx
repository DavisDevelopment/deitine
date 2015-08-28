package deitine.ds;

import Std.*;

using StringTools;
using Lambda;

/**
  * Deitine's Formatting mixin
  */
class Formatting {
	/**
	  * Display an integer in standard format
	  */
	public static function prettyInt(num : Int):String {
		var res:String = '';
		var chars:Array<String> = string(num).split('');
		chars.reverse();
		var _i:Int = 0;
		for (c in chars) {
			if (_i == 3) {
				res += ',';
				_i = 0;
			}
			res += c;
			_i++;
		}
		chars = res.split('');
		chars.reverse();
		res = chars.join('');
		return res;
	}
}
