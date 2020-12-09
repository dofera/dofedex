class dofus.datacenter.Accessory extends Object
{
	function Accessory(§\x1e\x1b\x1d§, §\x1e\x1c\x03§, §\x05\r§)
	{
		super();
		this.api = _global.API;
		this.initialize(var3,var4,var5);
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
	function initialize(§\x1e\x1b\x1d§, §\x1e\x1c\x03§, §\x05\r§)
	{
		this._nUnicID = var2;
		if(var4 != undefined)
		{
			this._nFrame = var4;
		}
		if(var3 != undefined)
		{
			this._nType = var3;
		}
		this._oItemText = this.api.lang.getItemUnicText(var2);
	}
}
