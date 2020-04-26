class dofus.datacenter.Character extends dofus.datacenter.PlayableCharacter
{
	var xtraClipTopAnimations = {staticF:true};
	function Character(sID, clipClass, §\x1e\x13\x16§, cellNum, §\x11\x1d§, gfxID, §\x1e\r\t§)
	{
		super();
		this._title = loc9;
		this.initialize(sID,clipClass,loc5,cellNum,loc7,gfxID);
	}
	function __get__speedModerator()
	{
		var loc2 = this._nSpeedModerator;
		if(this.isSlow)
		{
			loc2 = loc2 / 2;
		}
		else if(this.isAdminSonicSpeed)
		{
			loc2 = loc2 * 5;
		}
		return loc2;
	}
	function __get__Guild()
	{
		return this._nGuild;
	}
	function __set__Guild(loc2)
	{
		this._nGuild = Number(loc2);
		return this.__get__Guild();
	}
	function __get__Sex()
	{
		return this._nSex;
	}
	function __set__Sex(loc2)
	{
		this._nSex = Number(loc2);
		return this.__get__Sex();
	}
	function __get__Aura()
	{
		return this._nAura;
	}
	function __set__Aura(loc2)
	{
		this._nAura = Number(loc2);
		return this.__get__Aura();
	}
	function __get__alignment()
	{
		return this._oAlignment;
	}
	function __set__alignment(loc2)
	{
		this._oAlignment = loc2;
		return this.__get__alignment();
	}
	function __get__Merchant()
	{
		return this._bMerchant;
	}
	function __set__Merchant(loc2)
	{
		this._bMerchant = loc2;
		return this.__get__Merchant();
	}
	function __get__serverID()
	{
		return this._nServerID;
	}
	function __set__serverID(loc2)
	{
		this._nServerID = loc2;
		return this.__get__serverID();
	}
	function __get__Died()
	{
		return this._bDied;
	}
	function __set__Died(loc2)
	{
		this._bDied = loc2;
		return this.__get__Died();
	}
	function __get__rank()
	{
		return this._oRank;
	}
	function __set__rank(loc2)
	{
		this._oRank = loc2;
		return this.__get__rank();
	}
	function __get__multiCraftSkillsID()
	{
		return this._aMultiCraftSkillsID;
	}
	function __set__multiCraftSkillsID(loc2)
	{
		this._aMultiCraftSkillsID = loc2;
		return this.__get__multiCraftSkillsID();
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
	function __get__title()
	{
		return this._title;
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
	function __set__restrictions(loc2)
	{
		this._nRestrictions = Number(loc2);
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
	function __set__resistances(loc2)
	{
		this._aResistances = loc2;
		return this.__get__resistances();
	}
	function __get__resistances()
	{
		var loc2 = new Array();
		var loc3 = 0;
		while(loc3 < this._aResistances.length)
		{
			loc2[loc3] = this._aResistances[loc3];
			loc3 = loc3 + 1;
		}
		loc2[5] = loc2[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
		loc2[6] = loc2[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
		return loc2;
	}
}
