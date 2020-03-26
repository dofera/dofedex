class dofus.graphics.gapi.ui.bigstore.BigStoreSellFilter implements dofus.graphics.gapi.controls.inventoryviewer.IInventoryFilter
{
   var _nMaximalLevel = null;
   var _aAllowedTypes = null;
   function BigStoreSellFilter(maximalLevel, allowedTypes)
   {
      this._nMaximalLevel = maximalLevel;
      this._aAllowedTypes = allowedTypes;
   }
   function isItemListed(item)
   {
      if(this._nMaximalLevel != null && item.level > this._nMaximalLevel)
      {
         return false;
      }
      var _loc3_ = false;
      for(var i in this._aAllowedTypes)
      {
         if(item.type == Number(this._aAllowedTypes[i]))
         {
            _loc3_ = true;
            break;
         }
      }
      if(!_loc3_)
      {
         return false;
      }
      return true;
   }
}
