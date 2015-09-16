package deitine.storage;

import tannus.ds.Object;

interface IStateManager {
	function save(data:Object, complete:Void->Void):Void;
	function load(complete : Null<Object>->Void):Void;
}
