class dofus.datacenter.Subarea extends Object
{
	function Subarea(loc3, loc4)
	{
		super();
		this.api = _global.API;
		this.initialize(loc3,loc4);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__alignment()
	{
		return this._oAlignment;
	}
	function __set__alignment(loc2)
	{
		this._oAlignment = loc2;
		return this.__get__alignment();
	}
	function __get__name()
	{
		return String(this.api.lang.getMapSubAreaText(this._nID).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(this._nID).n:String(this.api.lang.getMapSubAreaText(this._nID).n).substr(2);
	}
	function __get__color()
	{
		return dofus.Constants.AREA_ALIGNMENT_COLOR[this._oAlignment.index];
	}
	function initialize(loc2, loc3)
	{
		this._nID = loc2;
		this._oAlignment = new dofus.datacenter.(loc3);
	}
}
