class ank.external.display.ScreenResolution extends ank.external.ExternalConnectorListerner
{
   function ScreenResolution()
   {
      super();
      ank.external.ExternalConnector.getInstance().addEventListener("onScreenResolutionError",this);
      ank.external.ExternalConnector.getInstance().addEventListener("onScreenResolutionSuccess",this);
   }
   function removeListeners()
   {
      super.removeListeners();
      ank.external.ExternalConnector.getInstance().removeEventListener("onScreenResolutionError",this);
      ank.external.ExternalConnector.getInstance().removeEventListener("onScreenResolutionSuccess",this);
   }
   function enable(nWidth, nHeight, nBitDepth)
   {
      ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionEnable",nWidth,nHeight,nBitDepth);
   }
   function disable()
   {
      ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionDisable");
   }
   function onScreenResolutionError(oEvent)
   {
      this.dispatchEvent({type:"onScreenResolutionError"});
   }
   function onScreenResolutionSuccess(oEvent)
   {
      this.dispatchEvent({type:"onScreenResolutionSuccess"});
   }
}
