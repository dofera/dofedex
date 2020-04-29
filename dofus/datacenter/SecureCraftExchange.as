class dofus.datacenter.SecureCraftExchange extends dofus.datacenter.Exchange
{
	var _nPayKama = 0;
	var _nPayIfSuccessKama = 0;
	function SecureCraftExchange(var3)
	{
		super();
		this.initialize(var3);
	}
	function __get__coopGarbage()
	{
		return this._eaCoopGarbage;
	}
	function __get__payGarbage()
	{
		return this._eaPayGarbage;
	}
	function __get__payIfSuccessGarbage()
	{
		return this._eaPayIfSuccessGarbage;
	}
	function __set__payKama(var2)
	{
		this._nPayKama = var2;
		this.dispatchEvent({type:"payKamaChange",value:var2});
		return this.__get__payKama();
	}
	function __get__payKama()
	{
		return this._nPayKama;
	}
	function __set__payIfSuccessKama(var2)
	{
		this._nPayIfSuccessKama = var2;
		this.dispatchEvent({type:"payIfSuccessKamaChange",value:var2});
		return this.__get__payIfSuccessKama();
	}
	function __get__payIfSuccessKama()
	{
		return this._nPayIfSuccessKama;
	}
	function initialize(var2)
	{
		super.initialize(var3);
		this._eaCoopGarbage = new ank.utils.();
		this._eaPayGarbage = new ank.utils.();
		this._eaPayIfSuccessGarbage = new ank.utils.();
	}
	function clearCoopGarbage()
	{
		this._eaCoopGarbage.removeAll();
	}
	function clearPayGarbage()
	{
		this._eaPayGarbage.removeAll();
	}
	function clearPayIfSuccessGarbage()
	{
		this._eaPayIfSuccessGarbage.removeAll();
	}
}
