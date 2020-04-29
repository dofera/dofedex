class dofus.datacenter.Character extends dofus.datacenter.PlayableCharacter
{
	var xtraClipTopAnimations = {staticF:true};
	function Character(sID, clipClass, §\x1e\x13\x14§, cellNum, §\x11\x1b§, gfxID, §\x1e\r\x07§)
	{
		super();
		this._title = var9;
		this.initialize(sID,clipClass,var5,cellNum,var7,gfxID);
	}
	function __get__speedModerator()
	{
		var var2 = this._nSpeedModerator;
		if(this.isSlow)
		{
			var2 = var2 / 2;
		}
		else if(this.isAdminSonicSpeed)
		{
			var2 = var2 * 5;
		}
		return var2;
	}
	function __get__Guild()
	{
		return this._nGuild;
	}
	function __set__Guild(var2)
	{
		this._nGuild = Number(var2);
		return this.__get__Guild();
	}
	function __get__Sex()
	{
		return this._nSex;
	}
	function __set__Sex(var2)
	{
		this._nSex = Number(var2);
		return this.__get__Sex();
	}
	function __get__Aura()
	{
		return this._nAura;
	}
	function __set__Aura(var2)
	{
		this._nAura = Number(var2);
		return this.__get__Aura();
	}
	function __get__alignment()
	{
		return this._oAlignment;
	}
	function __set__alignment(var2)
	{
		this._oAlignment = var2;
		return this.__get__alignment();
	}
	function __get__Merchant()
	{
		return this._bMerchant;
	}
	function __set__Merchant(var2)
	{
		this._bMerchant = var2;
		return this.__get__Merchant();
	}
	function __get__serverID()
	{
		return this._nServerID;
	}
	function __set__serverID(var2)
	{
		this._nServerID = var2;
		return this.__get__serverID();
	}
	function __get__Died()
	{
		return this._bDied;
	}
	function __set__Died(var2)
	{
		this._bDied = var2;
		return this.__get__Died();
	}
	function __get__rank()
	{
		return this._oRank;
	}
	function __set__rank(var2)
	{
		this._oRank = var2;
		return this.__get__rank();
	}
	function __get__multiCraftSkillsID()
	{
		return this._aMultiCraftSkillsID;
	}
	function __set__multiCraftSkillsID(var2)
	{
		this._aMultiCraftSkillsID = var2;
		return this.__get__multiCraftSkillsID();
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
	function __get__title()
	{
		return this._title;
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
	function __set__restrictions(var2)
	{
		this._nRestrictions = Number(var2);
		return this.__get__restrictions();
	}
	function __get__canBeAssault()
	{
		return (this._nRestrictions & 1) != 1;
	}
	function __get__canBeChallenge()
	{
		return (this._nRestrictions & 2) != 2;
	}
	function __get__canExchange()
	{
		return (this._nRestrictions & 4) != 4;
	}
	function __get__canBeAttack()
	{
		return (this._nRestrictions & 8) != 8;
	}
	function __get__forceWalk()
	{
		return (this._nRestrictions & 16) == 16;
	}
	function __get__isSlow()
	{
		return (this._nRestrictions & 32) == 32;
	}
	function __get__canSwitchInCreaturesMode()
	{
		return (this._nRestrictions & 64) != 64;
	}
	function __get__isTomb()
	{
		return (this._nRestrictions & 128) == 128;
	}
	function __get__isAdminSonicSpeed()
	{
		return (this._nRestrictions & 256) == 256;
	}
	function __set__resistances(var2)
	{
		this._aResistances = var2;
		return this.__get__resistances();
	}
	function __get__resistances()
	{
		var var2 = new Array();
		var var3 = 0;
		while(var3 < this._aResistances.length)
		{
			var2[var3] = this._aResistances[var3];
			var3 = var3 + 1;
		}
		var2[5] = var2[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
		var2[6] = var2[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
		return var2;
	}
}
