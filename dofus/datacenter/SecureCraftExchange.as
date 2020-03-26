class dofus.datacenter.SecureCraftExchange extends dofus.datacenter.Exchange
{
   var _nPayKama = 0;
   var _nPayIfSuccessKama = 0;
   function SecureCraftExchange(nDistantPlayerID)
   {
      super();
      this.initialize(nDistantPlayerID);
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
   function __set__payKama(nKama)
   {
      this._nPayKama = nKama;
      this.dispatchEvent({type:"payKamaChange",value:nKama});
      return this.__get__payKama();
   }
   function __get__payKama()
   {
      return this._nPayKama;
   }
   function __set__payIfSuccessKama(nKama)
   {
      this._nPayIfSuccessKama = nKama;
      this.dispatchEvent({type:"payIfSuccessKamaChange",value:nKama});
      return this.__get__payIfSuccessKama();
   }
   function __get__payIfSuccessKama()
   {
      return this._nPayIfSuccessKama;
   }
   function initialize(nDistantPlayerID)
   {
      super.initialize(nDistantPlayerID);
      this._eaCoopGarbage = new ank.utils.ExtendedArray();
      this._eaPayGarbage = new ank.utils.ExtendedArray();
      this._eaPayIfSuccessGarbage = new ank.utils.ExtendedArray();
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
