class dofus.datacenter.FeatEffect extends Object
{
	function FeatEffect(§\x04\x17§, §\x1e\x02§)
	{
		super();
		this.api = _global.API;
		this.initialize(var3,var4);
	}
	function __get__index()
	{
		return this._nIndex;
	}
	function __set__index(§\x04\x17§)
	{
		this._nIndex = var2;
		return this.__get__index();
	}
	function __get__description()
	{
		return ank.utils.PatternDecoder.getDescription(this._sFeatEffectInfos,this._aParams);
	}
	function __set__params(§\x1e\x02§)
	{
		this._aParams = var2;
		return this.__get__params();
	}
	function __get__params()
	{
		return this._aParams;
	}
	function initialize(§\x04\x17§, §\x1e\x02§)
	{
		this._nIndex = var2;
		this._aParams = var3;
		this._sFeatEffectInfos = this.api.lang.getAlignmentFeatEffect(var2);
	}
}
