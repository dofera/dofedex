class dofus.aks.Job extends dofus.aks.Handler
{
   function Job(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function changeJobStats(nJobID, params, minSlots)
   {
      this.aks.send("JO" + nJobID + "|" + params + "|" + minSlots);
   }
   function onSkills(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = this.api.datacenter.Player.Jobs;
      var _loc5_ = 0;
      while(_loc5_ < _loc3_.length)
      {
         var _loc6_ = _loc3_[_loc5_].split(";");
         var _loc7_ = Number(_loc6_[0]);
         var _loc8_ = new ank.utils.ExtendedArray();
         var _loc9_ = _loc6_[1].split(",");
         var _loc10_ = _loc9_.length;
         while(true)
         {
            _loc10_;
            if(_loc10_-- > 0)
            {
               var _loc11_ = _loc9_[_loc10_].split("~");
               _loc8_.push(new dofus.datacenter.Skill(_loc11_[0],_loc11_[1],_loc11_[2],_loc11_[3],_loc11_[4]));
               continue;
            }
            break;
         }
         var _loc12_ = new dofus.datacenter.Job(_loc7_,_loc8_);
         var _loc13_ = _loc4_.findFirstItem("id",_loc7_);
         if(_loc13_.index != -1)
         {
            _loc4_.updateItem(_loc13_.index,_loc12_);
         }
         else
         {
            _loc4_.push(_loc12_);
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function onXP(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = this.api.datacenter.Player.Jobs;
      var _loc5_ = _loc3_.length;
      while(true)
      {
         _loc5_;
         if(_loc5_-- > 0)
         {
            var _loc6_ = _loc3_[_loc5_].split(";");
            var _loc7_ = Number(_loc6_[0]);
            var _loc8_ = Number(_loc6_[1]);
            var _loc9_ = Number(_loc6_[2]);
            var _loc10_ = Number(_loc6_[3]);
            var _loc11_ = Number(_loc6_[4]);
            var _loc12_ = _loc4_.findFirstItem("id",_loc7_);
            if(_loc12_.index != -1)
            {
               var _loc13_ = _loc12_.item;
               _loc13_.level = _loc8_;
               _loc13_.xpMin = _loc9_;
               _loc13_.xp = _loc10_;
               _loc13_.xpMax = _loc11_;
               _loc4_.updateItem(_loc12_.index,_loc13_);
            }
            continue;
         }
         break;
      }
   }
   function onLevel(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("NEW_JOB_LEVEL",[this.api.lang.getJobText(_loc4_).n,_loc5_]),"ERROR_BOX",{name:"NewJobLevel"});
   }
   function onRemove(sExtraData)
   {
      var _loc3_ = Number(sExtraData);
      var _loc4_ = this.api.datacenter.Player.Jobs;
      var _loc5_ = _loc4_.findFirstItem("id",_loc3_);
      if(_loc5_.index != -1)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_JOB",[_loc5_.item.name]),"INFO_CHAT");
         _loc4_.removeItems(_loc5_.index,1);
      }
   }
   function onOptions(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = Number(_loc3_[2]);
      this.api.datacenter.Player.Jobs[_loc4_].options = new dofus.datacenter.JobOptions(_loc5_,_loc6_);
   }
}
