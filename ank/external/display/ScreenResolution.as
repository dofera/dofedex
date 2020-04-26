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
	function enable(loc2, loc3, loc4)
	{
		ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionEnable",loc2,loc3,loc4);
	}
	function disable()
	{
		ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionDisable");
	}
	function onScreenResolutionError(loc2)
	{
		this.dispatchEvent({type:"onScreenResolutionError"});
	}
	function onScreenResolutionSuccess(loc2)
	{
		this.dispatchEvent({type:"onScreenResolutionSuccess"});
	}
}
