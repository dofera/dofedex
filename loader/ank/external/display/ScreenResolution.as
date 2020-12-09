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
	function enable(§\x1e\x1b\x0f§, §\x05\x07§, §\b\x15§)
	{
		ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionEnable",var2,var3,var4);
	}
	function disable()
	{
		ank.external.ExternalConnector.getInstance().pushCall("ScreenResolutionDisable");
	}
	function onScreenResolutionError(§\x1e\x19\x18§)
	{
		this.dispatchEvent({type:"onScreenResolutionError"});
	}
	function onScreenResolutionSuccess(§\x1e\x19\x18§)
	{
		this.dispatchEvent({type:"onScreenResolutionSuccess"});
	}
}
