class dofus.datacenter.TaxCollectorStorage extends dofus.datacenter.Shop
{
	function TaxCollectorStorage()
	{
		super();
		this.initialize();
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
}
