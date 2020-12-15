class dofus.datacenter.Specialization extends Object
{
	function Specialization(var2)
	{
		super();
		this.api = _global.API;
		this.initialize(var3);
	}
	function __get__index()
	{
		return this._nIndex;
	}
	function __set__index(var2)
	{
		this._nIndex = !(_global.isNaN(var2) || var2 == undefined)?var2:0;
		return this.__get__index();
	}
	function __get__name()
	{
		return this._oSpecInfos.n;
	}
	function __get__description()
	{
		return this._oSpecInfos.d;
	}
	function __get__order()
	{
		return new dofus.datacenter.(this._oSpecInfos.o);
	}
	function __get__alignment()
	{
		return new dofus.datacenter.(this.order.alignment.index,this._oSpecInfos.av);
	}
	function __get__feats()
	{
		return this._eaFeats;
	}
	function initialize(var2)
	{
		this._nIndex = var2;
		this._oSpecInfos = this.api.lang.getAlignmentSpecialization(var2);
		this._eaFeats = new ank.utils.();
		var var3 = this._oSpecInfos.f;
		var var4 = 0;
		while(var4 < var3.length)
		{
			this._eaFeats.push(new dofus.datacenter.(var3[var4][0],var3[var4][1],var3[var4][2]));
			var4 = var4 + 1;
		}
	}
}
