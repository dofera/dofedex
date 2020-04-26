class dofus.datacenter.GuildInfos extends Object
{
	function GuildInfos(loc3, loc4, loc5, loc6, loc7, loc8)
	{
		super();
		this.api = _global.API;
		mx.events.EventDispatcher.initialize(this);
		this.initialize(loc3,loc4,loc5,loc6,loc7,loc8);
		this._eaMembers = new ank.utils.();
		this._eaTaxCollectors = new ank.utils.();
		this._eaMountParks = new ank.utils.();
	}
	function __get__name()
	{
		return this._sName;
	}
	function __get__isValid()
	{
		return this._bValid;
	}
	function __get__emblem()
	{
		return {backID:this._nBackEmblemID,backColor:this._nBackEmblemColor,upID:this._nUpEmblemID,upColor:this._nUpEmblemColor};
	}
	function __get__playerRights()
	{
		return this._grPlayerRights;
	}
	function __get__level()
	{
		return this._nLevel;
	}
	function __get__xpmin()
	{
		return this._nXPMin;
	}
	function __get__xpmax()
	{
		return this._nXPMax;
	}
	function __get__xp()
	{
		return this._nXP;
	}
	function __get__members()
	{
		return this._eaMembers;
	}
	function __get__taxCount()
	{
		return this._nTaxCount;
	}
	function __get__taxCountMax()
	{
		return this._nTaxCountMax;
	}
	function __get__taxSpells()
	{
		return this._eaTaxSpells;
	}
	function __get__taxLp()
	{
		return this._nTaxLP;
	}
	function __get__taxBonus()
	{
		return this._nTaxBonusDamage;
	}
	function __get__taxcollectorHireCost()
	{
		return this._nTaxHireCost;
	}
	function __get__taxPod()
	{
		return this._nTaxPods;
	}
	function __get__taxPP()
	{
		return this._nTaxPP;
	}
	function __get__taxWisdom()
	{
		return this._nTaxSagesse;
	}
	function __get__taxPopulation()
	{
		return this._nTaxPercepteur;
	}
	function __get__boostPoints()
	{
		return this._nBoostPoints;
	}
	function __get__taxCollectors()
	{
		return this._eaTaxCollectors;
	}
	function __get__mountParks()
	{
		return this._eaMountParks;
	}
	function __get__maxMountParks()
	{
		return this._nMaxMountParks;
	}
	function __get__houses()
	{
		return this._eaHouses;
	}
	function __set__defendedTaxCollectorID(loc2)
	{
		this._nDefendedTaxCollectorID = loc2;
		return this.__get__defendedTaxCollectorID();
	}
	function __get__defendedTaxCollectorID()
	{
		return this._nDefendedTaxCollectorID;
	}
	function __get__isLocalPlayerDefender()
	{
		return this._nDefendedTaxCollectorID != undefined;
	}
	function initialize(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		this._sName = loc2;
		this._nBackEmblemID = loc3;
		this._nBackEmblemColor = loc4;
		this._nUpEmblemID = loc5;
		this._nUpEmblemColor = loc6;
		this._grPlayerRights = new dofus.datacenter.(loc7);
	}
	function setGeneralInfos(loc2, loc3, loc4, loc5, loc6)
	{
		this._bValid = loc2;
		this._nLevel = loc3;
		this._nXPMin = loc4;
		this._nXP = loc5;
		this._nXPMax = loc6;
		this.dispatchEvent({type:"modelChanged",eventName:"general"});
	}
	function setMembers()
	{
		this.dispatchEvent({type:"modelChanged",eventName:"members"});
	}
	function setMountParks(loc2, loc3)
	{
		this._nMaxMountParks = loc2;
		this._eaMountParks = loc3;
		this.dispatchEvent({type:"modelChanged",eventName:"mountParks"});
	}
	function setBoosts(loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9, loc10, loc11, loc12)
	{
		this._nTaxCount = loc2;
		this._nTaxCountMax = loc3;
		this._nTaxLP = loc4;
		this._nTaxBonusDamage = loc5;
		this._nTaxPods = loc6;
		this._nTaxPP = loc7;
		this._nTaxSagesse = loc8;
		this._nTaxPercepteur = loc9;
		this._nBoostPoints = loc10;
		this._nTaxHireCost = loc11;
		this._eaTaxSpells = loc12;
		this.dispatchEvent({type:"modelChanged",eventName:"boosts"});
	}
	function setNoBoosts()
	{
		this.dispatchEvent({type:"modelChanged",eventName:"noboosts"});
	}
	function canBoost(loc2, loc3)
	{
		var loc4 = this.getBoostCostAndCountForCharacteristic(loc2,loc3).cost;
		if(this._nBoostPoints >= loc4 && loc4 != undefined)
		{
			return true;
		}
		return false;
	}
	function getBoostCostAndCountForCharacteristic(loc2, loc3)
	{
		var loc4 = this.api.lang.getGuildBoosts(loc2);
		var loc5 = 1;
		var loc6 = 1;
		var loc7 = 0;
		switch(loc2)
		{
			case "w":
				loc7 = this._nTaxPods;
				break;
			case "p":
				loc7 = this._nTaxPP;
				break;
			case "c":
				loc7 = this._nTaxPercepteur;
				break;
			default:
				switch(null)
				{
					case "x":
						loc7 = this._nTaxSagesse;
						break;
					case "s":
						var loc8 = this._eaTaxSpells.findFirstItem("ID",loc3);
						if(loc8 != -1)
						{
							loc7 = loc8.item.level;
							break;
						}
				}
		}
		var loc9 = this.api.lang.getGuildBoostsMax(loc2);
		if(loc7 < loc9)
		{
			var loc10 = 0;
			while(loc10 < loc4.length)
			{
				var loc11 = loc4[loc10][0];
				if(loc7 >= loc11)
				{
					loc5 = loc4[loc10][1];
					loc6 = loc4[loc10][2] != undefined?loc4[loc10][2]:1;
					loc10 = loc10 + 1;
					continue;
				}
				break;
			}
			return {cost:loc5,count:loc6};
		}
		return null;
	}
	function setTaxCollectors()
	{
		this.dispatchEvent({type:"modelChanged",eventName:"taxcollectors"});
	}
	function setNoTaxCollectors()
	{
		this.dispatchEvent({type:"modelChanged",eventName:"notaxcollectors"});
	}
	function setHouses(loc2)
	{
		this._eaHouses = loc2;
		this.dispatchEvent({type:"modelChanged",eventName:"houses"});
	}
	function setNoHouses()
	{
		this._eaHouses = new ank.utils.();
		this.dispatchEvent({type:"modelChanged",eventName:"nohouses"});
	}
}
