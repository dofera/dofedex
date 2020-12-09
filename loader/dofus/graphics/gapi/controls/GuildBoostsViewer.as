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
		var var2 = this.api.datacenter.Player.guildInfos;
		this._lblLPValue.text = var2.taxLp + "";
		this._lblBonusValue.text = var2.taxBonus + "";
		this._lblBoostPodValue.text = var2.taxPod + "";
		this._lblBoostPPValue.text = var2.taxPP + "";
		this._lblBoostWisdomValue.text = var2.taxWisdom + "";
		this._lblBoostPopValue.text = var2.taxPopulation + "";
		this._lblTaxCount.text = this.api.lang.getText("GUILD_TAX_COUNT",[var2.taxCount,var2.taxCountMax]);
		this._lblBoostPointsValue.text = ank.utils.PatternDecoder.combine(this.api.lang.getText("POINTS",[var2.boostPoints]),"m",var2.boostPoints < 2);
		this._lstSpells.dataProvider = var2.taxSpells;
		var var3 = var2.playerRights.canManageBoost && var2.boostPoints > 0;
		this._btnBoostPod._visible = var3 && var2.canBoost("w");
		this._btnBoostPP._visible = var3 && var2.canBoost("p");
		this._btnBoostWisdom._visible = var3 && var2.canBoost("x");
		this._btnBoostPop._visible = var3 && var2.canBoost("c");
		this._btnHireTaxCollector.enabled = var2.playerRights.canHireTaxCollector && (var2.taxCount < var2.taxCountMax && !this.api.datacenter.Player.cantInteractWithTaxCollector);
		this._btnHireTaxCollector._visible = true;
	}
	function itemSelected(§\x1e\x19\x18§)
	{
		this.gapi.loadUIComponent("SpellInfos","SpellInfos",{spell:var2.row.item});
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnBoostPod":
				this.api.sounds.events.onGuildButtonClick();
				this.api.network.Guild.boostCharacteristic("w");
				break;
			case "_btnBoostPP":
				this.api.sounds.events.onGuildButtonClick();
				this.api.network.Guild.boostCharacteristic("p");
				break;
			default:
				switch(null)
				{
					case "_btnBoostWisdom":
						this.api.sounds.events.onGuildButtonClick();
						this.api.network.Guild.boostCharacteristic("x");
						break;
					case "_btnBoostPop":
						this.api.sounds.events.onGuildButtonClick();
						this.api.network.Guild.boostCharacteristic("c");
						break;
					case "_btnHireTaxCollector":
						var var3 = this.api.datacenter.Player;
						if(var3.guildInfos.taxcollectorHireCost < var3.Kama)
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_YOU_HIRE_TAXCOLLECTOR",[var3.guildInfos.taxcollectorHireCost]),"CAUTION_YESNO",{name:"GuildTaxCollector",listener:this});
							break;
						}
						this.api.kernel.showMessage("undefined",this.api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"),"ERROR_BOX");
						break;
				}
		}
	}
	function over(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnBoostPod":
				var var3 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("w");
				var var4 = this.api.lang.getGuildBoostsMax("w");
				this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + var3.cost + " " + this.api.lang.getText("POUR") + " " + var3.count + " (max : " + var4 + ")",var2.target,-20);
				break;
			case "_btnBoostPP":
				var var5 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("p");
				var var6 = this.api.lang.getGuildBoostsMax("p");
				this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + var5.cost + " " + this.api.lang.getText("POUR") + " " + var5.count + " (max : " + var6 + ")",var2.target,-20);
				break;
			case "_btnBoostWisdom":
				var var7 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("x");
				var var8 = this.api.lang.getGuildBoostsMax("x");
				this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + var7.cost + " " + this.api.lang.getText("POUR") + " " + var7.count + " (max : " + var8 + ")",var2.target,-20);
				break;
			default:
				switch(null)
				{
					case "_btnBoostPop":
						var var9 = this.api.datacenter.Player.guildInfos.getBoostCostAndCountForCharacteristic("c");
						var var10 = this.api.lang.getGuildBoostsMax("c");
						this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + var9.cost + " " + this.api.lang.getText("POUR") + " " + var9.count + " (max : " + var10 + ")",var2.target,-20);
						break;
					case "_btnHireTaxCollector":
						this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + this.api.datacenter.Player.guildInfos.taxcollectorHireCost + " " + this.api.lang.getText("KAMAS"),var2.target,-20);
				}
		}
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
	function yes(§\x1e\x19\x18§)
	{
		this.api.network.Guild.hireTaxCollector();
	}
}
