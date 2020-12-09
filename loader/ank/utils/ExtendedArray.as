class ank.utils.ExtendedArray extends Array
{
	function ExtendedArray()
	{
		super();
		this.initialize();
	}
	function removeEventListener()
	{
	}
	function addEventListener()
	{
	}
	function dispatchEvent()
	{
	}
	function dispatchQueue()
	{
	}
	function initialize(§\x1e\n\f§)
	{
		mx.events.EventDispatcher.initialize(this);
	}
	function isInNoEventDispatchsPeriod()
	{
		return this._bNoEventDispatchs;
	}
	function startNoEventDispatchsPeriod(§\x06\t§)
	{
		this._bNoEventDispatchs = true;
		if(this._nNoEventPeriodTimeout != undefined)
		{
			_global.clearTimeout(this._nNoEventPeriodTimeout);
		}
		var var3 = _global.setTimeout(this,"endNoEventDispatchsPeriod",var2);
		this._nNoEventPeriodTimeout = var3;
	}
	function endNoEventDispatchsPeriod()
	{
		this._bNoEventDispatchs = undefined;
		this._nNoEventPeriodTimeout = undefined;
		this.doDispatchEvent({type:"modelChanged",eventName:"updateAll"});
		var var2 = _global.API;
		var2.ui.getUIComponent("TaxCollectorStorage").refreshGetItemButton();
	}
	function createFromArray(§\x03§)
	{
		this.splice(0,this.length);
		var var3 = 0;
		while(var3 < var2.length)
		{
			this.push(var2[var3]);
			var3 = var3 + 1;
		}
	}
	function removeAll(§\x1e\n\f§)
	{
		this.splice(0,this.length);
		this.doDispatchEvent({type:"modelChanged",eventName:"updateAll"});
	}
	function push(§\x1e\n\x0f§)
	{
		var var4 = super.push(var3);
		this.doDispatchEvent({type:"modelChanged",eventName:"addItem"});
		return var4;
	}
	function pop()
	{
		var var3 = super.pop();
		this.doDispatchEvent({type:"modelChanged",eventName:"updateAll"});
		return var3;
	}
	function shift()
	{
		var var3 = super.shift();
		this.doDispatchEvent({type:"modelChanged",eventName:"updateAll"});
		return var3;
	}
	function unshift(§\x1e\n\x0f§)
	{
		var var4 = super.unshift(var3);
		this.doDispatchEvent({type:"modelChanged",eventName:"updateAll"});
		return var4;
	}
	function reverse()
	{
		super.reverse();
		this.doDispatchEvent({type:"modelChanged",eventName:"updateAll"});
	}
	function replaceAll(§\x1e\x1d\n§, §\x1e\x05§)
	{
		var var4 = [var2,0];
		§§enumerate(var3);
		while((var var0 = §§enumeration()) != null)
		{
			var4.push(var3[k]);
		}
		this.splice.apply(this,var4);
		this.doDispatchEvent({type:"modelChanged",eventName:"updateAll"});
	}
	function removeItems(§\x04\x17§, §\x11\f§)
	{
		this.splice(var2,var3);
		this.doDispatchEvent({type:"modelChanged",eventName:"updateAll"});
	}
	function updateItem(§\x04\x17§, §\x05\x1b§)
	{
		this.splice(var2,1,var3);
		this.doDispatchEvent({type:"modelChanged",eventName:"updateOne",updateIndex:var2});
	}
	function findFirstItem(§\x1e\x0e\x17§, §\x1e\x16\x0f§)
	{
		var var4 = 0;
		while(var4 < this.length)
		{
			var var5 = this[var4];
			if(var5[var2] == var3)
			{
				return {index:var4,item:var5};
			}
			var4 = var4 + 1;
		}
		return {index:-1};
	}
	function clone()
	{
		var var2 = new ank.utils.
();
		var var3 = 0;
		while(var3 < this.length)
		{
			var2.push(this[var3].clone());
			var3 = var3 + 1;
		}
		return var2;
	}
	function shuffle()
	{
		var var2 = this.clone();
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = var2[var3];
			var var5 = random(var2.length);
			var2[var3] = var2[var5];
			var2[var5] = var4;
			var3 = var3 + 1;
		}
		return var2;
	}
	function doDispatchEvent(§\x1e\x19\x18§)
	{
		if(this.isInNoEventDispatchsPeriod())
		{
			return undefined;
		}
		this.dispatchEvent(var2);
	}
	function bubbleSortOn(§\x1e\x16\x11§, §\x0e\x10§)
	{
		if((var3 & Array.ASCENDING) == 0 && (var3 & Array.DESCENDING) == 0)
		{
			var3 = var3 | Array.ASCENDING;
		}
		while(true)
		{
			var var4 = false;
			var var5 = 1;
			while(var5 < this.length)
			{
				if((var3 & Array.ASCENDING) > 0 && this[var5 - 1][var2] > this[var5][var2] || (var3 & Array.DESCENDING) > 0 && this[var5 - 1][var2] < this[var5][var2])
				{
					var var6 = this[var5 - 1];
					this[var5 - 1] = this[var5];
					this[var5] = var6;
					var4 = true;
				}
				var5 = var5 + 1;
			}
			if(var4)
			{
				continue;
			}
			break;
		}
	}
	function concat(§\x1e\x1a\x14§)
	{
		var var4 = super.concat(var3);
		var var5 = new ank.utils.
();
		var5.createFromArray(var4);
		return var5;
	}
}
