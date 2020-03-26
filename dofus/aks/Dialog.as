class dofus.aks.Dialog extends dofus.aks.Handler
{
   function Dialog(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function begining(sNpcID)
   {
      this.aks.send("DB" + sNpcID,true);
   }
   function create(sNpcID)
   {
      this.aks.send("DC" + sNpcID,true);
   }
   function leave()
   {
      this.aks.send("DV",true);
   }
   function response(nQuestionID, nResponseID)
   {
      this.aks.send("DR" + nQuestionID + "|" + nResponseID,true);
   }
   function onCustomAction(sExtraData)
   {
      if((var _loc0_ = sExtraData) === "1")
      {
         getURL("javascript:DownloadOs()","_self");
      }
   }
   function onCreate(bSuccess, sExtraData)
   {
      if(!bSuccess)
      {
         return undefined;
      }
      var _loc4_ = Number(sExtraData);
      var _loc5_ = this.api.datacenter.Sprites.getItemAt(_loc4_);
      var _loc6_ = new Array();
      _loc6_[1] = _loc5_.color1 != undefined?_loc5_.color1:-1;
      _loc6_[2] = _loc5_.color2 != undefined?_loc5_.color2:-1;
      _loc6_[3] = _loc5_.color3 != undefined?_loc5_.color3:-1;
      this.api.ui.loadUIComponent("NpcDialog","NpcDialog",{name:_loc5_.name,gfx:_loc5_.gfxID,id:_loc4_,customArtwork:_loc5_.customArtwork,colors:_loc6_});
   }
   function onQuestion(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0].split(";");
      var _loc5_ = Number(_loc4_[0]);
      var _loc6_ = _loc4_[1].split(",");
      var _loc7_ = _loc3_[1].split(";");
      var _loc8_ = new dofus.datacenter.Question(_loc5_,_loc7_,_loc6_);
      this.api.ui.getUIComponent("NpcDialog").setQuestion(_loc8_);
   }
   function onPause()
   {
      this.api.ui.getUIComponent("NpcDialog").setPause();
   }
   function onLeave()
   {
      this.api.ui.unloadUIComponent("NpcDialog");
   }
}
