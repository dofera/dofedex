class dofus.datacenter.PlayerShop extends Object
{
   function PlayerShop()
   {
      super();
      this.initialize();
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
   function initialize()
   {
      mx.events.EventDispatcher.initialize(this);
   }
}
