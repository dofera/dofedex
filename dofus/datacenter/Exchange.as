class dofus.datacenter.Exchange extends Object
{
	var _nLocalKama = 0;
	var _nDistantKama = 0;
	function Exchange(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function __set__inventory(loc2)
	{
		this._eaInventory = loc2;
		return this.__get__inventory();
	}
	function __get__inventory()
	{
		return this._eaInventory;
	}
	function __get__localGarbage()
	{
		return this._eaLocalGarbage;
	}
	function __get__distantGarbage()
	{
		return this._eaDistantGarbage;
	}
	function __get__coopGarbage()
	{
		return this._eaCoopGarbage;
	}
	function __get__readyStates()
	{
		return this._eaReadyStates;
	}
	function __get__distantPlayerID()
	{
		return this._nDistantPlayerID;
	}
	function __set__localKama(loc2)
	{
		this._nLocalKama = loc2;
		this.dispatchEvent({type:"localKamaChange",value:loc2});
		return this.__get__localKama();
	}
	function __get__localKama()
	{
		return this._nLocalKama;
	}
	function __set__distantKama(loc2)
	{
		this._nDistantKama = loc2;
		this.dispatchEvent({type:"distantKamaChange",value:loc2});
		return this.__get__distantKama();
	}
	function __get__distantKama()
	{
		return this._nDistantKama;
	}
	function initialize(loc2)
	{
		eval("\n\x0b").events.EventDispatcher.initialize(this);
		this._nDistantPlayerID = loc2;
		this._eaLocalGarbage = new ank.utils.();
		this._eaDistantGarbage = new ank.utils.();
		this._eaCoopGarbage = new ank.utils.();
		this._eaReadyStates = new ank.utils.();
		this._eaReadyStates[0] = false;
		this._eaReadyStates[1] = false;
	}
	function clearLocalGarbage()
	{
		this._eaLocalGarbage.removeAll();
	}
	function clearDistantGarbage()
	{
		this._eaDistantGarbage.removeAll();
	}
	function clearCoopGarbage()
	{
		this._eaCoopGarbage.removeAll();
	}
}
