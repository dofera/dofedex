class dofus.datacenter.Feat extends Object
{
	function Feat(loc3, loc4, loc5)
	{
		super();
		this.api = _global.API;
		this.initialize(loc3,loc4,loc5);
	}
	function __get__index()
	{
		return this._nIndex;
	}
	function __set__index(loc2)
	{
		this._nIndex = !(_global.isNaN(loc2) || loc2 == undefined)?loc2:0;
		return this.__get__index();
	}
	function __get__name()
	{
		return this._oFeatInfos.n;
	}
	function __get__level()
	{
		return this._nLevel;
	}
	function __get__effect()
	{
		return new dofus.datacenter.(this._oFeatInfos.e,this._aParams);
	}
	function __get__iconFile()
	{
		return dofus.Constants.FEATS_PATH + this._oFeatInfos.g + ".swf";
	}
	function initialize(loc2, loc3, loc4)
	{
		this._nIndex = loc2;
		this._nLevel = loc3;
		this._aParams = loc4;
		this._oFeatInfos = this.api.lang.getAlignmentFeat(loc2);
	}
}
