class dofus.datacenter.Storage extends Object
{
	var _bLocalOwner = false;
	var _bLocked = false;
	function Storage()
	{
		super();
		this.initialize();
	}
	function __set__localOwner(loc2)
	{
		this._bLocalOwner = loc2;
		return this.__get__localOwner();
	}
	function __get__localOwner()
	{
		return this._bLocalOwner;
	}
	function __set__isLocked(loc2)
	{
		this._bLocked = loc2;
		this.dispatchEvent({type:"locked",value:loc2});
		return this.__get__isLocked();
	}
	function __get__isLocked()
	{
		return this._bLocked;
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
	function __set__Kama(loc2)
	{
		this._nKamas = loc2;
		this.dispatchEvent({type:"kamaChanged",value:loc2});
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
