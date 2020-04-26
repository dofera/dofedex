class ank.utils.CustomDate
{
	static var MS_PER_DAY = 86400000;
	function CustomDate(nRefTime, §\x1e\x07§, §\x1e\x1c\t§)
	{
		this._nRefTime = nRefTime;
		this._aMonths = loc3;
		this._nYearOffset = loc4;
		this._aMonths.sortOn("0",Array.NUMERIC | Array.DESCENDING);
		this._nSaveTime = getTimer();
	}
	function getCurrentTime()
	{
		var loc2 = this.getCurrentRealDate();
		var loc3 = loc2.getUTCHours();
		var loc4 = loc2.getUTCMinutes();
		return [loc3,loc4];
	}
	function getCurrentDate()
	{
		var loc2 = this.getCurrentRealDate();
		var loc3 = this.getYearDayNumber();
		var loc4 = 1;
		var loc5 = 0;
		while(loc5 < this._aMonths.length)
		{
			if(this._aMonths[loc5][0] < loc3)
			{
				loc4 = loc5;
				break;
			}
			loc5 = loc5 + 1;
		}
		return [loc2.getUTCFullYear(),this._aMonths[loc4][1],loc3 - this._aMonths[loc4][0]];
	}
	function getCurrentMillisInDay()
	{
		var loc2 = new Date();
		loc2.setTime(this._nRefTime);
		var loc3 = new Date(Date.UTC(1970,0,1,loc2.getUTCHours(),loc2.getUTCMinutes(),loc2.getUTCSeconds(),loc2.getUTCMilliseconds()));
		return loc3.getTime();
	}
	function getDiffDate(loc2)
	{
		var loc3 = this.getCurrentRealDate();
		var loc4 = new Date();
		loc4.setTime(loc2);
		loc4 = new Date(Date.UTC(loc4.getUTCFullYear() - this._nYearOffset,loc4.getUTCMonth(),loc4.getUTCDate(),loc4.getUTCHours(),loc4.getUTCMinutes(),loc4.getUTCSeconds(),loc4.getUTCMilliseconds()));
		return loc3 - loc4;
	}
	function getCurrentRealDate()
	{
		var loc2 = getTimer() - this._nSaveTime;
		var loc3 = new Date();
		loc3.setTime(this._nRefTime + loc2);
		loc3 = new Date(Date.UTC(loc3.getUTCFullYear() - this._nYearOffset,loc3.getUTCMonth(),loc3.getUTCDate(),loc3.getUTCHours(),loc3.getUTCMinutes(),loc3.getUTCSeconds(),loc3.getUTCMilliseconds()));
		return loc3;
	}
	function getYearDayNumber()
	{
		var loc2 = this.getCurrentRealDate();
		var loc3 = new Date(Date.UTC(loc2.getUTCFullYear(),0,1));
		return Math.floor((loc2 - loc3) / ank.utils.CustomDate.MS_PER_DAY) + 1;
	}
}
