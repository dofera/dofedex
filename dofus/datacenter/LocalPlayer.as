class dofus.datacenter.LocalPlayer extends dofus.utils.ApiElement
{
	var isAuthorized = false;
	var isSkippingFightAnimations = false;
	var isSkippingLootPanel = false;
	var haveFakeAlignment = false;
	var _nSummonedCreatures = 0;
	var _bIsRiding = false;
	function LocalPlayer(_loc3_)
	{
		super();
		this.initialize(_loc3_);
	}
	function initialize(_loc2_)
	{
		super.initialize(_loc3_);
		eval("\n\x0b").events.EventDispatcher.initialize(this);
		this.clean();
		eval("\n\x0b").events.EventDispatcher.initialize(this);
	}
	function clean()
	{
		this.SpellsManager = new dofus.managers.SpellsManager(this);
		this.InteractionsManager = new dofus.managers.InteractionsManager(this,this.api);
		this.Inventory = new ank.utils.();
		this.ItemSets = new ank.utils.();
		this.Jobs = new ank.utils.();
		this.Spells = new ank.utils.();
		this.Emotes = new ank.utils.();
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
	function __set__ID(_loc2_)
	{
		this._sID = _loc2_;
		return this.__get__ID();
	}
	function __get__ID()
	{
		return this._sID;
	}
	function __set__Name(_loc2_)
	{
		this._sName = String(_loc2_);
		return this.__get__Name();
	}
	function __get__Name()
	{
		return this._sName;
	}
	function __set__Guild(_loc2_)
	{
		this._nGuild = Number(_loc2_);
		return this.__get__Guild();
	}
	function __get__Guild()
	{
		return this._nGuild;
	}
	function __set__Level(_loc2_)
	{
		this._nLevel = Number(_loc2_);
		this.dispatchEvent({type:"levelChanged",value:_loc2_});
		return this.__get__Level();
	}
	function __get__Level()
	{
		return this._nLevel;
	}
	function __set__Sex(_loc2_)
	{
		this._nSex = Number(_loc2_);
		return this.__get__Sex();
	}
	function __get__Sex()
	{
		return this._nSex;
	}
	function __set__color1(_loc2_)
	{
		this._nColor1 = Number(_loc2_);
		return this.__get__color1();
	}
	function __get__color1()
	{
		return this._nColor1;
	}
	function __set__color2(_loc2_)
	{
		this._nColor2 = Number(_loc2_);
		return this.__get__color2();
	}
	function __get__color2()
	{
		return this._nColor2;
	}
	function __set__color3(_loc2_)
	{
		this._nColor3 = Number(_loc2_);
		return this.__get__color3();
	}
	function __get__color3()
	{
		return this._nColor3;
	}
	function __set__LP(_loc2_)
	{
		this._nLP = Number(_loc2_) <= 0?0:Number(_loc2_);
		this.dispatchEvent({type:"lpChanged",value:_loc2_});
		return this.__get__LP();
	}
	function __get__LP()
	{
		return this._nLP;
	}
	function __set__LPmax(_loc2_)
	{
		this._nLPMax = Number(_loc2_);
		this.dispatchEvent({type:"lpMaxChanged",value:_loc2_});
		return this.__get__LPmax();
	}
	function __get__LPmax()
	{
		return this._nLPMax;
	}
	function __set__AP(_loc2_)
	{
		this._nAP = Number(_loc2_);
		this.data.AP = Number(_loc2_);
		this.dispatchEvent({type:"apChanged",value:_loc2_});
		return this.__get__AP();
	}
	function __get__AP()
	{
		return this._nAP;
	}
	function __set__MP(_loc2_)
	{
		this._nMP = Number(_loc2_);
		this.data.MP = Number(_loc2_);
		this.dispatchEvent({type:"mpChanged",value:_loc2_});
		return this.__get__MP();
	}
	function __get__MP()
	{
		return this._nMP;
	}
	function __set__Kama(_loc2_)
	{
		this._nKama = Number(_loc2_);
		this.dispatchEvent({type:"kamaChanged",value:_loc2_});
		return this.__get__Kama();
	}
	function __get__Kama()
	{
		return this._nKama;
	}
	function __set__XPlow(_loc2_)
	{
		this._nXPLow = Number(_loc2_);
		return this.__get__XPlow();
	}
	function __get__XPlow()
	{
		return this._nXPLow;
	}
	function __set__XP(_loc2_)
	{
		this._nXP = Number(_loc2_);
		this.dispatchEvent({type:"xpChanged",value:_loc2_});
		return this.__get__XP();
	}
	function __get__XP()
	{
		return this._nXP;
	}
	function __set__XPhigh(_loc2_)
	{
		this._nXPHigh = Number(_loc2_);
		return this.__get__XPhigh();
	}
	function __get__XPhigh()
	{
		return this._nXPHigh;
	}
	function __set__Initiative(_loc2_)
	{
		this._nInitiative = Number(_loc2_);
		this.dispatchEvent({type:"initiativeChanged",value:_loc2_});
		return this.__get__Initiative();
	}
	function __get__Initiative()
	{
		return this._nInitiative;
	}
	function __set__Discernment(_loc2_)
	{
		this._nDiscernment = Number(_loc2_);
		this.dispatchEvent({type:"discernmentChanged",value:_loc2_});
		return this.__get__Discernment();
	}
	function __get__Discernment()
	{
		return this._nDiscernment;
	}
	function __set__Force(_loc2_)
	{
		this._nForce = Number(_loc2_);
		this.dispatchEvent({type:"forceChanged",value:_loc2_});
		return this.__get__Force();
	}
	function __get__Force()
	{
		return this._nForce;
	}
	function __set__ForceXtra(_loc2_)
	{
		this._nForceXtra = Number(_loc2_);
		this.dispatchEvent({type:"forceXtraChanged",value:_loc2_});
		return this.__get__ForceXtra();
	}
	function __get__ForceXtra()
	{
		return this._nForceXtra;
	}
	function __set__Vitality(_loc2_)
	{
		this._nVitality = Number(_loc2_);
		this.dispatchEvent({type:"vitalityChanged",value:_loc2_});
		return this.__get__Vitality();
	}
	function __get__Vitality()
	{
		return this._nVitality;
	}
	function __set__VitalityXtra(_loc2_)
	{
		this._nVitalityXtra = Number(_loc2_);
		this.dispatchEvent({type:"vitalityXtraChanged",value:_loc2_});
		return this.__get__VitalityXtra();
	}
	function __get__VitalityXtra()
	{
		return this._nVitalityXtra;
	}
	function __set__Wisdom(_loc2_)
	{
		this._nWisdom = Number(_loc2_);
		this.dispatchEvent({type:"wisdomChanged",value:_loc2_});
		return this.__get__Wisdom();
	}
	function __get__Wisdom()
	{
		return this._nWisdom;
	}
	function __set__WisdomXtra(_loc2_)
	{
		this._nWisdomXtra = Number(_loc2_);
		this.dispatchEvent({type:"wisdomXtraChanged",value:_loc2_});
		return this.__get__WisdomXtra();
	}
	function __get__WisdomXtra()
	{
		return this._nWisdomXtra;
	}
	function __set__Chance(_loc2_)
	{
		this._nChance = Number(_loc2_);
		this.dispatchEvent({type:"chanceChanged",value:_loc2_});
		return this.__get__Chance();
	}
	function __get__Chance()
	{
		return this._nChance;
	}
	function __set__ChanceXtra(_loc2_)
	{
		this._nChanceXtra = Number(_loc2_);
		this.dispatchEvent({type:"chanceXtraChanged",value:_loc2_});
		return this.__get__ChanceXtra();
	}
	function __get__ChanceXtra()
	{
		return this._nChanceXtra;
	}
	function __set__Agility(_loc2_)
	{
		this._agility = Number(_loc2_);
		this.dispatchEvent({type:"agilityChanged",value:_loc2_});
		return this.__get__Agility();
	}
	function __get__Agility()
	{
		return this._agility;
	}
	function __set__AgilityXtra(_loc2_)
	{
		this._nAgilityXtra = Number(_loc2_);
		this.dispatchEvent({type:"agilityXtraChanged",value:_loc2_});
		return this.__get__AgilityXtra();
	}
	function __get__AgilityXtra()
	{
		return this._nAgilityXtra;
	}
	function __set__AgilityTotal(_loc2_)
	{
		this._nAgilityTotal = Number(_loc2_);
		this.dispatchEvent({type:"agilityTotalChanged",value:_loc2_});
		return this.__get__AgilityTotal();
	}
	function __get__AgilityTotal()
	{
		return this._nAgilityTotal;
	}
	function __set__Intelligence(_loc2_)
	{
		this._intelligence = Number(_loc2_);
		this.dispatchEvent({type:"intelligenceChanged",value:_loc2_});
		return this.__get__Intelligence();
	}
	function __get__Intelligence()
	{
		return this._intelligence;
	}
	function __set__IntelligenceXtra(_loc2_)
	{
		this._nIntelligenceXtra = Number(_loc2_);
		this.dispatchEvent({type:"intelligenceXtraChanged",value:_loc2_});
		return this.__get__IntelligenceXtra();
	}
	function __get__IntelligenceXtra()
	{
		return this._nIntelligenceXtra;
	}
	function __set__BonusPoints(_loc2_)
	{
		this._nBonusPoints = Number(_loc2_);
		this.dispatchEvent({type:"bonusPointsChanged",value:_loc2_});
		return this.__get__BonusPoints();
	}
	function __get__BonusPoints()
	{
		return this._nBonusPoints;
	}
	function __set__BonusPointsSpell(_loc2_)
	{
		this._nBonusPointsSpell = Number(_loc2_);
		this.dispatchEvent({type:"bonusSpellsChanged",value:_loc2_});
		return this.__get__BonusPointsSpell();
	}
	function __get__BonusPointsSpell()
	{
		return this._nBonusPointsSpell;
	}
	function __set__RangeModerator(_loc2_)
	{
		this._nRangeModerator = Number(_loc2_);
		return this.__get__RangeModerator();
	}
	function __get__RangeModerator()
	{
		return this._nRangeModerator;
	}
	function __set__Energy(_loc2_)
	{
		this._nEnergy = Number(_loc2_);
		this.dispatchEvent({type:"energyChanged",value:_loc2_});
		return this.__get__Energy();
	}
	function __get__Energy()
	{
		return this._nEnergy;
	}
	function __set__EnergyMax(_loc2_)
	{
		this._nEnergyMax = Number(_loc2_);
		this.dispatchEvent({type:"energyMaxChanged",value:_loc2_});
		return this.__get__EnergyMax();
	}
	function __get__EnergyMax()
	{
		return this._nEnergyMax;
	}
	function __set__SummonedCreatures(_loc2_)
	{
		this._nSummonedCreatures = Number(_loc2_);
		return this.__get__SummonedCreatures();
	}
	function __get__SummonedCreatures()
	{
		return this._nSummonedCreatures;
	}
	function __set__MaxSummonedCreatures(_loc2_)
	{
		this._nMaxSummonedCreatures = Number(_loc2_);
		return this.__get__MaxSummonedCreatures();
	}
	function __get__MaxSummonedCreatures()
	{
		return this._nMaxSummonedCreatures;
	}
	function __set__CriticalHitBonus(_loc2_)
	{
		this._nCriticalHitBonus = Number(_loc2_);
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
	function __set__FullStats(_loc2_)
	{
		this._aFullStats = _loc2_;
		this.dispatchEvent({type:"fullStatsChanged",value:_loc2_});
		return this.__get__FullStats();
	}
	function __get__FullStats()
	{
		return this._aFullStats;
	}
	function __set__currentJobID(_loc2_)
	{
		if(_loc2_ == undefined)
		{
			delete this._nCurrentJobID;
		}
		else
		{
			this._nCurrentJobID = Number(_loc2_);
		}
		this.dispatchEvent({type:"currentJobChanged",value:_loc2_});
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
	function __set__currentWeight(_loc2_)
	{
		this._nCurrentWeight = _loc2_;
		this.dispatchEvent({type:"currentWeightChanged",value:_loc2_});
		return this.__get__currentWeight();
	}
	function __get__currentWeight()
	{
		return this._nCurrentWeight;
	}
	function __set__maxWeight(_loc2_)
	{
		this._nMaxWeight = _loc2_;
		this.dispatchEvent({type:"maxWeightChanged",value:_loc2_});
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
	function __set__restrictions(_loc2_)
	{
		this._nRestrictions = _loc2_;
		return this.__get__restrictions();
	}
	function __get__restrictions()
	{
		return this._nRestrictions;
	}
	function __set__specialization(_loc2_)
	{
		this._oSpecialization = _loc2_;
		this.dispatchEvent({type:"specializationChanged",value:_loc2_});
		return this.__get__specialization();
	}
	function __get__specialization()
	{
		return this._oSpecialization;
	}
	function __set__alignment(_loc2_)
	{
		this._oAlignment = _loc2_;
		this.dispatchEvent({type:"alignmentChanged",alignment:_loc2_});
		return this.__get__alignment();
	}
	function __get__alignment()
	{
		return this._oAlignment;
	}
	function __set__fakeAlignment(_loc2_)
	{
		this._oFakeAlignment = _loc2_;
		return this.__get__fakeAlignment();
	}
	function __get__fakeAlignment()
	{
		return this._oFakeAlignment;
	}
	function __set__rank(_loc2_)
	{
		this._oRank = _loc2_;
		this.dispatchEvent({type:"rankChanged",rank:_loc2_});
		return this.__get__rank();
	}
	function __get__rank()
	{
		return this._oRank;
	}
	function __set__mount(_loc2_)
	{
		this._oMount = _loc2_;
		this.dispatchEvent({type:"mountChanged",mount:_loc2_});
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
	function __set__isRiding(_loc2_)
	{
		this._bIsRiding = _loc2_;
		return this.__get__isRiding();
	}
	function __set__mountXPPercent(_loc2_)
	{
		this._nMountXPPercent = _loc2_;
		this.dispatchEvent({type:"mountXPPercentChanged",value:_loc2_});
		return this.__get__mountXPPercent();
	}
	function __get__mountXPPercent()
	{
		return this._nMountXPPercent;
	}
	function __set__craftPublicMode(_loc2_)
	{
		this._bCraftPublicMode = _loc2_;
		this.dispatchEvent({type:"craftPublicModeChanged",value:_loc2_});
		return this.__get__craftPublicMode();
	}
	function __get__craftPublicMode()
	{
		return this._bCraftPublicMode;
	}
	function __set__inParty(_loc2_)
	{
		this._bInParty = _loc2_;
		this.dispatchEvent({type:"inPartyChanged",inParty:_loc2_});
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
	function getPossibleItemReceiveQuantity(_loc2_, _loc3_)
	{
		var _loc4_ = !_loc3_?this.maxWeight - this.currentWeight:this.mount.podsMax - this.mount.pods;
		var _loc5_ = _loc2_.weight;
		var _loc6_ = Math.floor(_loc4_ / _loc5_);
		if(_loc6_ > _loc2_.Quantity)
		{
			_loc6_ = _loc2_.Quantity;
		}
		return _loc6_;
	}
	function updateLP(_loc2_)
	{
		_loc2_ = Number(_loc2_);
		if(this.LP + _loc2_ > this.LPmax)
		{
			_loc2_ = this.LPmax - this.LP;
		}
		this.LP = this.LP + _loc2_;
	}
	function hasEnoughAP(_loc2_)
	{
		return this.data.AP >= _loc2_;
	}
	function addItem(_loc2_)
	{
		if(_loc2_.position == 1)
		{
			this.setWeaponItem(_loc2_);
		}
		this.Inventory.push(_loc2_);
	}
	function updateItem(_loc2_)
	{
		var _loc3_ = this.Inventory.findFirstItem("ID",_loc2_.ID);
		if(_loc3_.item.ID == _loc2_.ID && _loc3_.item.maxSkin != _loc2_.maxSkin)
		{
			if(!_loc3_.item.isLeavingItem && _loc2_.isLeavingItem)
			{
				this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ASSOCIATE);
			}
			if(_loc3_.item.isLeavingItem && _loc2_.isLeavingItem)
			{
				this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_LEVEL_UP);
			}
		}
		this.Inventory.updateItem(_loc3_.index,_loc2_);
	}
	function updateItemQuantity(_loc2_, _loc3_)
	{
		var _loc4_ = this.Inventory.findFirstItem("ID",_loc2_);
		var _loc5_ = _loc4_.item;
		_loc5_.Quantity = _loc3_;
		this.Inventory.updateItem(_loc4_.index,_loc5_);
	}
	function updateItemPosition(_loc2_, _loc3_)
	{
		var _loc4_ = this.Inventory.findFirstItem("ID",_loc2_);
		var _loc5_ = _loc4_.item;
		if(_loc5_.position == 1)
		{
			this.setWeaponItem();
		}
		else if(_loc3_ == 1)
		{
			this.setWeaponItem(_loc5_);
		}
		_loc5_.position = _loc3_;
		this.Inventory.updateItem(_loc4_.index,_loc5_);
	}
	function dropItem(_loc2_)
	{
		var _loc3_ = this.Inventory.findFirstItem("ID",_loc2_);
		if(_loc3_.item.position == 1)
		{
			this.setWeaponItem();
		}
		this.Inventory.removeItems(_loc3_.index,1);
	}
	function updateSpell(_loc2_)
	{
		var _loc3_ = this.Spells.findFirstItem("ID",_loc2_.ID);
		if(_loc3_.index != -1)
		{
			_loc2_.position = _loc3_.item.position;
			this.Spells.updateItem(_loc3_.index,_loc2_);
		}
		else
		{
			this.Spells.push(_loc2_);
		}
	}
	function updateSpellPosition(_loc2_)
	{
		var _loc3_ = this.Spells.findFirstItem("position",_loc2_.position);
		var _loc4_ = this.Spells.findFirstItem("ID",_loc2_.ID);
		if(_loc3_.index != -1)
		{
			_loc3_.item.position = undefined;
			this.Spells.updateItem(_loc3_.index,_loc2_);
		}
		if(_loc4_.index != -1)
		{
			this.Spells.updateItem(_loc3_.index,_loc2_);
		}
		else
		{
			this.Spells.push(_loc2_);
		}
	}
	function removeSpell(_loc2_)
	{
		var _loc3_ = this.Spells.findFirstItem("ID",_loc2_);
		if(_loc3_.index != -1)
		{
			this.Spells.removeItems(_loc3_.index,1);
		}
	}
	function canBoost(_loc2_)
	{
		if(this.api.datacenter.Game.isRunning)
		{
			return false;
		}
		var _loc3_ = this.getBoostCostAndCountForCharacteristic(_loc2_).cost;
		if(this._nBonusPoints >= _loc3_)
		{
			return true;
		}
		return false;
	}
	function getBoostCostAndCountForCharacteristic(_loc2_)
	{
		var _loc3_ = this.api.lang.getClassText(this._nGuild)["b" + _loc2_];
		var _loc4_ = 1;
		var _loc5_ = 1;
		var _loc6_ = 0;
		if((var _loc0_ = _loc2_) !== 10)
		{
			switch(null)
			{
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
		}
		else
		{
			_loc6_ = this._nForce;
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
	function isAtHome(_loc2_)
	{
		var _loc3_ = Number(this.api.lang.getHousesMapText(_loc2_));
		if(_loc3_ != undefined)
		{
			return this.api.datacenter.Houses.getItemAt(_loc3_).localOwner;
		}
		return false;
	}
	function clearEmotes()
	{
		this.Emotes = new ank.utils.();
	}
	function addEmote(_loc2_)
	{
		this.Emotes.addItemAt(_loc2_,true);
	}
	function hasEmote(_loc2_)
	{
		return this.Emotes.getItemAt(_loc2_) == true;
	}
	function updateCloseCombat()
	{
		this.Spells[0] = new dofus.datacenter.(this._oWeaponItem,this._nGuild);
	}
	function setWeaponItem(_loc2_)
	{
		this._oWeaponItem = _loc2_;
		this.updateCloseCombat();
	}
}
