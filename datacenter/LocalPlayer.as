class dofus.datacenter.LocalPlayer extends dofus.utils.ApiElement
{
   var isAuthorized = false;
   var haveFakeAlignment = false;
   var _nSummonedCreatures = 0;
   var _bIsRiding = false;
   function LocalPlayer(oAPI)
   {
      super();
      this.initialize(oAPI);
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      mx.events.EventDispatcher.initialize(this);
      this.clean();
      mx.events.EventDispatcher.initialize(this);
   }
   function clean()
   {
      this.SpellsManager = new dofus.managers.SpellsManager(this);
      this.InteractionsManager = new dofus.managers.InteractionsManager(this,this.api);
      this.Inventory = new ank.utils.ExtendedArray();
      this.ItemSets = new ank.utils.ExtendedObject();
      this.Jobs = new ank.utils.ExtendedArray();
      this.Spells = new ank.utils.ExtendedArray();
      this.Emotes = new ank.utils.ExtendedObject();
      this.clearSummon();
      this._bCraftPublicMode = false;
      this._bInParty = false;
   }
   function clearSummon()
   {
      this._nSummonedCreatures = 0;
      this._nMaxSummonedCreatures = 1;
      this.summonedCreaturesID = new Object();
   }
   function __get__clip()
   {
      return this.api.datacenter.Sprites.getItemAt(this._sID).mc;
   }
   function __get__data()
   {
      return this.api.datacenter.Sprites.getItemAt(this._sID);
   }
   function __get__isCurrentPlayer()
   {
      return this.api.datacenter.Game.currentPlayerID == this._sID;
   }
   function __set__ID(value)
   {
      this._sID = value;
      return this.__get__ID();
   }
   function __get__ID()
   {
      return this._sID;
   }
   function __set__Name(value)
   {
      this._sName = String(value);
      return this.__get__Name();
   }
   function __get__Name()
   {
      return this._sName;
   }
   function __set__Guild(value)
   {
      this._nGuild = Number(value);
      return this.__get__Guild();
   }
   function __get__Guild()
   {
      return this._nGuild;
   }
   function __set__Level(value)
   {
      this._nLevel = Number(value);
      this.dispatchEvent({type:"levelChanged",value:value});
      return this.__get__Level();
   }
   function __get__Level()
   {
      return this._nLevel;
   }
   function __set__Sex(value)
   {
      this._nSex = Number(value);
      return this.__get__Sex();
   }
   function __get__Sex()
   {
      return this._nSex;
   }
   function __set__color1(value)
   {
      this._nColor1 = Number(value);
      return this.__get__color1();
   }
   function __get__color1()
   {
      return this._nColor1;
   }
   function __set__color2(value)
   {
      this._nColor2 = Number(value);
      return this.__get__color2();
   }
   function __get__color2()
   {
      return this._nColor2;
   }
   function __set__color3(value)
   {
      this._nColor3 = Number(value);
      return this.__get__color3();
   }
   function __get__color3()
   {
      return this._nColor3;
   }
   function __set__LP(value)
   {
      this._nLP = Number(value) <= 0?0:Number(value);
      this.dispatchEvent({type:"lpChanged",value:value});
      return this.__get__LP();
   }
   function __get__LP()
   {
      return this._nLP;
   }
   function __set__LPmax(value)
   {
      this._nLPMax = Number(value);
      this.dispatchEvent({type:"lpmaxChanged",value:value});
      return this.__get__LPmax();
   }
   function __get__LPmax()
   {
      return this._nLPMax;
   }
   function __set__AP(value)
   {
      this._nAP = Number(value);
      this.data.AP = Number(value);
      this.dispatchEvent({type:"apChanged",value:value});
      return this.__get__AP();
   }
   function __get__AP()
   {
      return this._nAP;
   }
   function __set__MP(value)
   {
      this._nMP = Number(value);
      this.data.MP = Number(value);
      this.dispatchEvent({type:"mpChanged",value:value});
      return this.__get__MP();
   }
   function __get__MP()
   {
      return this._nMP;
   }
   function __set__Kama(value)
   {
      this._nKama = Number(value);
      this.dispatchEvent({type:"kamaChanged",value:value});
      return this.__get__Kama();
   }
   function __get__Kama()
   {
      return this._nKama;
   }
   function __set__XPlow(value)
   {
      this._nXPLow = Number(value);
      return this.__get__XPlow();
   }
   function __get__XPlow()
   {
      return this._nXPLow;
   }
   function __set__XP(value)
   {
      this._nXP = Number(value);
      this.dispatchEvent({type:"xpChanged",value:value});
      return this.__get__XP();
   }
   function __get__XP()
   {
      return this._nXP;
   }
   function __set__XPhigh(value)
   {
      this._nXPHigh = Number(value);
      return this.__get__XPhigh();
   }
   function __get__XPhigh()
   {
      return this._nXPHigh;
   }
   function __set__Initiative(value)
   {
      this._nInitiative = Number(value);
      this.dispatchEvent({type:"initiativeChanged",value:value});
      return this.__get__Initiative();
   }
   function __get__Initiative()
   {
      return this._nInitiative;
   }
   function __set__Discernment(value)
   {
      this._nDiscernment = Number(value);
      this.dispatchEvent({type:"discernmentChanged",value:value});
      return this.__get__Discernment();
   }
   function __get__Discernment()
   {
      return this._nDiscernment;
   }
   function __set__Force(value)
   {
      this._nForce = Number(value);
      this.dispatchEvent({type:"forceChanged",value:value});
      return this.__get__Force();
   }
   function __get__Force()
   {
      return this._nForce;
   }
   function __set__ForceXtra(value)
   {
      this._nForceXtra = Number(value);
      this.dispatchEvent({type:"forceXtraChanged",value:value});
      return this.__get__ForceXtra();
   }
   function __get__ForceXtra()
   {
      return this._nForceXtra;
   }
   function __set__Vitality(value)
   {
      this._nVitality = Number(value);
      this.dispatchEvent({type:"vitalityChanged",value:value});
      return this.__get__Vitality();
   }
   function __get__Vitality()
   {
      return this._nVitality;
   }
   function __set__VitalityXtra(value)
   {
      this._nVitalityXtra = Number(value);
      this.dispatchEvent({type:"vitalityXtraChanged",value:value});
      return this.__get__VitalityXtra();
   }
   function __get__VitalityXtra()
   {
      return this._nVitalityXtra;
   }
   function __set__Wisdom(value)
   {
      this._nWisdom = Number(value);
      this.dispatchEvent({type:"wisdomChanged",value:value});
      return this.__get__Wisdom();
   }
   function __get__Wisdom()
   {
      return this._nWisdom;
   }
   function __set__WisdomXtra(value)
   {
      this._nWisdomXtra = Number(value);
      this.dispatchEvent({type:"wisdomXtraChanged",value:value});
      return this.__get__WisdomXtra();
   }
   function __get__WisdomXtra()
   {
      return this._nWisdomXtra;
   }
   function __set__Chance(value)
   {
      this._nChance = Number(value);
      this.dispatchEvent({type:"chanceChanged",value:value});
      return this.__get__Chance();
   }
   function __get__Chance()
   {
      return this._nChance;
   }
   function __set__ChanceXtra(value)
   {
      this._nChanceXtra = Number(value);
      this.dispatchEvent({type:"chanceXtraChanged",value:value});
      return this.__get__ChanceXtra();
   }
   function __get__ChanceXtra()
   {
      return this._nChanceXtra;
   }
   function __set__Agility(value)
   {
      this._agility = Number(value);
      this.dispatchEvent({type:"agilityChanged",value:value});
      return this.__get__Agility();
   }
   function __get__Agility()
   {
      return this._agility;
   }
   function __set__AgilityXtra(value)
   {
      this._nAgilityXtra = Number(value);
      this.dispatchEvent({type:"agilityXtraChanged",value:value});
      return this.__get__AgilityXtra();
   }
   function __get__AgilityXtra()
   {
      return this._nAgilityXtra;
   }
   function __set__AgilityTotal(value)
   {
      this._nAgilityTotal = Number(value);
      this.dispatchEvent({type:"agilityTotalChanged",value:value});
      return this.__get__AgilityTotal();
   }
   function __get__AgilityTotal()
   {
      return this._nAgilityTotal;
   }
   function __set__Intelligence(value)
   {
      this._intelligence = Number(value);
      this.dispatchEvent({type:"intelligenceChanged",value:value});
      return this.__get__Intelligence();
   }
   function __get__Intelligence()
   {
      return this._intelligence;
   }
   function __set__IntelligenceXtra(value)
   {
      this._nIntelligenceXtra = Number(value);
      this.dispatchEvent({type:"intelligenceXtraChanged",value:value});
      return this.__get__IntelligenceXtra();
   }
   function __get__IntelligenceXtra()
   {
      return this._nIntelligenceXtra;
   }
   function __set__BonusPoints(value)
   {
      this._nBonusPoints = Number(value);
      this.dispatchEvent({type:"bonusPointsChanged",value:value});
      return this.__get__BonusPoints();
   }
   function __get__BonusPoints()
   {
      return this._nBonusPoints;
   }
   function __set__BonusPointsSpell(value)
   {
      this._nBonusPointsSpell = Number(value);
      this.dispatchEvent({type:"bonusSpellsChanged",value:value});
      return this.__get__BonusPointsSpell();
   }
   function __get__BonusPointsSpell()
   {
      return this._nBonusPointsSpell;
   }
   function __set__RangeModerator(value)
   {
      this._nRangeModerator = Number(value);
      return this.__get__RangeModerator();
   }
   function __get__RangeModerator()
   {
      return this._nRangeModerator;
   }
   function __set__Energy(value)
   {
      this._nEnergy = Number(value);
      this.dispatchEvent({type:"energyChanged",value:value});
      return this.__get__Energy();
   }
   function __get__Energy()
   {
      return this._nEnergy;
   }
   function __set__EnergyMax(value)
   {
      this._nEnergyMax = Number(value);
      this.dispatchEvent({type:"energyMaxChanged",value:value});
      return this.__get__EnergyMax();
   }
   function __get__EnergyMax()
   {
      return this._nEnergyMax;
   }
   function __set__SummonedCreatures(value)
   {
      this._nSummonedCreatures = Number(value);
      return this.__get__SummonedCreatures();
   }
   function __get__SummonedCreatures()
   {
      return this._nSummonedCreatures;
   }
   function __set__MaxSummonedCreatures(value)
   {
      this._nMaxSummonedCreatures = Number(value);
      return this.__get__MaxSummonedCreatures();
   }
   function __get__MaxSummonedCreatures()
   {
      return this._nMaxSummonedCreatures;
   }
   function __set__CriticalHitBonus(value)
   {
      this._nCriticalHitBonus = Number(value);
      return this.__get__CriticalHitBonus();
   }
   function __get__CriticalHitBonus()
   {
      return this._nCriticalHitBonus;
   }
   function __get__weaponItem()
   {
      return this._oWeaponItem;
   }
   function __set__FullStats(value)
   {
      this._aFullStats = value;
      this.dispatchEvent({type:"fullStatsChanged",value:value});
      return this.__get__FullStats();
   }
   function __get__FullStats()
   {
      return this._aFullStats;
   }
   function __set__currentJobID(value)
   {
      if(value == undefined)
      {
         delete this._nCurrentJobID;
      }
      else
      {
         this._nCurrentJobID = Number(value);
      }
      return this.__get__currentJobID();
   }
   function __get__currentJobID()
   {
      return this._nCurrentJobID;
   }
   function __get__currentJob()
   {
      var _loc2_ = this.Jobs.findFirstItem("id",this._nCurrentJobID);
      return _loc2_.item;
   }
   function __set__currentWeight(value)
   {
      this._nCurrentWeight = value;
      this.dispatchEvent({type:"currentWeightChanged",value:value});
      return this.__get__currentWeight();
   }
   function __get__currentWeight()
   {
      return this._nCurrentWeight;
   }
   function __set__maxWeight(value)
   {
      this._nMaxWeight = value;
      this.dispatchEvent({type:"maxWeightChanged",value:value});
      return this.__get__maxWeight();
   }
   function __get__maxWeight()
   {
      return this._nMaxWeight;
   }
   function __get__isMutant()
   {
      return this.data instanceof dofus.datacenter.Mutant;
   }
   function __set__restrictions(value)
   {
      this._nRestrictions = value;
      return this.__get__restrictions();
   }
   function __get__restrictions()
   {
      return this._nRestrictions;
   }
   function __set__specialization(value)
   {
      this._oSpecialization = value;
      this.dispatchEvent({type:"specializationChanged",value:value});
      return this.__get__specialization();
   }
   function __get__specialization()
   {
      return this._oSpecialization;
   }
   function __set__alignment(value)
   {
      this._oAlignment = value;
      this.dispatchEvent({type:"alignmentChanged",alignment:value});
      return this.__get__alignment();
   }
   function __get__alignment()
   {
      return this._oAlignment;
   }
   function __set__fakeAlignment(value)
   {
      this._oFakeAlignment = value;
      return this.__get__fakeAlignment();
   }
   function __get__fakeAlignment()
   {
      return this._oFakeAlignment;
   }
   function __set__rank(value)
   {
      this._oRank = value;
      this.dispatchEvent({type:"rankChanged",rank:value});
      return this.__get__rank();
   }
   function __get__rank()
   {
      return this._oRank;
   }
   function __set__mount(value)
   {
      this._oMount = value;
      this.dispatchEvent({type:"mountChanged",mount:value});
      return this.__get__mount();
   }
   function __get__mount()
   {
      return this._oMount;
   }
   function __get__isRiding()
   {
      return this._bIsRiding;
   }
   function __set__isRiding(value)
   {
      this._bIsRiding = value;
      return this.__get__isRiding();
   }
   function __set__mountXPPercent(value)
   {
      this._nMountXPPercent = value;
      this.dispatchEvent({type:"mountXPPercentChanged",value:value});
      return this.__get__mountXPPercent();
   }
   function __get__mountXPPercent()
   {
      return this._nMountXPPercent;
   }
   function __set__craftPublicMode(value)
   {
      this._bCraftPublicMode = value;
      this.dispatchEvent({type:"craftPublicModeChanged",value:value});
      return this.__get__craftPublicMode();
   }
   function __get__craftPublicMode()
   {
      return this._bCraftPublicMode;
   }
   function __set__inParty(value)
   {
      this._bInParty = value;
      this.dispatchEvent({type:"inPartyChanged",inParty:value});
      return this.__get__inParty();
   }
   function __get__inParty()
   {
      return this._bInParty;
   }
   function __get__canAssault()
   {
      return (this._nRestrictions & 1) != 1;
   }
   function __get__canChallenge()
   {
      return (this._nRestrictions & 2) != 2;
   }
   function __get__canExchange()
   {
      return (this._nRestrictions & 4) != 4;
   }
   function __get__canAttack()
   {
      return (this._nRestrictions & 8) == 8;
   }
   function __get__canChatToAll()
   {
      return (this._nRestrictions & 16) != 16;
   }
   function __get__canBeMerchant()
   {
      return (this._nRestrictions & 32) != 32;
   }
   function __get__canUseObject()
   {
      return (this._nRestrictions & 64) != 64;
   }
   function __get__cantInteractWithTaxCollector()
   {
      return (this._nRestrictions & 128) == 128;
   }
   function __get__canUseInteractiveObjects()
   {
      return (this._nRestrictions & 256) != 256;
   }
   function __get__cantSpeakNPC()
   {
      return (this._nRestrictions & 512) == 512;
   }
   function __get__canAttackDungeonMonstersWhenMutant()
   {
      return (this._nRestrictions & 4096) == 4096;
   }
   function __get__canMoveInAllDirections()
   {
      return (this._nRestrictions & 8192) == 8192;
   }
   function __get__canAttackMonstersAnywhereWhenMutant()
   {
      return (this._nRestrictions & 16384) == 16384;
   }
   function __get__cantInteractWithPrism()
   {
      return (this._nRestrictions & 32768) == 32768;
   }
   function reset()
   {
      this.currentUseObject = null;
   }
   function updateLP(dLP)
   {
      dLP = Number(dLP);
      if(this.LP + dLP > this.LPmax)
      {
         dLP = this.LPmax - this.LP;
      }
      this.LP = this.LP + dLP;
   }
   function hasEnoughAP(wantedAP)
   {
      return this.data.AP >= wantedAP;
   }
   function addItem(oItem)
   {
      if(oItem.position == 1)
      {
         this.setWeaponItem(oItem);
      }
      this.Inventory.push(oItem);
   }
   function updateItem(oNewItem)
   {
      var _loc3_ = this.Inventory.findFirstItem("ID",oNewItem.ID);
      if(_loc3_.item.ID == oNewItem.ID && _loc3_.item.maxSkin != oNewItem.maxSkin)
      {
         if(!_loc3_.item.isLeavingItem && oNewItem.isLeavingItem)
         {
            this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ASSOCIATE);
         }
         if(_loc3_.item.isLeavingItem && oNewItem.isLeavingItem)
         {
            this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_LEVEL_UP);
         }
      }
      this.Inventory.updateItem(_loc3_.index,oNewItem);
   }
   function updateItemQuantity(nItemNum, nQuantity)
   {
      var _loc4_ = this.Inventory.findFirstItem("ID",nItemNum);
      var _loc5_ = _loc4_.item;
      _loc5_.Quantity = nQuantity;
      this.Inventory.updateItem(_loc4_.index,_loc5_);
   }
   function updateItemPosition(nItemNum, nPosition)
   {
      var _loc4_ = this.Inventory.findFirstItem("ID",nItemNum);
      var _loc5_ = _loc4_.item;
      if(_loc5_.position == 1)
      {
         this.setWeaponItem();
      }
      else if(nPosition == 1)
      {
         this.setWeaponItem(_loc5_);
      }
      _loc5_.position = nPosition;
      this.Inventory.updateItem(_loc4_.index,_loc5_);
   }
   function dropItem(nItemNum)
   {
      var _loc3_ = this.Inventory.findFirstItem("ID",nItemNum);
      if(_loc3_.item.position == 1)
      {
         this.setWeaponItem();
      }
      this.Inventory.removeItems(_loc3_.index,1);
   }
   function updateSpell(oSpell)
   {
      var _loc3_ = this.Spells.findFirstItem("ID",oSpell.ID);
      if(_loc3_.index != -1)
      {
         oSpell.position = _loc3_.item.position;
         this.Spells.updateItem(_loc3_.index,oSpell);
      }
      else
      {
         this.Spells.push(oSpell);
      }
   }
   function updateSpellPosition(oSpell)
   {
      var _loc3_ = this.Spells.findFirstItem("position",oSpell.position);
      var _loc4_ = this.Spells.findFirstItem("ID",oSpell.ID);
      if(_loc3_.index != -1)
      {
         _loc3_.item.position = undefined;
         this.Spells.updateItem(_loc3_.index,oSpell);
      }
      if(_loc4_.index != -1)
      {
         this.Spells.updateItem(_loc3_.index,oSpell);
      }
      else
      {
         this.Spells.push(oSpell);
      }
   }
   function removeSpell(nID)
   {
      var _loc3_ = this.Spells.findFirstItem("ID",nID);
      if(_loc3_.index != -1)
      {
         this.Spells.removeItems(_loc3_.index,1);
      }
   }
   function canBoost(nCharacID)
   {
      if(this.api.datacenter.Game.isRunning)
      {
         return false;
      }
      var _loc3_ = this.getBoostCostAndCountForCharacteristic(nCharacID).cost;
      if(this._nBonusPoints >= _loc3_)
      {
         return true;
      }
      return false;
   }
   function getBoostCostAndCountForCharacteristic(nCharacID)
   {
      var _loc3_ = this.api.lang.getClassText(this._nGuild)["b" + nCharacID];
      var _loc4_ = 1;
      var _loc5_ = 1;
      var _loc6_ = 0;
      switch(nCharacID)
      {
         case 10:
            _loc6_ = this._nForce;
            break;
         case 11:
            _loc6_ = this._nVitality;
            break;
         case 12:
            _loc6_ = this._nWisdom;
            break;
         case 13:
            _loc6_ = this._nChance;
            break;
         case 14:
            _loc6_ = this._agility;
            break;
         case 15:
            _loc6_ = this._intelligence;
      }
      var _loc7_ = 0;
      while(_loc7_ < _loc3_.length)
      {
         var _loc8_ = _loc3_[_loc7_][0];
         if(_loc6_ >= _loc8_)
         {
            _loc4_ = _loc3_[_loc7_][1];
            _loc5_ = _loc3_[_loc7_][2] != undefined?_loc3_[_loc7_][2]:1;
            _loc7_ = _loc7_ + 1;
            continue;
         }
         break;
      }
      return {cost:_loc4_,count:_loc5_};
   }
   function isAtHome(nMapID)
   {
      var _loc3_ = Number(this.api.lang.getHousesMapText(nMapID));
      if(_loc3_ != undefined)
      {
         return this.api.datacenter.Houses.getItemAt(_loc3_).localOwner;
      }
      return false;
   }
   function clearEmotes()
   {
      this.Emotes = new ank.utils.ExtendedObject();
   }
   function addEmote(nEmoteID)
   {
      this.Emotes.addItemAt(nEmoteID,true);
   }
   function hasEmote(nEmoteID)
   {
      return this.Emotes.getItemAt(nEmoteID) == true;
   }
   function updateCloseCombat()
   {
      this.Spells[0] = new dofus.datacenter.CloseCombat(this._oWeaponItem,this._nGuild);
   }
   function setWeaponItem(oItem)
   {
      this._oWeaponItem = oItem;
      this.updateCloseCombat();
   }
}
