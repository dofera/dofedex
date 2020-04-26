class dofus.datacenter.ServerProblem extends Object
{
	function ServerProblem(§\x06\x02§, nDate, §\x1e\x1d\b§, nStatus, §\x1d\x10§, aHistory)
	{
		super();
		this._nID = loc3;
		this._nDate = nDate;
		this._nType = loc5;
		this._nStatus = nStatus;
		this._aServers = loc7;
		this._aHistory = aHistory;
		var loc9 = _global.API;
		this._sType = loc9.lang.getText("STATUS_PROBLEM_" + this._nType);
		this._sStatus = loc9.lang.getText("STATUS_STATE_" + this._nStatus);
		var loc10 = loc9.lang.getConfigText("LONG_DATE_FORMAT");
		var loc11 = loc9.config.language;
		var loc12 = String(this._nDate);
		var loc13 = new Date(Number(loc12.substr(0,4)),Number(loc12.substr(4,2)) - 1,Number(loc12.substr(6,2)));
		this._sDate = eval("\x1e\x19\x13").utils.SimpleDateFormatter.formatDate(loc13,loc10,loc11);
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
