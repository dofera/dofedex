class dofus.datacenter.Rank extends Object
{
	function Rank(loc3, loc4, loc5, loc6)
	{
		super();
		this.api = _global.API;
		this.initialize(loc3,loc4,loc5,loc6);
	}
	function __get__value()
	{
		return this._nValue;
	}
	function __set__value(loc2)
	{
		this._nValue = loc2;
		return this.__get__value();
	}
	function __get__honour()
	{
		return this._nHonour;
	}
	function __set__honour(loc2)
	{
		this._nHonour = loc2;
		return this.__get__honour();
	}
	function __get__disgrace()
	{
		return this._nDisgrace;
	}
	function __set__disgrace(loc2)
	{
		this._nDisgrace = loc2;
		return this.__get__disgrace();
	}
	function __get__enable()
	{
		return this._bEnabled;
	}
	function __set__enable(loc2)
	{
		this._bEnabled = loc2;
		return this.__get__enable();
	}
	function initialize(loc2, loc3, loc4, loc5)
	{
		this._nValue = !(_global.isNaN(loc2) || loc2 == undefined)?loc2:0;
		this._nHonour = !(_global.isNaN(loc3) || loc3 == undefined)?loc3:0;
		this._nDisgrace = !(_global.isNaN(loc4) || loc4 == undefined)?loc4:0;
		this._bEnabled = loc5 != undefined?loc5:false;
	}
	function clone()
	{
		return new dofus.datacenter.Rank(this._nValue,this._nHonour,this._nDisgrace,this._bEnabled);
	}
}
