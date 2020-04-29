class dofus.utils.consoleParsers.AbstractConsoleParser
{
	function AbstractConsoleParser()
	{
	}
	function __get__api()
	{
		return this._oAPI;
	}
	function __set__api(var2)
	{
		this._oAPI = var2;
		return this.__get__api();
	}
	function initialize(var2)
	{
		this._oAPI = var2;
		this._aConsoleHistory = new Array();
		this._nConsoleHistoryPointer = 0;
	}
	function process(var2, var3)
	{
		this.pushHistory({value:var2,params:var3});
	}
	function pushHistory(var2)
	{
		var var3 = this._aConsoleHistory.slice(-1);
		if(var3[0].value != var2.value)
		{
			var var4 = this._aConsoleHistory.push(var2);
			if(var4 > 50)
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
		var var2 = this._aConsoleHistory[this._nConsoleHistoryPointer];
		return var2;
	}
	function getHistoryDown()
	{
		if(this._nConsoleHistoryPointer < this._aConsoleHistory.length)
		{
			this._nConsoleHistoryPointer++;
		}
		var var2 = this._aConsoleHistory[this._nConsoleHistoryPointer];
		return var2;
	}
	function autoCompletion(var2, var3)
	{
		return ank.utils.ConsoleUtils.autoCompletion(var2,var3);
	}
	function initializePointers()
	{
		this._nConsoleHistoryPointer = this._aConsoleHistory.length;
	}
}
