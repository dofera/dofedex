class dofus.datacenter.TaxCollector extends dofus.datacenter.PlayableCharacter
{
	function TaxCollector(sID, clipClass, §\x1e\x12\x01§, §\x13\x05§, §\x10\x1c§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,var5,var6,var7,gfxID);
	}
	function __set__name(var2)
	{
		this._sName = var2;
		return this.__get__name();
	}
	function __get__name()
	{
		return this._sName;
	}
	function __set__guildName(var2)
	{
		this._sGuildName = var2;
		return this.__get__guildName();
	}
	function __get__guildName()
	{
		return this._sGuildName;
	}
	function __set__emblem(var2)
	{
		this._oEmblem = var2;
		return this.__get__emblem();
	}
	function __get__emblem()
	{
		return this._oEmblem;
	}
	function __set__resistances(var2)
	{
		this._aResistances = var2;
		return this.__get__resistances();
	}
	function __get__resistances()
	{
		return this._aResistances;
	}
}
