class dofus.datacenter.GuildInfos extends Object
{
   function GuildInfos(sName, nBackEmblemID, nBackEmblemColor, nUpEmblemID, nUpEmblemColor, nPlayerRights)
   {
      super();
      this.api = _global.API;
      mx.events.EventDispatcher.initialize(this);
      this.initialize(sName,nBackEmblemID,nBackEmblemColor,nUpEmblemID,nUpEmblemColor,nPlayerRights);
      this._eaMembers = new ank.utils.ExtendedArray();
      this._eaTaxCollectors = new ank.utils.ExtendedArray();
      this._eaMountParks = new ank.utils.ExtendedArray();
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
   function __set__defendedTaxCollectorID(nDefendedTaxCollectorID)
   {
      this._nDefendedTaxCollectorID = nDefendedTaxCollectorID;
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
   function initialize(sName, nBackEmblemID, nBackEmblemColor, nUpEmblemID, nUpEmblemColor, nPlayerRights)
   {
      this._sName = sName;
      this._nBackEmblemID = nBackEmblemID;
      this._nBackEmblemColor = nBackEmblemColor;
      this._nUpEmblemID = nUpEmblemID;
      this._nUpEmblemColor = nUpEmblemColor;
      this._grPlayerRights = new dofus.datacenter.GuildRights(nPlayerRights);
   }
   function setGeneralInfos(bValid, nLevel, nXPMin, nXP, nXPMax)
   {
      this._bValid = bValid;
      this._nLevel = nLevel;
      this._nXPMin = nXPMin;
      this._nXP = nXP;
      this._nXPMax = nXPMax;
      this.dispatchEvent({type:"modelChanged",eventName:"general"});
   }
   function setMembers()
   {
      this.dispatchEvent({type:"modelChanged",eventName:"members"});
   }
   function setMountParks(nMaxMountParks, eaMountParks)
   {
      this._nMaxMountParks = nMaxMountParks;
      this._eaMountParks = eaMountParks;
      this.dispatchEvent({type:"modelChanged",eventName:"mountParks"});
   }
   function setBoosts(nTaxCount, nTaxCountMax, nLP, nBonusDamage, nPods, nPP, nSagesse, nPercepteur, nBoostPoints, nTaxHireCost, eaSpells)
   {
      this._nTaxCount = nTaxCount;
      this._nTaxCountMax = nTaxCountMax;
      this._nTaxLP = nLP;
      this._nTaxBonusDamage = nBonusDamage;
      this._nTaxPods = nPods;
      this._nTaxPP = nPP;
      this._nTaxSagesse = nSagesse;
      this._nTaxPercepteur = nPercepteur;
      this._nBoostPoints = nBoostPoints;
      this._nTaxHireCost = nTaxHireCost;
      this._eaTaxSpells = eaSpells;
      this.dispatchEvent({type:"modelChanged",eventName:"boosts"});
   }
   function setNoBoosts()
   {
      this.dispatchEvent({type:"modelChanged",eventName:"noboosts"});
   }
   function canBoost(sCharac, nParams)
   {
      var _loc4_ = this.getBoostCostAndCountForCharacteristic(sCharac,nParams).cost;
      if(this._nBoostPoints >= _loc4_ && _loc4_ != undefined)
      {
         return true;
      }
      return false;
   }
   function getBoostCostAndCountForCharacteristic(sCharac, nParams)
   {
      var _loc4_ = this.api.lang.getGuildBoosts(sCharac);
      var _loc5_ = 1;
      var _loc6_ = 1;
      var _loc7_ = 0;
      switch(sCharac)
      {
         case "w":
            _loc7_ = this._nTaxPods;
            break;
         case "p":
            _loc7_ = this._nTaxPP;
            break;
         case "c":
            _loc7_ = this._nTaxPercepteur;
            break;
         case "x":
            _loc7_ = this._nTaxSagesse;
            break;
         case "s":
            var _loc8_ = this._eaTaxSpells.findFirstItem("ID",nParams);
            if(_loc8_ != -1)
            {
               _loc7_ = _loc8_.item.level;
            }
      }
      var _loc9_ = this.api.lang.getGuildBoostsMax(sCharac);
      if(_loc7_ < _loc9_)
      {
         var _loc10_ = 0;
         while(_loc10_ < _loc4_.length)
         {
            var _loc11_ = _loc4_[_loc10_][0];
            if(_loc7_ >= _loc11_)
            {
               _loc5_ = _loc4_[_loc10_][1];
               _loc6_ = _loc4_[_loc10_][2] != undefined?_loc4_[_loc10_][2]:1;
               _loc10_ = _loc10_ + 1;
               continue;
            }
            break;
         }
         return {cost:_loc5_,count:_loc6_};
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
   function setHouses(eaHouses)
   {
      this._eaHouses = eaHouses;
      this.dispatchEvent({type:"modelChanged",eventName:"houses"});
   }
   function setNoHouses()
   {
      this._eaHouses = new ank.utils.ExtendedArray();
      this.dispatchEvent({type:"modelChanged",eventName:"nohouses"});
   }
}
