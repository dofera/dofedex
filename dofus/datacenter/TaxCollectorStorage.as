class dofus.datacenter.TaxCollectorStorage extends dofus.datacenter.Shop
{
   function TaxCollectorStorage()
   {
      super();
      this.initialize();
   }
   function __set__Kama(nKamas)
   {
      this._nKamas = nKamas;
      this.dispatchEvent({type:"kamaChanged",value:nKamas});
      return this.__get__Kama();
   }
   function __get__Kama()
   {
      return this._nKamas;
   }
}
