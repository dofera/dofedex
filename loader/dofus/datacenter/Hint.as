class dofus.datacenter.Hint extends Object
{
	function Hint(§\x11\x15§)
	{
		super();
		this.api = _global.API;
		this._oData = var3;
	}
	function __get__mapID()
	{
		return this._oData.m;
	}
	function __get__name()
	{
		return this._oData.n;
	}
	function __get__category()
	{
		return this.api.lang.getHintsCategory(this.categoryID).n;
	}
	function __get__categoryID()
	{
		return this._oData.c;
	}
	function __get__coordinates()
	{
		return this.x + ", " + this.y;
	}
	function __get__x()
	{
		if(this._oData.m == undefined)
		{
			return this._oData.x;
		}
		return this.api.lang.getMapText(this._oData.m).x;
	}
	function __get__y()
	{
		if(this._oData.m == undefined)
		{
			return this._oData.y;
		}
		return this.api.lang.getMapText(this._oData.m).y;
	}
	function __get__superAreaID()
	{
		var var2 = this.api.lang.getMapText(this._oData.m).sa;
		var var3 = this.api.lang.getMapSubAreaText(var2).a;
		var var4 = this.api.lang.getMapAreaText(var3).sua;
		return var4;
	}
	function __get__gfx()
	{
		return this._oData.g;
	}
}
