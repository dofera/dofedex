class dofus.aks.Subareas extends dofus.aks.Handler
{
   function Subareas(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function onList(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      this.api.datacenter.Subareas.removeAll();
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = String(_loc3_[_loc4_]).split(";");
         var _loc6_ = Number(_loc5_[0]);
         var _loc7_ = Number(_loc5_[1]);
         var _loc8_ = new dofus.datacenter.Subarea(_loc6_,_loc7_);
         this.api.datacenter.Subareas.addItemAt(_loc6_,_loc8_);
         _loc4_ = _loc4_ + 1;
      }
   }
   function onAlignmentModification(sExtraData)
   {
      var _loc3_ = String(sExtraData).split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = Number(_loc3_[2]) == 1;
      var _loc7_ = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(_loc4_);
      if(_loc7_ == undefined)
      {
         _loc7_ = new dofus.datacenter.Subarea(_loc4_,_loc5_);
         this.api.datacenter.Subareas.addItemAt(_loc4_,_loc7_);
      }
      else
      {
         _loc7_.alignment.index = _loc5_;
      }
      if(!_loc6_)
      {
         if(_loc5_ == -1)
         {
            this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("SUBAREA_ALIGNMENT_PRISM_REMOVED",[_loc7_.name]) + "</b>","PVP_CHAT");
         }
         else
         {
            this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("SUBAREA_ALIGNMENT_IS",[_loc7_.name,_loc7_.alignment.name]) + "</b>","PVP_CHAT");
         }
      }
   }
}
