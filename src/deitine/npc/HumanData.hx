package deitine.npc;

import deitine.npc.HumanStats;

typedef HumanData = {
	/* == General == */
	var name : String;
	var id : String;
	var gender : Bool;
	var profession : Int;

	/* == Aging == */
	var current_age : Int;
	var max_age : Int;

	/* == Leveling System == */
	var level : Int;
	var experience : Int;

	/* == Stats == */
	var stats : HumanStats;

	/* == Should Be a Stat == */
	var base_faith : Int;
};
