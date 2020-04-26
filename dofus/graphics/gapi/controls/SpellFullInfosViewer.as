class dofus.graphics.gapi.controls.SpellFullInfosViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "SpellFullInfosViewer";
	var _sCurrentTab = "Normal";
	function SpellFullInfosViewer()
	{
		super();
	}
	function __set__spell(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		if(loc2 == this._oSpell)
		{
			return undefined;
		}
		if(!loc2.isValid)
		{
			this._oSpell = new dofus.datacenter.(loc2.ID,1);
		}
		else
		{
			this._oSpell = loc2;
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
			var loc2 = this.api.kernel.GameManager.getCriticalHitChance(this._oSpell.criticalHit);
			this._lblRealCritValue.text = loc2 != 0?"1/" + loc2:"-";
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
				var loc3 = 1;
				while(loc3 <= 6)
				{
					var loc4 = this["_btnLevel" + loc3];
					var loc5 = loc3 == this._oSpell.level;
					loc4.selected = loc5;
					loc4.enabled = !loc5;
					if(loc3 <= this._oSpell.maxLevel)
					{
						loc4._alpha = 100;
					}
					else
					{
						loc4.enabled = false;
						loc4._alpha = 20;
					}
					loc3 = loc3 + 1;
				}
			}
			else
			{
				var loc6 = 1;
				while(loc6 <= 6)
				{
					var loc7 = this["_btnLevel" + loc6];
					loc7.selected = false;
					loc7.enabled = false;
					loc7._alpha = 20;
					loc6 = loc6 + 1;
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
				var loc2 = this._oSpell.effectsNormalHit;
				var loc4 = 0;
				while(loc4 < loc2.length)
				{
					var loc3 = loc2[loc4];
					if(loc3.type == 181)
					{
						break;
					}
					loc3.type = loc0 = 180;
					if(loc0)
					{
						var loc5 = new ank.utils.();
						var loc6 = this.api.datacenter.Player.data;
						loc5.push(loc6.name + " (" + this.api.lang.getText("LEVEL") + " " + this.api.datacenter.Player.Level + ")");
						loc5.push(this.api.lang.getText("LP") + " : " + this.api.datacenter.Player.LP);
						loc5.push(this.api.lang.getText("AP") + " : " + loc6.AP);
						loc5.push(this.api.lang.getText("MP") + " : " + loc6.MP);
						this._lstEffects.dataProvider = loc5;
						return undefined;
					}
					loc4 = loc4 + 1;
				}
				var loc7 = new ank.utils.();
				if(loc3 != undefined)
				{
					var loc8 = loc3.param1;
					var loc9 = loc3.param2;
					var loc10 = this.api.lang.getMonstersText(loc8);
					var loc11 = loc10["g" + loc9];
					loc7.push(loc10.n + " (" + this.api.lang.getText("LEVEL") + " " + loc11.l + ")");
					loc7.push(this.api.lang.getText("LP") + " : " + loc11.lp);
					loc7.push(this.api.lang.getText("AP") + " : " + loc11.ap);
					loc7.push(this.api.lang.getText("MP") + " : " + loc11.mp);
				}
				this._lstEffects.dataProvider = loc7;
				break;
			default:
				switch(null)
				{
					case "Glyph":
					case "Trap":
						var loc12 = 400;
						if(this._sCurrentTab == "Glyph")
						{
							loc12 = 401;
						}
						var loc13 = this._oSpell.effectsNormalHit;
						var loc15 = 0;
						while(loc15 < loc13.length)
						{
							var loc14 = loc13[loc15];
							if(loc14.type == loc12)
							{
								break;
							}
							loc15 = loc15 + 1;
						}
						var loc16 = new ank.utils.();
						if(loc14 != undefined)
						{
							var loc17 = loc14.param1;
							var loc18 = loc14.param2;
							var loc19 = this.api.kernel.CharactersManager.getSpellObjectFromData(loc17 + "~" + loc18 + "~");
							loc16 = loc19.effectsNormalHit;
						}
						this._lstEffects.dataProvider = loc16;
				}
		}
	}
	function setCurrentTab(loc2)
	{
		var loc3 = this["_btnTab" + this._sCurrentTab];
		var loc4 = this["_btnTab" + loc2];
		loc3.selected = true;
		loc3.enabled = true;
		loc4.selected = false;
		loc4.enabled = false;
		this._sCurrentTab = loc2;
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
	function setLevel(loc2)
	{
		var loc3 = this.api.kernel.CharactersManager.getSpellObjectFromData(this._oSpell.ID + "~" + loc2);
		if(loc3.isValid)
		{
			this.spell = loc3;
		}
		else
		{
			this["_btnLevel" + loc2].selected = false;
		}
	}
	function click(loc2)
	{
		loop0:
		switch(loc2.target._name)
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
						loop2:
						switch(null)
						{
							default:
								switch(null)
								{
									case "_btnLevel6":
										break loop2;
									case "_btnClose":
										this.dispatchEvent({type:"close"});
										this.unloadThis();
								}
								break loop0;
							case "_btnLevel2":
							case "_btnLevel3":
							case "_btnLevel4":
							case "_btnLevel5":
						}
					case "_btnLevel1":
						var loc3 = loc2.target._name.substr(9);
						this.setLevel(Number(loc3));
				}
		}
	}
}
