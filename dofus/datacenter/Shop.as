class dofus.datacenter.Shop extends Object
{
   function Shop()
   {
      super();
      this.initialize();
   }
   function __set__name(sName)
   {
      this._sName = sName;
      return this.__get__name();
   }
   function __get__name()
   {
      return this._sName;
   }
   function __set__gfx(sGfx)
   {
      this._sGfx = sGfx;
      return this.__get__gfx();
   }
   function __get__gfx()
   {
      return this._sGfx;
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
