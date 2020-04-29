class ank.utils.ExtendedObject extends Object
{
	function ExtendedObject()
	{
		super();
		this.initialize();
	}
	function initialize(var2)
	{
		this.clear();
		mx.events.EventDispatcher.initialize(this);
	}
	function clear(var2)
	{
		this._items = new Object();
		this._count = 0;
		this.dispatchEvent({type:"modelChanged"});
	}
	function addItemAt(var2, var3)
	{
		if(this._items[var2] == undefined)
		{
			this._count++;
		}
		this._items[var2] = var3;
		this.dispatchEvent({type:"modelChanged"});
	}
	function removeItemAt(var2)
	{
		var var3 = this._items[var2];
		delete this._items.register2;
		this._count--;
		this.dispatchEvent({type:"modelChanged"});
		return var3;
	}
	function removeAll(var2)
	{
		this.clear();
	}
	function removeAllExcept(var2)
	{
		for(var k in this._items)
		{
			if(k != var2)
			{
				delete this._items.k;
			}
		}
		this._count = 1;
		this.dispatchEvent({type:"modelChanged"});
	}
	function replaceItemAt(var2, var3)
	{
		if(this._items[var2] == undefined)
		{
			return undefined;
		}
		this._items[var2] = var3;
		this.dispatchEvent({type:"modelChanged"});
	}
	function getLength(var2)
	{
		return this._count;
	}
	function getItemAt(var2)
	{
		return this._items[var2];
	}
	function getItems(var2)
	{
		return this._items;
	}
	function getKeys()
	{
		var var2 = new Array();
		for(var k in this._items)
		{
			var2.push(k);
		}
		return var2;
	}
	function getPropertyValues(var2)
	{
		var var3 = new Array();
		for(var k in this._items)
		{
			var3.push(this._items[k][var2]);
		}
		return var3;
	}
}
