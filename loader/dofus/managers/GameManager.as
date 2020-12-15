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
	function GameManager(oAPI)
	{
		super();
		dofus.managers.GameManager._sSelf = this;
		this.initialize(oAPI);
	}
	function __get__isFullScreen()
	{
		return this._bIsFullScreen;
	}
	function __set__isFullScreen(var2)
	{
		this._bIsFullScreen = var2;
		return this.__get__isFullScreen();
	}
	function __get__isAllowingScale()
	{
		return this._bIsAllowingScale;
	}
	function __set__isAllowingScale(var2)
	{
		this._bIsAllowingScale = var2;
		return this.__get__isAllowingScale();
	}
	function __set__lastSpellLaunch(var2)
	{
		this._nLastSpellLaunch = var2;
		return this.__get__lastSpellLaunch();
	}
	static function getInstance()
	{
		return dofus.managers.GameManager._sSelf;
	}
	function initialize(oAPI)
	{
		super.initialize(oAPI);
		this.api.ui.addEventListener("removeCursor",this);
	}
	function askPrivateMessage(var2)
	{
		var var3 = this.api.ui.loadUIComponent("AskPrivateChat","AskPrivateChat",{title:this.api.lang.getText("WISPER_MESSAGE") + " " + this.api.lang.getText("TO_DESTINATION") + " " + var2,params:{playerName:var2}});
		var3.addEventListener("send",this);
		var3.addEventListener("addfriend",this);
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
	function askOfflineExchange(var2, var3, var4)
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_OFFLINEEXCHANGE",[var2,tax,var4]),"CAUTION_YESNO",{name:"OfflineExchange",listener:this,price:var4});
	}
	function startExchange(var2, var3, var4)
	{
		var var5 = this.api.datacenter.Player.data;
		if(var5.isInMove)
		{
			var5.isInMove = false;
			var5.GameActionsManager.cancel(var5.cellNum,true);
		}
		this.api.network.Exchange.request(var2,Number(var3),var4);
	}
	function startDialog(var2)
	{
		var var3 = this.api.datacenter.Player.data;
		if(var3.isInMove)
		{
			var3.isInMove = false;
			var3.GameActionsManager.cancel(var3.cellNum,true);
		}
		this.api.network.Dialog.create(var2);
	}
	function askAttack(var2)
	{
		var var3 = this.api.datacenter.Sprites.getItemAt(var2);
		var var4 = "";
		if(!this.api.datacenter.Player.rank.enable)
		{
			var4 = var4 + this.api.lang.getText("DO_U_ATTACK_WHEN_PVP_DISABLED");
		}
		if(var3.rank.value == 0)
		{
			if(var4 != "")
			{
				var4 = var4 + "\n\n";
			}
			var4 = var4 + this.api.lang.getText("DO_U_ATTACK_NEUTRAL");
		}
		if(var4 != "")
		{
			var4 = var4 + "\n\n";
		}
		if(!this.api.lang.getConfigText("SHOW_PVP_GAIN_WARNING_POPUP"))
		{
			var3.pvpGain = 0;
		}
		switch(var3.pvpGain)
		{
			case -1:
				var4 = var4 + this.api.lang.getText("DO_U_ATTACK_NO_GAIN",[var3.name]);
				break;
			case 1:
				var4 = var4 + this.api.lang.getText("DO_U_ATTACK_BONUS_GAIN",[var3.name]);
				break;
			default:
				var4 = var4 + this.api.lang.getText("DO_U_ATTACK",[var3.name]);
		}
		this.api.kernel.showMessage(undefined,var4,"CAUTION_YESNO",{name:"Punish",listener:this,params:{spriteID:var2}});
	}
	function askRemoveTaxCollector(var2)
	{
		var var3 = this.api.datacenter.Sprites.getItemAt(var2).name;
		this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_REMOVE_TAXCOLLECTOR",[var3]),"CAUTION_YESNO",{name:"RemoveTaxCollector",listener:this,params:{spriteID:var2}});
	}
	function useRessource(var2, var3, var4)
	{
		var var5 = this.api.datacenter.Player.data.GameActionsManager;
		if(var5 == undefined || var5.isOnUncancelableAction(1))
		{
			return undefined;
		}
		if(this.api.gfx.onCellRelease(var2))
		{
			this.api.network.GameActions.sendActions(500,[var3,var4]);
		}
	}
	function useSkill(var2)
	{
		this.api.network.GameActions.sendActions(507,[var2]);
	}
	function setEnabledInteractionIfICan(var2)
	{
		if(this.api.datacenter.Player.isCurrentPlayer)
		{
			this.api.gfx.setInteraction(var2);
		}
	}
	function cleanPlayer(var2)
	{
		if(var2 != this.api.datacenter.Game.currentPlayerID)
		{
			var var3 = this.api.datacenter.Sprites.getItemAt(var2);
			var3.EffectsManager.nextTurn();
			var3.CharacteristicsManager.nextTurn();
			var3.GameActionsManager.clear();
		}
	}
	function cleanUpGameArea(var2)
	{
		if(var2 && this.api.datacenter.Game.isRunning)
		{
			if(this.api.datacenter.Game.interactionType == dofus.datacenter.Game.INTERACTION_TYPE_SPELL)
			{
				var var3 = this.api.datacenter.Player.currentUseObject;
				if(var3 != null)
				{
					this.switchToSpellLaunch(var3,true);
					return undefined;
				}
			}
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
	function switchToItemTarget(var2)
	{
		if(this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		this.api.gfx.clearPointer();
		this.api.gfx.addPointerShape("C",0,dofus.Constants.CELL_SPELL_EFFECT_COLOR,this.api.datacenter.Player.data.cellNum);
		this.api.datacenter.Player.currentUseObject = var2;
		this.api.datacenter.Game.setInteractionType("target");
		this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
		this.api.ui.setCursor(var2,{width:25,height:25,x:15,y:15});
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
	function switchToSpellLaunch(var2, var3, var4)
	{
		if(var4 != true)
		{
			if(!this.api.datacenter.Game.isRunning)
			{
				return undefined;
			}
			var var5 = this.api.datacenter.Player.data;
			var var6 = var5.sequencer;
			if(var5.isInMove)
			{
				return undefined;
			}
			if(var6.containsAction(var5.GameActionsManager,var5.GameActionsManager.transmittingMove))
			{
				return undefined;
			}
			if(var5.GameActionsManager.isWaiting())
			{
				return undefined;
			}
			if(var5.GameActionsManager.m_bNextAction)
			{
				return undefined;
			}
			if(this._nLastSpellLaunch + dofus.managers.GameManager.MINIMAL_SPELL_LAUNCH_DELAY > getTimer())
			{
				return undefined;
			}
			if(!this.api.datacenter.Player.SpellsManager.checkCanLaunchSpell(var2.ID,undefined))
			{
				if(this.api.datacenter.Basics.spellManager_errorMsg != undefined)
				{
					this.api.kernel.showMessage(undefined,this.api.datacenter.Basics.spellManager_errorMsg,"ERROR_CHAT");
					delete this.api.datacenter.Basics.spellManager_errorMsg;
				}
				return undefined;
			}
		}
		this.api.gfx.mapHandler.resetEmptyCells();
		this.api.datacenter.Player.isCurrentSpellForced = var4;
		delete this.api.datacenter.Basics.interactionsManager_path;
		this.api.gfx.unSelect(true);
		this.api.datacenter.Player.currentUseObject = var2;
		this.api.gfx.clearZoneLayer("spell");
		this.api.gfx.clearPointer();
		var var7 = this.api.datacenter.Player.data.cellNum;
		if(var2.rangeMax != 63)
		{
			var var8 = var2.rangeMax;
			var var9 = var2.rangeMin;
			if(var8 != 0)
			{
				var var10 = !var2.canBoostRange?0:this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + this.api.datacenter.Player.RangeModerator;
				var8 = var8 + var10;
				var8 = Math.max(var9,var8);
			}
			if(var2.lineOnly)
			{
				this.api.gfx.drawZone(var7,var9,var8,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"X");
				this.drawAllowedZone(true,var7,var9,var8);
			}
			else
			{
				this.api.gfx.drawZone(var7,var9,var8,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"C");
				this.drawAllowedZone(false,var7,var9,var8);
			}
		}
		else
		{
			this.api.gfx.drawZone(0,0,100,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"C");
		}
		var var11 = var2.effectZones;
		var var12 = 0;
		while(var12 < var11.length)
		{
			if(!(var11[var12].size >= 63 && var11[var12].shape != "L"))
			{
				this.api.gfx.addPointerShape(var11[var12].shape,var11[var12].size,dofus.Constants.CELL_SPELL_EFFECT_COLOR,var7);
			}
			var12 = var12 + 1;
		}
		if(var3)
		{
			this.api.datacenter.Game.setInteractionType("spell");
		}
		else
		{
			this.api.datacenter.Game.setInteractionType("cc");
		}
		this.api.ui.setCursor(var2,{width:25,height:25,x:15,y:15},true);
		this.api.ui.setCursorForbidden(true,dofus.Constants.FORBIDDEN_FILE);
		this.api.datacenter.Basics.gfx_canLaunch = false;
		dofus.DofusCore.getInstance().forceMouseOver();
	}
	function drawAllowedZone(lineOnly, §\x1e\x17\x1d§, §\f\x13§, §\x1e\x17\t§)
	{
		if(!this.api.kernel.OptionsManager.getOption("AdvancedLineOfSight"))
		{
			return undefined;
		}
		var var6 = this.api.gfx.mapHandler.getCellCount();
		var var7 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(this.api.gfx.mapHandler,var3);
		var var8 = !this.api.datacenter.Player.currentUseObject.canBoostRange?0:this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(19) + this.api.datacenter.Player.RangeModerator;
		var var9 = 0;
		for(; var9 < var6; var9 = var9 + 1)
		{
			var var10 = ank.battlefield.utils.Pathfinding.goalDistance(this.api.gfx.mapHandler,var3,var9);
			if(var10 >= var4 && var10 <= var5)
			{
				if(lineOnly)
				{
					var var11 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(this.api.gfx.mapHandler,var9);
					if(var11.x != var7.x && var11.y != var7.y)
					{
						continue;
					}
				}
				if(this.api.datacenter.Player.SpellsManager.checkCanLaunchSpellOnCell(this.api.gfx.mapHandler,this.api.datacenter.Player.currentUseObject,this.api.gfx.mapHandler.getCellData(var9),var8))
				{
					this.api.gfx.select(var9,26316,"spell",50);
				}
			}
		}
	}
	function showDisgraceSanction()
	{
		var var2 = this.api.datacenter.Player.rank.disgrace;
		if(var2 > 0)
		{
			var var3 = "";
			var var4 = 1;
			while(var4 <= var2)
			{
				var var5 = this.api.lang.getText("DISGRACE_SANCTION_" + var4);
				if(var5 != undefined && (var5 != "undefined" && var5.charAt(0) != "!"))
				{
					var3 = var3 + ("\n\n" + var5);
				}
				var4 = var4 + 1;
			}
			if(var3 != "")
			{
				var3 = this.api.lang.getText("DISGRACE_SANCTION",[ank.utils.PatternDecoder.combine(this.api.lang.getText("POINTS",[var2]),"m",var2 < 2)]) + var3;
				this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),var3,"ERROR_BOX");
			}
		}
	}
	function getSpellDescriptionWithEffects(var2, var3, var4)
	{
		var var5 = new Array();
		var var6 = var2.length;
		if(typeof var2 == "object")
		{
			var var7 = 0;
			while(var7 < var6)
			{
				var var8 = var2[var7];
				var var9 = var8[0];
				var var10 = !(var4 > 0 && this.api.kernel.SpellsBoostsManager.isBoostedHealingOrDamagingEffect(var9))?-1:this.api.kernel.SpellsBoostsManager.getSpellModificator(var9,var4);
				var var11 = new dofus.datacenter.(undefined,var9,var8[1],var8[2],var8[3],undefined,var8[4],undefined,var10);
				if(var3 == true)
				{
					if(var11.showInTooltip)
					{
						var5.push(var11.description);
					}
				}
				else
				{
					var5.push(var11.description);
				}
				var7 = var7 + 1;
			}
			return var5.join(", ");
		}
		return null;
	}
	function getSpellEffects(var2, var3)
	{
		var var4 = new Array();
		var var5 = var2.length;
		if(typeof var2 == "object")
		{
			var var6 = 0;
			while(var6 < var5)
			{
				var var7 = var2[var6];
				var var8 = var7[0];
				var var9 = -1;
				if(var3 > 0)
				{
					if(this.api.kernel.SpellsBoostsManager.isBoostedHealingEffect(var8))
					{
						var9 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_HEAL,var3);
					}
					else if(this.api.kernel.SpellsBoostsManager.isBoostedDamagingEffect(var8))
					{
						var9 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_DMG,var3);
					}
				}
				var var10 = new dofus.datacenter.(undefined,var8,var7[1],var7[2],var7[3],var7[6],var7[4],undefined,var9);
				var10.probability = var7[5];
				var4.push(var10);
				var6 = var6 + 1;
			}
			return var4;
		}
		return null;
	}
	function removeCursor(var2)
	{
		if((var var0 = this.api.datacenter.Game.interactionType) !== 2)
		{
			switch(null)
			{
				case 3:
					break;
				case 5:
					if(!this.api.datacenter.Basics.gfx_canLaunch)
					{
						this.api.datacenter.Game.setInteractionType("move");
					}
					this.api.gfx.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
					this.api.gfx.clearPointer();
					this.api.gfx.unSelectAllButOne("startPosition");
			}
		}
		if(!this.api.datacenter.Basics.gfx_canLaunch)
		{
			this.api.datacenter.Game.setInteractionType("move");
		}
		this.api.gfx.clearZoneLayer("spell");
		this.api.gfx.clearPointer();
		this.api.gfx.unSelect(true);
	}
	function yes(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoGiveUp":
				this.api.network.Game.leave();
				break;
			case "AskYesNoOfflineExchange":
				this.api.network.Exchange.offlineExchange();
				break;
			default:
				switch(null)
				{
					case "AskYesNoPunish":
						this.api.network.GameActions.attack(var2.params.spriteID);
						break;
					case "AskYesNoAttack":
						this.api.network.GameActions.attack(var2.params.spriteID);
						break;
					case "AskYesNoRemoveTaxCollector":
						this.api.network.Guild.removeTaxCollector(var2.params.spriteID);
				}
		}
	}
	function send(var2)
	{
		if(var2.message.length != 0)
		{
			this.api.kernel.Console.process("/w " + var2.params.playerName + " " + var2.message);
		}
	}
	function addfriend(var2)
	{
		this.api.network.Friends.addFriend(var2.params.playerName);
	}
	function updateCompass(nX, nY, §\x19\x19§)
	{
		var var5 = this.api.ui.getUIComponent("Banner");
		if(!var4 && (this.api.datacenter.Basics.banner_targetCoords[0] == nX && this.api.datacenter.Basics.banner_targetCoords[1] == nY) || (_global.isNaN(nX) || _global.isNaN(nY)))
		{
			this.api.datacenter.Basics.banner_targetCoords = undefined;
			delete this.api.datacenter.Basics.banner_targetCoords;
			if(var5.illustrationType != "map")
			{
				var5.showCircleXtra("artwork",true,{bMask:true});
			}
			return false;
		}
		var var6 = this.api.datacenter.Map;
		if(var5.illustrationType != "map")
		{
			var5.showCircleXtra("compass",true,undefined,{updateOnLoad:false});
		}
		var5.setCircleXtraParams({allCoords:{targetCoords:[nX,nY],currentCoords:[var6.x,var6.y]}});
		this.api.datacenter.Basics.banner_targetCoords = [nX,nY];
		return true;
	}
	function isItemUseful(var2, var3, var4)
	{
		var var5 = this.api.lang.getSkillText(var3).cl;
		var var6 = 0;
		while(var6 < var5.length)
		{
			var var7 = var5[var6];
			var var8 = this.api.lang.getCraftText(var7);
			if(var8.length <= var4)
			{
				var var9 = 0;
				while(var9 < var8.length)
				{
					if(var8[var9][0] == var2)
					{
						return true;
					}
					var9 = var9 + 1;
				}
			}
			var6 = var6 + 1;
		}
		return false;
	}
	function analyseReceipts(var2, var3, var4)
	{
		var var5 = this.api.lang.getSkillText(var3).cl;
		var var6 = 0;
		while(var6 < var5.length)
		{
			var var7 = var5[var6];
			var var8 = this.api.lang.getCraftText(var7);
			if(var8.length <= var4)
			{
				var var9 = 0;
				var var10 = 0;
				while(var10 < var8.length)
				{
					var var11 = var8[var10];
					var var12 = var11[0];
					var var13 = var11[1];
					var var14 = var2.findFirstItem("unicID",var12);
					if(var14.index != -1 && var14.item.Quantity == var13)
					{
						var9 = var9 + 1;
						var10 = var10 + 1;
						continue;
					}
					break;
				}
				if(var9 == var8.length)
				{
					if(var2.length == var8.length)
					{
						return var7;
					}
					if(var2.length == var8.length + 1)
					{
						if(var2.findFirstItem("unicID",7508).index != -1)
						{
							return var7;
						}
					}
				}
			}
			var6 = var6 + 1;
		}
		return undefined;
	}
	function mergeTwoInventory(var2, var3)
	{
		var var4 = new ank.utils.();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var4.push(var2[var5]);
			var5 = var5 + 1;
		}
		var var6 = 0;
		while(var6 < var3.length)
		{
			var4.push(var3[var6]);
			var6 = var6 + 1;
		}
		return var4;
	}
	function mergeUnicItemInInventory(inventory)
	{
		var var3 = new ank.utils.();
		var var4 = new Object();
		var var5 = 0;
		while(var5 < inventory.length)
		{
			var var6 = inventory[var5];
			if(var4[var6.unicID] == undefined)
			{
				var4[var6.unicID] = var6.clone();
			}
			else
			{
				var4[var6.unicID].Quantity = var4[var6.unicID].Quantity + var6.Quantity;
			}
			var5 = var5 + 1;
		}
		for(var a in var4)
		{
			var3.push(var4[a]);
		}
		return var3;
	}
	function getRemainingString(var2)
	{
		if(var2 == -1)
		{
			return this.api.lang.getText("OPEN_BETA_ACCOUNT");
		}
		if(var2 == 0)
		{
			return this.api.lang.getText("SUBSCRIPTION_OUT");
		}
		var var3 = new Date();
		var3.setTime(var2);
		var var4 = var3.getUTCFullYear() - 1970;
		var var5 = var3.getUTCMonth();
		var var6 = var3.getUTCDate() - 1;
		var var7 = var3.getUTCHours();
		var var8 = var3.getUTCMinutes();
		var var9 = " " + this.api.lang.getText("AND") + " ";
		var var10 = this.api.lang.getText("REMAINING_TIME") + " ";
		if(var4 != 0 && var5 == 0)
		{
			var var11 = ank.utils.PatternDecoder.combine(this.api.lang.getText("YEARS"),"m",var4 == 1);
			var10 = var10 + (var4 + " " + var11);
		}
		else if(var4 != 0 && var5 != 0)
		{
			var var12 = ank.utils.PatternDecoder.combine(this.api.lang.getText("YEARS"),"m",var4 == 1);
			var var13 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",var5 == 1);
			var10 = var10 + (var4 + " " + var12 + var9 + var5 + " " + var13);
		}
		else if(var5 != 0 && var6 == 0)
		{
			var var14 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",var5 == 1);
			var10 = var10 + (var5 + " " + var14);
		}
		else if(var5 != 0 && var6 != 0)
		{
			var var15 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MONTHS"),"m",var5 == 1);
			var var16 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",var6 == 1);
			var10 = var10 + (var5 + " " + var15 + var9 + var6 + " " + var16);
		}
		else if(var6 != 0 && var7 == 0)
		{
			var var17 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",var6 == 1);
			var10 = var10 + (var6 + " " + var17);
		}
		else if(var6 != 0 && var7 != 0)
		{
			var var18 = ank.utils.PatternDecoder.combine(this.api.lang.getText("DAYS"),"m",var6 == 1);
			var var19 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",var7 == 1);
			var10 = var10 + (var6 + " " + var18 + var9 + var7 + " " + var19);
		}
		else if(var7 != 0 && var8 == 0)
		{
			var var20 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",var7 == 1);
			var10 = var10 + (var7 + " " + var20);
		}
		else if(var7 != 0 && var8 != 0)
		{
			var var21 = ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",var7 == 1);
			var var22 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",var8 == 1);
			var10 = var10 + (var7 + " " + var21 + var9 + var8 + " " + var22);
		}
		else if(var8 != 0)
		{
			var var23 = ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",var8 == 1);
			var10 = var10 + (var8 + " " + var23);
		}
		return var10;
	}
	function zoomGfx(var2, var3, var4, var5, var6)
	{
		var var7 = this.api.gfx.container;
		var var8 = ank.battlefield.Constants.CELL_WIDTH;
		var var9 = ank.battlefield.Constants.CELL_HEIGHT;
		if(var2 != undefined)
		{
			var var10 = this.api.gfx.screenWidth;
			var var11 = this.api.gfx.screenHeight;
			if(var3 == undefined)
			{
				var3 = var10 / 2;
			}
			if(var4 == undefined)
			{
				var3 = var11 / 2;
			}
			if(var5 == undefined)
			{
				var5 = var10 / 2;
			}
			if(var6 == undefined)
			{
				var6 = var11 / 2;
			}
			var var12 = var3 * var2 / 100;
			var var13 = var4 * var2 / 100;
			var var14 = var5 - var12;
			var var15 = var6 - var13;
			var var16 = (this.api.datacenter.Map.width - 1) * var8 * var2 / 100;
			var var17 = (this.api.datacenter.Map.height - 1) * var9 * var2 / 100;
			if(var14 > 0)
			{
				var14 = 0;
			}
			if(var14 + var16 < var10)
			{
				var14 = var10 - var16;
			}
			if(var15 > 0)
			{
				var15 = 0;
			}
			if(var15 + var17 < var11)
			{
				var15 = var11 - var17;
			}
			var7.zoom(var2);
			var7.setXY(var14,var15);
		}
		else
		{
			if(!var7.zoomMap())
			{
				var7.zoom(100);
			}
			var7.center();
		}
	}
	function zoomGfxRoot(var2, var3, var4)
	{
		var var5 = Stage.width;
		var var6 = Stage.height;
		var var7 = var3 * var2 / 100;
		var var8 = var4 * var2 / 100;
		if(var2 <= 100)
		{
			var var9 = 0;
			var var10 = 0;
		}
		else
		{
			var9 = var3 - var7;
			var10 = var4 - var8;
		}
		var var11 = _root;
		var11._xscale = var2;
		var11._yscale = var2;
		var11._x = var9;
		var11._y = var10;
	}
	function showMonsterPopupMenu(var2)
	{
		var var3 = var2;
		if(var3 == null)
		{
			return undefined;
		}
		var var4 = this.api.datacenter.Game.isFight;
		var var5 = var3.id;
		var var6 = var3.name;
		var var7 = this.api.ui.createPopupMenu();
		var7.addStaticItem(var6);
		if(var4 && (!this.api.datacenter.Game.isRunning && (var3.kickable || this.api.datacenter.Player.isAuthorized)))
		{
			var7.addItem(this.api.lang.getText("KICK"),this.api.network.Game,this.api.network.Game.leave,[var5]);
		}
		if(var7.items.length > 1)
		{
			var7.show(_root._xmouse,_root._ymouse,true);
		}
	}
	function applyCreatureMode()
	{
		if(!this.api.datacenter.Game.isFight && this.api.gfx.isContainerVisible)
		{
			var var2 = this.api.datacenter.Game.playerCount;
			var var3 = this.api.kernel.OptionsManager.getOption("CreaturesMode");
			if(var2 >= var3)
			{
				this.api.gfx.spriteHandler.setCreatureMode(true);
			}
			else if(var2 < var3 - 2)
			{
				this.api.gfx.spriteHandler.setCreatureMode(false);
			}
		}
	}
	function showCellPlayersPopupMenu(var2)
	{
		var var3 = false;
		var var4 = this.api.ui.createPopupMenu();
		for(var k in var2)
		{
			var var5 = this.api.gfx.getSprite(k);
			if(var5 instanceof dofus.datacenter.Character || var5 instanceof dofus.datacenter.Mutant && var5.showIsPlayer)
			{
				if(var5.gfxID != "999")
				{
					var3 = true;
					var var6 = var5.name + " >>";
					var4.addItem(var6,this,this.showPlayerPopupMenu,[var5,undefined]);
				}
			}
		}
		if(var3)
		{
			var4.show(_root._xmouse,_root._ymouse,true);
		}
	}
	function __get__lastClickedMessage()
	{
		return this._sLastClickedMessage;
	}
	function showMessagePopupMenu(var2, var3, var4)
	{
		this._sLastClickedMessage = var3;
		var var5 = this.api.ui.createPopupMenu();
		var5.addItem(var2 + " >>",this.api.kernel.GameManager,this.api.kernel.GameManager.showPlayerPopupMenu,[undefined,var2,null,null,null,var4,this.api.datacenter.Player.isAuthorized,null,true],true);
		var5.addItem(this.api.lang.getText("COPY"),System,System.setClipboard,[var3],true);
		var5.show(_root._xmouse,_root._ymouse,true);
	}
	function showPlayerPopupMenu(var2, var3, var4, var5, var6, var7, var8, var9, var10)
	{
		if(!var10)
		{
			this._sLastClickedMessage = undefined;
		}
		if(var9 == undefined)
		{
			var9 = false;
		}
		var var11 = null;
		if(var2 != undefined)
		{
			var11 = var2;
		}
		else if(var3 != undefined)
		{
			var var12 = this.api.datacenter.Sprites.getItems();
			loop0:
			for(var a in var12)
			{
				var var13 = var12[a];
				if(var13.name.toUpperCase() == var3.toUpperCase())
				{
					var11 = var13;
					while(true)
					{
						if(§§pop() == null)
						{
							break loop0;
						}
					}
				}
				else
				{
					continue;
				}
			}
		}
		else
		{
			return undefined;
		}
		var var14 = this.api.datacenter.Game.isFight;
		var var15 = var11.id;
		var var16 = var3 != undefined?var3:var11.name;
		if(Key.isDown(Key.SHIFT) && var16 != this.api.datacenter.Player.Name)
		{
			var var17 = this.api.ui.getUIComponent("Banner");
			var17.txtConsole = "/w " + var16 + " ";
			var17.placeCursorAtTheEnd();
		}
		else
		{
			if(this.api.datacenter.Player.isAuthorized && !var9)
			{
				var var18 = this.api.kernel.AdminManager.getAdminPopupMenu(var16,false);
				var18.addItem(var16 + " >>",this,this.showPlayerPopupMenu,[var2,var3,var4,var5,var6,var7,var8,true],true);
				var18.items.unshift(var18.items.pop());
			}
			else
			{
				var18 = this.getPlayerPopupMenu(var11,var3,var4,var5,var6,var7,var8);
			}
			if(var18.items.length > 0)
			{
				var18.show(_root._xmouse,_root._ymouse,true);
			}
		}
	}
	function showTeamAdminPopupMenu(var2)
	{
		var var3 = this.api.kernel.AdminManager.getAdminPopupMenu(var2,false);
		var3.show(_root._xmouse,_root._ymouse,true);
	}
	function getDurationString(var2, var3)
	{
		if(var2 <= 0)
		{
			return "-";
		}
		var var4 = new Date();
		var4.setTime(var2);
		var var5 = var4.getUTCHours();
		var var6 = var4.getUTCMinutes();
		var var7 = var4.getSeconds();
		if(var3 != true)
		{
			return (var5 == 0?"":var5 + " " + this.api.lang.getText("HOURS_SMALL") + " ") + var6 + " " + this.api.lang.getText("MINUTES_SMALL") + " " + var7 + " " + this.api.lang.getText("SECONDS_SMALL");
		}
		return (var5 == 0?"":var5 + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("HOURS"),"m",var5 < 2) + " ") + var6 + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("MINUTES"),"m",var6 < 2) + " " + var7 + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("SECONDS"),"m",var7 < 2);
	}
	function insertItemInChat(var2, var3, var4)
	{
		if(var3 == undefined)
		{
			var3 = "";
		}
		if(var4 == undefined)
		{
			var4 = "";
		}
		if(this.api.datacenter.Basics.chatParams.items == undefined)
		{
			this.api.datacenter.Basics.chatParams.items = new Array();
		}
		if(this.api.lang.getConfigText("CHAT_MAXIMUM_LINKS") == undefined || this.api.datacenter.Basics.chatParams.items.length < this.api.lang.getConfigText("CHAT_MAXIMUM_LINKS"))
		{
			this.api.datacenter.Basics.chatParams.items.push(var2);
			this.api.ui.getUIComponent("Banner").insertChat(var3 + "[" + var2.name + "]" + var4);
		}
		else
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TOO_MANY_ITEM_LINK"),"ERROR_CHAT");
		}
	}
	function getLastModified(var2)
	{
		var var3 = this._aLastModified[var2];
		if(var3 == undefined || _global.isNaN(var3))
		{
			return 0;
		}
		return var3;
	}
	function setAsModified(var2)
	{
		if(var2 < 0)
		{
			return undefined;
		}
		this._aLastModified[var2] = getTimer();
	}
	function getCriticalHitChance(var2)
	{
		if(var2 == 0)
		{
			return 0;
		}
		var var3 = Math.max(0,this.api.datacenter.Player.CriticalHitBonus);
		var var4 = Math.max(0,this.api.datacenter.Player.AgilityTotal);
		var2 = var2 - var3;
		if(var4 != 0)
		{
			var2 = Math.min(var2,Number(var2 * (Math.E * 1.1 / Math.log(var4 + 12))));
		}
		return Math.floor(Math.max(var2,2));
	}
	function reportSentance(var2, var3, var4, var5)
	{
		if(var4 != undefined && (var4.length > 0 && var4 != ""))
		{
			this.api.ui.loadUIComponent("AskReportMessage","AskReportMessage" + var4,{message:this.api.kernel.ChatManager.getMessageFromId(var4),messageId:var4,authorId:sID,authorName:var2});
		}
		else
		{
			this.api.kernel.ChatManager.addToBlacklist(var2,var5.gfxID);
			this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[var2]),"INFO_CHAT");
		}
	}
	function isInMyTeam(var2)
	{
		if(this.api.datacenter.Basics.aks_current_team == 0)
		{
			var var3 = 0;
			while(var3 < this.api.datacenter.Basics.aks_team1_starts.length)
			{
				if(this.api.datacenter.Basics.aks_team1_starts[var3] == var2.cellNum)
				{
					return true;
				}
				var3 = var3 + 1;
			}
		}
		else if(this.api.datacenter.Basics.aks_current_team == 1)
		{
			var var4 = 0;
			while(var4 < this.api.datacenter.Basics.aks_team2_starts.length)
			{
				if(this.api.datacenter.Basics.aks_team2_starts[var4] == var2.cellNum)
				{
					return true;
				}
				var4 = var4 + 1;
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
	function getPlayerPopupMenu(var2, var3, var4, var5, var6, var7, var8)
	{
		var var9 = this.api.datacenter.Game.isFight;
		var var10 = var2.id;
		var var11 = var3 != undefined?var3:var2.name;
		var var12 = this.api.ui.createPopupMenu();
		var12.addStaticItem(var11);
		var var13 = this.api.kernel.ChatManager.isBlacklisted(var11);
		if(var13)
		{
			var12.addStaticItem("(" + this.api.lang.getText("IGNORED_WORD") + ")");
		}
		if(var9)
		{
			if(!this.api.datacenter.Game.isRunning && (!this.api.datacenter.Player.isMutant || this.api.datacenter.Player.canAttackDungeonMonstersWhenMutant))
			{
				if(var2 != null && var10 != this.api.datacenter.Player.ID)
				{
					var12.addItem(this.api.lang.getText("KICK"),this.api.network.Game,this.api.network.Game.leave,[var10]);
				}
			}
		}
		if(var10 == this.api.datacenter.Player.ID)
		{
			var12.addItem(this.api.lang.getText("HIT_HIMSELF"),this.api.network.Chat,this.api.network.Chat.send,[this.api.lang.getText("SLAP_SENTENCE"),"*"]);
			if(!var9 && this.api.datacenter.Player.canBeMerchant)
			{
				var12.addItem(this.api.lang.getText("ORGANIZE_SHOP"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[6]);
				var12.addItem(this.api.lang.getText("MERCHANT_MODE"),this.api.kernel.GameManager,this.api.kernel.GameManager.offlineExchange);
			}
			if(this.api.datacenter.Player.data.isTomb)
			{
				var12.addItem(this.api.lang.getText("FREE_MY_SOUL"),this.api.network.Game,this.api.network.Game.freeMySoul);
			}
			else if(!var9)
			{
				var var14 = var2.animation == "static";
				var12.addItem(this.api.lang.getText("CHANGE_DIRECTION"),this.api.ui,this.api.ui.loadUIComponent,["DirectionChooser","DirectionChooser",{allDirections:this.api.datacenter.Player.canMoveInAllDirections,target:this.api.datacenter.Player.data.mc}]);
			}
		}
		else
		{
			if(var7 != undefined && (var7.length > 0 && (var7 != "" && !var13)))
			{
				var var15 = false;
				var var16 = 0;
				while(var16 < this.api.lang.getConfigText("ENABLED_SERVER_REPORT_LIST").length)
				{
					if(this.api.lang.getConfigText("ENABLED_SERVER_REPORT_LIST")[var16] == this.api.datacenter.Basics.aks_current_server.id)
					{
						var15 = true;
						break;
					}
					var16 = var16 + 1;
				}
				if(var15)
				{
					var12.addItem(this.api.lang.getText("REPORT_SENTANCE"),this.api.kernel.GameManager,this.api.kernel.GameManager.reportSentance,[var11,var10,var7,var2]);
				}
			}
			if(!this.api.kernel.ChatManager.isBlacklisted(var11))
			{
				var12.addItem(this.api.lang.getText("BLACKLIST_TEMPORARLY"),this.api.kernel.GameManager,this.api.kernel.GameManager.reportSentance,[var11,var10,undefined,var2]);
			}
			else
			{
				var12.addItem(this.api.lang.getText("BLACKLIST_REMOVE"),this.api.kernel.ChatManager,this.api.kernel.ChatManager.removeToBlacklist,[var11]);
			}
			if(!var9 || var9 && var3 != undefined)
			{
				var12.addItem(this.api.lang.getText("WHOIS"),this.api.network.Basics,this.api.network.Basics.whoIs,[var11]);
				if(var5 != true)
				{
					var12.addItem(this.api.lang.getText("ADD_TO_FRIENDS"),this.api.network.Friends,this.api.network.Friends.addFriend,[var11]);
				}
				if(var5 != true)
				{
					var12.addItem(this.api.lang.getText("ADD_TO_ENEMY"),this.api.network.Enemies,this.api.network.Enemies.addEnemy,[var11]);
				}
				var12.addItem(this.api.lang.getText("WISPER_MESSAGE"),this.api.kernel.GameManager,this.api.kernel.GameManager.askPrivateMessage,[var11]);
				if(var4 == undefined)
				{
					var12.addItem(this.api.lang.getText("ADD_TO_PARTY"),this.api.network.Party,this.api.network.Party.invite,[var11]);
				}
				if(this.api.datacenter.Player.guildInfos != undefined)
				{
					if(var6 != true)
					{
						if(var2 == null || (var2 != null && var2.guildName == undefined || var2.guildName.length == 0))
						{
							if(this.api.datacenter.Player.guildInfos.playerRights.canInvite)
							{
								var12.addItem(this.api.lang.getText("INVITE_IN_GUILD"),this.api.network.Guild,this.api.network.Guild.invite,[var11]);
							}
						}
					}
				}
				if(var8)
				{
					if(this.api.datacenter.Player.isAuthorized)
					{
						var12.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.kernel.AdminManager,this.api.kernel.AdminManager.sendCommand,["join " + var11]);
					}
					else if(this.api.datacenter.Map.superarea == 3)
					{
						var12.addItem(this.api.lang.getText("JOIN_SMALL"),this.api.network.Friends,this.api.network.Friends.joinFriend,[var11]);
					}
				}
			}
			if(!var9 && (var2 != null && (var2.gfxID != "999" && !var5)))
			{
				if(this.api.datacenter.Player.isAtHome(this.api.datacenter.Map.id))
				{
					var12.addItem(this.api.lang.getText("KICKOFF"),this.api.network.Houses,this.api.network.Houses.kick,[var10]);
				}
				if(this.api.datacenter.Player.canExchange && var2.canExchange)
				{
					var12.addItem(this.api.lang.getText("EXCHANGE"),this.api.kernel.GameManager,this.api.kernel.GameManager.startExchange,[1,var10]);
				}
				if(this.api.datacenter.Player.canChallenge && var2.canBeChallenge)
				{
					var12.addItem(this.api.lang.getText("CHALLENGE"),this.api.network.GameActions,this.api.network.GameActions.challenge,[var10],this.api.datacenter.Map.bCanChallenge);
				}
				if(this.api.datacenter.Player.canAssault && !var2.showIsPlayer)
				{
					var var17 = this.api.datacenter.Player.data.alignment.index;
					if(this.api.lang.getAlignmentCanAttack(var17,var2.alignment.index))
					{
						var12.addItem(this.api.lang.getText("ASSAULT"),this.api.kernel.GameManager,this.api.kernel.GameManager.askAttack,[[var10]],this.api.datacenter.Map.bCanAttack);
					}
				}
				if(this.api.datacenter.Player.canAttack && (var2.canBeAttack && !var2.showIsPlayer))
				{
					var12.addItem(this.api.lang.getText("ATTACK"),this.api.network.GameActions,this.api.network.GameActions.mutantAttack,[var2.id]);
				}
				var var18 = var2.multiCraftSkillsID;
				if(var18 != undefined && var18.length > 0)
				{
					var var19 = 0;
					while(var19 < var18.length)
					{
						var var20 = Number(var18[var19]);
						var12.addItem(this.api.lang.getText("ASK_TO") + " " + this.api.lang.getSkillText(var20).d,this.api.network.Exchange,this.api.network.Exchange.request,[13,var2.id,var20]);
						var19 = var19 + 1;
					}
				}
				else
				{
					var18 = this.api.datacenter.Player.data.multiCraftSkillsID;
					if(var18 != undefined && var18.length > 0)
					{
						var var21 = 0;
						while(var21 < var18.length)
						{
							var var22 = Number(var18[var21]);
							var12.addItem(this.api.lang.getText("INVITE_TO") + " " + this.api.lang.getSkillText(var22).d,this.api.network.Exchange,this.api.network.Exchange.request,[12,var2.id,var22]);
							var21 = var21 + 1;
						}
					}
				}
			}
		}
		if(var4 != undefined)
		{
			var4.addPartyMenuItems(var12);
		}
		return var12;
	}
	function inactivityCheck()
	{
		if(this._nLastActivity == undefined || !this.api.kernel.OptionsManager.getOption("RemindTurnTime"))
		{
			return undefined;
		}
		var var2 = this.api.lang.getConfigText("INACTIVITY_DISPLAY_COUNT");
		if(_global.isNaN(var2) || var2 == undefined)
		{
			var2 = 5;
		}
		if(this.api.datacenter.Basics.inactivity_signaled > var2)
		{
			return undefined;
		}
		var var3 = this.api.lang.getConfigText("INACTIVITY_TIMING");
		if(_global.isNaN(var3) || (var3 == undefined || var3 < 1000))
		{
			var3 = 11000;
		}
		if(this._nLastActivity + var3 < getTimer())
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
		var var2 = this.api.datacenter.Basics.team(this.api.datacenter.Sprites.getItemAt(this.api.datacenter.Player.ID).Team);
		var var3 = 0;
		for(var i in var2)
		{
			if(var2[i].LP > 0)
			{
				var3 = var3 + 1;
			}
		}
		return var3;
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
