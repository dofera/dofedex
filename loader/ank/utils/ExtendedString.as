class ank.utils.ExtendedString extends String
{
	static var DEFAULT_SPACECHARS = " \n\r\t";
	function ExtendedString(§\x1e\x1a\x1b§)
	{
		super();
		this._s = String(var3);
	}
	function replace(§\x1e\x17\x02§, §\x1e\x16\x0e§)
	{
		if(arguments.length == 0)
		{
			return this._s;
		}
		if(arguments.length == 1)
		{
			if(var2 instanceof Array)
			{
				var3 = new Array(var2.length);
			}
			else
			{
				return this._s.split(var2).join("");
			}
		}
		if(!(var2 instanceof Array))
		{
			return this._s.split(var2).join(var3);
		}
		var var4 = var2.length;
		var var5 = this._s;
		if(var3 instanceof Array)
		{
			var var6 = 0;
			while(var6 < var4)
			{
				var5 = var5.split(var2[var6]).join(var3[var6]);
				var6 = var6 + 1;
			}
		}
		else
		{
			var var7 = 0;
			while(var7 < var4)
			{
				var5 = var5.split(var2[var7]).join(var3);
				var7 = var7 + 1;
			}
		}
		return var5;
	}
	function addLeftChar(§\x1e\x14\x11§, §\x03\b§)
	{
		var var4 = var3 - this._s.length;
		var var5 = new String();
		var var6 = 0;
		while(var6 < var4)
		{
			var5 = var5 + var2;
			var6 = var6 + 1;
		}
		var5 = var5 + this._s;
		return var5;
	}
	function addMiddleChar(§\x07\x18§, §\x07\b§)
	{
		if(_global.isNaN(var3))
		{
			var3 = Number(var3);
		}
		var3 = Math.abs(var3);
		var var5 = new Array();
		var var4 = this._s.length;
		while(var4 > 0)
		{
			if(Math.max(0,var4 - var3) == 0)
			{
				var5.push(this._s.substr(0,var4));
			}
			else
			{
				var5.push(this._s.substr(var4 - var3,var3));
			}
			var4 = var4 - var3;
		}
		var5.reverse();
		return var5.join(var2);
	}
	function lTrim(§\x1d§)
	{
		this._clearOutOfRange();
		this._lTrim(this.spaceStringToObject(var2));
		return this;
	}
	function rTrim(§\x1d§)
	{
		this._clearOutOfRange();
		this._rTrim(this.spaceStringToObject(var2));
		return this;
	}
	function trim(§\x1d§)
	{
		var var3 = this.spaceStringToObject(var2);
		this._clearOutOfRange();
		this._rTrim(var3);
		this._lTrim(var3);
		return this;
	}
	function toString()
	{
		return this._s;
	}
	function spaceStringToObject(§\x1d§)
	{
		var var3 = new Object();
		if(var2 == undefined)
		{
			var2 = ank.utils.ExtendedString.DEFAULT_SPACECHARS;
		}
		if(typeof var2 == "string")
		{
			var var4 = var2.length;
			while((var4 = var4 - 1) >= 0)
			{
				var3[var2.charAt(var4)] = true;
			}
		}
		else
		{
			var3 = var2;
		}
		return var3;
	}
	function _lTrim(§\x1d§)
	{
		var var3 = this._s.length;
		var var4 = 0;
		while(var3 > 0)
		{
			if(!var2[this._s.charAt(var4)])
			{
				break;
			}
			var4 = var4 + 1;
			var3 = var3 - 1;
		}
		this._s = this._s.slice(var4);
	}
	function _rTrim(§\x1d§)
	{
		var var3 = this._s.length;
		var var4 = var3 - 1;
		while(var3 > 0)
		{
			if(!var2[this._s.charAt(var4)])
			{
				break;
			}
			var4 = var4 - 1;
			var3 = var3 - 1;
		}
		this._s = this._s.slice(0,var4 + 1);
	}
	function _clearOutOfRange()
	{
		var var2 = "";
		var var3 = 0;
		while(var3 < this._s.length)
		{
			if(this._s.charCodeAt(var3) >= 32 && this._s.charCodeAt(var3) <= 255)
			{
				var2 = var2 + this._s.charAt(var3);
			}
			var3 = var3 + 1;
		}
		this._s = var2;
	}
}
