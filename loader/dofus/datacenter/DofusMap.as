class dofus.datacenter.DofusMap extends ank.battlefield.datacenter.Map
{
	function DofusMap(var3)
	{
		super(var3);
	}
	function __get__coordinates()
	{
		var var2 = _global.API.lang.getMapText(this.id);
		return _global.API.lang.getText("COORDINATES") + " : " + var2.x + ", " + var2.y;
	}
	function __get__x()
	{
		return _global.API.lang.getMapText(this.id).x;
	}
	function __get__y()
	{
		return _global.API.lang.getMapText(this.id).y;
	}
	function __get__superarea()
	{
		var var2 = _global.API.lang;
		return var2.getMapAreaInfos(this.subarea).superareaID;
	}
	function __get__area()
	{
		var var2 = _global.API.lang;
		return var2.getMapAreaInfos(this.subarea).areaID;
	}
	function __get__subarea()
	{
		var var2 = _global.API.lang;
		return var2.getMapText(this.id).sa;
	}
	function __get__musics()
	{
		var var2 = _global.API.lang;
		return var2.getMapSubAreaText(this.subarea).m;
	}
}
