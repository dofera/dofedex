class dofus.datacenter.Crafter extends Object
{
	function Crafter(sId, §\x1e\x10\x06§)
	{
		super();
		this.api = _global.API;
		this.id = sId;
		this._sName = var4;
	}
	function __get__name()
	{
		return this._sName;
	}
	function __set__name(§\x1e\x10\x06§)
	{
		this._sName = var2;
		return this.__get__name();
	}
	function __get__job()
	{
		return this._oJob;
	}
	function __set__job(§\x1e\n\x0f§)
	{
		this._oJob = var2;
		return this.__get__job();
	}
	function __get__breedId()
	{
		return this._nBreedId;
	}
	function __set__breedId(§\b\x0f§)
	{
		this._nBreedId = var2;
		return this.__get__breedId();
	}
	function __get__gfxFile()
	{
		var var2 = this._nBreedId * 10 + this._nSex;
		return dofus.Constants.CLIPS_PERSOS_PATH + var2 + ".swf";
	}
	function __get__gfxBreedFile()
	{
		return dofus.Constants.GUILDS_MINI_PATH + (this._nBreedId * 10 + this._nSex) + ".swf";
	}
	function __get__sex()
	{
		return this._nSex;
	}
	function __set__sex(§\x1e\n\x0f§)
	{
		this._nSex = Number(var2);
		return this.__get__sex();
	}
	function __get__color1()
	{
		return this._nColor1;
	}
	function __set__color1(§\x1e\n\x0f§)
	{
		this._nColor1 = Number(var2);
		return this.__get__color1();
	}
	function __get__color2()
	{
		return this._nColor2;
	}
	function __set__color2(§\x1e\n\x0f§)
	{
		this._nColor2 = Number(var2);
		return this.__get__color2();
	}
	function __get__color3()
	{
		return this._nColor3;
	}
	function __set__color3(§\x1e\n\x0f§)
	{
		this._nColor3 = Number(var2);
		return this.__get__color3();
	}
	function __get__accessories()
	{
		return this._aAccessories;
	}
	function __set__accessories(§\x1e\n\x0f§)
	{
		this._aAccessories = var2;
		return this.__get__accessories();
	}
	function __set__mapId(§\x03\x19§)
	{
		this._nMapId = var2;
		return this.__get__mapId();
	}
	function __get__subarea()
	{
		if(this._nMapId == 0)
		{
			return undefined;
		}
		var var2 = this.api.lang.getMapText(this._nMapId);
		var var3 = this.api.lang.getMapSubAreaText(var2.sa);
		var var4 = this.api.lang.getMapAreaText(var3.a);
		return !(var3.n.charAt(0) == "/" && var3.n.charAt(1) == "/")?var4.n + " (" + var3.n + ")":var4.n;
	}
	function __get__coord()
	{
		if(this._nMapId == 0)
		{
			return undefined;
		}
		var var2 = this.api.lang.getMapText(this._nMapId);
		return {x:var2.x,y:var2.y};
	}
}
