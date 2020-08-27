class dofus.datacenter.Order extends Object
{
	function Order(var3)
	{
		super();
		this.api = _global.API;
		this.initialize(var3);
	}
	function __get__index()
	{
		return this._nIndex;
	}
	function __set__index(var2)
	{
		this._nIndex = !(_global.isNaN(var2) || var2 == undefined)?var2:0;
		return this.__get__index();
	}
	function __get__name()
	{
		return this._oOrderInfos.n;
	}
	function __get__alignment()
	{
		return new dofus.datacenter.(this._oOrderInfos.a);
	}
	function __get__iconFile()
	{
		return dofus.Constants.ORDERS_PATH + this._nIndex + ".swf";
	}
	function initialize(var2)
	{
		this._nIndex = var2;
		this._oOrderInfos = this.api.lang.getAlignmentOrder(var2);
	}
}
