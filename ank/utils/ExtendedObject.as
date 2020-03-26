class ank.utils.ExtendedObject extends Object
{
   function ExtendedObject()
   {
      super();
      this.initialize();
   }
   function initialize(Void)
   {
      this.clear();
      mx.events.EventDispatcher.initialize(this);
   }
   function clear(Void)
   {
      this._items = new Object();
      this._count = 0;
      this.dispatchEvent({type:"modelChanged"});
   }
   function addItemAt(key, item)
   {
      if(this._items[key] == undefined)
      {
         this._count = this._count + 1;
      }
      this._items[key] = item;
      this.dispatchEvent({type:"modelChanged"});
   }
   function removeItemAt(key)
   {
      var _loc3_ = this._items[key];
      delete this._items.key;
      this._count = this._count - 1;
      this.dispatchEvent({type:"modelChanged"});
      return _loc3_;
   }
   function removeAll(Void)
   {
      this.clear();
   }
   function removeAllExcept(key)
   {
      for(var k in this._items)
      {
         if(k != key)
         {
            delete this._items.k;
         }
      }
      this._count = 1;
      this.dispatchEvent({type:"modelChanged"});
   }
   function replaceItemAt(key, item)
   {
      if(this._items[key] == undefined)
      {
         return undefined;
      }
      this._items[key] = item;
      this.dispatchEvent({type:"modelChanged"});
   }
   function getLength(Void)
   {
      return this._count;
   }
   function getItemAt(key)
   {
      return this._items[key];
   }
   function getItems(Void)
   {
      return this._items;
   }
   function getKeys()
   {
      var _loc2_ = new Array();
      for(var k in this._items)
      {
         _loc2_.push(k);
      }
      return _loc2_;
   }
   function getPropertyValues(sProperty)
   {
      var _loc3_ = new Array();
      for(var k in this._items)
      {
         _loc3_.push(this._items[k][sProperty]);
      }
      return _loc3_;
   }
}
