class ank.external.ExternalConnectorListerner
{
	function ExternalConnectorListerner()
	{
		mx.events.EventDispatcher.initialize(this);
		ank.external.ExternalConnector.getInstance().addEventListener("onExternalConnectionFaild",this);
	}
	function getParams()
	{
		return this._oParams;
	}
	function setParams(§\x1e\x18\x15§)
	{
		this._oParams = var2;
	}
	function removeListeners()
	{
		ank.external.ExternalConnector.getInstance().removeEventListener("onExternalConnectionFaild",this);
	}
	function onExternalConnectionFaild(§\x1e\x19\x18§)
	{
		this.dispatchEvent({type:"onExternalError"});
	}
}
