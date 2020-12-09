class dofus.datacenter.Feat extends Object
{
	function Feat(§\x04\x17§, §\x04\x01§, §\x1e\x02§)
	{
		super();
		this.api = _global.API;
		this.initialize(var3,var4,var5);
	}
	function __get__index()
	{
		return this._nIndex;
	}
	function __set__index(§\x04\x17§)
	{
		this._nIndex = !(_global.isNaN(var2) || var2 == undefined)?var2:0;
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
		return new dofus.datacenter.(this._oFeatInfos.e,this._aParams);
	}
	function __get__iconFile()
	{
		return dofus.Constants.FEATS_PATH + this._oFeatInfos.g + ".swf";
	}
	function initialize(§\x04\x17§, §\x04\x01§, §\x1e\x02§)
	{
		this._nIndex = var2;
		this._nLevel = var3;
		this._aParams = var4;
		this._oFeatInfos = this.api.lang.getAlignmentFeat(var2);
	}
}
