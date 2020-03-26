class dofus.datacenter.Storage extends Object
{
   var _bLocalOwner = false;
   var _bLocked = false;
   function Storage()
   {
      super();
      this.initialize();
   }
   function __set__localOwner(bLocalOwner)
   {
      this._bLocalOwner = bLocalOwner;
      return this.__get__localOwner();
   }
   function __get__localOwner()
   {
      return this._bLocalOwner;
   }
   function __set__isLocked(bLocked)
   {
      this._bLocked = bLocked;
      this.dispatchEvent({type:"locked",value:bLocked});
      return this.__get__isLocked();
   }
   function __get__isLocked()
   {
      return this._bLocked;
   }
   function __set__inventory(eaInventory)
   {
      this._eaInventory = eaInventory;
      this.dispatchEvent({type:"modelChanged"});
      return this.__get__inventory();
   }
   function __get__inventory()
   {
      return this._eaInventory;
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
   function initialize()
   {
      mx.events.EventDispatcher.initialize(this);
   }
}
