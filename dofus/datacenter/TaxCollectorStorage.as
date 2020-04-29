class dofus.datacenter.TaxCollectorStorage extends dofus.datacenter.Shop
{
	function TaxCollectorStorage()
	{
		super();
		this.initialize();
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
}
