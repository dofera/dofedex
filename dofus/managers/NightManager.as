class dofus.managers.NightManager
{
	static var STATE_COLORS = [undefined,dofus.Constants.NIGHT_COLOR];
	static var _sSelf = null;
	function NightManager(loc3)
	{
		dofus.managers.NightManager._sSelf = this;
		this._oApi = loc2;
	}
	function __get__time()
	{
		var loc2 = this.getCurrentTime();
		if(new ank.utils.(loc2[1]).addLeftChar("0",2) == "undefined")
		{
			return "";
		}
		return new ank.utils.(loc2[0]).addLeftChar("0",2) + ":" + new ank.utils.(loc2[1]).addLeftChar("0",2);
	}
	function __get__date()
	{
		return this.getCurrentDateString();
	}
	function initialize(loc2, loc3, loc4, loc5)
	{
		this._aSequence = loc2;
		this._aMonths = loc3;
		this._nYearOffset = loc4;
		this._mcBattlefield = loc5;
	}
	function setReferenceTime(loc2)
	{
		this._cdDate = new ank.utils.(loc2,this._aMonths,this._nYearOffset);
		this.clear();
		this.setState();
	}
	function setReferenceDate(loc2, loc3, loc4)
	{
		this._nYear = loc2;
		this._nMonth = loc3;
		this._nDay = loc4;
	}
	function clear()
	{
		_global.clearInterval(this._nIntervalID);
	}
	function noEffects()
	{
		this.clear();
		this._mcBattlefield.setColor();
	}
	function getCurrentTime()
	{
		return this._cdDate.getCurrentTime();
	}
	function getCurrentDateString()
	{
		var loc2 = this._cdDate.getCurrentDate();
		if(getTimer() - this._oApi.datacenter.Basics.lastDateUpdate > 60000)
		{
			this._oApi.network.Basics.getDate();
		}
		var loc3 = this._nYear == undefined?loc2[2] + " " + loc2[1] + " " + loc2[0]:this._nDay + " " + this._aMonths[11 - this._nMonth][1] + " " + this._nYear;
		return loc3;
	}
	function getDiffDate(loc2)
	{
		return this._cdDate.getDiffDate(loc2);
	}
	static function getInstance()
	{
		return dofus.managers.NightManager._sSelf;
	}
	function setState()
	{
		var loc2 = this._cdDate.getCurrentMillisInDay();
		var loc3 = 0;
		while(loc3 < this._aSequence.length)
		{
			var loc4 = this._aSequence[loc3][1];
			if(loc2 < loc4)
			{
				var loc5 = this._aSequence[loc3][2];
				this.applyState(loc5,loc4 - loc2,loc4);
				return undefined;
			}
			loc3 = loc3 + 1;
		}
		ank.utils.Logger.err("[setState] ... heu la date " + loc2 + " n\'est pas dans la séquence");
	}
	function applyState(loc2, loc3, loc4)
	{
		this._mcBattlefield.setColor(loc2);
		this.clear();
		this._nIntervalID = _global.setInterval(this,"setState",loc3,loc4);
	}
}
