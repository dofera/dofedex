class dofus.datacenter.ItemSet extends Object
{
   function ItemSet(nID, sEffects, aItemIDs)
   {
      super();
      this.initialize(nID,sEffects,aItemIDs);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__name()
   {
      return this.api.lang.getItemSetText(this._nID).n;
   }
   function __get__description()
   {
      return this.api.lang.getItemSetText(this._nID).d;
   }
   function __get__itemCount()
   {
      return this._aItems.length;
   }
   function __get__items()
   {
      return this._aItems;
   }
   function __get__effects()
   {
      return dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects);
   }
   function initialize(nID, sEffects, aItemIDs)
   {
      if(sEffects == undefined)
      {
         sEffects = "";
      }
      if(aItemIDs == undefined)
      {
         aItemIDs = [];
      }
      this.api = _global.API;
      this._nID = nID;
      this.setEffects(sEffects);
      this.setItems(aItemIDs);
   }
   function setEffects(compressedData)
   {
      this._sEffects = compressedData;
      this._aEffects = new Array();
      var _loc3_ = compressedData.split(",");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = _loc3_[_loc4_].split("#");
         _loc5_[0] = _global.parseInt(_loc5_[0],16);
         _loc5_[1] = _loc5_[1] != "0"?_global.parseInt(_loc5_[1],16):undefined;
         _loc5_[2] = _loc5_[2] != "0"?_global.parseInt(_loc5_[2],16):undefined;
         _loc5_[3] = _loc5_[3] != "0"?_global.parseInt(_loc5_[3],16):undefined;
         this._aEffects.push(_loc5_);
         _loc4_ = _loc4_ + 1;
      }
   }
   function setItems(aItemIDs)
   {
      var _loc3_ = this.api.lang.getItemSetText(this._nID).i;
      this._aItems = new Array();
      var _loc4_ = new Object();
      for(var k in aItemIDs)
      {
         _loc4_[aItemIDs[k]] = true;
      }
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         var _loc6_ = Number(_loc3_[_loc5_]);
         if(!_global.isNaN(_loc6_))
         {
            var _loc7_ = new dofus.datacenter.Item(0,_loc6_,1);
            var _loc8_ = _loc4_[_loc6_] == true;
            this._aItems.push({isEquiped:_loc8_,item:_loc7_});
         }
         _loc5_ = _loc5_ + 1;
      }
   }
}
