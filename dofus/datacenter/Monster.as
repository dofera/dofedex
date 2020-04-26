class dofus.datacenter.Monster extends dofus.datacenter.PlayableCharacter
{
	var _nSpeedModerator = 1;
	function Monster(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID)
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
	function __get__kickable()
	{
		return this.api.lang.getMonstersText(this._nNameID).k;
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
	function __get__resistances()
	{
		var loc2 = this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].r;
		var loc3 = new Array();
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			loc3[loc4] = loc2[loc4];
			loc4 = loc4 + 1;
		}
		loc3[5] = loc3[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
		loc3[6] = loc3[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
		return loc3;
	}
	function __get__alignment()
	{
		return new dofus.datacenter.(this.api.lang.getMonstersText(this._nNameID).a,0);
	}
	function alertChatText()
	{
		var loc2 = this.api.datacenter.Map;
		return this.name + " niveau " + this.Level + " en " + loc2.x + "," + loc2.y + ".";
	}
}
