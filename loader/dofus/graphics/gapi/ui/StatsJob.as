class dofus.graphics.gapi.ui.StatsJob extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "StatsJob";
	function StatsJob()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.StatsJob.CLASS_NAME);
	}
	function destroy()
	{
		this.gapi.hideTooltip();
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this._mcViewersPlacer._visible = false;
		this._btnClosePanel._visible = false;
		this.api.datacenter.Player.data.addListener(this);
		this.api.datacenter.Player.addEventListener("nameChanged",this);
		this.api.datacenter.Player.addEventListener("levelChanged",this);
		this.api.datacenter.Player.addEventListener("xpChanged",this);
		this.api.datacenter.Player.addEventListener("lpChanged",this);
		this.api.datacenter.Player.addEventListener("lpMaxChanged",this);
		this.api.datacenter.Player.addEventListener("apChanged",this);
		this.api.datacenter.Player.addEventListener("mpChanged",this);
		this.api.datacenter.Player.addEventListener("initiativeChanged",this);
		this.api.datacenter.Player.addEventListener("discernmentChanged",this);
		this.api.datacenter.Player.addEventListener("forceXtraChanged",this);
		this.api.datacenter.Player.addEventListener("vitalityXtraChanged",this);
		this.api.datacenter.Player.addEventListener("wisdomXtraChanged",this);
		this.api.datacenter.Player.addEventListener("chanceXtraChanged",this);
		this.api.datacenter.Player.addEventListener("agilityXtraChanged",this);
		this.api.datacenter.Player.addEventListener("intelligenceXtraChanged",this);
		this.api.datacenter.Player.addEventListener("bonusPointsChanged",this);
		this.api.datacenter.Player.addEventListener("energyChanged",this);
		this.api.datacenter.Player.addEventListener("energyMaxChanged",this);
		this.api.datacenter.Player.addEventListener("alignmentChanged",this);
	}
	function addListeners()
	{
		this._ctrAlignment.addEventListener("click",this);
		this._ctrJob0.addEventListener("click",this);
		this._ctrJob1.addEventListener("click",this);
		this._ctrJob2.addEventListener("click",this);
		this._ctrSpe0.addEventListener("click",this);
		this._ctrSpe1.addEventListener("click",this);
		this._ctrSpe2.addEventListener("click",this);
		this._ctrAlignment.addEventListener("over",this);
		this._ctrJob0.addEventListener("over",this);
		this._ctrJob1.addEventListener("over",this);
		this._ctrJob2.addEventListener("over",this);
		this._ctrSpe0.addEventListener("over",this);
		this._ctrSpe1.addEventListener("over",this);
		this._ctrSpe2.addEventListener("over",this);
		this._ctrAlignment.addEventListener("out",this);
		this._ctrJob0.addEventListener("out",this);
		this._ctrJob1.addEventListener("out",this);
		this._ctrJob2.addEventListener("out",this);
		this._ctrSpe0.addEventListener("out",this);
		this._ctrSpe1.addEventListener("out",this);
		this._ctrSpe2.addEventListener("out",this);
		this._btn10.addEventListener("click",this);
		this._btn10.addEventListener("over",this);
		this._btn10.addEventListener("out",this);
		this._btn11.addEventListener("click",this);
		this._btn11.addEventListener("over",this);
		this._btn11.addEventListener("out",this);
		this._btn12.addEventListener("click",this);
		this._btn12.addEventListener("over",this);
		this._btn12.addEventListener("out",this);
		this._btn13.addEventListener("click",this);
		this._btn13.addEventListener("over",this);
		this._btn13.addEventListener("out",this);
		this._btn14.addEventListener("click",this);
		this._btn14.addEventListener("over",this);
		this._btn14.addEventListener("out",this);
		this._btn15.addEventListener("click",this);
		this._btn15.addEventListener("over",this);
		this._btn15.addEventListener("out",this);
		this.api.datacenter.Game.addEventListener("stateChanged",this);
		this._btnClose.addEventListener("click",this);
		this._btnClosePanel.addEventListener("click",this);
		this._mcMoreStats.onRelease = function()
		{
			this._parent.click({target:this});
		};
	}
	function initData()
	{
		var var2 = this.api.datacenter.Player;
		this.levelChanged({value:var2.Level});
		this.xpChanged({value:var2.XP});
		this.lpChanged({value:var2.LP});
		this.lpMaxChanged({value:var2.LPmax});
		this.apChanged({value:var2.AP});
		this.mpChanged({value:var2.MP});
		this.initiativeChanged({value:var2.Initiative});
		this.discernmentChanged({value:var2.Discernment});
		this.forceXtraChanged({value:var2.ForceXtra});
		this.vitalityXtraChanged({value:var2.VitalityXtra});
		this.wisdomXtraChanged({value:var2.WisdomXtra});
		this.chanceXtraChanged({value:var2.ChanceXtra});
		this.agilityXtraChanged({value:var2.AgilityXtra});
		this.intelligenceXtraChanged({value:var2.IntelligenceXtra});
		this.bonusPointsChanged({value:var2.BonusPoints});
		this.energyChanged({value:var2.Energy});
		this.alignmentChanged({alignment:var2.alignment});
		var var3 = this.api.datacenter.Player.Jobs;
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4];
			var var6 = var5.specializationOf;
			if(var6 != 0)
			{
				var var7 = 0;
				while(var7 < 3)
				{
					var var8 = this["_ctrSpe" + var7];
					if(var8.contentData == undefined)
					{
						var8.contentData = var5;
						break;
					}
					var7 = var7 + 1;
				}
			}
			else
			{
				var var9 = 0;
				while(var9 < 3)
				{
					var var10 = this["_ctrJob" + var9];
					if(var10.contentData == undefined)
					{
						var10.contentData = var5;
						break;
					}
					var9 = var9 + 1;
				}
			}
			var4 = var4 + 1;
		}
		this._lblName.text = this.api.datacenter.Player.Name;
		this.activateBoostButtons(!this.api.datacenter.Game.isFight);
	}
	function initTexts()
	{
		this._lblEnergy.text = this.api.lang.getText("ENERGY");
		if(this.api.datacenter.Basics.aks_current_server.typeNum == dofus.datacenter.Server.SERVER_HARDCORE)
		{
			this._lblEnergy._alpha = 50;
			this._mcOverEnergy._visible = false;
		}
		this._lblCharacteristics.text = this.api.lang.getText("CHARACTERISTICS");
		this._lblMyJobs.text = this.api.lang.getText("MY_JOBS");
		this._lblXP.text = this.api.lang.getText("EXPERIMENT");
		this._lblLP.text = this.api.lang.getText("LIFEPOINTS");
		this._lblAP.text = this.api.lang.getText("ACTIONPOINTS");
		this._lblMP.text = this.api.lang.getText("MOVEPOINTS");
		this._lblInitiative.text = this.api.lang.getText("INITIATIVE");
		this._lblDiscernment.text = this.api.lang.getText("DISCERNMENT");
		this._lblForce.text = this.api.lang.getText("FORCE");
		this._lblVitality.text = this.api.lang.getText("VITALITY");
		this._lblWisdom.text = this.api.lang.getText("WISDOM");
		this._lblChance.text = this.api.lang.getText("CHANCE");
		this._lblAgility.text = this.api.lang.getText("AGILITY");
		this._lblIntelligence.text = this.api.lang.getText("INTELLIGENCE");
		this._lblCapital.text = this.api.lang.getText("CHARACTERISTICS_POINTS");
		this._lblSpecialization.text = this.api.lang.getText("SPECIALIZATIONS");
		this._mcMoreStats.onRollOver = function()
		{
			this._parent.gapi.showTooltip(this._parent.api.lang.getText("MORE_STATS"),this,-20);
		};
		this._mcMoreStats.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
	}
	function showStats()
	{
		this.hideAlignment();
		this.hideJob();
		if(this._svStats == undefined)
		{
			this.attachMovie("StatsViewer","_svStats",this.getNextHighestDepth(),{_x:this._mcViewersPlacer._x,_y:this._mcViewersPlacer._y});
			this._btnClosePanel._visible = true;
			this._btnClosePanel.swapDepths(this.getNextHighestDepth());
			this._btnClosePanel._x = this._btnClosePanel._x + 35;
		}
		else
		{
			this.hideStats();
		}
	}
	function hideStats()
	{
		if(this._svStats != undefined)
		{
			this._btnClosePanel._x = this._btnClosePanel._x - 35;
		}
		this._svStats.removeMovieClip();
		this._btnClosePanel._visible = false;
	}
	function showJob(var2)
	{
		this.hideAlignment();
		this.hideStats();
		if(var2 == undefined)
		{
			this.hideJob();
			return undefined;
		}
		if(this._jvJob == undefined)
		{
			this.attachMovie("JobViewer","_jvJob",this.getNextHighestDepth(),{_x:this._mcViewersPlacer._x,_y:this._mcViewersPlacer._y});
		}
		else if(this._oCurrentJob.id == var2.id)
		{
			this.hideJob();
			return undefined;
		}
		this._btnClosePanel._visible = true;
		this._btnClosePanel.swapDepths(this.getNextHighestDepth());
		this._jvJob.job = var2;
		this["_ctr" + (this._oCurrentJob.specializationOf != 0?"Spe":"Job") + this._oCurrentJob.id].selected = false;
		this["_ctr" + (var2.specializationOf != 0?"Spe":"Job") + var2.id].selected = true;
		this._oCurrentJob = var2;
	}
	function hideJob()
	{
		this["_ctr" + (this._oCurrentJob.specializationOf != 0?"Spe":"Job") + this._oCurrentJob.id].selected = false;
		this._jvJob.removeMovieClip();
		delete this._oCurrentJob;
		this._btnClosePanel._visible = false;
	}
	function showAlignment()
	{
		this.hideJob();
		this.hideStats();
		if(this._avAlignment == undefined)
		{
			this.attachMovie("AlignmentViewer","_avAlignment",this.getNextHighestDepth(),{_x:this._mcViewersPlacer._x,_y:this._mcViewersPlacer._y});
			this._btnClosePanel._visible = true;
			this._btnClosePanel.swapDepths(this.getNextHighestDepth());
		}
		else
		{
			this.hideAlignment();
		}
	}
	function hideAlignment()
	{
		this._avAlignment.removeMovieClip();
		this._btnClosePanel._visible = false;
	}
	function activateBoostButtons(var2)
	{
		var var3 = 10;
		while(var3 < 16)
		{
			this["_btn" + var3].enabled = var2;
			var3 = var3 + 1;
		}
	}
	function updateCharacteristicButton(var2)
	{
		var var3 = this.api.datacenter.Player.getBoostCostAndCountForCharacteristic(var2).cost;
		var var4 = this["_btn" + var2];
		if(var3 <= this.api.datacenter.Player.BonusPoints)
		{
			var4._visible = true;
		}
		else
		{
			var4._visible = false;
		}
	}
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnClosePanel":
				this.hideJob();
				this.hideAlignment();
				this.hideStats();
				break;
			case "_ctrAlignment":
				if(this.api.datacenter.Player.data.alignment.index == 0)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("NEED_ALIGNMENT"),"ERROR_BOX");
				}
				else
				{
					this.showAlignment();
				}
				break;
			default:
				loop1:
				switch(null)
				{
					default:
						switch(null)
						{
							case "_btn15":
								break loop1;
							case "_btnClose":
								this.callClose();
								break loop0;
							case "_mcMoreStats":
								this.showStats();
								break loop0;
							default:
								this.showJob(var2.target.contentData);
						}
					case "_btn10":
					case "_btn11":
					case "_btn12":
					case "_btn13":
					case "_btn14":
				}
				this.api.sounds.events.onStatsJobBoostButtonClick();
				var var3 = var2.target._name.substr(4);
				if(this.api.datacenter.Player.canBoost(var3))
				{
					this.api.network.Account.boost(var3);
				}
		}
	}
	function over(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			default:
				switch(null)
				{
					case "_btn12":
					case "_btn13":
					case "_btn14":
					case "_btn15":
						break loop0;
					case "_ctrAlignment":
						this.gapi.showTooltip(this.api.datacenter.Player.alignment.name,var2.target,var2.target.height + 5);
						break;
					default:
						this.gapi.showTooltip(var2.target.contentData.name,var2.target,-20);
				}
			case "_btn10":
			case "_btn11":
		}
		var var3 = Number(var2.target._name.substr(4));
		var var4 = this.api.datacenter.Player.getBoostCostAndCountForCharacteristic(var3);
		this.gapi.showTooltip(this.api.lang.getText("COST") + " : " + var4.cost + " " + this.api.lang.getText("POUR") + " " + var4.count,var2.target,-20);
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function nameChanged(var2)
	{
		this._lblName.text = var2.value;
	}
	function levelChanged(var2)
	{
		this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + String(var2.value);
	}
	function xpChanged(oEvent)
	{
		this._pbXP.minimum = this.api.datacenter.Player.XPlow;
		this._pbXP.maximum = this.api.datacenter.Player.XPhigh;
		this._pbXP.value = oEvent.value;
		this._mcXP.onRollOver = function()
		{
			this._parent.gapi.showTooltip(new ank.utils.(oEvent.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._pbXP.maximum).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcXP.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
	}
	function lpChanged(var2)
	{
		this._lblLPValue.text = String(var2.value);
	}
	function lpMaxChanged(var2)
	{
		this._lblLPmaxValue.text = String(var2.value);
	}
	function apChanged(var2)
	{
		this._lblAPValue.text = String(Math.max(0,var2.value));
	}
	function mpChanged(var2)
	{
		this._lblMPValue.text = String(Math.max(0,var2.value));
	}
	function forceXtraChanged(var2)
	{
		this._lblForceValue.text = this.api.datacenter.Player.Force + (var2.value == 0?"":(var2.value <= 0?" (":" (+") + String(var2.value) + ")");
		this.updateCharacteristicButton(10);
	}
	function vitalityXtraChanged(var2)
	{
		this._lblVitalityValue.text = this.api.datacenter.Player.Vitality + (var2.value == 0?"":(var2.value <= 0?" (":" (+") + String(var2.value) + ")");
		this.updateCharacteristicButton(11);
	}
	function wisdomXtraChanged(var2)
	{
		this._lblWisdomValue.text = this.api.datacenter.Player.Wisdom + (var2.value == 0?"":(var2.value <= 0?" (":" (+") + String(var2.value) + ")");
		this.updateCharacteristicButton(12);
	}
	function chanceXtraChanged(var2)
	{
		this._lblChanceValue.text = this.api.datacenter.Player.Chance + (var2.value == 0?"":(var2.value <= 0?" (":" (+") + String(var2.value) + ")");
		this.updateCharacteristicButton(13);
	}
	function agilityXtraChanged(var2)
	{
		this._lblAgilityValue.text = this.api.datacenter.Player.Agility + (var2.value == 0?"":(var2.value <= 0?" (":" (+") + String(var2.value) + ")");
		this.updateCharacteristicButton(14);
	}
	function intelligenceXtraChanged(var2)
	{
		this._lblIntelligenceValue.text = this.api.datacenter.Player.Intelligence + (var2.value == 0?"":(var2.value <= 0?" (":" (+") + String(var2.value) + ")");
		this.updateCharacteristicButton(15);
	}
	function bonusPointsChanged(var2)
	{
		this._lblCapitalValue.text = String(var2.value);
	}
	function energyChanged(oEvent)
	{
		if(this.api.datacenter.Basics.aks_current_server.typeNum != dofus.datacenter.Server.SERVER_HARDCORE)
		{
			this._mcEnergy.onRollOver = function()
			{
				this._parent.gapi.showTooltip(new ank.utils.(oEvent.value).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(Math.max(10000,this._parent._pbEnergy.maximum)).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
			};
			this._mcEnergy.onRollOut = function()
			{
				this._parent.gapi.hideTooltip();
			};
			this._pbEnergy.maximum = this.api.datacenter.Player.EnergyMax;
			this._pbEnergy.value = oEvent.value;
		}
		else
		{
			this._pbEnergy._alpha = 50;
			this._pbEnergy.enabled = false;
		}
	}
	function energyMaxChanged(var2)
	{
		this._pbEnergy.maximum = var2.value;
	}
	function alignmentChanged(var2)
	{
		this._ctrAlignment.contentPath = var2.alignment.iconFile;
	}
	function initiativeChanged(var2)
	{
		this._lblInitiativeValue.text = String(var2.value);
	}
	function discernmentChanged(var2)
	{
		this._lblDiscernmentValue.text = String(var2.value);
	}
	function stateChanged(var2)
	{
		this.activateBoostButtons(!(var2.value > 1 && var2.value != undefined));
	}
}
