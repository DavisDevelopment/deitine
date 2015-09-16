package deitine;

import tannus.math.Random;
import tannus.io.ByteArray;
import tannus.io.Byte;
import tannus.ds.IntRange;

using tannus.math.RandomTools;

@:expose('Utils')
class Utils {
	/**
	  * Generate a random String with the specified number of digits
	  */
	public static function randomString(len : Int):String {
		var valid:Array<IntRange> = [new IntRange(48, 57), new IntRange(65, 90)];
		var bits:ByteArray = new ByteArray();
		var b:Byte;
		for (i in 0...len) {
			b = valid.choice().between();
			bits.writeByte( b );
		}
		return bits.toString();
	}
}
