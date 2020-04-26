class dofus.datacenter.FeatEffect extends Object
{
	function FeatEffect(loc3, loc4)
	{
		super();
		this.api = _global.API;
		this.initialize(loc3,loc4);
	}
	function __get__index()
	{
		return this._nIndex;
	}
	function __set__index(loc2)
	{
		this._nIndex = loc2;
		return this.__get__index();
	}
	function __get__description()
	{
		return ank.utils.PatternDecoder.getDescription(this._sFeatEffectInfos,this._aParams);
	}
	function __set__params(loc2)
	{
		this._aParams = loc2;
		return this.__get__params();
	}
	function __get__params()
	{
		return this._aParams;
	}
	function initialize(loc2, loc3)
	{
		this._nIndex = loc2;
		this._aParams = loc3;
		this._sFeatEffectInfos = this.api.lang.getAlignmentFeatEffect(loc2);
	}
}
