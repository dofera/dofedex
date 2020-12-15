class dofus.datacenter.BigStore extends dofus.datacenter.Shop
{
	function BigStore()
	{
		super();
		this.initialize();
	}
	function __set__quantity1(var2)
	{
		this._nQuantity1 = var2;
		return this.__get__quantity1();
	}
	function __get__quantity1()
	{
		return this._nQuantity1;
	}
	function __set__quantity2(var2)
	{
		this._nQuantity2 = var2;
		return this.__get__quantity2();
	}
	function __get__quantity2()
	{
		return this._nQuantity2;
	}
	function __set__quantity3(var2)
	{
		this._nQuantity3 = var2;
		return this.__get__quantity3();
	}
	function __get__quantity3()
	{
		return this._nQuantity3;
	}
	function __set__types(var2)
	{
		this._aTypes = var2;
		return this.__get__types();
	}
	function __get__types()
	{
		return this._aTypes;
	}
	function __get__typesObj()
	{
		var var2 = new Object();
		for(var k in this._aTypes)
		{
			var2[this._aTypes[k]] = true;
		}
		return var2;
	}
	function __set__tax(var2)
	{
		this._nTax = var2;
		return this.__get__tax();
	}
	function __get__tax()
	{
		return this._nTax;
	}
	function __set__maxLevel(var2)
	{
		this._nMaxLevel = var2;
		return this.__get__maxLevel();
	}
	function __get__maxLevel()
	{
		return this._nMaxLevel;
	}
	function __set__maxItemCount(var2)
	{
		this._nMaxItemCount = var2;
		return this.__get__maxItemCount();
	}
	function __get__maxItemCount()
	{
		return this._nMaxItemCount;
	}
	function __set__inventory2(var2)
	{
		this._eaInventory2 = var2;
		this.dispatchEvent({type:"modelChanged2"});
		return this.__get__inventory2();
	}
	function __get__inventory2()
	{
		return this._eaInventory2;
	}
}
