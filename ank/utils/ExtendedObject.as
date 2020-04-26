class ank.utils.ExtendedObject extends Object
{
	function ExtendedObject()
	{
		super();
		this.initialize();
	}
	function initialize(loc2)
	{
		this.clear();
		mx.events.EventDispatcher.initialize(this);
	}
	function clear(loc2)
	{
		this._items = new Object();
		this._count = 0;
		this.dispatchEvent({type:"modelChanged"});
	}
	function addItemAt(loc2, loc3)
	{
		if(this._items[loc2] == undefined)
		{
			this._count++;
		}
		this._items[loc2] = loc3;
		this.dispatchEvent({type:"modelChanged"});
	}
	function removeItemAt(loc2)
	{
		var loc3 = this._items[loc2];
		delete this._items.register2;
		this._count--;
		this.dispatchEvent({type:"modelChanged"});
		return loc3;
	}
	function removeAll(loc2)
	{
		this.clear();
	}
	function removeAllExcept(loc2)
	{
		for(var k in this._items)
		{
			if(k != loc2)
			{
				delete this._items.k;
			}
		}
		this._count = 1;
		this.dispatchEvent({type:"modelChanged"});
	}
	function replaceItemAt(loc2, loc3)
	{
		if(this._items[loc2] == undefined)
		{
			return undefined;
		}
		this._items[loc2] = loc3;
		this.dispatchEvent({type:"modelChanged"});
	}
	function getLength(loc2)
	{
		return this._count;
	}
	function getItemAt(loc2)
	{
		return this._items[loc2];
	}
	function getItems(loc2)
	{
		return this._items;
	}
	function getKeys()
	{
		var loc2 = new Array();
		for(var k in this._items)
		{
			loc2.push(k);
		}
		return loc2;
	}
	function getPropertyValues(loc2)
	{
		var loc3 = new Array();
		for(var k in this._items)
		{
			loc3.push(this._items[k][loc2]);
		}
		return loc3;
	}
}
