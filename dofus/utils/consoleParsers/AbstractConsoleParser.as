class dofus.utils.consoleParsers.AbstractConsoleParser
{
	function AbstractConsoleParser()
	{
	}
	function __get__api()
	{
		return this._oAPI;
	}
	function __set__api(loc2)
	{
		this._oAPI = loc2;
		return this.__get__api();
	}
	function initialize(loc2)
	{
		this._oAPI = loc2;
		this._aConsoleHistory = new Array();
		this._nConsoleHistoryPointer = 0;
	}
	function process(loc2, loc3)
	{
		this.pushHistory({value:loc2,params:loc3});
	}
	function pushHistory(loc2)
	{
		var loc3 = this._aConsoleHistory.slice(-1);
		if(loc3[0].value != loc2.value)
		{
			var loc4 = this._aConsoleHistory.push(loc2);
			if(loc4 > 50)
			{
				this._aConsoleHistory.shift();
			}
		}
		this.initializePointers();
	}
	function getHistoryUp()
	{
		if(this._nConsoleHistoryPointer > 0)
		{
			this._nConsoleHistoryPointer--;
		}
		var loc2 = this._aConsoleHistory[this._nConsoleHistoryPointer];
		return loc2;
	}
	function getHistoryDown()
	{
		if(this._nConsoleHistoryPointer < this._aConsoleHistory.length)
		{
			this._nConsoleHistoryPointer++;
		}
		var loc2 = this._aConsoleHistory[this._nConsoleHistoryPointer];
		return loc2;
	}
	function autoCompletion(loc2, loc3)
	{
		return ank.utils.ConsoleUtils.autoCompletion(loc2,loc3);
	}
	function initializePointers()
	{
		this._nConsoleHistoryPointer = this._aConsoleHistory.length;
	}
}
