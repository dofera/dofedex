class dofus.datacenter.GuildInfos extends Object
{
	function GuildInfos(var3, var4, var5, var6, var7, var8)
	{
		super();
		this.api = _global.API;
		eval(mx).events.EventDispatcher.initialize(this);
		this.initialize(false,var3,var4,var5,var6,var7,var8);
		this._eaMembers = new ank.utils.();
		this._eaTaxCollectors = new ank.utils.();
		this._eaMountParks = new ank.utils.();
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
	function __set__defendedTaxCollectorID(var2)
	{
		this._nDefendedTaxCollectorID = var2;
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
	function initialize(var2, var3, var4, var5, var6, var7, var8)
	{
		this._sName = var3;
		this._nBackEmblemID = var4;
		this._nBackEmblemColor = var5;
		this._nUpEmblemID = var6;
		this._nUpEmblemColor = var7;
		this._grPlayerRights = new dofus.datacenter.(var8);
		if(var2)
		{
			this.dispatchEvent({type:"modelChanged",eventName:"infosUpdate"});
		}
	}
	function setGeneralInfos(var2, var3, var4, var5, var6)
	{
		this._bValid = var2;
		this._nLevel = var3;
		this._nXPMin = var4;
		this._nXP = var5;
		this._nXPMax = var6;
		this.dispatchEvent({type:"modelChanged",eventName:"general"});
	}
	function setMembers()
	{
		this.dispatchEvent({type:"modelChanged",eventName:"members"});
	}
	function setMountParks(var2, var3)
	{
		this._nMaxMountParks = var2;
		this._eaMountParks = var3;
		this.dispatchEvent({type:"modelChanged",eventName:"mountParks"});
	}
	function setBoosts(var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12)
	{
		this._nTaxCount = var2;
		this._nTaxCountMax = var3;
		this._nTaxLP = var4;
		this._nTaxBonusDamage = var5;
		this._nTaxPods = var6;
		this._nTaxPP = var7;
		this._nTaxSagesse = var8;
		this._nTaxPercepteur = var9;
		this._nBoostPoints = var10;
		this._nTaxHireCost = var11;
		this._eaTaxSpells = var12;
		this.dispatchEvent({type:"modelChanged",eventName:"boosts"});
	}
	function setNoBoosts()
	{
		this.dispatchEvent({type:"modelChanged",eventName:"noboosts"});
	}
	function canBoost(var2, var3)
	{
		var var4 = this.getBoostCostAndCountForCharacteristic(var2,var3).cost;
		if(this._nBoostPoints >= var4 && var4 != undefined)
		{
			return true;
		}
		return false;
	}
	function getBoostCostAndCountForCharacteristic(var2, var3)
	{
		var var4 = this.api.lang.getGuildBoosts(var2);
		var var5 = 1;
		var var6 = 1;
		var var7 = 0;
		switch(var2)
		{
			case "w":
				var7 = this._nTaxPods;
				break;
			case "p":
				var7 = this._nTaxPP;
				break;
			default:
				switch(null)
				{
					case "c":
						var7 = this._nTaxPercepteur;
						break;
					case "x":
						var7 = this._nTaxSagesse;
						break;
					case "s":
						var var8 = this._eaTaxSpells.findFirstItem("ID",var3);
						if(var8 != -1)
						{
							var7 = var8.item.level;
							break;
						}
				}
		}
		var var9 = this.api.lang.getGuildBoostsMax(var2);
		if(var7 < var9)
		{
			var var10 = 0;
			while(var10 < var4.length)
			{
				var var11 = var4[var10][0];
				if(var7 >= var11)
				{
					var5 = var4[var10][1];
					var6 = var4[var10][2] != undefined?var4[var10][2]:1;
					var10 = var10 + 1;
					continue;
				}
				break;
			}
			return {cost:var5,count:var6};
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
	function setHouses(var2)
	{
		this._eaHouses = var2;
		this.dispatchEvent({type:"modelChanged",eventName:"houses"});
	}
	function setNoHouses()
	{
		this._eaHouses = new ank.utils.();
		this.dispatchEvent({type:"modelChanged",eventName:"nohouses"});
	}
}
