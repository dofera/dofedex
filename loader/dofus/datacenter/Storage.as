class dofus.datacenter.Storage extends Object
{
	var _bLocalOwner = false;
	var _bLocked = false;
	function Storage()
	{
		super();
		this.initialize();
	}
	function __set__localOwner(var2)
	{
		this._bLocalOwner = var2;
		return this.__get__localOwner();
	}
	function __get__localOwner()
	{
		return this._bLocalOwner;
	}
	function __set__isLocked(var2)
	{
		this._bLocked = var2;
		this.dispatchEvent({type:"locked",value:var2});
		return this.__get__isLocked();
	}
	function __get__isLocked()
	{
		return this._bLocked;
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
	function __set__Kama(var2)
	{
		this._nKamas = var2;
		this.dispatchEvent({type:"kamaChanged",value:var2});
		return this.__get__Kama();
	}
	function __get__Kama()
	{
		return this._nKamas;
	}
	function initialize()
	{
		mx.events.EventDispatcher.initialize(this);
	}
}
