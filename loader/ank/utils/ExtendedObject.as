class ank.utils.ExtendedObject extends Object
{
	function ExtendedObject()
	{
		super();
		this.initialize();
	}
	function initialize(§\x1e\n\f§)
	{
		this.clear();
		mx.events.EventDispatcher.initialize(this);
	}
	function clear(§\x1e\n\f§)
	{
		this._items = new Object();
		this._count = 0;
		this.dispatchEvent({type:"modelChanged"});
	}
	function addItemAt(§\f\x0e§, §\f\x15§)
	{
		if(this._items[var2] == undefined)
		{
			this._count++;
		}
		this._items[var2] = var3;
		this.dispatchEvent({type:"modelChanged"});
	}
	function removeItemAt(§\f\x0e§)
	{
		var var3 = this._items[var2];
		delete this._items.register2;
		this._count--;
		this.dispatchEvent({type:"modelChanged"});
		return var3;
	}
	function removeAll(§\x1e\n\f§)
	{
		this.clear();
	}
	function removeAllExcept(§\f\x0e§)
	{
		§§enumerate(this._items);
		while((var var0 = §§enumeration()) != null)
		{
			if(k != var2)
			{
				delete this._items.k;
			}
		}
		this._count = 1;
		this.dispatchEvent({type:"modelChanged"});
	}
	function replaceItemAt(§\f\x0e§, §\f\x15§)
	{
		if(this._items[var2] == undefined)
		{
			return undefined;
		}
		this._items[var2] = var3;
		this.dispatchEvent({type:"modelChanged"});
	}
	function getLength(§\x1e\n\f§)
	{
		return this._count;
	}
	function getItemAt(§\f\x0e§)
	{
		return this._items[var2];
	}
	function getItems(§\x1e\n\f§)
	{
		return this._items;
	}
	function getKeys()
	{
		var var2 = new Array();
		§§enumerate(this._items);
		while((var var0 = §§enumeration()) != null)
		{
			var2.push(k);
		}
		return var2;
	}
	function getPropertyValues(§\x1e\x0e\x18§)
	{
		var var3 = new Array();
		§§enumerate(this._items);
		while((var var0 = §§enumeration()) != null)
		{
			var3.push(this._items[k][var2]);
		}
		return var3;
	}
}
