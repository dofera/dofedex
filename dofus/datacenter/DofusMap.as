class dofus.datacenter.DofusMap extends ank.battlefield.datacenter.Map
{
	function DofusMap(loc3)
	{
		super(loc3);
	}
	function __get__coordinates()
	{
		var loc2 = _global.API.lang.getMapText(this.id);
		return _global.API.lang.getText("COORDINATES") + " : " + loc2.x + ", " + loc2.y;
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
		var loc2 = _global.API.lang;
		return loc2.getMapAreaInfos(this.subarea).superareaID;
	}
	function __get__area()
	{
		var loc2 = _global.API.lang;
		return loc2.getMapAreaInfos(this.subarea).areaID;
	}
	function __get__subarea()
	{
		var loc2 = _global.API.lang;
		return loc2.getMapText(this.id).sa;
	}
	function __get__musics()
	{
		var loc2 = _global.API.lang;
		return loc2.getMapSubAreaText(this.subarea).m;
	}
}
