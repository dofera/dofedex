class dofus.datacenter.ConquestBonusData extends Object
{
	function ConquestBonusData(xp, drop, recolte)
	{
		super();
		this._nXp = xp;
		this._nDrop = drop;
		this._nRecolte = recolte;
	}
	function __get__xp()
	{
		return this._nXp;
	}
	function __set__xp(loc2)
	{
		this._nXp = loc2;
		return this.__get__xp();
	}
	function __get__drop()
	{
		return this._nDrop;
	}
	function __set__drop(loc2)
	{
		this._nDrop = loc2;
		return this.__get__drop();
	}
	function __get__recolte()
	{
		return this._nRecolte;
	}
	function __set__recolte(loc2)
	{
		this._nRecolte = loc2;
		return this.__get__recolte();
	}
}
