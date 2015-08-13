package deitine.time;

import tannus.io.Ptr;
import tannus.math.TMath in Tm;
import tannus.math.TMath.*;
import Math.*;

abstract GameDate (Ptr<Int>) {
	/* Constructor Function */
	public inline function new(year:Int=0, month:Int=0, day:Int=0, hour:Int=0, minute:Int=0, second:Int=0):Void {
		var _n:Int = sum([
			second,
			(minute * MIN),
			(hour * HOUR),
			(day * DAY),
			(month * MONTH),
			(year * YEAR)
		]);
		this = Ptr.create(_n);
	}

/* === Instance Fields === */

	/**
	  * This
	  */
	private var self(get, set):Int;
	private inline function get_self() return this._;
	private inline function set_self(v : Int) return (this._ = v);

	/**
	  * Seconds
	  */
	public var seconds(get, set):Int;
	private inline function get_seconds() return floor(self % 60);
	private inline function set_seconds(ns : Int):Int {
		var cs = floor(self % 60);
		self -= cs;
		self += ns;
		return seconds;
	}

	/**
	  * Total Seconds
	  */
	public var totalSeconds(get, set):Int;
	private inline function get_totalSeconds() return self;
	private inline function set_totalSeconds(ns : Int) return (self = ns);

	/**
	  * Minutes
	  */
	public var minutes(get, set):Int;
	private inline function get_minutes() return floor((self / 60) % 60);
	private inline function set_minutes(nm : Int):Int {
		self = (self - (minutes*MIN) + (nm*MIN));
		return minutes;
	}

	/**
	  * Total Minutes
	  */
	public var totalMinutes(get, never):Int;
	private inline function get_totalMinutes():Int {
		return floor(self / 60);
	}
	private inline function set_totalMinutes(v : Int):Int {
		self -= floor(self / 60);
		self += v;
		return totalMinutes;
	}

	/**
	  * Hours
	  */
	public var hours(get, never):Int;
	private inline function get_hours():Int {
		return floor((self / HOUR) % M_DAY);
	}
	private inline function set_hours(v : Int):Int {
		self -= floor(hours * HOUR);
		self += floor(v * HOUR);
		return hours;
	}

	/**
	  * Total Hours
	  */
	public var totalHours(get, set):Int;
	private inline function get_totalHours():Int {
		return floor(self / HOUR);
	}
	private inline function set_totalHours(v : Int):Int {
		self -= floor(hours * HOUR);
		self += floor(v * HOUR);
		return totalHours;
	}

	/**
	  * Days
	  */
	public var days(get, set):Int;
	private inline function get_days():Int {
		return floor((self / DAY) % M_MONTH);
	}
	private inline function set_days(v : Int):Int {
		self -= floor(days * DAY);
		self += floor(v * DAY);
		return days;
	}

	/**
	  * Months
	  */
	public var months(get, set):Int;
	private inline function get_months() return floor((self / MONTH) % M_YEAR);
	private inline function set_months(v : Int):Int {
		self -= floor(months * MONTH);
		self += floor(v * MONTH);
		return months;
	}

	/**
	  * Years
	  */
	public var years(get, set):Int;
	private inline function get_years() return floor((self / YEAR));
	private inline function set_years(v : Int):Int {
		self -= floor(years * YEAR);
		self += floor(v * YEAR);
		return years;
	}

/* === Implicit Casting Methods === */

	/**
	  * To Date
	  */
	@:to
	public inline function toDate():Date {
		return new Date(years, months, days, hours, minutes, seconds);
	}

	/**
	  * To String
	  */
	@:to
	public inline function toString():String {
		return toDate().toString();
	}

	/**
	  * To Int
	  */
	@:to
	public inline function toInt():Int {
		return totalSeconds;
	}

	/**
	  * From Int
	  */
	@:from
	public static inline function fromInt(i : Int):GameDate {
		var d:GameDate = cast Ptr.create(i);
		return d;
	}

/* === Static Fields === */

	private static inline var M_HOUR:Int = 60;
	private static inline var M_DAY:Int = 24;
	private static inline var M_MONTH:Int = 30;
	private static inline var M_YEAR:Int = 12;

	private static inline var MIN:Int = 60;
	private static inline var HOUR:Int = (MIN * M_HOUR);
	private static inline var DAY:Int = (HOUR * M_DAY);
	private static inline var MONTH:Int = (DAY * M_MONTH);
	private static inline var YEAR:Int = (MONTH * M_YEAR);
}
