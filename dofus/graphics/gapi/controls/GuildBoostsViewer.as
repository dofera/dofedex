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
		var loc2 = this.api.datacenter.Player.guildInfos;
		this._lblLPValue.text = loc2.taxLp + "";
		this._lblBonusValue.text = loc2.taxBonus + "";
		this._lblBoostPodValue.text = loc2.taxPod + "";
		this._lblBoostPPValue.text = loc2.taxPP + "";
		this._lblBoostWisdomValue.text = loc2.taxWisdom + "";
		this._lblBoostPopValue.text = loc2.taxPopulation + "";
		this._lblTaxCount.text = this.api.lang.getText("GUILD_TAX_COUNT",[loc2.taxCount,loc2.taxCountMax]);
		this._lblBoostPointsValue.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("POINTS",[loc2.boostPoints]),"m",loc2.boostPoints < 2);
		this._lstSpells.dataProvider = loc2.taxSpells;
		var loc3 = loc2.playerRights.canManageBoost && loc2.boostPoints > 0;
		this._btnBoostPod._visible = loc3 && loc2.canBoost("w");
		this._btnBoostPP._visible = loc3 && loc2.canBoost("p");
		this._btnBoostWisdom._visible = loc3 && loc2.canBoost("x");
		this._btnBoostPop._visible = loc3 && loc2.canBoost("c");
		this._btnHireTaxCollector.enabled = loc2.playerRights.canHireTaxCollector && (loc2.taxCount < loc2.taxCountMax && !this.api.datacenter.Player.cantInteractWithTaxCollector);
		this._btnHireTaxCollector._visible = true;
	}
	function itemSelected(loc2)
	{
		this.gapi.loadUIComponent("SpellInfos","SpellInfos",{spell:loc2.row.item});
	}
	function click(loc2)
	{
		switch(loc2.target._name)
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
			default:
				switch(null)
				{
					case "_btnBoostPop":
						this.api.sounds.events.onGuildButtonClick();
						this.api.network.Guild.boostCharacteristic("c");
						break;
					case "_btnHireTaxCollector":
						var loc3 = this.api.datacenter.Player;
						if(loc3.guildInfos.taxcollectorHireCost < loc3.Kama)
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_YOU_HIRE_TAXCOLLECTOR",[loc3.guildInfos.taxcollectorHireCost]),"CAUTION_YESNO",{name:"GuildTaxCollector",listener:this});
							break;
						}
						this.api.kernel.showMessage("undefined",this.api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"),"ERROR_BOX");
						break;
				}
		}
	}
	function over(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnBoostPod":
				var loc3 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("w");
				var loc4 = this.api.lang.getGuildBoostsMax("w");
				this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + loc3.cost + " " + this.api.lang.getText("POUR") + " " + loc3.count + " (max : " + loc4 + ")",loc2.target,-20);
				break;
			case "_btnBoostPP":
				var loc5 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("p");
				var loc6 = this.api.lang.getGuildBoostsMax("p");
				this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + loc5.cost + " " + this.api.lang.getText("POUR") + " " + loc5.count + " (max : " + loc6 + ")",loc2.target,-20);
				break;
			case "_btnBoostWisdom":
				var loc7 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("x");
				var loc8 = this.api.lang.getGuildBoostsMax("x");
				this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + loc7.cost + " " + this.api.lang.getText("POUR") + " " + loc7.count + " (max : " + loc8 + ")",loc2.target,-20);
				break;
			default:
				switch(null)
				{
					case "_btnBoostPop":
						var loc9 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("c");
						var loc10 = this.api.lang.getGuildBoostsMax("c");
						this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + loc9.cost + " " + this.api.lang.getText("POUR") + " " + loc9.count + " (max : " + loc10 + ")",loc2.target,-20);
						break;
					case "_btnHireTaxCollector":
						this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + this.api.datacenter.Player.guildInfos.taxcollectorHireCost + " " + this.api.lang.getText("KAMAS"),loc2.target,-20);
				}
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function yes(loc2)
	{
		this.api.network.Guild.hireTaxCollector();
	}
}
