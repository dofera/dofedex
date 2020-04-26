class dofus.datacenter.Accessory extends Object
{
	function Accessory(loc3, loc4, loc5)
	{
		super();
		this.api = _global.API;
		this.initialize(loc3,loc4,loc5);
	}
	function __get__unicID()
	{
		return this._nUnicID;
	}
	function __get__type()
	{
		if(this._nType != undefined)
		{
			return this._nType;
		}
		return this._oItemText.t;
	}
	function __get__gfxID()
	{
		return this._oItemText.g;
	}
	function __get__gfx()
	{
		return this.type + "_" + this.gfxID;
	}
	function __get__frame()
	{
		return this._nFrame;
	}
	function initialize(loc2, loc3, loc4)
	{
		this._nUnicID = loc2;
		if(loc4 != undefined)
		{
			this._nFrame = loc4;
		}
		if(loc3 != undefined)
		{
			this._nType = loc3;
		}
		this._oItemText = this.api.lang.getItemUnicText(loc2);
	}
}
