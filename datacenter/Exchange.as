class dofus.datacenter.Exchange extends Object
{
   var _nLocalKama = 0;
   var _nDistantKama = 0;
   function Exchange(nDistantPlayerID)
   {
      super();
      this.initialize(nDistantPlayerID);
   }
   function __set__inventory(eaInventory)
   {
      this._eaInventory = eaInventory;
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
   function __set__localKama(nLocalKama)
   {
      this._nLocalKama = nLocalKama;
      this.dispatchEvent({type:"localKamaChange",value:nLocalKama});
      return this.__get__localKama();
   }
   function __get__localKama()
   {
      return this._nLocalKama;
   }
   function __set__distantKama(nDistantKama)
   {
      this._nDistantKama = nDistantKama;
      this.dispatchEvent({type:"distantKamaChange",value:nDistantKama});
      return this.__get__distantKama();
   }
   function __get__distantKama()
   {
      return this._nDistantKama;
   }
   function initialize(nDistantPlayerID)
   {
      mx.events.EventDispatcher.initialize(this);
      this._nDistantPlayerID = nDistantPlayerID;
      this._eaLocalGarbage = new ank.utils.ExtendedArray();
      this._eaDistantGarbage = new ank.utils.ExtendedArray();
      this._eaCoopGarbage = new ank.utils.ExtendedArray();
      this._eaReadyStates = new ank.utils.ExtendedArray();
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
