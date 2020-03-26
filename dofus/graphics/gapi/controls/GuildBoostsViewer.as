class dofus.graphics.gapi.controls.GuildBoostsViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "GuildBoostsViewer";
   function GuildBoostsViewer()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.GuildBoostsViewer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this._btnBoostWisdom._visible = false;
      this._btnBoostPod._visible = false;
      this._btnBoostPop._visible = false;
      this._btnBoostPP._visible = false;
      this._btnHireTaxCollector._visible = false;
   }
   function addListeners()
   {
      this._lstSpells.addEventListener("itemSelected",this);
      this._btnBoostPP.addEventListener("click",this);
      this._btnBoostWisdom.addEventListener("click",this);
      this._btnBoostPod.addEventListener("click",this);
      this._btnBoostPop.addEventListener("click",this);
      this._btnHireTaxCollector.addEventListener("click",this);
      this._btnBoostPP.addEventListener("over",this);
      this._btnBoostWisdom.addEventListener("over",this);
      this._btnBoostPod.addEventListener("over",this);
      this._btnBoostPop.addEventListener("over",this);
      this._btnHireTaxCollector.addEventListener("over",this);
      this._btnBoostPP.addEventListener("out",this);
      this._btnBoostWisdom.addEventListener("out",this);
      this._btnBoostPod.addEventListener("out",this);
      this._btnBoostPop.addEventListener("out",this);
      this._btnHireTaxCollector.addEventListener("out",this);
   }
   function initTexts()
   {
      this._lblLP.text = this.api.lang.getText("LIFEPOINTS");
      this._lblBonus.text = this.api.lang.getText("DAMAGES_BONUS");
      this._lblBoostPP.text = this.api.lang.getText("DISCERNMENT");
      this._lblBoostWisdom.text = this.api.lang.getText("WISDOM");
      this._lblBoostPod.text = this.api.lang.getText("WEIGHT");
      this._lblBoostPop.text = this.api.lang.getText("TAX_COLLECTOR_COUNT");
      this._lblBoostPoints.text = this.api.lang.getText("GUILD_BONUSPOINTS");
      this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL");
      this._lblTaxSpells.text = this.api.lang.getText("GUILD_TAXSPELLS");
      this._lblTaxCharacteristics.text = this.api.lang.getText("GUILD_TAXCHARACTERISTICS");
      this._btnHireTaxCollector.label = this.api.lang.getText("HIRE_TAXCOLLECTOR");
   }
   function updateData()
   {
      this.gapi.hideTooltip();
      var _loc2_ = this.api.datacenter.Player.guildInfos;
      this._lblLPValue.text = _loc2_.taxLp + "";
      this._lblBonusValue.text = _loc2_.taxBonus + "";
      this._lblBoostPodValue.text = _loc2_.taxPod + "";
      this._lblBoostPPValue.text = _loc2_.taxPP + "";
      this._lblBoostWisdomValue.text = _loc2_.taxWisdom + "";
      this._lblBoostPopValue.text = _loc2_.taxPopulation + "";
      this._lblTaxCount.text = this.api.lang.getText("GUILD_TAX_COUNT",[_loc2_.taxCount,_loc2_.taxCountMax]);
      this._lblBoostPointsValue.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("POINTS",[_loc2_.boostPoints]),"m",_loc2_.boostPoints < 2);
      this._lstSpells.dataProvider = _loc2_.taxSpells;
      var _loc3_ = _loc2_.playerRights.canManageBoost && _loc2_.boostPoints > 0;
      this._btnBoostPod._visible = _loc3_ && _loc2_.canBoost("w");
      this._btnBoostPP._visible = _loc3_ && _loc2_.canBoost("p");
      this._btnBoostWisdom._visible = _loc3_ && _loc2_.canBoost("x");
      this._btnBoostPop._visible = _loc3_ && _loc2_.canBoost("c");
      this._btnHireTaxCollector.enabled = _loc2_.playerRights.canHireTaxCollector && (_loc2_.taxCount < _loc2_.taxCountMax && !this.api.datacenter.Player.cantInteractWithTaxCollector);
      this._btnHireTaxCollector._visible = true;
   }
   function itemSelected(oEvent)
   {
      this.gapi.loadUIComponent("SpellInfos","SpellInfos",{spell:oEvent.row.item});
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnBoostPod":
            this.api.sounds.events.onGuildButtonClick();
            this.api.network.Guild.boostCharacteristic("w");
            break;
         case "_btnBoostPP":
            this.api.sounds.events.onGuildButtonClick();
            this.api.network.Guild.boostCharacteristic("p");
            break;
         case "_btnBoostWisdom":
            this.api.sounds.events.onGuildButtonClick();
            this.api.network.Guild.boostCharacteristic("x");
            break;
         case "_btnBoostPop":
            this.api.sounds.events.onGuildButtonClick();
            this.api.network.Guild.boostCharacteristic("c");
            break;
         case "_btnHireTaxCollector":
            var _loc3_ = this.api.datacenter.Player;
            if(_loc3_.guildInfos.taxcollectorHireCost < _loc3_.Kama)
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_YOU_HIRE_TAXCOLLECTOR",[_loc3_.guildInfos.taxcollectorHireCost]),"CAUTION_YESNO",{name:"GuildTaxCollector",listener:this});
            }
            else
            {
               this.api.kernel.showMessage("undefined",this.api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"),"ERROR_BOX");
            }
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnBoostPod":
            var _loc3_ = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("w");
            var _loc4_ = this.api.lang.getGuildBoostsMax("w");
            this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc3_.cost + " " + this.api.lang.getText("POUR") + " " + _loc3_.count + " (max : " + _loc4_ + ")",oEvent.target,-20);
            break;
         case "_btnBoostPP":
            var _loc5_ = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("p");
            var _loc6_ = this.api.lang.getGuildBoostsMax("p");
            this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc5_.cost + " " + this.api.lang.getText("POUR") + " " + _loc5_.count + " (max : " + _loc6_ + ")",oEvent.target,-20);
            break;
         case "_btnBoostWisdom":
            var _loc7_ = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("x");
            var _loc8_ = this.api.lang.getGuildBoostsMax("x");
            this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc7_.cost + " " + this.api.lang.getText("POUR") + " " + _loc7_.count + " (max : " + _loc8_ + ")",oEvent.target,-20);
            break;
         case "_btnBoostPop":
            var _loc9_ = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("c");
            var _loc10_ = this.api.lang.getGuildBoostsMax("c");
            this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + _loc9_.cost + " " + this.api.lang.getText("POUR") + " " + _loc9_.count + " (max : " + _loc10_ + ")",oEvent.target,-20);
            break;
         case "_btnHireTaxCollector":
            this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + this.api.datacenter.Player.guildInfos.taxcollectorHireCost + " " + this.api.lang.getText("KAMAS"),oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function yes(oEvent)
   {
      this.api.network.Guild.hireTaxCollector();
   }
}
