class dofus.datacenter.Shop extends Object
{
	function Shop()
	{
		super();
		this.initialize();
	}
	function __set__name(loc2)
	{
		this._sName = loc2;
		return this.__get__name();
	}
	function __get__name()
	{
		return this._sName;
	}
	function __set__gfx(loc2)
	{
		this._sGfx = loc2;
		return this.__get__gfx();
	}
	function __get__gfx()
	{
		return this._sGfx;
	}
	function __set__inventory(loc2)
	{
		this._eaInventory = loc2;
		this.dispatchEvent({type:"modelChanged"});
		return this.__get__inventory();
	}
	function __get__inventory()
	{
		return this._eaInventory;
	}
	function initialize()
	{
		eval("\n\x0b").events.EventDispatcher.initialize(this);
	}
}
