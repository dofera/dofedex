class dofus.aks.Storages extends dofus.aks.Handler
{
   function Storages(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function onList(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = 0;
      while(_loc5_ < _loc4_.length)
      {
         var _loc6_ = _loc4_[_loc5_].split(";");
         var _loc7_ = _loc6_[0];
         var _loc8_ = _loc6_[1] == "1";
         var _loc9_ = this.api.datacenter.Storages;
         if(_loc3_)
         {
            var _loc10_ = _loc9_.getItemAt(_loc7_);
            if(_loc10_ == undefined)
            {
               _loc10_ = new dofus.datacenter.Storage();
            }
            _loc10_.isLocked = _loc8_;
            _loc9_.addItemAt(_loc7_,_loc10_);
         }
         else
         {
            _loc9_.removeItemAt(_loc7_);
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function onLockedProperty(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1] == "1";
      var _loc6_ = this.api.datacenter.Storages;
      var _loc7_ = _loc6_.getItemAt(_loc4_);
      if(_loc7_ == undefined)
      {
         _loc7_ = new dofus.datacenter.Storage(_loc4_);
         _loc6_.addItemAt(_loc4_,_loc7_);
      }
      _loc7_.isLocked = _loc5_;
   }
}
