class dofus.aks.Quests extends dofus.aks.Handler
{
   function Quests(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function getList()
   {
      this.aks.send("QL");
   }
   function getStep(nQuestID, nDelta)
   {
      this.aks.send("QS" + nQuestID + (nDelta == undefined?"":"|" + (nDelta <= 0?nDelta:"+" + nDelta)));
   }
   function onList(sExtraData)
   {
      var _loc3_ = 0;
      var _loc4_ = new Array();
      if(sExtraData.length != 0)
      {
         var _loc5_ = sExtraData.split("|");
         var _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            var _loc7_ = _loc5_[_loc6_].split(";");
            var _loc8_ = Number(_loc7_[0]);
            var _loc9_ = _loc7_[1] == "1";
            var _loc10_ = Number(_loc7_[2]);
            if(!_loc9_)
            {
               _loc3_ = _loc3_ + 1;
            }
            var _loc11_ = new dofus.datacenter.Quest(_loc8_,_loc9_,_loc10_);
            _loc4_.push(_loc11_);
            _loc6_ = _loc6_ + 1;
         }
      }
      this.api.datacenter.Temporary.QuestBook.quests.replaceAll(0,_loc4_);
      this.api.ui.getUIComponent("Quests").setPendingCount(_loc3_);
   }
   function onStep(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = _loc3_[2];
      var _loc7_ = new ank.utils.ExtendedArray();
      var _loc8_ = _loc3_[3];
      var _loc9_ = _loc8_.length != 0?_loc8_.split(";"):new Array();
      _loc9_.reverse();
      var _loc10_ = _loc3_[4];
      var _loc11_ = _loc10_.length != 0?_loc10_.split(";"):new Array();
      var _loc12_ = _loc3_[5].split(";");
      var _loc13_ = _loc12_[0];
      var _loc14_ = _loc12_[1].split(",");
      var _loc15_ = _loc6_.split(";");
      var _loc16_ = 0;
      while(_loc16_ < _loc15_.length)
      {
         var _loc17_ = _loc15_[_loc16_].split(",");
         var _loc18_ = Number(_loc17_[0]);
         var _loc19_ = _loc17_[1] == "1";
         var _loc20_ = new dofus.datacenter.QuestObjective(_loc18_,_loc19_);
         _loc7_.push(_loc20_);
         _loc16_ = _loc16_ + 1;
      }
      var _loc21_ = this.api.datacenter.Temporary.QuestBook;
      var _loc22_ = _loc21_.getQuest(_loc4_);
      if(_loc22_ != null)
      {
         var _loc23_ = new dofus.datacenter.QuestStep(_loc5_,1,_loc7_,_loc9_,_loc11_,_loc13_,_loc14_);
         _loc22_.addStep(_loc23_);
         this.api.ui.getUIComponent("Quests").setStep(_loc23_);
      }
      else
      {
         ank.utils.Logger.err("[onStep] Impossible de trouver l\'objet de quête");
      }
   }
}
