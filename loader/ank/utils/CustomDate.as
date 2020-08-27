class ank.utils.CustomDate
{
	static var MS_PER_DAY = 86400000;
	function CustomDate(nRefTime, §\x1e\x07§, §\x1e\x1c\x07§)
	{
		this._nRefTime = nRefTime;
		this._aMonths = var3;
		this._nYearOffset = var4;
		this._aMonths.sortOn("0",Array.NUMERIC | Array.DESCENDING);
		this._nSaveTime = getTimer();
	}
	function getCurrentTime()
	{
		var var2 = this.getCurrentRealDate();
		var var3 = var2.getUTCHours();
		var var4 = var2.getUTCMinutes();
		return [var3,var4];
	}
	function getCurrentDate()
	{
		var var2 = this.getCurrentRealDate();
		var var3 = this.getYearDayNumber();
		var var4 = 1;
		var var5 = 0;
		while(var5 < this._aMonths.length)
		{
			if(this._aMonths[var5][0] < var3)
			{
				var4 = var5;
				break;
			}
			var5 = var5 + 1;
		}
		return [var2.getUTCFullYear(),this._aMonths[var4][1],var3 - this._aMonths[var4][0]];
	}
	function getCurrentMillisInDay()
	{
		var var2 = new Date();
		var2.setTime(this._nRefTime);
		var var3 = new Date(Date.UTC(1970,0,1,var2.getUTCHours(),var2.getUTCMinutes(),var2.getUTCSeconds(),var2.getUTCMilliseconds()));
		return var3.getTime();
	}
	function getDiffDate(var2)
	{
		var var3 = this.getCurrentRealDate();
		var var4 = new Date();
		var4.setTime(var2);
		var4 = new Date(Date.UTC(var4.getUTCFullYear() - this._nYearOffset,var4.getUTCMonth(),var4.getUTCDate(),var4.getUTCHours(),var4.getUTCMinutes(),var4.getUTCSeconds(),var4.getUTCMilliseconds()));
		return var3 - var4;
	}
	function getCurrentRealDate()
	{
		var var2 = getTimer() - this._nSaveTime;
		var var3 = new Date();
		var3.setTime(this._nRefTime + var2);
		var3 = new Date(Date.UTC(var3.getUTCFullYear() - this._nYearOffset,var3.getUTCMonth(),var3.getUTCDate(),var3.getUTCHours(),var3.getUTCMinutes(),var3.getUTCSeconds(),var3.getUTCMilliseconds()));
		return var3;
	}
	function getYearDayNumber()
	{
		var var2 = this.getCurrentRealDate();
		var var3 = new Date(Date.UTC(var2.getUTCFullYear(),0,1));
		return Math.floor((var2 - var3) / ank.utils.CustomDate.MS_PER_DAY) + 1;
	}
}
