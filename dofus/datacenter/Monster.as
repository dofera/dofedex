class dofus.datacenter.Monster extends dofus.datacenter.PlayableCharacter
{
	var _nSpeedModerator = 1;
	function Monster(sID, clipClass, §\x1e\x13\x14§, cellNum, §\x11\x1b§, gfxID)
	{
		super();
		this.initialize(sID,clipClass,var5,cellNum,var7,gfxID);
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
	function __get__kickable()
	{
		return this.api.lang.getMonstersText(this._nNameID).k;
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
	function __get__resistances()
	{
		var var2 = this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].r;
		var var3 = new Array();
		var var4 = 0;
		while(var4 < var2.length)
		{
			var3[var4] = var2[var4];
			var4 = var4 + 1;
		}
		var3[5] = var3[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
		var3[6] = var3[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
		return var3;
	}
	function __get__alignment()
	{
		return new dofus.datacenter.(this.api.lang.getMonstersText(this._nNameID).a,0);
	}
	function alertChatText()
	{
		var var2 = this.api.datacenter.Map;
		return this.name + " niveau " + this.Level + " en " + var2.x + "," + var2.y + ".";
	}
}
