class dofus.datacenter.PlayerShop extends Object
{
	function PlayerShop()
	{
		super();
		this.initialize();
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
