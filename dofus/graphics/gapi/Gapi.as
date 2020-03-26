class dofus.graphics.gapi.Gapi extends ank.gapi.Gapi
{
   function Gapi()
   {
      super();
   }
   function loadUIComponent(sLink, sInstanceName, oComponentParams, oUIParams)
   {
      this.api.kernel.TipsManager.onNewInterface(sLink);
      this.api.kernel.StreamingDisplayManager.onNewInterface(sLink);
      var _loc7_ = super.loadUIComponent(sLink,sInstanceName,oComponentParams,oUIParams);
      return _loc7_;
   }
   function unloadUIComponent(sInstanceName)
   {
      this.api.kernel.StreamingDisplayManager.onInterfaceClose(sInstanceName);
      return super.unloadUIComponent(sInstanceName);
   }
}
