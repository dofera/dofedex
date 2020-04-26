class dofus.datacenter.Order extends Object
{
	function Order(loc3)
	{
		super();
		this.api = _global.API;
		this.initialize(loc3);
	}
	function __get__index()
	{
		return this._nIndex;
	}
	function __set__index(loc2)
	{
		this._nIndex = !(_global.isNaN(loc2) || loc2 == undefined)?loc2:0;
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
	function initialize(loc2)
	{
		this._nIndex = loc2;
		this._oOrderInfos = this.api.lang.getAlignmentOrder(loc2);
	}
}
