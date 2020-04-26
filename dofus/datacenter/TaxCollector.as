class dofus.datacenter.TaxCollector extends dofus.datacenter.PlayableCharacter
{
	function TaxCollector(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,loc5,cellNum,loc7,gfxID);
	}
	function __set__name(loc2)
	{
		this._sName = loc2;
		return this.__get__name();
	}
	function __get__name()
	{
		return this._sName;
	}
	function __set__guildName(loc2)
	{
		this._sGuildName = loc2;
		return this.__get__guildName();
	}
	function __get__guildName()
	{
		return this._sGuildName;
	}
	function __set__emblem(loc2)
	{
		this._oEmblem = loc2;
		return this.__get__emblem();
	}
	function __get__emblem()
	{
		return this._oEmblem;
	}
	function __set__resistances(loc2)
	{
		this._aResistances = loc2;
		return this.__get__resistances();
	}
	function __get__resistances()
	{
		return this._aResistances;
	}
}
