class dofus.aks.Key extends dofus.aks.Handler
{
   function Key(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function leave()
   {
      this.aks.send("KV",false);
   }
   function sendKey(nType, sKeyCode)
   {
      this.aks.send("KK" + nType + "|" + sKeyCode);
   }
   function onCreate(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      this.api.ui.loadUIComponent("KeyCode","KeyCode",{title:this.api.lang.getText("TYPE_CODE"),changeType:_loc4_,slotsCount:_loc5_});
   }
   function onKey(bSuccess)
   {
      var _loc3_ = !bSuccess?this.api.lang.getText("BAD_CODE"):this.api.lang.getText("CODE_CHANGED");
      this.api.kernel.showMessage(this.api.lang.getText("CODE"),_loc3_,"ERROR_BOX",{name:"Key"});
   }
   function onLeave()
   {
      this.api.ui.unloadUIComponent("KeyCode");
   }
}
