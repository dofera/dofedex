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
	function enable(var2, var3, var4)
	{
		ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionEnable",var2,var3,var4);
	}
	function disable()
	{
		ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionDisable");
	}
	function onScreenResolutionError(var2)
	{
		this.dispatchEvent({type:"onScreenResolutionError"});
	}
	function onScreenResolutionSuccess(var2)
	{
		this.dispatchEvent({type:"onScreenResolutionSuccess"});
	}
}
