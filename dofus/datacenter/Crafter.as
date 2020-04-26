class dofus.datacenter.Crafter extends Object
{
	function Crafter(sId, §\x1e\x11\x15§)
	{
		super();
		this.api = _global.API;
		this.id = sId;
		this._sName = loc4;
	}
	function __get__name()
	{
		return this._sName;
	}
	function __set__name(loc2)
	{
		this._sName = loc2;
		return this.__get__name();
	}
	function __get__job()
	{
		return this._oJob;
	}
	function __set__job(loc2)
	{
		this._oJob = loc2;
		return this.__get__job();
	}
	function __get__breedId()
	{
		return this._nBreedId;
	}
	function __set__breedId(loc2)
	{
		this._nBreedId = loc2;
		return this.__get__breedId();
	}
	function __get__gfxFile()
	{
		var loc2 = this._nBreedId * 10 + this._nSex;
		return dofus.Constants.CLIPS_PERSOS_PATH + loc2 + ".swf";
	}
	function __get__gfxBreedFile()
	{
		return dofus.Constants.GUILDS_MINI_PATH + (this._nBreedId * 10 + this._nSex) + ".swf";
	}
	function __get__sex()
	{
		return this._nSex;
	}
	function __set__sex(loc2)
	{
		this._nSex = Number(loc2);
		return this.__get__sex();
	}
	function __get__color1()
	{
		return this._nColor1;
	}
	function __set__color1(loc2)
	{
		this._nColor1 = Number(loc2);
		return this.__get__color1();
	}
	function __get__color2()
	{
		return this._nColor2;
	}
	function __set__color2(loc2)
	{
		this._nColor2 = Number(loc2);
		return this.__get__color2();
	}
	function __get__color3()
	{
		return this._nColor3;
	}
	function __set__color3(loc2)
	{
		this._nColor3 = Number(loc2);
		return this.__get__color3();
	}
	function __get__accessories()
	{
		return this._aAccessories;
	}
	function __set__accessories(loc2)
	{
		this._aAccessories = loc2;
		return this.__get__accessories();
	}
	function __set__mapId(loc2)
	{
		this._nMapId = loc2;
		return this.__get__mapId();
	}
	function __get__subarea()
	{
		if(this._nMapId == 0)
		{
			return undefined;
		}
		var loc2 = this.api.lang.getMapText(this._nMapId);
		var loc3 = this.api.lang.getMapSubAreaText(loc2.sa);
		var loc4 = this.api.lang.getMapAreaText(loc3.a);
		return !(loc3.n.charAt(0) == "/" && loc3.n.charAt(1) == "/")?loc4.n + " (" + loc3.n + ")":loc4.n;
	}
	function __get__coord()
	{
		if(this._nMapId == 0)
		{
			return undefined;
		}
		var loc2 = this.api.lang.getMapText(this._nMapId);
		return {x:loc2.x,y:loc2.y};
	}
}
