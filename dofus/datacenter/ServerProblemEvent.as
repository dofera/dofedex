class dofus.datacenter.ServerProblemEvent extends Object
{
	function ServerProblemEvent(nTimestamp, nEventID, bTranslated, §\x1e\x15\t§)
	{
		super();
		this._nTimestamp = nTimestamp;
		this._nID = nEventID;
		this._bTranslated = bTranslated;
		this._sContent = loc6;
		var loc7 = _global.API;
		this._sTitle = loc7.lang.getText("STATUS_EVENT_" + this._nID);
		var loc8 = loc7.lang.getConfigText("HOUR_FORMAT");
		var loc9 = loc7.config.language;
		var loc10 = new Date(this._nTimestamp);
		this._sHour = org.utils.SimpleDateFormatter.formatDate(loc10,loc8,loc9);
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
