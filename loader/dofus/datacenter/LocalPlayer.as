class dofus.datacenter.LocalPlayer extends dofus.utils.ApiElement
{
	var isAuthorized = false;
	var isSkippingFightAnimations = false;
	var isSkippingLootPanel = false;
	var haveFakeAlignment = false;
	var _nSummonedCreatures = 0;
	var _bIsRiding = false;
	function LocalPlayer(§\x1e\x1a\x16§)
	{
		super();
		this.initialize(var3);
	}
	function initialize(§\x1e\x1a\x16§)
	{
		super.initialize(var3);
		mx.events.EventDispatcher.initialize(this);
		this.clean();
		mx.events.EventDispatcher.initialize(this);
	}
	function clean()
	{
		this.SpellsManager = new dofus.managers.SpellsManager(this);
		this.InteractionsManager = new dofus.managers.InteractionsManager(this,this.api);
		this.Inventory = new ank.utils.
();
		this.ItemSets = new ank.utils.	();
		this.Jobs = new ank.utils.
();
		this.Spells = new ank.utils.
();
		this.Emotes = new ank.utils.	();
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
	function __set__ID(§\x1e\n\x0f§)
	{
		this._sID = var2;
		return this.__get__ID();
	}
	function __get__ID()
	{
		return this._sID;
	}
	function __set__Name(§\x1e\n\x0f§)
	{
		this._sName = String(var2);
		this.dispatchEvent({type:"nameChanged",value:var2});
		return this.__get__Name();
	}
	function __get__Name()
	{
		return this._sName;
	}
	function __set__Guild(§\x1e\n\x0f§)
	{
		this._nGuild = Number(var2);
		return this.__get__Guild();
	}
	function __get__Guild()
	{
		return this._nGuild;
	}
	function __set__Level(§\x1e\n\x0f§)
	{
		this._nLevel = Number(var2);
		this.dispatchEvent({type:"levelChanged",value:var2});
		return this.__get__Level();
	}
	function __get__Level()
	{
		return this._nLevel;
	}
	function __set__Sex(§\x1e\n\x0f§)
	{
		this._nSex = Number(var2);
		return this.__get__Sex();
	}
	function __get__Sex()
	{
		return this._nSex;
	}
	function __set__color1(§\x1e\n\x0f§)
	{
		this._nColor1 = Number(var2);
		return this.__get__color1();
	}
	function __get__color1()
	{
		return this._nColor1;
	}
	function __set__color2(§\x1e\n\x0f§)
	{
		this._nColor2 = Number(var2);
		return this.__get__color2();
	}
	function __get__color2()
	{
		return this._nColor2;
	}
	function __set__color3(§\x1e\n\x0f§)
	{
		this._nColor3 = Number(var2);
		return this.__get__color3();
	}
	function __get__color3()
	{
		return this._nColor3;
	}
	function __set__LP(§\x1e\n\x0f§)
	{
		this._nLP = Number(var2) <= 0?0:Number(var2);
		this.dispatchEvent({type:"lpChanged",value:var2});
		return this.__get__LP();
	}
	function __get__LP()
	{
		return this._nLP;
	}
	function __set__LPmax(§\x1e\n\x0f§)
	{
		this._nLPMax = Number(var2);
		this.dispatchEvent({type:"lpMaxChanged",value:var2});
		return this.__get__LPmax();
	}
	function __get__LPmax()
	{
		return this._nLPMax;
	}
	function __set__AP(§\x1e\n\x0f§)
	{
		this._nAP = Number(var2);
		this.data.AP = Number(var2);
		this.dispatchEvent({type:"apChanged",value:var2});
		return this.__get__AP();
	}
	function __get__AP()
	{
		return this._nAP;
	}
	function __set__MP(§\x1e\n\x0f§)
	{
		this._nMP = Number(var2);
		this.data.MP = Number(var2);
		this.dispatchEvent({type:"mpChanged",value:var2});
		return this.__get__MP();
	}
	function __get__MP()
	{
		return this._nMP;
	}
	function __set__Kama(§\x1e\n\x0f§)
	{
		this._nKama = Number(var2);
		this.dispatchEvent({type:"kamaChanged",value:var2});
		return this.__get__Kama();
	}
	function __get__Kama()
	{
		return this._nKama;
	}
	function __set__XPlow(§\x1e\n\x0f§)
	{
		this._nXPLow = Number(var2);
		return this.__get__XPlow();
	}
	function __get__XPlow()
	{
		return this._nXPLow;
	}
	function __set__XP(§\x1e\n\x0f§)
	{
		this._nXP = Number(var2);
		this.dispatchEvent({type:"xpChanged",value:var2});
		return this.__get__XP();
	}
	function __get__XP()
	{
		return this._nXP;
	}
	function __set__XPhigh(§\x1e\n\x0f§)
	{
		this._nXPHigh = Number(var2);
		return this.__get__XPhigh();
	}
	function __get__XPhigh()
	{
		return this._nXPHigh;
	}
	function __set__Initiative(§\x1e\n\x0f§)
	{
		this._nInitiative = Number(var2);
		this.dispatchEvent({type:"initiativeChanged",value:var2});
		return this.__get__Initiative();
	}
	function __get__Initiative()
	{
		return this._nInitiative;
	}
	function __set__Discernment(§\x1e\n\x0f§)
	{
		this._nDiscernment = Number(var2);
		this.dispatchEvent({type:"discernmentChanged",value:var2});
		return this.__get__Discernment();
	}
	function __get__Discernment()
	{
		return this._nDiscernment;
	}
	function __set__Force(§\x1e\n\x0f§)
	{
		this._nForce = Number(var2);
		this.dispatchEvent({type:"forceChanged",value:var2});
		return this.__get__Force();
	}
	function __get__Force()
	{
		return this._nForce;
	}
	function __set__ForceXtra(§\x1e\n\x0f§)
	{
		this._nForceXtra = Number(var2);
		this.dispatchEvent({type:"forceXtraChanged",value:var2});
		return this.__get__ForceXtra();
	}
	function __get__ForceXtra()
	{
		return this._nForceXtra;
	}
	function __set__Vitality(§\x1e\n\x0f§)
	{
		this._nVitality = Number(var2);
		this.dispatchEvent({type:"vitalityChanged",value:var2});
		return this.__get__Vitality();
	}
	function __get__Vitality()
	{
		return this._nVitality;
	}
	function __set__VitalityXtra(§\x1e\n\x0f§)
	{
		this._nVitalityXtra = Number(var2);
		this.dispatchEvent({type:"vitalityXtraChanged",value:var2});
		return this.__get__VitalityXtra();
	}
	function __get__VitalityXtra()
	{
		return this._nVitalityXtra;
	}
	function __set__Wisdom(§\x1e\n\x0f§)
	{
		this._nWisdom = Number(var2);
		this.dispatchEvent({type:"wisdomChanged",value:var2});
		return this.__get__Wisdom();
	}
	function __get__Wisdom()
	{
		return this._nWisdom;
	}
	function __set__WisdomXtra(§\x1e\n\x0f§)
	{
		this._nWisdomXtra = Number(var2);
		this.dispatchEvent({type:"wisdomXtraChanged",value:var2});
		return this.__get__WisdomXtra();
	}
	function __get__WisdomXtra()
	{
		return this._nWisdomXtra;
	}
	function __set__Chance(§\x1e\n\x0f§)
	{
		this._nChance = Number(var2);
		this.dispatchEvent({type:"chanceChanged",value:var2});
		return this.__get__Chance();
	}
	function __get__Chance()
	{
		return this._nChance;
	}
	function __set__ChanceXtra(§\x1e\n\x0f§)
	{
		this._nChanceXtra = Number(var2);
		this.dispatchEvent({type:"chanceXtraChanged",value:var2});
		return this.__get__ChanceXtra();
	}
	function __get__ChanceXtra()
	{
		return this._nChanceXtra;
	}
	function __set__Agility(§\x1e\n\x0f§)
	{
		this._agility = Number(var2);
		this.dispatchEvent({type:"agilityChanged",value:var2});
		return this.__get__Agility();
	}
	function __get__Agility()
	{
		return this._agility;
	}
	function __set__AgilityXtra(§\x1e\n\x0f§)
	{
		this._nAgilityXtra = Number(var2);
		this.dispatchEvent({type:"agilityXtraChanged",value:var2});
		return this.__get__AgilityXtra();
	}
	function __get__AgilityXtra()
	{
		return this._nAgilityXtra;
	}
	function __set__AgilityTotal(§\x1e\n\x0f§)
	{
		this._nAgilityTotal = Number(var2);
		this.dispatchEvent({type:"agilityTotalChanged",value:var2});
		return this.__get__AgilityTotal();
	}
	function __get__AgilityTotal()
	{
		return this._nAgilityTotal;
	}
	function __set__Intelligence(§\x1e\n\x0f§)
	{
		this._intelligence = Number(var2);
		this.dispatchEvent({type:"intelligenceChanged",value:var2});
		return this.__get__Intelligence();
	}
	function __get__Intelligence()
	{
		return this._intelligence;
	}
	function __set__IntelligenceXtra(§\x1e\n\x0f§)
	{
		this._nIntelligenceXtra = Number(var2);
		this.dispatchEvent({type:"intelligenceXtraChanged",value:var2});
		return this.__get__IntelligenceXtra();
	}
	function __get__IntelligenceXtra()
	{
		return this._nIntelligenceXtra;
	}
	function __set__BonusPoints(§\x1e\n\x0f§)
	{
		this._nBonusPoints = Number(var2);
		this.dispatchEvent({type:"bonusPointsChanged",value:var2});
		return this.__get__BonusPoints();
	}
	function __get__BonusPoints()
	{
		return this._nBonusPoints;
	}
	function __set__BonusPointsSpell(§\x1e\n\x0f§)
	{
		this._nBonusPointsSpell = Number(var2);
		this.dispatchEvent({type:"bonusSpellsChanged",value:var2});
		return this.__get__BonusPointsSpell();
	}
	function __get__BonusPointsSpell()
	{
		return this._nBonusPointsSpell;
	}
	function __set__RangeModerator(§\x1e\n\x0f§)
	{
		this._nRangeModerator = Number(var2);
		return this.__get__RangeModerator();
	}
	function __get__RangeModerator()
	{
		return this._nRangeModerator;
	}
	function __set__Energy(§\x1e\n\x0f§)
	{
		this._nEnergy = Number(var2);
		this.dispatchEvent({type:"energyChanged",value:var2});
		return this.__get__Energy();
	}
	function __get__Energy()
	{
		return this._nEnergy;
	}
	function __set__EnergyMax(§\x1e\n\x0f§)
	{
		this._nEnergyMax = Number(var2);
		this.dispatchEvent({type:"energyMaxChanged",value:var2});
		return this.__get__EnergyMax();
	}
	function __get__EnergyMax()
	{
		return this._nEnergyMax;
	}
	function __set__SummonedCreatures(§\x1e\n\x0f§)
	{
		this._nSummonedCreatures = Number(var2);
		return this.__get__SummonedCreatures();
	}
	function __get__SummonedCreatures()
	{
		return this._nSummonedCreatures;
	}
	function __set__MaxSummonedCreatures(§\x1e\n\x0f§)
	{
		this._nMaxSummonedCreatures = Number(var2);
		return this.__get__MaxSummonedCreatures();
	}
	function __get__MaxSummonedCreatures()
	{
		return this._nMaxSummonedCreatures;
	}
	function __set__CriticalHitBonus(§\x1e\n\x0f§)
	{
		this._nCriticalHitBonus = Number(var2);
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
	function __set__FullStats(§\x1e\n\x0f§)
	{
		this._aFullStats = var2;
		this.dispatchEvent({type:"fullStatsChanged",value:var2});
		return this.__get__FullStats();
	}
	function __get__FullStats()
	{
		return this._aFullStats;
	}
	function __set__currentJobID(§\x1e\n\x0f§)
	{
		if(var2 == undefined)
		{
			delete this._nCurrentJobID;
		}
		else
		{
			this._nCurrentJobID = Number(var2);
		}
		this.dispatchEvent({type:"currentJobChanged",value:var2});
		return this.__get__currentJobID();
	}
	function __get__currentJobID()
	{
		return this._nCurrentJobID;
	}
	function __get__currentJob()
	{
		var var2 = this.Jobs.findFirstItem("id",this._nCurrentJobID);
		return var2.item;
	}
	function __set__currentWeight(§\x1e\n\x0f§)
	{
		this._nCurrentWeight = var2;
		this.dispatchEvent({type:"currentWeightChanged",value:var2});
		return this.__get__currentWeight();
	}
	function __get__currentWeight()
	{
		return this._nCurrentWeight;
	}
	function __set__maxWeight(§\x1e\n\x0f§)
	{
		this._nMaxWeight = var2;
		this.dispatchEvent({type:"maxWeightChanged",value:var2});
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
	function __set__restrictions(§\x1e\n\x0f§)
	{
		this._nRestrictions = var2;
		return this.__get__restrictions();
	}
	function __get__restrictions()
	{
		return this._nRestrictions;
	}
	function __set__specialization(§\x1e\n\x0f§)
	{
		this._oSpecialization = var2;
		this.dispatchEvent({type:"specializationChanged",value:var2});
		return this.__get__specialization();
	}
	function __get__specialization()
	{
		return this._oSpecialization;
	}
	function __set__alignment(§\x1e\n\x0f§)
	{
		this._oAlignment = var2;
		this.dispatchEvent({type:"alignmentChanged",alignment:var2});
		return this.__get__alignment();
	}
	function __get__alignment()
	{
		return this._oAlignment;
	}
	function __set__fakeAlignment(§\x1e\n\x0f§)
	{
		this._oFakeAlignment = var2;
		return this.__get__fakeAlignment();
	}
	function __get__fakeAlignment()
	{
		return this._oFakeAlignment;
	}
	function __set__rank(§\x1e\n\x0f§)
	{
		this._oRank = var2;
		this.dispatchEvent({type:"rankChanged",rank:var2});
		return this.__get__rank();
	}
	function __get__rank()
	{
		return this._oRank;
	}
	function __set__mount(§\x1e\n\x0f§)
	{
		this._oMount = var2;
		this.dispatchEvent({type:"mountChanged",mount:var2});
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
	function __set__isRiding(§\x1e\n\x0f§)
	{
		this._bIsRiding = var2;
		return this.__get__isRiding();
	}
	function __set__mountXPPercent(§\x1e\n\x0f§)
	{
		this._nMountXPPercent = var2;
		this.dispatchEvent({type:"mountXPPercentChanged",value:var2});
		return this.__get__mountXPPercent();
	}
	function __get__mountXPPercent()
	{
		return this._nMountXPPercent;
	}
	function __set__craftPublicMode(§\x1e\n\x0f§)
	{
		this._bCraftPublicMode = var2;
		this.dispatchEvent({type:"craftPublicModeChanged",value:var2});
		return this.__get__craftPublicMode();
	}
	function __get__craftPublicMode()
	{
		return this._bCraftPublicMode;
	}
	function __set__inParty(§\x1e\n\x0f§)
	{
		this._bInParty = var2;
		this.dispatchEvent({type:"inPartyChanged",inParty:var2});
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
	function canReceiveItems(§\x1e\x10§, §\x17\x1a§)
	{
		var var4 = !var3?this.maxWeight - this.currentWeight:this.mount.podsMax - this.mount.pods;
		var var5 = 0;
		var var6 = 0;
		while(var6 < var2.length)
		{
			var var7 = var2[var6];
			var5 = var5 + var7.weight * var7.Quantity;
			var6 = var6 + 1;
		}
		return var5 <= var4;
	}
	function getPossibleItemReceiveQuantity(§\x1e\x18\r§, §\x17\x1a§)
	{
		var var4 = !var3?this.maxWeight - this.currentWeight:this.mount.podsMax - this.mount.pods;
		var var5 = var2.weight;
		var var6 = Math.floor(var4 / var5);
		if(var6 > var2.Quantity)
		{
			var6 = var2.Quantity;
		}
		return var6;
	}
	function updateLP(§\x11\x06§)
	{
		var2 = Number(var2);
		if(this.LP + var2 > this.LPmax)
		{
			var2 = this.LPmax - this.LP;
		}
		this.LP = this.LP + var2;
	}
	function hasEnoughAP(§\x1e\n\n§)
	{
		return this.data.AP >= var2;
	}
	function addItem(§\x1e\x19\r§)
	{
		if(var2.position == 1)
		{
			this.setWeaponItem(var2);
		}
		this.Inventory.startNoEventDispatchsPeriod(dofus.Constants.DELAYED_INVENTORY_ITEMS_VISUAL_REFRESH);
		this.Inventory.push(var2);
	}
	function updateItem(§\x1e\x18\x1b§)
	{
		var var3 = this.Inventory.findFirstItem("ID",var2.ID);
		if(var3.item.ID == var2.ID && var3.item.maxSkin != var2.maxSkin)
		{
			if(!var3.item.isLeavingItem && var2.isLeavingItem)
			{
				this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ASSOCIATE);
			}
			if(var3.item.isLeavingItem && var2.isLeavingItem)
			{
				this.api.kernel.SpeakingItemsManager.triggerPrivateEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_LEVEL_UP);
			}
		}
		this.Inventory.updateItem(var3.index,var2);
	}
	function updateItemQuantity(§\x04\x11§, §\x01\x0e§)
	{
		var var4 = this.Inventory.findFirstItem("ID",var2);
		var var5 = var4.item;
		var5.Quantity = var3;
		this.Inventory.updateItem(var4.index,var5);
	}
	function updateItemPosition(§\x04\x11§, §\x01\x17§)
	{
		var var4 = this.Inventory.findFirstItem("ID",var2);
		var var5 = var4.item;
		if(var5.position == 1)
		{
			this.setWeaponItem();
		}
		else if(var3 == 1)
		{
			this.setWeaponItem(var5);
		}
		var5.position = var3;
		this.Inventory.updateItem(var4.index,var5);
	}
	function dropItem(§\x04\x11§)
	{
		var var3 = this.Inventory.findFirstItem("ID",var2);
		if(var3.item.position == 1)
		{
			this.setWeaponItem();
		}
		this.Inventory.startNoEventDispatchsPeriod(dofus.Constants.DELAYED_INVENTORY_ITEMS_VISUAL_REFRESH);
		this.Inventory.removeItems(var3.index,1);
	}
	function updateSpell(§\x1e\x18\x04§)
	{
		var var3 = this.Spells.findFirstItem("ID",var2.ID);
		if(var3.index != -1)
		{
			var2.position = var3.item.position;
			this.Spells.updateItem(var3.index,var2);
		}
		else
		{
			this.Spells.push(var2);
		}
	}
	function updateSpellPosition(§\x1e\x18\x04§)
	{
		var var3 = this.Spells.findFirstItem("position",var2.position);
		var var4 = this.Spells.findFirstItem("ID",var2.ID);
		if(var3.index != -1)
		{
			var3.item.position = undefined;
			this.Spells.updateItem(var3.index,var2);
		}
		if(var4.index != -1)
		{
			this.Spells.updateItem(var3.index,var2);
		}
		else
		{
			this.Spells.push(var2);
		}
	}
	function removeSpell(§\x05\x02§)
	{
		var var3 = this.Spells.findFirstItem("ID",var2);
		if(var3.index != -1)
		{
			this.Spells.removeItems(var3.index,1);
		}
	}
	function canBoost(§\x07\x17§)
	{
		if(this.api.datacenter.Game.isRunning)
		{
			return false;
		}
		var var3 = this.getBoostCostAndCountForCharacteristic(var2).cost;
		if(this._nBonusPoints >= var3)
		{
			return true;
		}
		return false;
	}
	function getBoostCostAndCountForCharacteristic(§\x07\x17§)
	{
		var var3 = this.api.lang.getClassText(this._nGuild)["b" + var2];
		var var4 = 1;
		var var5 = 1;
		var var6 = 0;
		if((var var0 = var2) !== 10)
		{
			switch(null)
			{
				case 11:
					var6 = this._nVitality;
					break;
				case 12:
					var6 = this._nWisdom;
					break;
				case 13:
					var6 = this._nChance;
					break;
				case 14:
					var6 = this._agility;
					break;
				case 15:
					var6 = this._intelligence;
			}
		}
		else
		{
			var6 = this._nForce;
		}
		var var7 = 0;
		while(var7 < var3.length)
		{
			var var8 = var3[var7][0];
			if(var6 >= var8)
			{
				var4 = var3[var7][1];
				var5 = var3[var7][2] != undefined?var3[var7][2]:1;
				var7 = var7 + 1;
				continue;
			}
			break;
		}
		return {cost:var4,count:var5};
	}
	function isAtHome(§\x03\x18§)
	{
		var var3 = Number(this.api.lang.getHousesMapText(var2));
		if(var3 != undefined)
		{
			return this.api.datacenter.Houses.getItemAt(var3).localOwner;
		}
		return false;
	}
	function clearEmotes()
	{
		this.Emotes = new ank.utils.	();
	}
	function addEmote(§\x06\x05§)
	{
		this.Emotes.addItemAt(var2,true);
	}
	function hasEmote(§\x06\x05§)
	{
		return this.Emotes.getItemAt(var2) == true;
	}
	function updateCloseCombat()
	{
		this.Spells[0] = new dofus.datacenter.(this._oWeaponItem,this._nGuild);
	}
	function setWeaponItem(§\x1e\x19\r§)
	{
		this._oWeaponItem = var2;
		this.updateCloseCombat();
	}
}
