class ank.gapi.core.UIAdvancedComponent extends ank.gapi.core.UIBasicComponent
{
	function UIAdvancedComponent()
	{
		super();
	}
	function __set__api(var2)
	{
		this._oAPI = var2;
		return this.__get__api();
	}
	function __get__api()
	{
		if(this._oAPI == undefined)
		{
			return this._parent.api;
		}
		return this._oAPI;
	}
	function __set__instanceName(var2)
	{
		this._sInstanceName = var2;
		return this.__get__instanceName();
	}
	function __get__instanceName()
	{
		return this._sInstanceName;
	}
	function callClose()
	{
		return false;
	}
	function unloadThis()
	{
		this.gapi.unloadUIComponent(this._sInstanceName);
	}
}
