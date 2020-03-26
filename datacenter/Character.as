class dofus.datacenter.Character extends dofus.datacenter.PlayableCharacter
{
   var xtraClipTopAnimations = {staticF:true};
   function Character(sID, clipClass, sGfxFile, cellNum, dir, gfxID, title)
   {
      super();
      this._title = title;
      this.initialize(sID,clipClass,sGfxFile,cellNum,dir,gfxID);
   }
   function __get__speedModerator()
   {
      return !this.isSlow?this._nSpeedModerator:0.5;
   }
   function __get__Guild()
   {
      return this._nGuild;
   }
   function __set__Guild(value)
   {
      this._nGuild = Number(value);
      return this.__get__Guild();
   }
   function __get__Sex()
   {
      return this._nSex;
   }
   function __set__Sex(value)
   {
      this._nSex = Number(value);
      return this.__get__Sex();
   }
   function __get__Aura()
   {
      return this._nAura;
   }
   function __set__Aura(value)
   {
      this._nAura = Number(value);
      return this.__get__Aura();
   }
   function __get__alignment()
   {
      return this._oAlignment;
   }
   function __set__alignment(value)
   {
      this._oAlignment = value;
      return this.__get__alignment();
   }
   function __get__Merchant()
   {
      return this._bMerchant;
   }
   function __set__Merchant(value)
   {
      this._bMerchant = value;
      return this.__get__Merchant();
   }
   function __get__serverID()
   {
      return this._nServerID;
   }
   function __set__serverID(value)
   {
      this._nServerID = value;
      return this.__get__serverID();
   }
   function __get__Died()
   {
      return this._bDied;
   }
   function __set__Died(value)
   {
      this._bDied = value;
      return this.__get__Died();
   }
   function __get__rank()
   {
      return this._oRank;
   }
   function __set__rank(value)
   {
      this._oRank = value;
      return this.__get__rank();
   }
   function __get__multiCraftSkillsID()
   {
      return this._aMultiCraftSkillsID;
   }
   function __set__multiCraftSkillsID(value)
   {
      this._aMultiCraftSkillsID = value;
      return this.__get__multiCraftSkillsID();
   }
   function __set__guildName(sGuildName)
   {
      this._sGuildName = sGuildName;
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
   function __set__emblem(oEmblem)
   {
      this._oEmblem = oEmblem;
      return this.__get__emblem();
   }
   function __get__emblem()
   {
      return this._oEmblem;
   }
   function __set__restrictions(nRestrictions)
   {
      this._nRestrictions = Number(nRestrictions);
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
   function __set__resistances(aResistances)
   {
      this._aResistances = aResistances;
      return this.__get__resistances();
   }
   function __get__resistances()
   {
      var _loc2_ = new Array();
      var _loc3_ = 0;
      while(_loc3_ < this._aResistances.length)
      {
         _loc2_[_loc3_] = this._aResistances[_loc3_];
         _loc3_ = _loc3_ + 1;
      }
      _loc2_[5] = _loc2_[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
      _loc2_[6] = _loc2_[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
      return _loc2_;
   }
}
