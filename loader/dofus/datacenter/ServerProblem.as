class dofus.datacenter.ServerProblem extends Object
{
	function ServerProblem(§\x05\x02§, nDate, §\x1e\x1c\x03§, nStatus, §\x1d\x0f§, aHistory)
	{
		super();
		this._nID = var3;
		this._nDate = nDate;
		this._nType = var5;
		this._nStatus = nStatus;
		this._aServers = var7;
		this._aHistory = aHistory;
		var var9 = _global.API;
		this._sType = var9.lang.getText("STATUS_PROBLEM_" + this._nType);
		this._sStatus = var9.lang.getText("STATUS_STATE_" + this._nStatus);
		var var10 = var9.lang.getConfigText("LONG_DATE_FORMAT");
		var var11 = var9.config.language;
		var var12 = String(this._nDate);
		var var13 = new Date(Number(var12.substr(0,4)),Number(var12.substr(4,2)) - 1,Number(var12.substr(6,2)));
		this._sDate = org.utils.SimpleDateFormatter.formatDate(var13,var10,var11);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__date()
	{
		return this._sDate;
	}
	function __get__type()
	{
		return this._sType;
	}
	function __get__status()
	{
		return this._sStatus;
	}
	function __get__servers()
	{
		return this._aServers;
	}
	function __get__history()
	{
		return this._aHistory;
	}
}
