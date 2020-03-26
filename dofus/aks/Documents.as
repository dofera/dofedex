class dofus.aks.Documents extends dofus.aks.Handler
{
   function Documents(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function leave()
   {
      this.aks.send("dV");
   }
   function onCreate(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = sExtraData;
         var _loc5_ = this.api.config.language;
         this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("LOADING"),background:false},{bForceLoad:true});
         this.api.kernel.DocumentsServersManager.loadDocument(_loc5_ + "_" + _loc4_);
      }
   }
   function onLeave()
   {
      this.api.ui.unloadUIComponent("Document");
   }
}
