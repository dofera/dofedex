class dofus.datacenter.Specialization extends Object
{
	function Specialization(loc3)
	{
		super();
		this.api = _global.API;
		this.initialize(loc3);
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
		return this._oSpecInfos.n;
	}
	function __get__description()
	{
		return this._oSpecInfos.d;
	}
	function __get__order()
	{
		return new dofus.datacenter.(this._oSpecInfos.o);
	}
	function __get__alignment()
	{
		return new dofus.datacenter.(this.order.alignment.index,this._oSpecInfos.av);
	}
	function __get__feats()
	{
		return this._eaFeats;
	}
	function initialize(loc2)
	{
		this._nIndex = loc2;
		this._oSpecInfos = this.api.lang.getAlignmentSpecialization(loc2);
		this._eaFeats = new ank.utils.();
		var loc3 = this._oSpecInfos.f;
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			this._eaFeats.push(new dofus.datacenter.(loc3[loc4][0],loc3[loc4][1],loc3[loc4][2]));
			loc4 = loc4 + 1;
		}
	}
}
