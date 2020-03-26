class dofus.datacenter.BigStore extends dofus.datacenter.Shop
{
   function BigStore()
   {
      super();
      this.initialize();
   }
   function __set__quantity1(nQuantity1)
   {
      this._nQuantity1 = nQuantity1;
      return this.__get__quantity1();
   }
   function __get__quantity1()
   {
      return this._nQuantity1;
   }
   function __set__quantity2(nQuantity2)
   {
      this._nQuantity2 = nQuantity2;
      return this.__get__quantity2();
   }
   function __get__quantity2()
   {
      return this._nQuantity2;
   }
   function __set__quantity3(nQuantity3)
   {
      this._nQuantity3 = nQuantity3;
      return this.__get__quantity3();
   }
   function __get__quantity3()
   {
      return this._nQuantity3;
   }
   function __set__types(aTypes)
   {
      this._aTypes = aTypes;
      return this.__get__types();
   }
   function __get__types()
   {
      return this._aTypes;
   }
   function __get__typesObj()
   {
      var _loc2_ = new Object();
      for(var k in this._aTypes)
      {
         _loc2_[this._aTypes[k]] = true;
      }
      return _loc2_;
   }
   function __set__tax(nTax)
   {
      this._nTax = nTax;
      return this.__get__tax();
   }
   function __get__tax()
   {
      return this._nTax;
   }
   function __set__maxLevel(nMaxLevel)
   {
      this._nMaxLevel = nMaxLevel;
      return this.__get__maxLevel();
   }
   function __get__maxLevel()
   {
      return this._nMaxLevel;
   }
   function __set__maxItemCount(nMaxItemCount)
   {
      this._nMaxItemCount = nMaxItemCount;
      return this.__get__maxItemCount();
   }
   function __get__maxItemCount()
   {
      return this._nMaxItemCount;
   }
   function __set__inventory2(eaInventory)
   {
      this._eaInventory2 = eaInventory;
      this.dispatchEvent({type:"modelChanged2"});
      return this.__get__inventory2();
   }
   function __get__inventory2()
   {
      return this._eaInventory2;
   }
}
