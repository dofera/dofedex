class dofus.datacenter.BigStore extends dofus.datacenter.Shop
{
	function BigStore()
	{
		super();
		this.initialize();
	}
	function __set__quantity1(loc2)
	{
		this._nQuantity1 = loc2;
		return this.__get__quantity1();
	}
	function __get__quantity1()
	{
		return this._nQuantity1;
	}
	function __set__quantity2(loc2)
	{
		this._nQuantity2 = loc2;
		return this.__get__quantity2();
	}
	function __get__quantity2()
	{
		return this._nQuantity2;
	}
	function __set__quantity3(loc2)
	{
		this._nQuantity3 = loc2;
		return this.__get__quantity3();
	}
	function __get__quantity3()
	{
		return this._nQuantity3;
	}
	function __set__types(loc2)
	{
		this._aTypes = loc2;
		return this.__get__types();
	}
	function __get__types()
	{
		return this._aTypes;
	}
	function __get__typesObj()
	{
		var loc2 = new Object();
		for(var k in this._aTypes)
		{
			loc2[this._aTypes[k]] = true;
		}
		return loc2;
	}
	function __set__tax(loc2)
	{
		this._nTax = loc2;
		return this.__get__tax();
	}
	function __get__tax()
	{
		return this._nTax;
	}
	function __set__maxLevel(loc2)
	{
		this._nMaxLevel = loc2;
		return this.__get__maxLevel();
	}
	function __get__maxLevel()
	{
		return this._nMaxLevel;
	}
	function __set__maxItemCount(loc2)
	{
		this._nMaxItemCount = loc2;
		return this.__get__maxItemCount();
	}
	function __get__maxItemCount()
	{
		return this._nMaxItemCount;
	}
	function __set__inventory2(loc2)
	{
		this._eaInventory2 = loc2;
		this.dispatchEvent({type:"modelChanged2"});
		return this.__get__inventory2();
	}
	function __get__inventory2()
	{
		return this._eaInventory2;
	}
}
