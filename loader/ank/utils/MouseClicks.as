class ank.utils.MouseClicks
{
	static var MAX_CAPACITY = 20;
	var _aMouseClicks = new Array();
	var _aMouseClicksForGather = new Array();
	function MouseClicks()
	{
	}
	function storeCurrentMouseClick(var2)
	{
		var var3 = new ank.utils.datacenter.	(getTimer(),_root._xmouse,_root._ymouse,var2);
		this._aMouseClicks.push(var3);
		this._aMouseClicksForGather.push(var3);
		if(this._aMouseClicks.length > ank.utils.MouseClicks.MAX_CAPACITY)
		{
			this._aMouseClicks.shift();
		}
		if(this._aMouseClicksForGather.length > 2)
		{
			this._aMouseClicksForGather.shift();
		}
	}
	function getPreviousMouseClickForGather()
	{
		if(this._aMouseClicksForGather.length < 2)
		{
			return undefined;
		}
		return this._aMouseClicksForGather[this._aMouseClicksForGather.length - 2];
	}
	function resetForGather()
	{
		if(this._aMouseClicksForGather.length == 0)
		{
			return undefined;
		}
		this._aMouseClicksForGather = new Array();
	}
}
