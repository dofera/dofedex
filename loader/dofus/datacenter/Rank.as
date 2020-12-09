class dofus.datacenter.Rank extends Object
{
	function Rank(§\x1e\x1b\x17§, §\x05\x06§, §\x06\x11§, §\x1a\x11§)
	{
		super();
		this.api = _global.API;
		this.initialize(var3,var4,var5,var6);
	}
	function __get__value()
	{
		return this._nValue;
	}
	function __set__value(§\x1e\n\x13§)
	{
		this._nValue = var2;
		return this.__get__value();
	}
	function __get__honour()
	{
		return this._nHonour;
	}
	function __set__honour(§\x1e\n\x13§)
	{
		this._nHonour = var2;
		return this.__get__honour();
	}
	function __get__disgrace()
	{
		return this._nDisgrace;
	}
	function __set__disgrace(§\x1e\n\x13§)
	{
		this._nDisgrace = var2;
		return this.__get__disgrace();
	}
	function __get__enable()
	{
		return this._bEnabled;
	}
	function __set__enable(§\x1e\n\x13§)
	{
		this._bEnabled = var2;
		return this.__get__enable();
	}
	function initialize(§\x1e\x1b\x17§, §\x05\x06§, §\x06\x11§, §\x1a\x11§)
	{
		this._nValue = !(_global.isNaN(var2) || var2 == undefined)?var2:0;
		this._nHonour = !(_global.isNaN(var3) || var3 == undefined)?var3:0;
		this._nDisgrace = !(_global.isNaN(var4) || var4 == undefined)?var4:0;
		this._bEnabled = var5 != undefined?var5:false;
	}
	function clone()
	{
		return new dofus.datacenter.Rank(this._nValue,this._nHonour,this._nDisgrace,this._bEnabled);
	}
}
