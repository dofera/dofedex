class dofus.managers.GameManager extends dofus.utils.ApiElement
{
	static var MINIMAL_SPELL_LAUNCH_DELAY = 500;
	static var _sSelf = null;
	var _aLastModified = new Array();
	var _bIsFullScreen = false;
	var _bIsAllowingScale = true;
	var _nLastSpellLaunch = 0;
	static var FIGHT_TYPE_CHALLENGE = 0;
	static var FIGHT_TYPE_AGRESSION = 1;
	static var FIGHT_TYPE_PvMA = 2;
	static var FIGHT_TYPE_MXvM = 3;
	static var FIGHT_TYPE_PvM = 4;
	static var FIGHT_TYPE_PvT = 5;
	static var FIGHT_TYPE_PvMU = 6;
	var _nFightTurnInactivity = 0;
	function GameManager(loc3)
	{
		super();
		dofus.managers.GameManager._sSelf = this;
		this.initialize(loc3);
	}
	function __get__isFullScreen()
	{
		return this._bIsFullScreen;
	}
	function __set__isFullScreen(loc2)
	{
		this._bIsFullScreen = loc2;
		return this.__get__isFullScreen();
	}
	function __get__isAllowingScale()
	{
		return this._bIsAllowingScale;
	}
	function __set__isAllowingScale(loc2)
	{
		this._bIsAllowingScale = loc2;
		return this.__get__isAllowingScale();
	}
	function __set__lastSpellLaunch(loc2)
	{
		this._nLastSpellLaunch = loc2;
		return this.__get__lastSpellLaunch();
	}
	static function getInstance()
	{
		return dofus.managers.GameManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		this.api.ui.addEventListener("removeCursor",this);
	}
	function askPrivateMessage(loc2)
	{
		var loc3 = this.api.ui.loadUIComponent("AskPrivateChat","AskPrivateChat",{title:this.api.lang.getText("WISPER_MESSAGE") + " " + this.api.lang.getText("TO_DESTINATION") + " " + loc2,params:{playerName:loc2}});
		loc3.addEventListener("send",this);
		loc3.addEventListener("addfriend",this);
	}
	function giveUpGame()
	{
		if(this.api.datacenter.Game.fightType == dofus.managers.GameManager.FIGHT_TYPE_CHALLENGE || this.api.datacenter.Basics.aks_current_server.typeNum != dofus.datacenter.Server.SERVER_HARDCORE)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_GIVEUP"),"CAUTION_YESNO",{name:"GiveUp",listener:this});
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_SUICIDE"),"CAUTION_YESNO",{name:"GiveUp",listener:this});
		}
	}
	function offlineExchange()
	{
		this.api.network.Exchange.askOfflineExchange();
	}
	function askOfflineExchange(loc2, loc3, loc4)
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_OFFLINEEXCHANGE",[loc2,tax,loc4]),"CAUTION_YESNO",{name:"OfflineExchange",listener:this,price:loc4});
	}
	function startExchange(loc2, loc3, loc4)
	{
		var loc5 = this.api.datacenter.Player.data;
		if(loc5.isInMove)
		{
			loc5.isInMove = false;
			loc5.GameActionsManager.cancel(loc5.cellNum,true);
		}
		this.api.network.Exchange.request(loc2,Number(loc3),loc4);
	}
	function startDialog(loc2)
	{
		var loc3 = this.api.datacenter.Player.data;
		if(loc3.isInMove)
		{
			loc3.isInMove = false;
			loc3.GameActionsManager.cancel(loc3.cellNum,true);
		}
		this.api.network.Dialog.create(loc2);
	}
	function askAttack(loc2)
	{
		var loc3 = this.api.datacenter.Sprites.getItemAt(loc2);
		var loc4 = "";
		if(!this.api.datacenter.Player.rank.enable)
		{
			loc4 = loc4 + this.api.lang.getText("DO_U_ATTACK_WHEN_PVP_DISABLED");
		}
		if(loc3.rank.value == 0)
		{
			if(loc4 != "")
			{
				loc4 = loc4 + "\n\n";
			}
			loc4 = loc4 + this.api.lang.getText("DO_U_ATTACK_NEUTRAL");
		}
		if(loc4 != "")
		{
			loc4 = loc4 + "\n\n";
		}
		if(!this.api.lang.getConfigText("SHOW_PVP_GAIN_WARNING_POPUP"))
		{
			loc3.pvpGain = 0;
		}
		switch(loc3.pvpGain)
		{
			case -1:
				loc4 = loc4 + this.api.lang.getText("DO_U_ATTACK_NO_GAIN",[loc3.name]);
				break;
			case 1:
				loc4 = loc4 + this.api.lang.getText("DO_U_ATTACK_BONUS_GAIN",[loc3.name]);
				break;
			default:
				loc4 = loc4 + this.api.lang.getText("DO_U_ATTACK",[loc3.name]);
		}
		this.api.kernel.showMessage(undefined,loc4,"CAUTION_YESNO",{name:"Punish",listener:this,params:{spriteID:loc2}});
	}
	function askRemoveTaxCollector(loc2)
	{
		var loc3 = this.api.datacenter.Sprites.getItemAt(loc2).name;
		this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_REMOVE_TAXCOLLECTOR",[loc3]),"CAUTION_YESNO",{name:"RemoveTaxCollector",listener:this,params:{spriteID:loc2}});
	}
	function useRessource(loc2, loc3, loc4)
	{
		if(this.api.gfx.onCellRelease(loc2))
		{
			this.api.network.GameActions.sendActions(500,[loc3,loc4]);
		}
	}
	function useSkill(loc2)
	{
		this.api.network.GameActions.sendActions(507,[loc2]);
	}
	function setEnabledInteractionIfICan(loc2)
	{
		if(this.api.datacenter.Player.isCurrentPlayer)
		{
			this.api.gfx.setInteraction(loc2);
		}
	}
	function cleanPlayer(loc2)
	{
		if(loc2 != this.api.datacenter.Game.currentPlayerID)
		{
			var loc3 = this.api.datacenter.Sprites.getItemAt(loc2);
			loc3.EffectsManager.nextTurn();
			loc3.CharacteristicsManager.nextTurn();
			loc3.GameActionsManager.clear();
		}
	}
	function cleanUpGameArea(loc2)
	{
		if(loc2)
		{
			this.api.gfx.unSelect(true);
		}
		this.api.ui.removeCursor();
		this.api.ui.getUIComponent("Banner").hideRightPanel();
		this.api.gfx.clearZoneLayer("spell");
		this.api.gfx.clearPointer();
		this.api.gfx.unSelect(true);
		delete this.api.datacenter.Player.currentUseObject;
		if(!(this.api.datacenter.Game.isFight && !this.api.datacenter.Game.isRunning))
		{
			this.api.datacenter.Game.setInteractionType("move");
		}
		this.api.datacenter.Player.InteractionsManager.setState(this.api.datacenter.Game.isFight);
	}
	function terminateFight()
	{
		if(!this.api.datacenter.Basics.isLogged)
		{
			return undefined;
		}
		this.api.sounds.events.onGameEnd();
		this.api.sounds.playMusic(this.api.datacenter.Map.musicID);
		this.api.kernel.showMessage(undefined,this.api.lang.getText("GAME_END"),"INFO_CHAT");
		if(!this.api.datacenter.Player.isSkippingLootPanel)
		{
			this.api.ui.loadUIComponent("GameResult","GameResult",{data:this.api.datacenter.Game.results},{bAlwaysOnTop:true});
		}
		this.api.gfx.cleanMap();
		this.api.network.Game.onLeave();
	}
	function switchToItemTarget(loc2)
	{
		if(this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		this.api.gfx.unSelect(true);
		this.api.gfx.clearPointer();
		this.api.gfx.addPointerShape("C",0,dofus.Constants.CELL_SPELL_EFFECT_COLOR,this.api.datacenter.Player.data.cellNum);
		this.api.datacenter.Player.currentUseObject = loc2;
		this.api.datacenter.Game.setInteractionType("target");
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
		this.api.ui.setCursor(loc2,{width:25,height:25,x:15,y:15});
		this.api.datacenter.Basics.gfx_canLaunch = false;
		dofus.DofusCore.getInstance().forceMouseOver();
	}
	function switchToFlagSet()
	{
		if(!this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		this.api.gfx.clearPointer();
		this.api.gfx.unSelectAllButOne("startPosition");
		this.api.gfx.addPointerShape("C",0,dofus.Constants.CELL_SPELL_EFFECT_COLOR,this.api.datacenter.Player.data.cellNum);
		this.api.datacenter.Game.setInteractionType("flag");
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
		this.api.ui.removeCursor();
		this.api.datacenter.Basics.gfx_canLaunch = false;
		dofus.DofusCore.getInstance().forceMouseOver();
	}
	function switchToSpellLaunch(loc2, loc3, loc4)
	{
		if(loc4 != true)
		{
			if(!this.api.datacenter.Game.isRunning)
			{
				return undefined;
			}
			if(this.api.datacenter.Player.data.sequencer.isPlaying())
			{
				return undefined;
			}
			if(this.api.datacenter.Player.data.GameActionsManager.isWaiting())
			{
				return undefined;
			}
			if(this.api.datacenter.Player.data.GameActionsManager.m_bNextAction)
			{
				return undefined;
			}
			if(this._nLastSpellLaunch + dofus.managers.GameManager.MINIMAL_SPELL_LAUNCH_DELAY > getTimer())
			{
				return undefined;
			}
			if(!this.api.datacenter.Player.SpellsManager.checkCanLaunchSpell(loc2.ID,undefined))
			{
				if(this.api.datacenter.Basics.spellManager_errorMsg != undefined)
				{
					this.api.kernel.showMessage(undefined,this.api.datacenter.Basics.spellManager_errorMsg,"ERROR_CHAT");
					delete this.api.datacenter.Basics.spellManager_errorMsg;
				}
				return undefined;
			}
		}
		this.api.datacenter.Player.isCurrentSpellForced = loc4;
		delete this.api.datacenter.Basics.interactionsManager_path;
		this.api.gfx.unSelect(true);
		this.api.datacenter.Player.currentUseObject = loc2;
		this.api.gfx.clearZoneLayer("spell");
		this.api.gfx.clearPointer();
		var loc5 = this.api.datacenter.Player.data.cellNum;
		if(loc2.rangeMax != 63)
		{
			var loc6 = loc2.rangeMax;
			var loc7 = loc2.rangeMin;
			if(loc6 != 0)
			{
				var loc8 = !loc2.canBoostRange?0:this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + this.api.datacenter.Player.RangeModerator;
				loc6 = loc6 + loc8;
				loc6 = Math.max(loc7,loc6);
			}
			if(loc2.lineOnly)
			{
				this.api.gfx.drawZone(loc5,loc7,loc6,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"X");
				this.drawAllowedZone(true,loc5,loc7,loc6);
			}
			else
			{
				this.api.gfx.drawZone(loc5,loc7,loc6,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"C");
				this.drawAllowedZone(false,loc5,loc7,loc6);
			}
		}
		else
		{
			this.api.gfx.drawZone(0,0,100,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"C");
		}
		var loc9 = loc2.effectZones;
		var loc10 = 0;
		while(loc10 < loc9.length)
		{
			if(loc9[loc10].size < 63)
			{
				this.api.gfx.addPointerShape(loc9[loc10].shape,loc9[loc10].size,dofus.Constants.CELL_SPELL_EFFECT_COLOR,loc5);
			}
			loc10 = loc10 + 1;
		}
		if(loc3)
		{
			this.api.datacenter.Game.setInteractionType("spell");
		}
		else
		{
			this.api.datacenter.Game.setInteractionType("cc");
		}
		this.api.ui.setCursor(loc2,{width:25,height:25,x:15,y:15});
		this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
		this.api.datacenter.Basics.gfx_canLaunch = false;
		dofus.DofusCore.getInstance().forceMouseOver();
	}
	function drawAllowedZone(lineOnly, §\x1e\x19\x12§, §\r\x14§, §\x1e\x18\x1b§)
	{
		if(!this.api.kernel.OptionsManager.getOption("AdvancedLineOfSight"))
		{
			return undefined;
		}
		var loc6 = this.api.gfx.mapHandler.getCellCount();
		var loc7 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(this.api.gfx.mapHandler,loc3);
		var loc8 = !this.api.datacenter.Player.currentUseObject.canBoostRange?0:this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + this.api.datacenter.Player.RangeModerator;
		var loc9 = 0;
		for(; loc9 < loc6; loc9 = loc9 + 1)
		{
			var loc10 = ank.battlefield.utils.Pathfinding.goalDistance(this.api.gfx.mapHandler,loc3,loc9);
			if(loc10 >= loc4 && loc10 <= loc5)
			{
				if(lineOnly)
				{
					var loc11 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(this.api.gfx.mapHandler,loc9);
					if(loc11.x != loc7.x && loc11.y != loc7.y)
					{
						continue;
					}
				}
				if(this.api.datacenter.Player.SpellsManager.checkCanLaunchSpellOnCell(this.api.gfx.mapHandler,this.api.datacenter.Player.currentUseObject,this.api.gfx.mapHandler.getCellData(loc9),loc8))
				{
					this.api.gfx.select(loc9,26316,"spell",50);
				}
			}
		}
	}
	function showDisgraceSanction()
	{
		var loc2 = this.api.datacenter.Player.rank.disgrace;
		if(loc2 > 0)
		{
			var loc3 = "";
			var loc4 = 1;
			while(loc4 <= loc2)
			{
				var loc5 = this.api.lang.getText("DISGRACE_SANCTION_" + loc4);
				if(loc5 != undefined && (loc5 != "undefined" && loc5.charAt(0) != "!"))
				{
					loc3 = loc3 + ("\n\n" + loc5);
				}
				loc4 = loc4 + 1;
			}
			if(loc3 != "")
			{
				loc3 = this.api.lang.getText("DISGRACE_SANCTION",[ank.utils.PatternDecoder.combine(this.api.lang.getText("POINTS",[loc2]),"m",loc2 < 2)]) + loc3;
				this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),loc3,"ERROR_BOX");
			}
		}
	}
	function getSpellDescriptionWithEffects(loc2, loc3, loc4)
	{
		var loc5 = new Array();
		var loc6 = loc2.length;
		if(typeof loc2 == "object")
		{
			var loc7 = 0;
			while(loc7 < loc6)
			{
				var loc8 = loc2[loc7];
				var loc9 = loc8[0];
				var loc10 = !(loc4 > 0 && this.api.kernel.SpellsBoostsManager.isBoostedHealingOrDamagingEffect(loc9))?-1:this.api.kernel.SpellsBoostsManager.getSpellModificator(loc9,loc4);
				var loc11 = new dofus.datacenter.(loc9,loc8[1],loc8[2],loc8[3],undefined,loc8[4],undefined,loc10);
				if(loc3 == true)
				{
					if(loc11.showInTooltip)
					{
						loc5.push(loc11.description);
					}
				}
				else
				{
					loc5.push(loc11.description);
				}
				loc7 = loc7 + 1;
			}
			return loc5.join(", ");
		}
		return null;
	}
	function getSpellEffects(loc2, loc3)
	{
		var loc4 = new Array();
		var loc5 = loc2.length;
		if(typeof loc2 == "object")
		{
			var loc6 = 0;
			while(loc6 < loc5)
			{
				var loc7 = loc2[loc6];
				var loc8 = loc7[0];
				var loc9 = -1;
				if(loc3 > 0)
				{
					if(this.api.kernel.SpellsBoostsManager.isBoostedHealingEffect(loc8))
					{
						loc9 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_HEAL,loc3);
					}
					else if(this.api.kernel.SpellsBoostsManager.isBoostedDamagingEffect(loc8))
					{
						loc9 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_DMG,loc3);
					}
				}
				var loc10 = new dofus.datacenter.(loc8,loc7[1],loc7[2],loc7[3],loc7[6],loc7[4],undefined,loc9);
				loc10.probability = loc7[5];
				loc4.push(loc10);
				loc6 = loc6 + 1;
			}
			return loc4;
		}
		return null;
	}
	function removeCursor(loc2)
	{
		switch(this.api.datacenter.Game.interactionType)
		{
			case 2:
			case 3:
				if(!this.api.datacenter.Basics.gfx_canLaunch)
				{
					this.api.datacenter.Game.setInteractionType("move");
				}
				this.api.gfx.clearZoneLayer("spell");
				this.api.gfx.clearPointer();
				this.api.gfx.unSelect(true);
				break;
			default:
				if(loc0 !== 5)
				{
					break;
				}
				if(!this.api.datacenter.Basics.gfx_canLaunch)
				{
					this.api.datacenter.Game.setInteractionType("move");
				}
				this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
				this.api.gfx.clearPointer();
				this.api.gfx.unSelectAllButOne("startPosition");
				break;
		}
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoGiveUp":
				this.api.network.Game.leave();
				break;
			case "AskYesNoOfflineExchange":
				this.api.network.Exchange.offlineExchange();
				break;
			case "AskYesNoPunish":
				this.api.network.GameActions.attack(loc2.params.spriteID);
				break;
			default:
				switch(null)
				{
					case "AskYesNoAttack":
						this.api.network.GameActions.attack(loc2.params.spriteID);
						break;
					case "AskYesNoRemoveTaxCollector":
						this.api.network.Guild.removeTaxCollector(loc2.params.spriteID);
				}
		}
	}
	function send(loc2)
	{
		if(loc2.message.length != 0)
		{
			this.api.kernel.Console.process("/w " + loc2.params.playerName + " " + loc2.message);
		}
	}
	function addfriend(loc2)
	{
		this.api.network.Friends.addFriend(loc2.params.playerName);
	}
	function updateCompass(loc2, loc3, loc4)
	{
		var loc5 = this.api.ui.getUIComponent("Banner");
		if(!loc4 && (this.api.datacenter.Basics.banner_targetCoords[0] == loc2 && this.api.datacenter.Basics.banner_targetCoords[1] == loc3) || (_global.isNaN(loc2) || _global.isNaN(loc3)))
		{
			this.api.datacenter.Basics.banner_targetCoords = undefined;
			delete this.api.datacenter.Basics.banner_targetCoords;
			if(loc5.illustrationType != "map")
			{
				loc5.showCircleXtra("artwork",true,{bMask:true});
			}
			return false;
		}
		var loc6 = this.api.datacenter.Map;
		if(loc5.illustrationType != "map")
		{
			loc5.showCircleXtra("compass",true,undefined,{updateOnLoad:false});
		}
		loc5.setCircleXtraParams({allCoords:{targetCoords:[loc2,loc3],currentCoords:[loc6.x,loc6.y]}});
		this.api.datacenter.Basics.banner_targetCoords = [loc2,loc3];
		return true;
	}
	function isItemUseful(loc2, loc3, loc4)
	{
		var loc5 = this.api.lang.getSkillText(loc3).cl;
		var loc6 = 0;
		while(loc6 < loc5.length)
		{
			var loc7 = loc5[loc6];
			var loc8 = this.api.lang.getCraftText(loc7);
			if(loc8.length <= loc4)
			{
				var loc9 = 0;
				while(loc9 < loc8.length)
				{
					if(loc8[loc9][0] == loc2)
					{
						return true;
					}
					loc9 = loc9 + 1;
				}
			}
			loc6 = loc6 + 1;
		}
		return false;
	}
	function analyseReceipts(loc2, loc3, loc4)
	{
		var loc5 = this.api.lang.getSkillText(loc3).cl;
		var loc6 = 0;
		while(loc6 < loc5.length)
		{
			var loc7 = loc5[loc6];
			var loc8 = this.api.lang.getCraftText(loc7);
			if(loc8.length <= loc4)
			{
				var loc9 = 0;
				var loc10 = 0;
				while(loc10 < loc8.length)
				{
					var loc11 = loc8[loc10];
					var loc12 = loc11[0];
					var loc13 = loc11[1];
					var loc14 = loc2.findFirstItem("unicID",loc12);
					if(loc14.index != -1 && loc14.item.Quantity == loc13)
					{
						loc9 = loc9 + 1;
						loc10 = loc10 + 1;
						continue;
					}
					break;
				}
				if(loc9 == loc8.length)
				{
					if(loc2.length == loc8.length)
					{
						return loc7;
					}
					if(loc2.length == loc8.length + 1)
					{
						if(loc2.findFirstItem("unicID",7508).index != -1)
						{
							return loc7;
						}
					}
				}
			}
			loc6 = loc6 + 1;
		}
		return undefined;
	}
	function mergeTwoInventory(loc2, loc3)
	{
		var loc4 = new ank.utils.();
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			loc4.push(loc2[loc5]);
			loc5 = loc5 + 1;
		}
		var loc6 = 0;
		while(loc6 < loc3.length)
		{
			loc4.push(loc3[loc6]);
			loc6 = loc6 + 1;
		}
		return loc4;
	}
	function mergeUnicItemInInventory(inventory)
	{
		var loc3 = new ank.utils.();
		var loc4 = new Object();
		var loc5 = 0;
		while(loc5 < inventory.length)
		{
			var loc6 = inventory[loc5];
			if(loc4[loc6.unicID] == undefined)
			{
				loc4[loc6.unicID] = loc6.clone();
			}
			else
			{
				loc4[loc6.unicID].Quantity = loc4[loc6.unicID].Quantity + loc6.Quantity;
			}
			loc5 = loc5 + 1;
		}
		for(var a in loc4)
		{
			loc3.push(loc4[a]);
		}
		return loc3;
	}
	function getRemainingString(loc2)
	{
		if(loc2 == -1)
		{
			return this.api.lang.getText("OPEN_BETA_ACCOUNT");
		}
		if(loc2 == 0)
		{
			return this.api.lang.getText("SUBSCRIPTION_OUT");
		}
		var loc3 = new Date();
		loc3.setTime(loc2);
		var loc4 = loc3.getUTCFullYear() - 1970;
		var loc5 = loc3.getUTCMonth();
		var loc6 = loc3.getUTCDate() - 1;
		var loc7 = loc3.getUTCHours();
		var loc8 = loc3.getUTCMinutes();
		var loc9 = " " + this.api.lang.getText("AND") + " ";
		var loc10 = this.api.lang.getText("REMAINING_TIME") + " ";
		if(loc4 != 0 && loc5 == 0)
		{
			var loc11 = ank.utils.PatternDecoder.combine(this.api.lang.getText("YEARS"),"m",loc4 == 1);
			loc10 = loc10 + (loc4 + " " + loc11);
		}
		else if(loc4 != 0 && loc5 != 0)
		{
			var loc12 = ank.utils.PatternDecoder.combine(this.api.lang.getText("YEARS"),"m",loc4 == 1);
			var loc13 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",loc5 == 1);
			loc10 = loc10 + (loc4 + " " + loc12 + loc9 + loc5 + " " + loc13);
		}
		else if(loc5 != 0 && loc6 == 0)
		{
			var loc14 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",loc5 == 1);
			loc10 = loc10 + (loc5 + " " + loc14);
		}
		else if(loc5 != 0 && loc6 != 0)
		{
			var loc15 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",loc5 == 1);
			var loc16 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",loc6 == 1);
			loc10 = loc10 + (loc5 + " " + loc15 + loc9 + loc6 + " " + loc16);
		}
		else if(loc6 != 0 && loc7 == 0)
		{
			var loc17 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",loc6 == 1);
			loc10 = loc10 + (loc6 + " " + loc17);
		}
		else if(loc6 != 0 && loc7 != 0)
		{
			var loc18 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",loc6 == 1);
			var loc19 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",loc7 == 1);
			loc10 = loc10 + (loc6 + " " + loc18 + loc9 + loc7 + " " + loc19);
		}
		else if(loc7 != 0 && loc8 == 0)
		{
			var loc20 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",loc7 == 1);
			loc10 = loc10 + (loc7 + " " + loc20);
		}
		else if(loc7 != 0 && loc8 != 0)
		{
			var loc21 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",loc7 == 1);
			var loc22 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",loc8 == 1);
			loc10 = loc10 + (loc7 + " " + loc21 + loc9 + loc8 + " " + loc22);
		}
		else if(loc8 != 0)
		{
			var loc23 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",loc8 == 1);
			loc10 = loc10 + (loc8 + " " + loc23);
		}
		return loc10;
	}
	function zoomGfx(loc2, loc3, loc4, loc5, loc6)
	{
		var loc7 = this.api.gfx.container;
		var loc8 = ank.battlefield.Constants.CELL_WIDTH;
		var loc9 = ank.battlefield.Constants.CELL_HEIGHT;
		if(loc2 != undefined)
		{
			var loc10 = this.api.gfx.screenWidth;
			var loc11 = this.api.gfx.screenHeight;
			if(loc3 == undefined)
			{
				loc3 = loc10 / 2;
			}
			if(loc4 == undefined)
			{
				loc3 = loc11 / 2;
			}
			if(loc5 == undefined)
			{
				loc5 = loc10 / 2;
			}
			if(loc6 == undefined)
			{
				loc6 = loc11 / 2;
			}
			var loc12 = loc3 * loc2 / 100;
			var loc13 = loc4 * loc2 / 100;
			var loc14 = loc5 - loc12;
			var loc15 = loc6 - loc13;
			var loc16 = (this.api.datacenter.Map.width - 1) * loc8 * loc2 / 100;
			var loc17 = (this.api.datacenter.Map.height - 1) * loc9 * loc2 / 100;
			if(loc14 > 0)
			{
				loc14 = 0;
			}
			if(loc14 + loc16 < loc10)
			{
				loc14 = loc10 - loc16;
			}
			if(loc15 > 0)
			{
				loc15 = 0;
			}
			if(loc15 + loc17 < loc11)
			{
				loc15 = loc11 - loc17;
			}
			loc7.zoom(loc2);
			loc7.setXY(loc14,loc15);
		}
		else
		{
			if(!loc7.zoomMap())
			{
				loc7.zoom(100);
			}
			loc7.center();
		}
	}
	function showMonsterPopupMenu(loc2)
	{
		var loc3 = loc2;
		if(loc3 == null)
		{
			return undefined;
		}
		var loc4 = this.api.datacenter.Game.isFight;
		var loc5 = loc3.id;
		var loc6 = loc3.name;
		var loc7 = this.api.ui.createPopupMenu();
		loc7.addStaticItem(loc6);
		if(loc4 && (!this.api.datacenter.Game.isRunning && (loc3.kickable || this.api.datacenter.Player.isAuthorized)))
		{
			loc7.addItem(this.api.lang.getText("KICK"),this.api.network.Game,this.api.network.Game.leave,[loc5]);
		}
		if(loc7.items.length > 1)
		{
			loc7.show(_root._xmouse,_root._ymouse,true);
		}
	}
	function applyCreatureMode()
	{
		if(!this.api.datacenter.Game.isFight && this.api.gfx.isContainerVisible)
		{
			var loc2 = this.api.datacenter.Game.playerCount;
			var loc3 = this.api.kernel.OptionsManager.getOption("CreaturesMode");
			if(loc2 >= loc3)
			{
				this.api.gfx.spriteHandler.setCreatureMode(true);
			}
			else if(loc2 < loc3 - 2)
			{
				this.api.gfx.spriteHandler.setCreatureMode(false);
			}
		}
	}
	function showCellPlayersPopupMenu(loc2)
	{
		var loc3 = false;
		var loc4 = this.api.ui.createPopupMenu();
		for(var k in loc2)
		{
			var loc5 = this.api.gfx.getSprite(k);
			if(loc5 instanceof dofus.datacenter.Character || loc5 instanceof dofus.datacenter.Mutant && loc5.showIsPlayer)
			{
				if(loc5.gfxID != "999")
				{
					loc3 = true;
					var loc6 = loc5.name + " >>";
					loc4.addItem(loc6,this,this.showPlayerPopupMenu,[loc5,undefined]);
				}
			}
		}
		if(loc3)
		{
			loc4.show(_root._xmouse,_root._ymouse,true);
		}
	}
	function showMessagePopupMenu(loc2, loc3, loc4)
	{
		if(this.api.kernel.OptionsManager.getOption("TimestampInChat"))
		{
			loc3 = this.api.kernel.DebugManager.getTimestamp() + " " + loc3;
		}
		var loc5 = this.api.ui.createPopupMenu();
		loc5.addItem(loc2 + " >>",this.api.kernel.GameManager,this.api.kernel.GameManager.showPlayerPopupMenu,[undefined,loc2,null,null,null,loc4,this.api.datacenter.Player.isAuthorized],true);
		loc5.addItem(this.api.lang.getText("COPY"),System,System.setClipboard,[loc3],true);
		loc5.show(_root._xmouse,_root._ymouse,true);
	}
	function showPlayerPopupMenu(loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9)
	{
		if(loc9 == undefined)
		{
			loc9 = false;
		}
		var loc10 = null;
		if(loc2 != undefined)
		{
			loc10 = loc2;
		}
		else if(loc3 != undefined)
		{
			var loc11 = this.api.datacenter.Sprites.getItems();
			for(var a in loc11)
			{
				var loc12 = loc11[a];
				if(loc12.name.toUpperCase() == loc3.toUpperCase())
				{
					loc10 = loc12;
					break;
				}
			}
		}
		else
		{
			return undefined;
		}
		var loc13 = this.api.datacenter.Game.isFight;
		var loc14 = loc10.id;
		var loc15 = loc3 != undefined?loc3:loc10.name;
		if(Key.isDown(Key.SHIFT) && loc15 != this.api.datacenter.Player.Name)
		{
			var loc16 = this.api.ui.getUIComponent("Banner");
			loc16.txtConsole = "/w " + loc15 + " ";
			loc16.placeCursorAtTheEnd();
		}
		else
		{
			if(this.api.datacenter.Player.isAuthorized && !loc9)
			{
				var loc17 = this.api.kernel.AdminManager.getAdminPopupMenu(loc15);
				loc17.addItem(loc15 + " >>",this,this.showPlayerPopupMenu,[loc2,loc3,loc4,loc5,loc6,loc7,loc8,true],true);
				loc17.items.unshift(loc17.items.pop());
			}
			else
			{
				loc17 = this.getPlayerPopupMenu(loc10,loc3,loc4,loc5,loc6,loc7,loc8);
			}
			if(loc17.items.length > 0)
			{
				loc17.show(_root._xmouse,_root._ymouse,true);
			}
		}
	}
	function showTeamAdminPopupMenu(loc2)
	{
		var loc3 = this.api.kernel.AdminManager.getAdminPopupMenu(loc2);
		loc3.show(_root._xmouse,_root._ymouse,true);
	}
	function getDurationString(loc2, loc3)
	{
		if(loc2 <= 0)
		{
			return "-";
		}
		var loc4 = new Date();
		loc4.setTime(loc2);
		var loc5 = loc4.getUTCHours();
		var loc6 = loc4.getUTCMinutes();
		if(loc3 != true)
		{
			return (loc5 == 0?"":loc5 + " " + this.api.lang.getText("HOURS_SMALL") + " ") + loc6 + " " + this.api.lang.getText("MINUTES_SMALL");
		}
		return (loc5 == 0?"":loc5 + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",loc5 < 2) + " ") + loc6 + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",loc6 < 2);
	}
	function insertItemInChat(loc2, loc3, loc4)
	{
		if(loc3 == undefined)
		{
			loc3 = "";
		}
		if(loc4 == undefined)
		{
			loc4 = "";
		}
		if(this.api.datacenter.Basics.chatParams.items == undefined)
		{
			this.api.datacenter.Basics.chatParams.items = new Array();
		}
		if(this.api.lang.getConfigText("CHAT_MAXIMUM_LINKS") == undefined || this.api.datacenter.Basics.chatParams.items.length < this.api.lang.getConfigText("CHAT_MAXIMUM_LINKS"))
		{
			this.api.datacenter.Basics.chatParams.items.push(loc2);
			this.api.ui.getUIComponent("Banner").insertChat(loc3 + "[" + loc2.name + "]" + loc4);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TOO_MANY_ITEM_LINK"),"ERROR_CHAT");
		}
	}
	function getLastModified(loc2)
	{
		var loc3 = this._aLastModified[loc2];
		if(loc3 == undefined || _global.isNaN(loc3))
		{
			return 0;
		}
		return loc3;
	}
	function setAsModified(loc2)
	{
		if(loc2 < 0)
		{
			return undefined;
		}
		this._aLastModified[loc2] = getTimer();
	}
	function getCriticalHitChance(loc2)
	{
		if(loc2 == 0)
		{
			return 0;
		}
		var loc3 = Math.max(0,this.api.datacenter.Player.CriticalHitBonus);
		var loc4 = Math.max(0,this.api.datacenter.Player.AgilityTotal);
		loc2 = loc2 - loc3;
		if(loc4 != 0)
		{
			loc2 = Math.min(loc2,Number(loc2 * (Math.E * 1.1 / Math.log(loc4 + 12))));
		}
		return Math.floor(Math.max(loc2,2));
	}
	function reportSentance(loc2, loc3, loc4, loc5)
	{
		if(loc4 != undefined && (loc4.length > 0 && loc4 != ""))
		{
			this.api.ui.loadUIComponent("AskReportMessage","AskReportMessage" + loc4,{message:this.api.kernel.ChatManager.getMessageFromId(loc4),messageId:loc4,authorId:sID,authorName:loc2});
		}
		else
		{
			this.api.kernel.ChatManager.addToBlacklist(loc2,loc5.gfxID);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[loc2]),"INFO_CHAT");
		}
	}
	function isInMyTeam(loc2)
	{
		if(this.api.datacenter.Basics.aks_current_team == 0)
		{
			var loc3 = 0;
			while(loc3 < this.api.datacenter.Basics.aks_team1_starts.length)
			{
				if(this.api.datacenter.Basics.aks_team1_starts[loc3] == loc2.cellNum)
				{
					return true;
				}
				loc3 = loc3 + 1;
			}
		}
		else if(this.api.datacenter.Basics.aks_current_team == 1)
		{
			var loc4 = 0;
			while(loc4 < this.api.datacenter.Basics.aks_team2_starts.length)
			{
				if(this.api.datacenter.Basics.aks_team2_starts[loc4] == loc2.cellNum)
				{
					return true;
				}
				loc4 = loc4 + 1;
			}
		}
		return false;
	}
	function startInactivityDetector()
	{
		this.stopInactivityDetector();
		this.signalActivity();
		this._nInactivityInterval = _global.setInterval(this,"inactivityCheck",1000);
		this._bFightActivity = false;
		Mouse.addListener(this);
	}
	function signalActivity()
	{
		this._nLastActivity = getTimer();
	}
	function stopInactivityDetector()
	{
		if(this._nInactivityInterval != undefined)
		{
			_global.clearInterval(this._nInactivityInterval);
		}
		this._nLastActivity = undefined;
	}
	function getPlayerPopupMenu(loc2, loc3, loc4, loc5, loc6, loc7, loc8)
	{
		var loc9 = this.api.datacenter.Game.isFight;
		var loc10 = loc2.id;
		var loc11 = loc3 != undefined?loc3:loc2.name;
		var loc12 = this.api.ui.createPopupMenu();
		loc12.addStaticItem(loc11);
		var loc13 = this.api.kernel.ChatManager.isBlacklisted(loc11);
		if(loc13)
		{
			loc12.addStaticItem("(" + this.api.lang.getText("IGNORED_WORD") + ")");
		}
		if(loc9)
		{
			if(!this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant))
			{
				if(loc2 != null && loc10 != this.api.datacenter.Player.ID)
				{
					loc12.addItem(this.api.lang.getText("KICK"),this.api.network.Game,this.api.network.Game.leave,[loc10]);
				}
			}
		}
		if(loc10 == this.api.datacenter.Player.ID)
		{
			loc12.addItem(this.api.lang.getText("HIT_HIMSELF"),this.api.network.Chat,this.api.network.Chat.send,[this.api.lang.getText("SLAP_SENTENCE"),"*"]);
			if(!loc9 && this.api.datacenter.Player.canBeMerchant)
			{
				loc12.addItem(this.api.lang.getText("ORGANIZE_SHOP"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[6]);
				loc12.addItem(this.api.lang.getText("MERCHANT_MODE"),this.api.kernel.GameManager,this.api.kernel.GameManager.offlineExchange);
			}
			if(this.api.datacenter.Player.data.isTomb)
			{
				loc12.addItem(this.api.lang.getText("FREE_MY_SOUL"),this.api.network.Game,this.api.network.Game.freeMySoul);
			}
			else if(!loc9)
			{
				var loc14 = loc2.animation == "static";
				loc12.addItem(this.api.lang.getText("CHANGE_DIRECTION"),this.api.ui,this.api.ui.loadUIComponent,["DirectionChooser","DirectionChooser",{allDirections:this.api.datacenter.Player.canMoveInAllDirections,target:this.api.datacenter.Player.data.mc}]);
			}
		}
		else
		{
			if(loc7 != undefined && (loc7.length > 0 && (loc7 != "" && !loc13)))
			{
				var loc15 = false;
				var loc16 = 0;
				while(loc16 < this.api.lang.getConfigText("ENABLED_SERVER_REPORT_LIST").length)
				{
					if(this.api.lang.getConfigText("ENABLED_SERVER_REPORT_LIST")[loc16] == this.api.datacenter.Basics.aks_current_server.id)
					{
						loc15 = true;
						break;
					}
					loc16 = loc16 + 1;
				}
				if(loc15)
				{
					loc12.addItem(this.api.lang.getText("REPORT_SENTANCE"),this.api.kernel.GameManager,this.api.kernel.GameManager.reportSentance,[loc11,loc10,loc7,loc2]);
				}
			}
			if(!this.api.kernel.ChatManager.isBlacklisted(loc11))
			{
				loc12.addItem(this.api.lang.getText("BLACKLIST_TEMPORARLY"),this.api.kernel.GameManager,this.api.kernel.GameManager.reportSentance,[loc11,loc10,undefined,loc2]);
			}
			else
			{
				loc12.addItem(this.api.lang.getText("BLACKLIST_REMOVE"),this.api.kernel.ChatManager,this.api.kernel.ChatManager.removeToBlacklist,[loc11]);
			}
			if(!loc9 || loc9 && loc3 != undefined)
			{
				loc12.addItem(this.api.lang.getText("WHOIS"),this.api.network.Basics,this.api.network.Basics.whoIs,[loc11]);
				if(loc5 != true)
				{
					loc12.addItem(this.api.lang.getText("ADD_TO_FRIENDS"),this.api.network.Friends,this.api.network.Friends.addFriend,[loc11]);
				}
				if(loc5 != true)
				{
					loc12.addItem(this.api.lang.getText("ADD_TO_ENEMY"),this.api.network.Enemies,this.api.network.Enemies.addEnemy,[loc11]);
				}
				loc12.addItem(this.api.lang.getText("WISPER_MESSAGE"),this.api.kernel.GameManager,this.api.kernel.GameManager.askPrivateMessage,[loc11]);
				if(loc4 == undefined)
				{
					loc12.addItem(this.api.lang.getText("ADD_TO_PARTY"),this.api.network.Party,this.api.network.Party.invite,[loc11]);
				}
				if(this.api.datacenter.Player.guildInfos != undefined)
				{
					if(loc6 != true)
					{
						if(loc2 == null || (loc2 != null && loc2.guildName == undefined || loc2.guildName.length == 0))
						{
							if(this.api.datacenter.Player.guildInfos.playerRights.canInvite)
							{
								loc12.addItem(this.api.lang.getText("INVITE_IN_GUILD"),this.api.network.Guild,this.api.network.Guild.invite,[loc11]);
							}
						}
					}
				}
				if(loc8)
				{
					if(this.api.datacenter.Player.isAuthorized)
					{
						loc12.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.kernel.AdminManager,this.api.kernel.AdminManager.sendCommand,["join " + loc11]);
					}
					else if(this.api.datacenter.Map.superarea == 3)
					{
						loc12.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.network.Friends,this.api.network.Friends.joinFriend,[loc11]);
					}
				}
			}
			if(!loc9 && (loc2 != null && (loc2.gfxID != "999" && !loc5)))
			{
				if(this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
				{
					loc12.addItem(this.api.lang.getText("KICKOFF"),this.api.network.Houses,this.api.network.Houses.kick,[loc10]);
				}
				if(this.api.datacenter.Player.canExchange && loc2.canExchange)
				{
					loc12.addItem(this.api.lang.getText("EXCHANGE"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[1,loc10]);
				}
				if(this.api.datacenter.Player.canChallenge && loc2.canBeChallenge)
				{
					loc12.addItem(this.api.lang.getText("CHALLENGE"),this.api.network.GameActions,this.api.network.GameActions.challenge,[loc10],this.api.datacenter.Map.bCanChallenge);
				}
				if(this.api.datacenter.Player.canAssault && !loc2.showIsPlayer)
				{
					var loc17 = this.api.datacenter.Player.data.alignment.index;
					if(this.api.lang.getAlignmentCanAttack(loc17,loc2.alignment.index))
					{
						loc12.addItem(this.api.lang.getText("ASSAULT"),this.api.kernel.GameManager,this.api.kernel.GameManager.askAttack,[[loc10]],this.api.datacenter.Map.bCanAttack);
					}
				}
				if(this.api.datacenter.Player.canAttack && (loc2.canBeAttack && !loc2.showIsPlayer))
				{
					loc12.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.mutantAttack,[loc2.id]);
				}
				var loc18 = loc2.multiCraftSkillsID;
				if(loc18 != undefined && loc18.length > 0)
				{
					var loc19 = 0;
					while(loc19 < loc18.length)
					{
						var loc20 = Number(loc18[loc19]);
						loc12.addItem(this.api.lang.getText("ASK_TO") + " " + this.api.lang.getSkillText(loc20).d,this.api.network.Exchange,this.api.network.Exchange.request,[13,loc2.id,loc20]);
						loc19 = loc19 + 1;
					}
				}
				else
				{
					loc18 = this.api.datacenter.Player.data.multiCraftSkillsID;
					if(loc18 != undefined && loc18.length > 0)
					{
						var loc21 = 0;
						while(loc21 < loc18.length)
						{
							var loc22 = Number(loc18[loc21]);
							loc12.addItem(this.api.lang.getText("INVITE_TO") + " " + this.api.lang.getSkillText(loc22).d,this.api.network.Exchange,this.api.network.Exchange.request,[12,loc2.id,loc22]);
							loc21 = loc21 + 1;
						}
					}
				}
			}
		}
		if(loc4 != undefined)
		{
			loc4.addPartyMenuItems(loc12);
		}
		if(loc2 != null && (loc2.gfxID != "999" && (loc2.isVisible && (this.api.ui.getUIComponent("Zoom") == undefined && !loc9))))
		{
			loc12.addItem(this.api.lang.getText("ZOOM"),this.api.ui,this.api.ui.loadUIAutoHideComponent,["Zoom","Zoom",{sprite:loc2}]);
		}
		return loc12;
	}
	function inactivityCheck()
	{
		if(this._nLastActivity == undefined || !this.api.kernel.OptionsManager.getOption("RemindTurnTime"))
		{
			return undefined;
		}
		var loc2 = this.api.lang.getConfigText("INACTIVITY_DISPLAY_COUNT");
		if(_global.isNaN(loc2) || loc2 == undefined)
		{
			loc2 = 5;
		}
		if(this.api.datacenter.Basics.inactivity_signaled > loc2)
		{
			return undefined;
		}
		var loc3 = this.api.lang.getConfigText("INACTIVITY_TIMING");
		if(_global.isNaN(loc3) || (loc3 == undefined || loc3 < 1000))
		{
			loc3 = 11000;
		}
		if(this._nLastActivity + loc3 < getTimer())
		{
			if(this.api.datacenter.Game.isFight && (this.api.datacenter.Game.isRunning && this.api.datacenter.Player.isCurrentPlayer))
			{
				if(this.autoSkip)
				{
					this.api.network.Game.turnEnd();
					return undefined;
				}
				this.api.kernel.showMessage(undefined,this.api.lang.getText("INFIGHT_INACTIVITY"),"ERROR_CHAT");
				this.api.kernel.TipsManager.pointGUI("Banner",["_btnNextTurn"]);
				this.api.datacenter.Basics.inactivity_signaled++;
			}
			this.stopInactivityDetector();
		}
	}
	function __get__livingPlayerInCurrentTeam()
	{
		var loc2 = this.api.datacenter.Basics.team(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team);
		var loc3 = 0;
		for(var i in loc2)
		{
			if(loc2[i].LP > 0)
			{
				loc3 = loc3 + 1;
			}
		}
		return loc3;
	}
	function __get__autoSkip()
	{
		return !this._bFightActivity && (this._nFightTurnInactivity > 0 && (this.livingPlayerInCurrentTeam > 1 && this.api.lang.getConfigText("FIGHT_AUTO_SKIP")));
	}
	function signalFightActivity()
	{
		this._bFightActivity = true;
	}
	function onTurnEnd()
	{
		if(!this._bFightActivity && (this.api.lang.getConfigText("FIGHT_AUTO_SKIP") && this.livingPlayerInCurrentTeam > 1))
		{
			this._nFightTurnInactivity++;
			this.api.kernel.showMessage(undefined,this.api.lang.getText("INFIGHT_INACTIVITY_AUTO_SKIP"),"ERROR_CHAT");
		}
		else
		{
			this._nFightTurnInactivity = 0;
		}
	}
	function onMouseMove()
	{
		this._bFightActivity = true;
	}
	function onMouseUp()
	{
		this._bFightActivity = true;
	}
}
