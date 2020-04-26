class ank.utils.ExtendedString extends String
{
	static var DEFAULT_SPACECHARS = " \n\r\t";
	function ExtendedString(loc3)
	{
		super();
		this._s = String(loc3);
	}
	function replace(loc2, loc3)
	{
		if(arguments.length == 0)
		{
			return this._s;
		}
		if(arguments.length == 1)
		{
			if(loc2 instanceof Array)
			{
				loc3 = new Array(loc2.length);
			}
			else
			{
				return this._s.split(loc2).join("");
			}
		}
		if(!(loc2 instanceof Array))
		{
			return this._s.split(loc2).join(loc3);
		}
		var loc4 = loc2.length;
		var loc5 = this._s;
		if(loc3 instanceof Array)
		{
			var loc6 = 0;
			while(loc6 < loc4)
			{
				loc5 = loc5.split(loc2[loc6]).join(loc3[loc6]);
				loc6 = loc6 + 1;
			}
		}
		else
		{
			var loc7 = 0;
			while(loc7 < loc4)
			{
				loc5 = loc5.split(loc2[loc7]).join(loc3);
				loc7 = loc7 + 1;
			}
		}
		return loc5;
	}
	function addLeftChar(loc2, loc3)
	{
		var loc4 = loc3 - this._s.length;
		var loc5 = new String();
		var loc6 = 0;
		while(loc6 < loc4)
		{
			loc5 = loc5 + loc2;
			loc6 = loc6 + 1;
		}
		loc5 = loc5 + this._s;
		return loc5;
	}
	function addMiddleChar(§\b\x13§, nCount)
	{
		if(_global.isNaN(nCount))
		{
			nCount = Number(nCount);
		}
		nCount = Math.abs(nCount);
		var loc5 = new Array();
		var loc4 = this._s.length;
		while(loc4 > 0)
		{
			if(Math.max(0,loc4 - nCount) == 0)
			{
				loc5.push(this._s.substr(0,loc4));
			}
			else
			{
				loc5.push(this._s.substr(loc4 - nCount,nCount));
			}
			loc4 = loc4 - nCount;
		}
		loc5.reverse();
		return loc5.join(loc2);
	}
	function lTrim(loc2)
	{
		this._clearOutOfRange();
		this._lTrim(this.spaceStringToObject(loc2));
		return this;
	}
	function rTrim(loc2)
	{
		this._clearOutOfRange();
		this._rTrim(this.spaceStringToObject(loc2));
		return this;
	}
	function trim(loc2)
	{
		var loc3 = this.spaceStringToObject(loc2);
		this._clearOutOfRange();
		this._rTrim(loc3);
		this._lTrim(loc3);
		return this;
	}
	function toString()
	{
		return this._s;
	}
	function spaceStringToObject(loc2)
	{
		var loc3 = new Object();
		if(loc2 == undefined)
		{
			loc2 = ank.utils.ExtendedString.DEFAULT_SPACECHARS;
		}
		if(typeof loc2 == "string")
		{
			var loc4 = loc2.length;
			while((loc4 = loc4 - 1) >= 0)
			{
				loc3[loc2.charAt(loc4)] = true;
			}
		}
		else
		{
			loc3 = loc2;
		}
		return loc3;
	}
	function _lTrim(loc2)
	{
		var loc3 = this._s.length;
		var loc4 = 0;
		while(loc3 > 0)
		{
			if(!loc2[this._s.charAt(loc4)])
			{
				break;
			}
			loc4 = loc4 + 1;
			loc3 = loc3 - 1;
		}
		this._s = this._s.slice(loc4);
	}
	function _rTrim(loc2)
	{
		var loc3 = this._s.length;
		var loc4 = loc3 - 1;
		while(loc3 > 0)
		{
			if(!loc2[this._s.charAt(loc4)])
			{
				break;
			}
			loc4 = loc4 - 1;
			loc3 = loc3 - 1;
		}
		this._s = this._s.slice(0,loc4 + 1);
	}
	function _clearOutOfRange()
	{
		var loc2 = "";
		var loc3 = 0;
		while(loc3 < this._s.length)
		{
			if(this._s.charCodeAt(loc3) >= 32 && this._s.charCodeAt(loc3) <= 255)
			{
				loc2 = loc2 + this._s.charAt(loc3);
			}
			loc3 = loc3 + 1;
		}
		this._s = loc2;
	}
}
