class dofus.datacenter.Creature extends dofus.datacenter.PlayableCharacter
{
	var _sStartAnimation = "appear";
	function Creature(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,loc5,cellNum,loc7,gfxID);
	}
	function __set__name(loc2)
	{
		this._nNameID = Number(loc2);
		return this.__get__name();
	}
	function __get__name()
	{
		return this.api.lang.getMonstersText(this._nNameID).n;
	}
	function __set__powerLevel(loc2)
	{
		this._nPowerLevel = Number(loc2);
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
	function __set__resistances(loc2)
	{
		this._resistances = loc2;
		return this.__get__resistances();
	}
	function __get__resistances()
	{
		if(this._resistances)
		{
			return this._resistances;
		}
		var loc2 = this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].r;
		loc2[5] = loc2[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
		loc2[6] = loc2[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
		return loc2;
	}
	function __get__alignment()
	{
		return new dofus.datacenter.(this.api.lang.getMonstersText(this._nNameID).a,0);
	}
}
