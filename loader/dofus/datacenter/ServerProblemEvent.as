class dofus.datacenter.ServerProblemEvent extends Object
{
	function ServerProblemEvent(nTimestamp, nEventID, bTranslated, §\x1e\x13\x12§)
	{
		super();
		this._nTimestamp = nTimestamp;
		this._nID = nEventID;
		this._bTranslated = bTranslated;
		this._sContent = var6;
		var var7 = _global.API;
		this._sTitle = var7.lang.getText("STATUS_EVENT_" + this._nID);
		var var8 = var7.lang.getConfigText("HOUR_FORMAT");
		var var9 = var7.config.language;
		var var10 = new Date(this._nTimestamp);
		this._sHour = org.utils.SimpleDateFormatter.formatDate(var10,var8,var9);
	}
	function __get__timestamp()
	{
		return this._nTimestamp;
	}
	function __get__hour()
	{
		return this._sHour;
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__title()
	{
		return this._sTitle;
	}
	function __get__translated()
	{
		return this._bTranslated;
	}
	function __get__content()
	{
		return this._sContent;
	}
}
