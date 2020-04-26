class dofus.datacenter.Hint extends Object
{
	function Hint(loc3)
	{
		super();
		this.api = _global.API;
		this._oData = loc3;
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
		var loc2 = this.api.lang.getMapText(this._oData.m).sa;
		var loc3 = this.api.lang.getMapSubAreaText(loc2).a;
		var loc4 = this.api.lang.getMapAreaText(loc3).sua;
		return loc4;
	}
	function __get__gfx()
	{
		return this._oData.g;
	}
}
