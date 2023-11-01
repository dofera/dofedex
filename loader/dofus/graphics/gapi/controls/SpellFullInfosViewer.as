class dofus.graphics.gapi.controls.SpellFullInfosViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "SpellFullInfosViewer";
	var _sCurrentTab = "Normal";
	function SpellFullInfosViewer()
	{
		super();
	}
	function __set__spell(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		if(var2 == this._oSpell)
		{
			return undefined;
		}
		if(!var2.isValid)
		{
			this._oSpell = new dofus.datacenter.(var2.ID,1);
		}
		else
		{
			this._oSpell = var2;
		}
		if(this.initialized)
		{
			this.updateData();
		}
		return this.__get__spell();
	}
	function __get__spell()
	{
		return this._oSpell;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.SpellFullInfosViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this.hideAllCheck();
		this._btnTabCreature._visible = false;
		this._btnTabGlyph._visible = false;
		this._btnTabTrap._visible = false;
	}
	function addListeners()
	{
		this._ldrIcon.addEventListener("complete",this);
		this._btnTabNormal.addEventListener("click",this);
		this._btnTabCritical.addEventListener("click",this);
		this._btnTabCreature.addEventListener("click",this);
		this._btnTabGlyph.addEventListener("click",this);
		this._btnTabTrap.addEventListener("click",this);
		this._btnLevel1.addEventListener("click",this);
		this._btnLevel2.addEventListener("click",this);
		this._btnLevel3.addEventListener("click",this);
		this._btnLevel4.addEventListener("click",this);
		this._btnLevel5.addEventListener("click",this);
		this._btnLevel6.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
	}
	function initData()
	{
		this.updateData();
	}
	function initTexts()
	{
		this._lblEffectsTitle.text = this.api.lang.getText("EFFECTS");
		this._lblOtherTitle.text = this.api.lang.getText("OTHER_CHARACTERISTICS");
		this._lblCriticalHit.text = this.api.lang.getText("CRITICAL_HIT_PROBABILITY");
		this._lblCriticalMiss.text = this.api.lang.getText("CRITICAL_MISS_PROBABILITY");
		this._lblCountByTurn.text = this.api.lang.getText("COUNT_BY_TURN");
		this._lblCountByTurnByPlayer.text = this.api.lang.getText("COUNT_BY_TURN_BY_PLAYER");
		this._lblDelay.text = this.api.lang.getText("DELAY_RELAUNCH");
		this._lblRangeBoost.text = this.api.lang.getText("RANGE_BOOST");
		this._lblLineOfSight.text = this.api.lang.getText("LINE_OF_SIGHT");
		this._lblLineOnly.text = this.api.lang.getText("LINE_ONLY");
		this._lblFreeCell.text = this.api.lang.getText("FREE_CELL");
		this._lblRealCrit.text = this.api.lang.getText("ACTUAL_CRITICAL_CHANCE");
		this._lblFailureEndsTheTurn.text = this.api.lang.getText("FAILURE_ENDS_THE_TURN");
		this._btnTabNormal.label = this.api.lang.getText("NORMAL_EFFECTS");
		this._btnTabCritical.label = this.api.lang.getText("CRITICAL_EFECTS");
		this._btnTabCreature.label = this.api.lang.getText("SUMMONED_CREATURE");
		this._btnTabGlyph.label = this.api.lang.getText("GLYPH");
		this._btnTabTrap.label = this.api.lang.getText("TRAP");
	}
	function updateData()
	{
		if(this._oSpell != undefined && this._txtDescription.text != undefined)
		{
			this._ldrIcon.contentPath = this._oSpell.iconFile;
			if(dofus.Constants.DOUBLEFRAMERATE && this._ldrIcon.loaded)
			{
				var var2 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
				this._ldrIcon.content.gotoAndStop(var2);
			}
			this._lblName.text = this._oSpell.name;
			this._lblLevel.text = this.api.lang.getText("ACTUAL_SPELL_LEVEL") + ":";
			this._lblReqLevel.text = this._oSpell.minPlayerLevel == undefined?"":this.api.lang.getText("REQUIRED_SPELL_LEVEL") + ": " + this._oSpell.minPlayerLevel;
			this._lblRange.text = this._oSpell.rangeStr + " " + this.api.lang.getText("RANGE");
			this._lblAP.text = this._oSpell.apCost + " " + this.api.lang.getText("AP");
			this._txtDescription.text = this._oSpell.description;
			this._btnTabCreature._visible = this._oSpell.summonSpell;
			this._btnTabGlyph._visible = this._oSpell.glyphSpell;
			this._btnTabTrap._visible = this._oSpell.trapSpell;
			if(this._oSpell.effectsCriticalHit[0] == undefined)
			{
				if(this._sCurrentTab == "Critical")
				{
					this.setCurrentTab("Normal");
				}
				this._btnTabCritical._alpha = 70;
				this._btnTabCritical.enabled = false;
			}
			else
			{
				this._btnTabCritical._alpha = 100;
				this._btnTabCritical.enabled = true;
			}
			if(!this._oSpell.summonSpell && this._sCurrentTab == "Creature")
			{
				this.setCurrentTab("Normal");
			}
			else if(!this._oSpell.glyphSpell && this._sCurrentTab == "Glyph")
			{
				this.setCurrentTab("Normal");
			}
			else if(!this._oSpell.trapSpell && this._sCurrentTab == "Trap")
			{
				this.setCurrentTab("Normal");
			}
			else
			{
				this.updateCurrentTabInformations();
			}
			var var3 = this.api.kernel.GameManager.getCriticalHitChance(this._oSpell.criticalHit);
			this._lblRealCritValue.text = var3 != 0?"1/" + var3:"-";
			this._lblCriticalHitValue.text = this._oSpell.criticalHit != 0?"1/" + this._oSpell.criticalHit:"-";
			this._lblCriticalMissValue.text = this._oSpell.criticalFailure != 0?"1/" + this._oSpell.criticalFailure:"-";
			this._lblCountByTurnValue.text = this._oSpell.launchCountByTurn != 0?String(this._oSpell.launchCountByTurn):"-";
			this._lblCountByTurnByPlayerValue.text = this._oSpell.launchCountByPlayerTurn != 0?String(this._oSpell.launchCountByPlayerTurn):"-";
			this._lblDelayValue.text = this._oSpell.delayBetweenLaunch < 63?this._oSpell.delayBetweenLaunch != 0?String(this._oSpell.delayBetweenLaunch):"-":"inf.";
			this._mcCrossRangeBoost._visible = !this._oSpell.canBoostRange;
			this._mcCheckRangeBoost._visible = this._oSpell.canBoostRange;
			this._mcCrossLineOfSight._visible = !this._oSpell.lineOfSight;
			this._mcCheckLineOfSight._visible = this._oSpell.lineOfSight;
			this._mcCrossLineOnly._visible = !this._oSpell.lineOnly;
			this._mcCheckLineOnly._visible = this._oSpell.lineOnly;
			this._mcCrossFreeCell._visible = !this._oSpell.freeCell;
			this._mcCheckFreeCell._visible = this._oSpell.freeCell;
			this._mcCrossFailureEndsTheTurn._visible = !this._oSpell.criticalFailureEndsTheTurn;
			this._mcCheckFailureEndsTheTurn._visible = this._oSpell.criticalFailureEndsTheTurn;
			if(this._oSpell.level != undefined)
			{
				var var4 = 1;
				while(var4 <= 6)
				{
					var var5 = this["_btnLevel" + var4];
					var var6 = var4 == this._oSpell.level;
					var5.selected = var6;
					var5.enabled = !var6;
					if(var4 <= this._oSpell.maxLevel)
					{
						var5._alpha = 100;
					}
					else
					{
						var5.enabled = false;
						var5._alpha = 20;
					}
					var4 = var4 + 1;
				}
			}
			else
			{
				var var7 = 1;
				while(var7 <= 6)
				{
					var var8 = this["_btnLevel" + var7];
					var8.selected = false;
					var8.enabled = false;
					var8._alpha = 20;
					var7 = var7 + 1;
				}
			}
		}
		else if(this._lblName.text != undefined)
		{
			this._ldrIcon.contentPath = "";
			this._lblName.text = "";
			this._lblLevel.text = "";
			this._lblRange.text = "";
			this._lblAP.text = "";
			this._txtDescription.text = "";
			this._lblCriticalHitValue.text = "";
			this._lblCriticalMissValue.text = "";
			this._lblCountByTurnValue.text = "";
			this._lblCountByTurnByPlayerValue.text = "";
			this._lblDelayValue.text = "";
			this.hideAllCheck();
			this._lstEffects.dataProvider = null;
		}
	}
	function updateCurrentTabInformations()
	{
		switch(this._sCurrentTab)
		{
			case "Normal":
				this._lstEffects.dataProvider = this._oSpell.effectsNormalHitWithArea;
				break;
			case "Critical":
				this._lstEffects.dataProvider = this._oSpell.effectsCriticalHitWithArea;
				break;
			case "Creature":
				var var2 = this._oSpell.effectsNormalHit;
				var var4 = 0;
				while(var4 < var2.length)
				{
					var var3 = var2[var4];
					if(var3.type == 181)
					{
						break;
					}
					var3.type = var0 = 180;
					if(var0)
					{
						var var5 = new ank.utils.();
						var var6 = this.api.datacenter.Player.data;
						var5.push(var6.name + " (" + this.api.lang.getText("LEVEL") + " " + this.api.datacenter.Player.Level + ")");
						var5.push(this.api.lang.getText("LP") + " : " + this.api.datacenter.Player.LP);
						var5.push(this.api.lang.getText("AP") + " : " + var6.AP);
						var5.push(this.api.lang.getText("MP") + " : " + var6.MP);
						this._lstEffects.dataProvider = var5;
						return undefined;
					}
					var4 = var4 + 1;
				}
				var var7 = new ank.utils.();
				if(var3 != undefined)
				{
					var var8 = var3.param1;
					var var9 = var3.param2;
					var var10 = this.api.lang.getMonstersText(var8);
					var var11 = var10["g" + var9];
					var7.push(var10.n + " (" + this.api.lang.getText("LEVEL") + " " + var11.l + ")");
					var7.push(this.api.lang.getText("LP") + " : " + var11.lp);
					var7.push(this.api.lang.getText("AP") + " : " + var11.ap);
					var7.push(this.api.lang.getText("MP") + " : " + var11.mp);
				}
				this._lstEffects.dataProvider = var7;
				break;
			default:
				if(var0 !== "Trap")
				{
					break;
				}
			case "Glyph":
				var var12 = 400;
				if(this._sCurrentTab == "Glyph")
				{
					var12 = 401;
				}
				var var13 = this._oSpell.effectsNormalHit;
				var var15 = 0;
				while(var15 < var13.length)
				{
					var var14 = var13[var15];
					if(var14.type == var12)
					{
						break;
					}
					var15 = var15 + 1;
				}
				var var16 = new ank.utils.();
				if(var14 != undefined)
				{
					var var17 = var14.param1;
					var var18 = var14.param2;
					var var19 = this.api.kernel.CharactersManager.getSpellObjectFromData(var17 + "~" + var18 + "~");
					var16 = var19.effectsNormalHit;
				}
				this._lstEffects.dataProvider = var16;
		}
	}
	function setCurrentTab(var2)
	{
		var var3 = this["_btnTab" + this._sCurrentTab];
		var var4 = this["_btnTab" + var2];
		var3.selected = true;
		var3.enabled = true;
		var4.selected = false;
		var4.enabled = false;
		this._sCurrentTab = var2;
		this.updateCurrentTabInformations();
	}
	function hideAllCheck()
	{
		this._mcCrossRangeBoost._visible = true;
		this._mcCheckRangeBoost._visible = false;
		this._mcCrossLineOfSight._visible = true;
		this._mcCheckLineOfSight._visible = false;
		this._mcCrossLineOnly._visible = true;
		this._mcCheckLineOnly._visible = false;
		this._mcCrossFreeCell._visible = true;
		this._mcCheckFreeCell._visible = false;
	}
	function setLevel(var2)
	{
		var var3 = this.api.kernel.CharactersManager.getSpellObjectFromData(this._oSpell.ID + "~" + var2);
		if(var3.isValid)
		{
			this.spell = var3;
		}
		else
		{
			this["_btnLevel" + var2].selected = false;
		}
	}
	function complete(var2)
	{
		if(!dofus.Constants.DOUBLEFRAMERATE)
		{
			return undefined;
		}
		var var3 = var2.clip;
		var var4 = this.api.kernel.OptionsManager.getOption("RemasteredSpellIconsPack");
		var3.gotoAndStop(var4);
	}
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnTabNormal":
				this.setCurrentTab("Normal");
				break;
			case "_btnTabCritical":
				this.setCurrentTab("Critical");
				break;
			default:
				switch(null)
				{
					case "_btnTabCreature":
						this.setCurrentTab("Creature");
						break loop0;
					case "_btnTabGlyph":
						this.setCurrentTab("Glyph");
						break loop0;
					case "_btnTabTrap":
						this.setCurrentTab("Trap");
						break loop0;
					default:
						switch(null)
						{
							case "_btnLevel3":
							case "_btnLevel4":
							case "_btnLevel5":
							case "_btnLevel6":
								break;
							case "_btnClose":
								this.dispatchEvent({type:"close"});
								this.unloadThis();
						}
						break loop0;
					case "_btnLevel1":
					case "_btnLevel2":
						var var3 = var2.target._name.substr(9);
						this.setLevel(Number(var3));
				}
		}
	}
}
