class dofus.datacenter.Shop extends Object
{
	function Shop()
	{
		super();
		this.initialize();
	}
	function __set__id(sID)
	{
		this._sID = sID;
		return this.__get__id();
	}
	function __get__id()
	{
		return this._sID;
	}
	function __set__name(var2)
	{
		this._sName = var2;
		return this.__get__name();
	}
	function __get__name()
	{
		return this._sName;
	}
	function __set__gfx(var2)
	{
		this._sGfx = var2;
		return this.__get__gfx();
	}
	function __get__gfx()
	{
		return this._sGfx;
	}
	function __set__inventory(var2)
	{
		this._eaInventory = var2;
		this.dispatchEvent({type:"modelChanged"});
		return this.__get__inventory();
	}
	function __get__inventory()
	{
		return this._eaInventory;
	}
	function initialize()
	{
		mx.events.EventDispatcher.initialize(this);
	}
}
