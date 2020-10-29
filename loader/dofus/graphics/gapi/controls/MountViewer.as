class dofus.graphics.gapi.controls.MountViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MountViewer";
	var _sCurrentTab = "General";
	function MountViewer()
	{
		super();
	}
	function __set__mount(var2)
	{
		this._oMount = var2;
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__mount();
	}
	function __get__mount()
	{
		return this._oMount;
	}
	function __get__isMyMount()
	{
		return this._oMount.ID == this.api.datacenter.Player.mount.ID && this._oMount.ID != undefined;
	}
	function __get__currentTab()
	{
		return this._sCurrentTab;
	}
	function __set__currentTab(var2)
	{
		this._sCurrentTab = var2;
		return this.__get__currentTab();
	}
	function setCurrentTab(var2)
	{
		if(var2 != undefined)
		{
			var var3 = this["_btnTab" + this._sCurrentTab];
			var var4 = this["_btnTab" + var2];
			var3.selected = true;
			var3.enabled = true;
			var4.selected = false;
			var4.enabled = false;
			this._sCurrentTab = var2;
			this.selectTab(this["_btnTab" + var2]);
		}
		else
		{
			var var5 = this["_btnTab" + this._sCurrentTab];
			var5.selected = false;
			var5.enabled = false;
			this.selectTab(var5);
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.MountViewer.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._ldrSprite.addEventListener("initialization",this);
		this._btnPregnant.addEventListener("over",this);
		this._btnPregnant.addEventListener("out",this);
		this._btnTabGeneral.addEventListener("click",this);
		this._btnTabStats.addEventListener("click",this);
		this._btnTabCapacities.addEventListener("click",this);
		this._btnTabEffects.addEventListener("click",this);
		this._btnAncestors.addEventListener("click",this);
		this._btnAncestors.addEventListener("over",this);
		this._btnAncestors.addEventListener("out",this);
		this._mcXP.onRollOver = function()
		{
			this._parent.gapi.showTooltip(new ank.utils.(this._parent._oMount.xp).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.xpMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcXP.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._mcEnergy.onRollOver = function()
		{
			this._parent.gapi.showTooltip(new ank.utils.(this._parent._oMount.energy).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.energyMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcEnergy.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._mcTired.onRollOver = function()
		{
			this._parent.gapi.showTooltip(new ank.utils.(this._parent._oMount.tired).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.tiredMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcTired.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._mcReproductions.onRollOver = function()
		{
			if(this._parent._oMount.reprodMax > -1)
			{
				this._parent.gapi.showTooltip(this._parent.api.lang.getText("REPRODUCTIONS") + ": " + new ank.utils.(this._parent._oMount.reprod).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.reprodMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
			}
			else
			{
				this._parent.gapi.showTooltip(this._parent.api.lang.getText("REPRODUCTIONS") + ": " + this._parent.api.lang.getText("UNLIMITED_WORD"),this,-10);
			}
		};
		this._mcReproductions.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
	}
	function initTexts()
	{
		this._lblXP.text = this.api.lang.getText("EXPERIMENT");
		this._lblModel.text = this.api.lang.getText("TYPE");
		this._lblEnergy.text = this.api.lang.getText("ENERGY");
		this._lblTired.text = this.api.lang.getText("TIRE");
		this._btnTabGeneral.label = this.api.lang.getText("OPTIONS_GENERAL");
		this._btnTabStats.label = this.api.lang.getText("STATS");
		this._btnTabCapacities.label = this.api.lang.getText("CAPACITIES");
		this._btnTabEffects.label = this.api.lang.getText("EFFECTS");
	}
	function updateData()
	{
		if(this._oMount != undefined)
		{
			this._oMount.addEventListener("nameChanged",this);
			this._ldrSprite.forceNextLoad();
			this._ldrSprite.contentPath = this._oMount.gfxFile;
			var var2 = new ank.battlefield.datacenter.("-1",undefined,"",0,0);
			var2.mount = this._oMount;
			this.api.colors.addSprite(this._ldrSprite,var2);
			this._oMount.level = this._oMount.level;
			this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + this._oMount.level.toString();
			this._pbXP.minimum = this._oMount.xpMin;
			this._pbXP.maximum = this._oMount.xpMax;
			this._pbXP.value = this._oMount.xp;
			this._pbEnergy.maximum = this._oMount.energyMax;
			this._pbEnergy.value = this._oMount.energy;
			this._pbTired.maximum = this._oMount.tiredMax;
			this._pbTired.value = this._oMount.tired;
			this._pbReproductions.maximum = this._oMount.reprodMax <= -1?0:this._oMount.reprodMax;
			this._pbReproductions.value = this._oMount.reprodMax <= -1?0:this._oMount.reprod;
			this._ldrEnergy.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "94.swf";
			this._lblModelValue.text = this._oMount.modelName;
			var var3 = this._oMount.fecondation > 0;
			if(var3)
			{
				this._lblPregnant._visible = true;
				this._btnPregnant._visible = true;
				this._btnPregnant.icon = "Oeuf";
				this._lblPregnant.styleName = "RedLeftMediumBoldLabel";
				this._lblPregnant.text = this.api.lang.getText("PREGNANT_SINCE",[this._oMount.fecondation]);
				this._lblPregnant._x = 110;
				this._mcReproductions._visible = false;
				this._pbReproductions._visible = false;
			}
			else if(this._oMount.fecondable)
			{
				this._lblPregnant._visible = true;
				this._btnPregnant._visible = false;
				this._lblPregnant.styleName = "GreenLeftMediumBoldLabel";
				this._lblPregnant.text = this.api.lang.getText("FECONDABLE");
				this._lblPregnant._x = 90;
				this._mcReproductions._visible = true;
				this._pbReproductions._visible = true;
			}
			else if(this._oMount.reprodMax == this._oMount.reprod)
			{
				this._btnPregnant._visible = false;
				this._lblPregnant._visible = true;
				this._lblPregnant.styleName = "RedLeftMediumBoldLabel";
				this._lblPregnant.text = this.api.lang.getText("STERILE");
				this._lblPregnant._x = 90;
				this._mcReproductions._visible = false;
				this._pbReproductions._visible = false;
			}
			else if(this._oMount.reprod == -1)
			{
				this._btnPregnant._visible = false;
				this._lblPregnant._visible = true;
				this._lblPregnant.styleName = "RedLeftMediumBoldLabel";
				this._lblPregnant.text = this.api.lang.getText("CASTRATED");
				this._lblPregnant._x = 90;
				this._mcReproductions._visible = false;
				this._pbReproductions._visible = false;
			}
			else
			{
				this._btnPregnant._visible = false;
				this._lblPregnant._visible = true;
				this._lblPregnant.styleName = "BrownLeftMediumBoldLabel";
				this._lblPregnant.text = this.api.lang.getText("REPRODUCTIONS");
				this._lblPregnant._x = 90;
				this._mcReproductions._visible = true;
				this._pbReproductions._visible = true;
			}
			this.addToQueue({object:this,method:this.setCurrentTab});
		}
	}
	function selectTab(var2, var3)
	{
		switch(var2)
		{
			case this._btnTabGeneral:
				this.gotoAndStop("general");
				this.addToQueue({object:this,method:this.switchToGeneralTab});
				break;
			case this._btnTabStats:
				this.gotoAndStop("stats");
				this.addToQueue({object:this,method:this.switchToStatsTab});
				break;
			default:
				switch(null)
				{
					case this._btnTabCapacities:
						this.gotoAndStop("capacities");
						this.addToQueue({object:this,method:this.switchToCapacitiesTab});
						break;
					case this._btnTabEffects:
						this.gotoAndStop("effects");
						this.addToQueue({object:this,method:this.switchToEffectsTab});
				}
		}
	}
	function switchToGeneralTab()
	{
		this._lblName.text = this.api.lang.getText("NAME_BIG");
		this._lblNameValue.text = this._oMount.name;
		this._lblSex.text = this.api.lang.getText("CREATE_SEX");
		this._lblSexValue.text = !this._oMount.sex?this.api.lang.getText("ANIMAL_MEN"):this.api.lang.getText("ANIMAL_WOMEN");
		this._lblMountable.text = this.api.lang.getText("MOUNTABLE");
		this._lblMountableValue.text = !this._oMount.mountable?this.api.lang.getText("NO"):this.api.lang.getText("YES");
		this._lblWild.text = this.api.lang.getText("WILD");
		this._lblWildValue.text = !this._oMount.wild?this.api.lang.getText("NO"):this.api.lang.getText("YES");
	}
	function switchToStatsTab()
	{
		this._ldrSerenity.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "98.swf";
		this._ldrAgressivity.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "99.swf";
		this._ldrLove.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "97.swf";
		this._ldrLove2.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "97.swf";
		this._ldrStamina.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "96.swf";
		this._ldrStamina2.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "96.swf";
		this._ldrMaturity.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "95.swf";
		this._ldrMaturity2.contentPath = dofus.Constants.SMILEYS_ICONS_PATH + "95.swf";
		this._lblAgressivity.text = this.api.lang.getText("AGRESSIVITY");
		this._lblSerenity.text = this.api.lang.getText("SERENITY");
		this._lblMaturity.text = this.api.lang.getText("MATURITY");
		this._lblStamina.text = this.api.lang.getText("STAMINA");
		this._lblLove.text = this.api.lang.getText("LOVE");
		this._pbSerenity.minimum = this._oMount.serenityMin;
		this._pbSerenity.maximum = this._oMount.serenityMax;
		this._pbSerenity.value = this._oMount.serenity;
		this._pbLove.maximum = this._oMount.loveMax;
		this._pbLove.value = this._oMount.love;
		this._pbMaturity.maximum = this._oMount.maturityMax;
		this._pbMaturity.value = this._oMount.maturity;
		this._pbStamina.maximum = this._oMount.staminaMax;
		this._pbStamina.value = this._oMount.stamina;
		this._mcSerenity.onRollOver = function()
		{
			this._parent.gapi.showTooltip(new ank.utils.(this._parent._oMount.serenityMin).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.serenity).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.serenityMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcSerenity.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._mcLove.onRollOver = function()
		{
			this._parent.gapi.showTooltip(new ank.utils.(this._parent._oMount.love).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.loveMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcLove.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._mcMaturity.onRollOver = function()
		{
			this._parent.gapi.showTooltip(new ank.utils.(this._parent._oMount.maturity).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.maturityMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcMaturity.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._mcStamina.onRollOver = function()
		{
			this._parent.gapi.showTooltip(new ank.utils.(this._parent._oMount.stamina).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.(this._parent._oMount.staminaMax).addMiddleChar(this._parent.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this,-10);
		};
		this._mcStamina.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._mcZone1.onRollOver = function()
		{
			this._alpha = 100;
			this._parent.gapi.showTooltip(this._parent.api.lang.getText("MOUNT_VIEWER_TOOLTIP_ZONE1"),this,-30);
		};
		this._mcZone1.onRollOut = function()
		{
			this._alpha = 0;
			this._parent.gapi.hideTooltip();
		};
		this._mcZone2.onRollOver = function()
		{
			this._alpha = 100;
			this._parent.gapi.showTooltip(this._parent.api.lang.getText("MOUNT_VIEWER_TOOLTIP_ZONE2"),this,-30);
		};
		this._mcZone2.onRollOut = function()
		{
			this._alpha = 0;
			this._parent.gapi.hideTooltip();
		};
		this._mcZone3.onRollOver = function()
		{
			this._alpha = 100;
			this._parent.gapi.showTooltip(this._parent.api.lang.getText("MOUNT_VIEWER_TOOLTIP_ZONE3"),this,-30);
		};
		this._mcZone3.onRollOut = function()
		{
			this._alpha = 0;
			this._parent.gapi.hideTooltip();
		};
		this._mcZone1._alpha = 0;
		this._mcZone2._alpha = 0;
		this._mcZone3._alpha = 0;
		this._lblMaturity.onRollOver = function()
		{
			this._parent.gapi.showTooltip(this._parent.api.lang.getText("MOUNT_VIEWER_TOOLTIP_MATURITY"),this,-10);
		};
		this._lblMaturity.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._lblStamina.onRollOver = function()
		{
			this._parent.gapi.showTooltip(this._parent.api.lang.getText("MOUNT_VIEWER_TOOLTIP_STAMINA"),this,-10);
		};
		this._lblStamina.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
		this._lblLove.onRollOver = function()
		{
			this._parent.gapi.showTooltip(this._parent.api.lang.getText("MOUNT_VIEWER_TOOLTIP_LOVE"),this,-10);
		};
		this._lblLove.onRollOut = function()
		{
			this._parent.gapi.hideTooltip();
		};
	}
	function switchToCapacitiesTab()
	{
		this._lstList.addEventListener("itemRollOver",this);
		this._lstList.addEventListener("itemRollOut",this);
		if(this._oMount.capacities.length > 0)
		{
			this._lstList.dataProvider = this._oMount.capacities;
		}
		else
		{
			var var2 = new ank.utils.();
			var2.push({label:this.api.lang.getText("NO_CONDITIONS")});
			this._lstList.dataProvider = var2;
		}
	}
	function switchToEffectsTab()
	{
		this._lstList.removeEventListener("itemRollOver",this);
		this._lstList.removeEventListener("itemRollOut",this);
		if(this._oMount.effects.length > 0)
		{
			var var2 = new ank.utils.();
			var var3 = this._oMount.effects;
			var var4 = 0;
			while(var4 < var3.length)
			{
				var2.push({label:var3[var4].description});
				var4 = var4 + 1;
			}
			this._lstList.dataProvider = var2;
		}
		else
		{
			var var5 = new ank.utils.();
			var5.push({label:this.api.lang.getText("NONE")});
			this._lstList.dataProvider = var5;
		}
	}
	function initialization(var2)
	{
		var var3 = var2.target.content;
		var3.attachMovie("staticR_front","anim_front",11);
		var3.attachMovie("staticR_back","anim_back",10);
	}
	function click(var2)
	{
		if((var var0 = var2.target) !== this._btnAncestors)
		{
			this.setCurrentTab(var2.target._name.substr(7));
		}
		else
		{
			this.gapi.loadUIComponent("MountAncestorsViewer","MountAncestorsViewer",{mount:this._oMount});
		}
	}
	function nameChanged(var2)
	{
		var var3 = this.api.datacenter.Player.mount;
		this._lblNameValue.text = var3.name;
	}
	function over(var2)
	{
		switch(var2.target)
		{
			case this._btnAncestors:
				this.gapi.showTooltip(this.api.lang.getText("MOUNT_ANCESTORS"),var2.target,-30,{bXLimit:true,bYLimit:false});
				break;
			case this._btnPregnant:
				var var3 = this.api.lang.getText(this._oMount.fecondation <= 0?"FECONDABLE":"PREGNANT_SINCE",[this._oMount.fecondation]);
				this.gapi.showTooltip(var3,var2.target,-30,{bXLimit:true,bYLimit:false});
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function itemRollOver(var2)
	{
		if((var var0 = var2.target) === this._lstList)
		{
			if(this._btnTabCapacities.selected == false)
			{
				var var3 = this.api.lang.getMountCapacity(var2.row.item.data).d;
				if(var3 != undefined && var3.length > 0)
				{
					this.gapi.showTooltip(var3,var2.target,20,{bXLimit:true,bYLimit:false});
				}
			}
		}
	}
	function itemRollOut(var2)
	{
		this.out();
	}
}
