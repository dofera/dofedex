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
	function setParams(loc2)
	{
		this._oParams = loc2;
	}
	function removeListeners()
	{
		ank.external.ExternalConnector.getInstance().removeEventListener("onExternalConnectionFaild",this);
	}
	function onExternalConnectionFaild(loc2)
	{
		this.dispatchEvent({type:"onExternalError"});
	}
}
