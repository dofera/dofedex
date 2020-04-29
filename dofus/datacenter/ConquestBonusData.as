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
	function __set__xp(var2)
	{
		this._nXp = var2;
		return this.__get__xp();
	}
	function __get__drop()
	{
		return this._nDrop;
	}
	function __set__drop(var2)
	{
		this._nDrop = var2;
		return this.__get__drop();
	}
	function __get__recolte()
	{
		return this._nRecolte;
	}
	function __set__recolte(var2)
	{
		this._nRecolte = var2;
		return this.__get__recolte();
	}
}
