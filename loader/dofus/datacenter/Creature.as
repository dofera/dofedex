class dofus.datacenter.Creature extends dofus.datacenter.PlayableCharacter
{
	var _sStartAnimation = "appear";
	function Creature(sID, clipClass, §\x1e\x12\x01§, §\x13\x05§, §\x10\x1c§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,var5,var6,var7,gfxID);
	}
	function __set__name(var2)
	{
		this._nNameID = Number(var2);
		return this.__get__name();
	}
	function __get__name()
	{
		return this.api.lang.getMonstersText(this._nNameID).n;
	}
	function __set__powerLevel(var2)
	{
		this._nPowerLevel = Number(var2);
		return this.__get__powerLevel();
	}
	function __get__powerLevel()
	{
		return this._nPowerLevel;
	}
	function __get__Level()
	{
		return this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].l;
	}
	function __set__resistances(var2)
	{
		this._resistances = var2;
		return this.__get__resistances();
	}
	function __get__resistances()
	{
		if(this._resistances)
		{
			return this._resistances;
		}
		var var2 = this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].r;
		var2[5] = var2[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
		var2[6] = var2[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
		return var2;
	}
	function __get__alignment()
	{
		return new dofus.datacenter.(this.api.lang.getMonstersText(this._nNameID).a,0);
	}
}
