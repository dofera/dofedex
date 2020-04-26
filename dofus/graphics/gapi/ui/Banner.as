class dofus.graphics.gapi.ui.Banner extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Banner";
	static var NO_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	static var INACTIVE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:50,bb:0};
	var _nFightsCount = 0;
	var _bChatAutoFocus = true;
	var _sChatPrefix = "";
	function Banner()
	{
		super();
	}
	function __set__data(loc2)
	{
		this._oData = loc2;
		return this.__get__data();
	}
	function __get__fightsCount()
	{
		return this._nFightsCount;
	}
	function __set__fightsCount(loc2)
	{
		this._nFightsCount = loc2;
		this.updateEye();
		return this.__get__fightsCount();
	}
	function __get__chatAutoFocus()
	{
		return this._bChatAutoFocus;
	}
	function __set__chatAutoFocus(loc2)
	{
		this._bChatAutoFocus = loc2;
		return this.__get__chatAutoFocus();
	}
	function __set__txtConsole(loc2)
	{
		this._txtConsole.text = loc2;
		return this.__get__txtConsole();
	}
	function __get__chat()
	{
		return this._cChat;
	}
	function __get__shortcuts()
	{
		return this._msShortcuts;
	}
	function __get__illustration()
	{
		return this._mcXtra;
	}
	function __get__illustrationType()
	{
		return this._sCurrentCircleXtra;
	}
	function updateEye()
	{
		if(this._btnFights.icon == "")
		{
			this._btnFights.icon = "Eye2";
		}
		var loc2 = this._nFightsCount != 0 && !this.api.datacenter.Game.isFight;
		this._btnFights._visible = loc2;
	}
	function setSelectable(loc2)
	{
		this._cChat.selectable = loc2;
	}
	function insertChat(loc2)
	{
		this._txtConsole.text = this._txtConsole.text + loc2;
	}
	function showNextTurnButton(loc2)
	{
		this._btnNextTurn._visible = loc2;
	}
	function showGiveUpButton(loc2)
	{
		if(loc2)
		{
			this.setXtraFightMask(true);
		}
		this._btnGiveUp._visible = loc2;
	}
	function showPoints(loc2)
	{
		this._pvAP._visible = loc2;
		this._pvMP._visible = loc2;
		this._cChat.showSitDown(!loc2);
		if(loc2)
		{
			this._oData.data.addEventListener("lpChanged",this);
			this._oData.data.addEventListener("apChanged",this);
			this._oData.data.addEventListener("mpChanged",this);
			this.apChanged({value:Math.max(0,this._oData.data.AP)});
			this.mpChanged({value:Math.max(0,this._oData.data.MP)});
		}
	}
	function setXtraFightMask(loc2)
	{
		this._mcChronoGrid._visible = loc2;
		if(!loc2)
		{
			this._mcXtra.setMask(this._mcCircleXtraMaskBig);
			if(this.api.kernel.OptionsManager.getOption("BannerGaugeMode") == "none")
			{
				this._ccChrono.setGaugeChrono(100,2109246);
			}
		}
		else
		{
			this._mcXtra.setMask(this._mcCircleXtraMask);
		}
		this.displayMovableBar(this.api.kernel.OptionsManager.getOption("MovableBar") && (!this.api.kernel.OptionsManager.getOption("HideSpellBar") || this.api.datacenter.Game.isFight));
	}
	function showCircleXtra(loc2, loc3, loc4, loc5)
	{
		if(loc2 == undefined)
		{
			return null;
		}
		if(loc2 == this._sCurrentCircleXtra && loc3)
		{
			return null;
		}
		if(loc2 != this._sCurrentCircleXtra && !loc3)
		{
			return null;
		}
		if(this._sCurrentCircleXtra != undefined && loc3)
		{
			this.showCircleXtra(this._sCurrentCircleXtra,false);
		}
		var loc8 = new Object();
		var loc9 = new Array();
		if(loc5 == undefined)
		{
			loc5 = new Object();
		}
		this.api.kernel.OptionsManager.setOption("BannerIllustrationMode",loc2);
		switch(loc2)
		{
			case "artwork":
				var loc10 = dofus.Constants.GUILDS_FACES_PATH + this.api.datacenter.Player.Guild + this.api.datacenter.Player.Sex + ".swf";
				var loc6 = "Loader";
				loc8 = {_x:this._mcCircleXtraMask._x,_y:this._mcCircleXtraMask._y,fallbackContentPath:loc10,contentPath:dofus.Constants.GUILDS_FACES_PATH + this._oData.data.gfxID + ".swf",enabled:true};
				loc9 = ["complete","click"];
				break;
			case "compass":
				var loc11 = this.api.datacenter.Map;
				loc6 = "Compass";
				loc8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height,arrow:"UI_BannerCompassArrow",noArrow:"UI_BannerCompassNoArrow",background:"UI_BannerCompassBack",targetCoords:this.api.datacenter.Basics.banner_targetCoords,currentCoords:[loc11.x,loc11.y]};
				loc9 = ["click","over","out"];
				break;
			case "clock":
				loc6 = "Clock";
				loc8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height,arrowHours:"UI_BannerClockArrowHours",arrowMinutes:"UI_BannerClockArrowMinutes",background:"UI_BannerClockBack",updateFunction:{object:this.api.kernel.NightManager,method:this.api.kernel.NightManager.getCurrentTime}};
				loc9 = ["click","over","out"];
				break;
			case "helper":
				loc6 = "Loader";
				if(dofus.Constants.DOUBLEFRAMERATE)
				{
					loc8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Helper_DoubleFramerate",enabled:true};
				}
				else
				{
					loc8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Helper",enabled:true};
				}
				loc9 = ["click","over","out"];
				break;
			case "map":
				loc6 = "MiniMap";
				loc8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Map",enabled:true};
				loc9 = [];
				break;
			default:
				loc6 = "Loader";
				loc8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height};
		}
		var loc12 = null;
		if(loc3)
		{
			for(var k in loc8)
			{
				loc5[k] = loc8[k];
			}
			loc12 = this.attachMovie(loc6,"_mcXtra",this.getNextHighestDepth(),loc5);
			this._sCurrentCircleXtra = loc2;
			if(loc4.bMask)
			{
				this._sDefaultMaskType = loc4.sMaskSize;
				if(!this.api.datacenter.Game.isFight && this.api.kernel.OptionsManager.getOption("BannerGaugeMode") == "none")
				{
					this._mcXtra.setMask(this._mcCircleXtraMaskBig);
				}
				else
				{
					this._mcXtra.setMask(this._mcCircleXtraMask);
				}
			}
			for(var k in loc9)
			{
				this._mcXtra.addEventListener(loc9[k],this);
			}
			this._mcXtra.swapDepths(this._mcCircleXtraPlacer);
		}
		else if(this._mcXtra != undefined)
		{
			for(var k in loc9)
			{
				this._mcXtra.removeEventListener(loc9[k],this);
			}
			this._mcCircleXtraPlacer.swapDepths(this._mcXtra);
			this._mcXtra.removeMovieClip();
			delete this._sCurrentCircleXtra;
		}
		return loc12;
	}
	function setCircleXtraParams(loc2)
	{
		for(var k in loc2)
		{
			this._mcXtra[k] = loc2[k];
		}
	}
	function startTimer(loc2)
	{
		this.setXtraFightMask(true);
		this._ccChrono.startTimer(loc2);
	}
	function redrawChrono()
	{
		this._ccChrono.redraw();
	}
	function stopTimer()
	{
		this._ccChrono.stopTimer();
	}
	function setChatText(loc2)
	{
		this._cChat.setText(loc2);
	}
	function showRightPanel(loc2, loc3, loc4, loc5)
	{
		if(this.api.datacenter.Game.isSpectator && this._mcRightPanel.bMouseSpriteRollover == true)
		{
			return undefined;
		}
		if(this._mcRightPanel.className == loc2 && !(this.api.datacenter.Game.isSpectator && loc4 == true))
		{
			return undefined;
		}
		if(!(this.api.datacenter.Game.isSpectator && loc4 != true))
		{
			if(this._mcRightPanel.className == loc2)
			{
				this._mcRightPanel.update(loc3.data);
			}
			else
			{
				if(this._mcRightPanel != undefined)
				{
					this.hideRightPanel(true);
				}
				loc3._x = this._mcRightPanelPlacer._x;
				loc3._y = this._mcRightPanelPlacer._y;
				var loc6 = this.attachMovie(loc2,"_mcRightPanel",this.getNextHighestDepth(),loc3);
				loc6.swapDepths(this._mcRightPanelPlacer);
				loc6.parent = this;
				loc6.onRollOver = function()
				{
					this.parent.hideRightPanel(true);
				};
			}
			this._mcRightPanel.bMouseSpriteRollover = loc5;
		}
	}
	function hideRightPanel(loc2, loc3)
	{
		if(loc3)
		{
			this._mcRightPanel.bMouseSpriteRollover = false;
		}
		if(this._mcRightPanel != undefined && !(this.api.datacenter.Game.isSpectator && loc2 != true))
		{
			this._mcRightPanel.swapDepths(this._mcRightPanelPlacer);
			this._mcRightPanel.removeMovieClip();
		}
	}
	function updateSmileysEmotes()
	{
		this._cChat.updateSmileysEmotes();
	}
	function showSmileysEmotesPanel(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = true;
		}
		this._cChat.hideSmileys(!loc2);
		this._cChat._btnSmileys.selected = loc2;
	}
	function updateLocalPlayer()
	{
		if(this._sCurrentCircleXtra == "artwork")
		{
			var loc2 = dofus.Constants.GUILDS_FACES_PATH + this.api.datacenter.Player.Guild + this.api.datacenter.Player.Sex + ".swf";
			this._mcXtra.fallbackContentPath = loc2;
			this._mcXtra.contentPath = dofus.Constants.GUILDS_FACES_PATH + this._oData.data.gfxID + ".swf";
		}
		this._msShortcuts.meleeVisible = !this._oData.isMutant && this._msShortcuts.currentTab == dofus.graphics.gapi.controls.MouseShortcuts.TAB_SPELLS;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Banner.CLASS_NAME);
	}
	function createChildren()
	{
		this._btnFights._visible = false;
		this.addToQueue({object:this,method:this.hideEpisodicContent});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.showPoints(false);
		this.showNextTurnButton(false);
		this.showGiveUpButton(false);
		this._mcRightPanelPlacer._visible = false;
		this._mcCircleXtraPlacer._visible = false;
		this.api.ui.unloadUIComponent("FightOptionButtons");
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		this.api.kernel.KeyManager.addKeysListener("onKeys",this);
		this.api.kernel.SpeakingItemsManager.triggerEvent(dofus.managers.SpeakingItemsManager.SPEAK_TRIGGER_ON_CONNECT);
		this.api.network.Game.nLastMapIdReceived = -1;
		this._txtConsole.onSetFocus = function()
		{
			this._parent.onSetFocus();
		};
		this._txtConsole.onKillFocus = function()
		{
			this._parent.onKillFocus();
		};
		this._txtConsole.maxChars = dofus.Constants.MAX_MESSAGE_LENGTH + dofus.Constants.MAX_MESSAGE_LENGTH_MARGIN;
		ank.battlefield.Battlefield.useCacheAsBitmapOnStaticAnim = this.api.lang.getConfigText("USE_CACHEASBITMAP_ON_STATICANIM");
	}
	function linkMovableContainer()
	{
		var loc2 = this._mcbMovableBar.containers;
		var loc3 = 0;
		while(loc3 < loc2.length)
		{
			var loc4 = loc2[loc3];
			this._msShortcuts.setContainer(loc3 + 15,loc4);
			loc4.addEventListener("click",this);
			loc4.addEventListener("dblClick",this);
			loc4.addEventListener("over",this);
			loc4.addEventListener("out",this);
			loc4.addEventListener("drag",this);
			loc4.addEventListener("drop",this);
			loc4.params = {position:loc3 + 15};
			loc3 = loc3 + 1;
		}
	}
	function addListeners()
	{
		this._btnPvP.addEventListener("click",this);
		this._btnMount.addEventListener("click",this);
		this._btnGuild.addEventListener("click",this);
		this._btnStatsJob.addEventListener("click",this);
		this._btnSpells.addEventListener("click",this);
		this._btnInventory.addEventListener("click",this);
		this._btnQuests.addEventListener("click",this);
		this._btnMap.addEventListener("click",this);
		this._btnFriends.addEventListener("click",this);
		this._btnFights.addEventListener("click",this);
		this._btnHelp.addEventListener("click",this);
		this._btnPvP.addEventListener("over",this);
		this._btnMount.addEventListener("over",this);
		this._btnGuild.addEventListener("over",this);
		this._btnStatsJob.addEventListener("over",this);
		this._btnSpells.addEventListener("over",this);
		this._btnInventory.addEventListener("over",this);
		this._btnQuests.addEventListener("over",this);
		this._btnMap.addEventListener("over",this);
		this._btnFriends.addEventListener("over",this);
		this._btnFights.addEventListener("over",this);
		this._btnHelp.addEventListener("over",this);
		this._btnPvP.addEventListener("out",this);
		this._btnMount.addEventListener("out",this);
		this._btnGuild.addEventListener("out",this);
		this._btnStatsJob.addEventListener("out",this);
		this._btnSpells.addEventListener("out",this);
		this._btnInventory.addEventListener("out",this);
		this._btnQuests.addEventListener("out",this);
		this._btnMap.addEventListener("out",this);
		this._btnFriends.addEventListener("out",this);
		this._btnFights.addEventListener("out",this);
		this._btnHelp.addEventListener("out",this);
		this._btnStatsJob.tabIndex = 0;
		this._btnSpells.tabIndex = 1;
		this._btnInventory.tabIndex = 2;
		this._btnQuests.tabIndex = 3;
		this._btnMap.tabIndex = 4;
		this._btnFriends.tabIndex = 5;
		this._btnGuild.tabIndex = 6;
		this._ccChrono.addEventListener("finalCountDown",this);
		this._ccChrono.addEventListener("beforeFinalCountDown",this);
		this._ccChrono.addEventListener("tictac",this);
		this._ccChrono.addEventListener("finish",this);
		this._cChat.addEventListener("filterChanged",this);
		this._cChat.addEventListener("selectSmiley",this);
		this._cChat.addEventListener("selectEmote",this);
		this._cChat.addEventListener("href",this);
		this._oData.addEventListener("lpChanged",this);
		this._oData.addEventListener("lpMaxChanged",this);
		this._btnNextTurn.addEventListener("click",this);
		this._btnNextTurn.addEventListener("over",this);
		this._btnNextTurn.addEventListener("out",this);
		this._btnGiveUp.addEventListener("click",this);
		this._btnGiveUp.addEventListener("over",this);
		this._btnGiveUp.addEventListener("out",this);
		this._oData.SpellsManager.addEventListener("spellLaunched",this);
		this._oData.SpellsManager.addEventListener("nextTurn",this);
		this._pvAP.addEventListener("over",this);
		this._pvAP.addEventListener("out",this);
		this._pvMP.addEventListener("over",this);
		this._pvMP.addEventListener("out",this);
		this._oData.Spells.addEventListener("modelChanged",this);
		this._oData.Inventory.addEventListener("modelChanged",this);
		this._hHeart.onRollOver = function()
		{
			this._parent.over({target:this});
		};
		this._hHeart.onRollOut = function()
		{
			this._parent.out({target:this});
		};
		this._hHeart.onRelease = function()
		{
			this.toggleDisplay();
		};
	}
	function initData()
	{
		switch(this.api.kernel.OptionsManager.getOption("BannerIllustrationMode"))
		{
			case "artwork":
				this.showCircleXtra("artwork",true,{bMask:true});
				break;
			case "clock":
				this.showCircleXtra("clock",true,{bMask:true});
				break;
			default:
				switch(null)
				{
					case "compass":
						this.showCircleXtra("compass",true);
					case "helper":
						this.showCircleXtra("helper",true);
					case "map":
						this.showCircleXtra("map",true,{bMask:true});
				}
		}
		this.drawBar();
		this.lpMaxChanged({value:this._oData.LPmax});
		this.lpChanged({value:this._oData.LP});
		this.api.kernel.ChatManager.refresh();
		this.setGaugeMode(this.api.kernel.OptionsManager.getOption("BannerGaugeMode"));
		if(this.api.kernel.OptionsManager.getOption("MovableBar"))
		{
			this.displayMovableBar(this.api.kernel.OptionsManager.getOption("MovableBar") && (!this.api.kernel.OptionsManager.getOption("HideSpellBar") || this.api.datacenter.Game.isFight));
		}
	}
	function setChatFocus()
	{
		Selection.setFocus(this._txtConsole);
	}
	function isChatFocus()
	{
		return eval(Selection.getFocus())._name == "_txtConsole";
	}
	function placeCursorAtTheEnd()
	{
		Selection.setFocus(this._txtConsole);
		Selection.setSelection(this._txtConsole.text.length,dofus.Constants.MAX_MESSAGE_LENGTH + dofus.Constants.MAX_MESSAGE_LENGTH_MARGIN);
	}
	function setChatFocusWithLastKey()
	{
		if(!this._bChatAutoFocus)
		{
			return undefined;
		}
		if(Selection.getFocus() != undefined)
		{
			return undefined;
		}
		this.setChatFocus();
		this.placeCursorAtTheEnd();
	}
	function setChatPrefix(loc2)
	{
		this._sChatPrefix = loc2;
		if(loc2 != "")
		{
			this._btnHelp.label = loc2;
			this._btnHelp.icon = "";
		}
		else
		{
			this._btnHelp.label = "";
			this._btnHelp.icon = "UI_BannerChatCommandAll";
		}
		this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
	}
	function getChatCommand()
	{
		var loc2 = this._txtConsole.text;
		var loc3 = loc2.split(" ");
		if(loc3[0].charAt(0) == "/")
		{
			return loc2;
		}
		if(this._sChatPrefix != "")
		{
			return this._sChatPrefix + " " + loc2;
		}
		return loc2;
	}
	function hideEpisodicContent()
	{
		this._btnPvP._visible = this.api.datacenter.Basics.aks_current_regional_version >= 16;
		this._btnMount._visible = this.api.datacenter.Basics.aks_current_regional_version >= 20;
		this._btnGuild._visible = !this.api.config.isStreaming;
		var loc2 = this._btnStatsJob._x;
		var loc3 = this._btnPvP._x;
		var loc4 = new Array();
		loc4.push(this._btnStatsJob);
		loc4.push(this._btnSpells);
		loc4.push(this._btnInventory);
		loc4.push(this._btnQuests);
		loc4.push(this._btnMap);
		loc4.push(this._btnFriends);
		if(this._btnGuild._visible)
		{
			loc4.push(this._btnGuild);
		}
		if(this._btnMount._visible)
		{
			loc4.push(this._btnMount);
		}
		if(this._btnPvP._visible)
		{
			loc4.push(this._btnPvP);
		}
		var loc5 = (loc3 - loc2) / (loc4.length - 1);
		var loc6 = 0;
		while(loc6 < loc4.length)
		{
			loc4[loc6]._x = loc6 * loc5 + loc2;
			loc6 = loc6 + 1;
		}
	}
	function displayChatHelp()
	{
		this.api.kernel.Console.process("/help");
		this._cChat.open(false);
	}
	function setGaugeMode(loc2)
	{
		var loc3 = this.api.kernel.OptionsManager.getOption("BannerGaugeMode");
		switch(loc3)
		{
			case "xp":
				this.api.datacenter.Player.removeEventListener("xpChanged",this);
				break;
			case "xpmount":
				this.api.datacenter.Player.removeEventListener("mountChanged",this);
				break;
			case "pods":
				this.api.datacenter.Player.removeEventListener("currentWeightChanged",this);
				break;
			case "energy":
				this.api.datacenter.Player.removeEventListener("energyChanged",this);
				break;
			case "xpcurrentjob":
				this.api.datacenter.Player.removeEventListener("currentJobChanged",this);
		}
		this.api.kernel.OptionsManager.setOption("BannerGaugeMode",loc2);
		switch(loc2)
		{
			case "xp":
				this.api.datacenter.Player.addEventListener("xpChanged",this);
				break;
			case "xpmount":
				this.api.datacenter.Player.addEventListener("mountChanged",this);
				break;
			default:
				switch(null)
				{
					case "pods":
						this.api.datacenter.Player.addEventListener("currentWeightChanged",this);
						break;
					case "energy":
						this.api.datacenter.Player.addEventListener("energyChanged",this);
						break;
					case "xpcurrentjob":
						this.api.datacenter.Player.addEventListener("currentJobChanged",this);
				}
		}
		this.showGaugeMode();
	}
	function showGaugeModeSelectMenu()
	{
		var loc2 = this.api.kernel.OptionsManager.getOption("BannerGaugeMode");
		var loc3 = this.api.ui.createPopupMenu();
		loc3.addItem(this.api.lang.getText("DISABLE"),this,this.setGaugeMode,["none"],loc2 != "none");
		loc3.addItem(this.api.lang.getText("WORD_XP"),this,this.setGaugeMode,["xp"],loc2 != "xp");
		loc3.addItem(this.api.lang.getText("WORD_XP") + " " + this.api.lang.getText("JOB"),this,this.setGaugeMode,["xpcurrentjob"],loc2 != "xpcurrentjob");
		loc3.addItem(this.api.lang.getText("WORD_XP") + " " + this.api.lang.getText("MOUNT"),this,this.setGaugeMode,["xpmount"],loc2 != "xpmount");
		loc3.addItem(this.api.lang.getText("WEIGHT"),this,this.setGaugeMode,["pods"],loc2 != "pods");
		loc3.addItem(this.api.lang.getText("ENERGY"),this,this.setGaugeMode,["energy"],loc2 != "energy");
		loc3.show(_root._xmouse,_root._ymouse,true);
	}
	function xpChanged()
	{
		this.showGaugeMode();
	}
	function energyChanged()
	{
		this.showGaugeMode();
	}
	function currentWeightChanged()
	{
		this.showGaugeMode();
	}
	function mountChanged()
	{
		this.showGaugeMode();
	}
	function currentJobChanged()
	{
		this.showGaugeMode();
	}
	function showGaugeMode()
	{
		if(this.api.datacenter.Game.isFight)
		{
			return undefined;
		}
		var loc2 = this.api.kernel.OptionsManager.getOption("BannerGaugeMode");
		if(loc2 == "none")
		{
			this.setXtraFightMask(false);
			return undefined;
		}
		this.setXtraFightMask(true);
		if((var loc0 = loc2) !== "xp")
		{
			switch(null)
			{
				case "xpmount":
					if(this.api.datacenter.Player.mount == undefined)
					{
						var loc3 = 0;
					}
					else
					{
						loc3 = Math.floor((this.api.datacenter.Player.mount.xp - this.api.datacenter.Player.mount.xpMin) / (this.api.datacenter.Player.mount.xpMax - this.api.datacenter.Player.mount.xpMin) * 100);
					}
					var loc4 = 8298148;
					break;
				case "pods":
					loc3 = Math.floor(this.api.datacenter.Player.currentWeight / this.api.datacenter.Player.maxWeight * 100);
					loc4 = 6340148;
					break;
				case "energy":
					if(this.api.datacenter.Player.EnergyMax == -1)
					{
						loc3 = 0;
					}
					else
					{
						loc3 = Math.floor(this.api.datacenter.Player.Energy / this.api.datacenter.Player.EnergyMax * 100);
					}
					loc4 = 10994717;
					break;
				case "xpcurrentjob":
					var loc5 = this.api.datacenter.Player.currentJobID;
					if(loc5 != undefined)
					{
						var loc6 = this.api.datacenter.Player.Jobs.findFirstItem("id",loc5).item;
						if(loc6.xpMax != -1)
						{
							loc3 = Math.floor((loc6.xp - loc6.xpMin) / (loc6.xpMax - loc6.xpMin) * 100);
						}
						else
						{
							loc3 = 0;
						}
					}
					else
					{
						loc3 = 0;
					}
					loc4 = 10441125;
			}
		}
		else
		{
			loc3 = Math.floor((this.api.datacenter.Player.XP - this.api.datacenter.Player.XPlow) / (this.api.datacenter.Player.XPhigh - this.api.datacenter.Player.XPlow) * 100);
			loc4 = 8298148;
		}
		if(!_global.isNaN(loc4))
		{
			if(_global.isNaN(loc3))
			{
				loc3 = 0;
			}
			this._ccChrono.setGaugeChrono(loc3,loc4);
		}
	}
	function displayMovableBar(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = this._mcbMovableBar == undefined;
		}
		if(loc2)
		{
			if(this._mcbMovableBar._name != undefined)
			{
				return undefined;
			}
			this._mcbMovableBar = (dofus.graphics.gapi.ui.MovableContainerBar)this.api.ui.loadUIComponent("MovableContainerBar","MovableBar",[],{bAlwaysOnTop:true});
			this._mcbMovableBar.addEventListener("drawBar",this);
			this._mcbMovableBar.addEventListener("drop",this);
			this._mcbMovableBar.addEventListener("dblClick",this);
			var loc3 = {left:0,top:0,right:this.gapi.screenWidth,bottom:this.gapi.screenHeight};
			var loc4 = this.api.kernel.OptionsManager.getOption("MovableBarSize");
			var loc5 = this.api.kernel.OptionsManager.getOption("MovableBarCoord");
			loc5 = !loc5?{x:0,y:(this.gapi.screenHeight - this._mcbMovableBar._height) / 2}:loc5;
			this.addToQueue({object:this._mcbMovableBar,method:this._mcbMovableBar.setOptions,params:[9,20,loc3,loc4,loc5]});
		}
		else
		{
			this.api.ui.unloadUIComponent("MovableBar");
		}
	}
	function setMovableBarSize(loc2)
	{
		this._mcbMovableBar.size = loc2;
	}
	function onKeys(loc2)
	{
		if(this._lastKeyIsShortcut)
		{
			this._lastKeyIsShortcut = false;
			return undefined;
		}
		this.setChatFocusWithLastKey();
	}
	function onShortcut(loc2)
	{
		var loc3 = true;
		loop1:
		switch(loc2)
		{
			case "CTRL_STATE_CHANGED_ON":
				if(this._bIsOnFocus && !(this.api.config.isLinux || this.api.config.isMac))
				{
					getURL("FSCommand:" add "trapallkeys","false");
				}
				break;
			case "CTRL_STATE_CHANGED_OFF":
				if(this._bIsOnFocus && !(this.api.config.isLinux || this.api.config.isMac))
				{
					getURL("FSCommand:" add "trapallkeys","true");
				}
				break;
			default:
				switch(null)
				{
					case "ESCAPE":
						if(this.isChatFocus())
						{
							Selection.setFocus(null);
							loc3 = false;
						}
						break loop1;
					case "SEND_CHAT_MSG":
						if(this.isChatFocus())
						{
							if(this._txtConsole.text.length != 0)
							{
								this.api.kernel.Console.process(this.getChatCommand(),this.api.datacenter.Basics.chatParams);
								this.api.datacenter.Basics.chatParams = new Object();
								if(this._txtConsole.text != undefined)
								{
									this._txtConsole.text = "";
								}
								loc3 = false;
							}
						}
						else if(Selection.getFocus() == undefined && this._bChatAutoFocus)
						{
							this.setChatFocus();
						}
						break loop1;
					case "TEAM_MESSAGE":
						if(this.isChatFocus())
						{
							if(this._txtConsole.text.length != 0)
							{
								var loc4 = this.getChatCommand();
								if(loc4.charAt(0) == "/")
								{
									loc4 = loc4.substr(loc4.indexOf(" ") + 1);
								}
								this.api.kernel.Console.process("/t " + loc4,this.api.datacenter.Basics.chatParams);
								this.api.datacenter.Basics.chatParams = new Object();
								if(this._txtConsole.text != undefined)
								{
									this._txtConsole.text = "";
								}
								loc3 = false;
							}
						}
						else if(Selection.getFocus() == undefined && this._bChatAutoFocus)
						{
							this.setChatFocus();
						}
						break loop1;
					case "GUILD_MESSAGE":
						if(this.isChatFocus())
						{
							if(this._txtConsole.text.length != 0)
							{
								var loc5 = this.getChatCommand();
								if(loc5.charAt(0) == "/")
								{
									loc5 = loc5.substr(loc5.indexOf(" ") + 1);
								}
								this.api.kernel.Console.process("/g " + loc5,this.api.datacenter.Basics.chatParams);
								this.api.datacenter.Basics.chatParams = new Object();
								if(this._txtConsole.text != undefined)
								{
									this._txtConsole.text = "";
								}
								loc3 = false;
							}
						}
						else if(Selection.getFocus() == undefined && this._bChatAutoFocus)
						{
							this.setChatFocus();
						}
						break loop1;
					case "WHISPER_HISTORY_UP":
						if(this.isChatFocus())
						{
							this._txtConsole.text = this.api.kernel.Console.getWhisperHistoryUp();
							this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
							loc3 = false;
						}
						break loop1;
					default:
						switch(null)
						{
							case "WHISPER_HISTORY_DOWN":
								if(this.isChatFocus())
								{
									this._txtConsole.text = this.api.kernel.Console.getWhisperHistoryDown();
									this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
									loc3 = false;
								}
								break loop1;
							case "HISTORY_UP":
								if(this.isChatFocus())
								{
									var loc6 = this.api.kernel.Console.getHistoryUp();
									if(loc6 != undefined)
									{
										this.api.datacenter.Basics.chatParams = loc6.params;
										this._txtConsole.text = loc6.value;
									}
									this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
									loc3 = false;
								}
								break loop1;
							case "HISTORY_DOWN":
								if(this.isChatFocus())
								{
									var loc7 = this.api.kernel.Console.getHistoryDown();
									if(loc7 != undefined)
									{
										this.api.datacenter.Basics.chatParams = loc7.params;
										this._txtConsole.text = loc7.value;
									}
									else
									{
										this._txtConsole.text = "";
									}
									this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
									loc3 = false;
								}
								break loop1;
							case "AUTOCOMPLETE":
								var loc8 = new Array();
								var loc9 = this.api.datacenter.Sprites.getItems();
								for(var k in loc9)
								{
									if(loc9[k] instanceof dofus.datacenter.Character)
									{
										loc8.push(loc9[k].name);
									}
								}
								var loc10 = this.api.kernel.Console.autoCompletion(loc8,this._txtConsole.text);
								if(!loc10.isFull)
								{
									if(loc10.list == undefined || loc10.list.length == 0)
									{
										this.api.sounds.events.onError();
									}
									else
									{
										this.api.ui.showTooltip(loc10.list.sort().join(", "),0,520);
									}
								}
								this._txtConsole.text = loc10.result + (!loc10.isFull?"":" ");
								this.placeCursorAtTheEnd();
								break loop1;
							default:
								switch(null)
								{
									case "NEXTTURN":
										if(this.api.datacenter.Game.isFight)
										{
											this.api.network.Game.turnEnd();
											loc3 = false;
										}
										break loop1;
									case "MAXI":
										this._cChat.open(false);
										loc3 = false;
										break loop1;
									case "MINI":
										this._cChat.open(true);
										loc3 = false;
										break loop1;
									case "CHARAC":
										if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
										{
											this.click({target:this._btnStatsJob});
											loc3 = false;
										}
										break loop1;
									case "SPELLS":
										if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
										{
											this.click({target:this._btnSpells});
											loc3 = false;
										}
										break loop1;
									default:
										switch(null)
										{
											case "INVENTORY":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnInventory});
													loc3 = false;
												}
												break loop1;
											case "QUESTS":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnQuests});
													loc3 = false;
												}
												break loop1;
											case "MAP":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnMap});
													loc3 = false;
												}
												break loop1;
											case "FRIENDS":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnFriends});
													loc3 = false;
												}
												break loop1;
											case "GUILD":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnGuild});
													loc3 = false;
												}
												break loop1;
											default:
												if(§§enum_assign() !== "MOUNT")
												{
													break loop1;
												}
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnMount});
													loc3 = false;
													break loop1;
												}
												break loop1;
										}
								}
						}
				}
		}
		this._lastKeyIsShortcut = loc3;
		return loc3;
	}
	function click(loc2)
	{
		this.api.kernel.GameManager.signalFightActivity();
		loop0:
		switch(loc2.target._name)
		{
			case "_btnPvP":
				this.api.sounds.events.onBannerRoundButtonClick();
				if(this.api.datacenter.Player.data.alignment.index == 0)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("NEED_ALIGNMENT"),"ERROR_CHAT");
				}
				else
				{
					this.showSmileysEmotesPanel(false);
					this.gapi.loadUIAutoHideComponent("Conquest","Conquest",{currentTab:"Stats"});
				}
				break;
			case "_btnMount":
				this.api.sounds.events.onBannerRoundButtonClick();
				if(this._oData.isMutant)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
					return undefined;
				}
				if(this._oData.mount != undefined)
				{
					this.showSmileysEmotesPanel(false);
					if(Key.isDown(Key.SHIFT))
					{
						this.api.network.Exchange.request(15);
					}
					else if(this.gapi.getUIComponent("MountAncestorsViewer") != undefined)
					{
						this.gapi.unloadUIComponent("MountAncestorsViewer");
						this.gapi.unloadUIComponent("Mount");
					}
					else
					{
						this.gapi.loadUIAutoHideComponent("Mount","Mount");
					}
				}
				else
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("UI_ONLY_FOR_MOUNT"),"ERROR_CHAT");
				}
				break;
			case "_btnGuild":
				this.api.sounds.events.onBannerRoundButtonClick();
				if(this._oData.isMutant)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
					return undefined;
				}
				if(this._oData.guildInfos != undefined)
				{
					this.showSmileysEmotesPanel(false);
					this.gapi.loadUIAutoHideComponent("Guild","Guild",{currentTab:"Members"});
				}
				else
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("UI_ONLY_FOR_GUILD"),"ERROR_CHAT");
				}
				break;
			case "_btnStatsJob":
				this.api.sounds.events.onBannerRoundButtonClick();
				if(this._oData.isMutant)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
					return undefined;
				}
				this.showSmileysEmotesPanel(false);
				this.gapi.loadUIAutoHideComponent("StatsJob","StatsJob");
				break;
			case "_btnSpells":
				this.api.sounds.events.onBannerRoundButtonClick();
				if(this._oData.isMutant)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
					return undefined;
				}
				this.showSmileysEmotesPanel(false);
				this.gapi.loadUIAutoHideComponent("Spells","Spells");
				break;
			default:
				switch(null)
				{
					case "_btnInventory":
						this.api.sounds.events.onBannerRoundButtonClick();
						this.showSmileysEmotesPanel(false);
						this.gapi.loadUIAutoHideComponent("Inventory","Inventory");
						break loop0;
					case "_btnQuests":
						this.api.sounds.events.onBannerRoundButtonClick();
						this.showSmileysEmotesPanel(false);
						this.gapi.loadUIAutoHideComponent("Quests","Quests");
						break loop0;
					case "_btnMap":
						this.api.sounds.events.onBannerRoundButtonClick();
						this.showSmileysEmotesPanel(false);
						this.gapi.loadUIAutoHideComponent("MapExplorer","MapExplorer");
						break loop0;
					case "_btnFriends":
						this.api.sounds.events.onBannerRoundButtonClick();
						this.showSmileysEmotesPanel(false);
						this.gapi.loadUIAutoHideComponent("Friends","Friends");
						break loop0;
					default:
						switch(null)
						{
							case "_btnFights":
								if(!this.api.datacenter.Game.isFight)
								{
									this.gapi.loadUIComponent("FightsInfos","FightsInfos",null,{bAlwaysOnTop:true});
								}
								break loop0;
							case "_btnHelp":
								var loc3 = this.api.lang.getConfigText("CHAT_FILTERS");
								var loc4 = this.api.ui.createPopupMenu();
								loc4.addStaticItem(this.api.lang.getText("CHAT_PREFIX"));
								loc4.addItem(this.api.lang.getText("DEFAUT"),this,this.setChatPrefix,[""]);
								loc4.addItem(this.api.lang.getText("TEAM") + " (/t)",this,this.setChatPrefix,["/t"],this.api.datacenter.Game.isFight);
								loc4.addItem(this.api.lang.getText("PARTY") + " (/p)",this,this.setChatPrefix,["/p"],this.api.ui.getUIComponent("Party") != undefined);
								loc4.addItem(this.api.lang.getText("GUILD") + " (/g)",this,this.setChatPrefix,["/g"],this.api.datacenter.Player.guildInfos != undefined);
								if(loc3[4])
								{
									loc4.addItem(this.api.lang.getText("ALIGNMENT") + " (/a)",this,this.setChatPrefix,["/a"],this.api.datacenter.Player.alignment.index != 0);
								}
								if(loc3[5])
								{
									loc4.addItem(this.api.lang.getText("RECRUITMENT") + " (/r)",this,this.setChatPrefix,["/r"]);
								}
								if(loc3[6])
								{
									loc4.addItem(this.api.lang.getText("TRADE") + " (/b)",this,this.setChatPrefix,["/b"]);
								}
								if(loc3[7])
								{
									loc4.addItem(this.api.lang.getText("MEETIC") + " (/i)",this,this.setChatPrefix,["/i"]);
								}
								if(this.api.datacenter.Player.isAuthorized)
								{
									loc4.addItem(this.api.lang.getText("PRIVATE_CHANNEL") + " (/q)",this,this.setChatPrefix,["/q"]);
								}
								loc4.addItem(this.api.lang.getText("HELP"),this,this.displayChatHelp,[]);
								loc4.show(this._btnHelp._x,this._btnHelp._y,true);
								break loop0;
							case "_btnNextTurn":
								if(this.api.datacenter.Game.isFight)
								{
									this.api.network.Game.turnEnd();
								}
								break loop0;
							case "_btnGiveUp":
								if(this.api.datacenter.Game.isFight)
								{
									if(this.api.datacenter.Game.isSpectator)
									{
										this.api.network.Game.leave();
									}
									else
									{
										this.api.kernel.GameManager.giveUpGame();
									}
								}
								break loop0;
							default:
								if(loc0 !== "_mcXtra")
								{
									if((loc0 = this._msShortcuts.currentTab) !== "Spells")
									{
										if(loc0 !== "Items")
										{
											break loop0;
										}
										if(this.api.kernel.TutorialManager.isTutorialMode)
										{
											this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_CONTAINER_SELECT",params:[Number(loc2.target._name.substr(4))]});
											break loop0;
										}
										if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && (loc2.target.contentData != undefined && !loc2.target.notInChat))
										{
											this.api.kernel.GameManager.insertItemInChat(loc2.target.contentData);
											return undefined;
										}
										loc2.target.notInChat = false;
										var loc7 = this.gapi.getUIComponent("Inventory");
										if(loc7 != undefined)
										{
											loc7.showItemInfos(loc2.target.contentData);
											break loop0;
										}
										var loc8 = loc2.target.contentData;
										if(loc8 == undefined)
										{
											return undefined;
										}
										if(this.api.datacenter.Player.canUseObject)
										{
											if(loc8.canTarget)
											{
												this.api.kernel.GameManager.switchToItemTarget(loc8);
												break loop0;
											}
											if(loc8.canUse && loc2.keyBoard)
											{
												this.api.network.Items.use(loc8.ID);
												break loop0;
											}
											break loop0;
										}
										break loop0;
									}
									this.api.sounds.events.onBannerSpellSelect();
									if(this.api.kernel.TutorialManager.isTutorialMode)
									{
										this.api.kernel.TutorialManager.onWaitingCase({code:"SPELL_CONTAINER_SELECT",params:[Number(loc2.target._name.substr(4))]});
										break loop0;
									}
									if(this.gapi.getUIComponent("Spells") != undefined)
									{
										return undefined;
									}
									var loc6 = loc2.target.contentData;
									if(loc6 == undefined)
									{
										return undefined;
									}
									this.api.kernel.GameManager.switchToSpellLaunch(loc6,true);
									break loop0;
								}
								if(!Key.isDown(Key.SHIFT))
								{
									if(this._sCurrentCircleXtra == "helper" && dofus.managers.TipsManager.getInstance().hasNewTips())
									{
										dofus.managers.TipsManager.getInstance().displayNextTips();
										break loop0;
									}
									var loc5 = this.api.ui.createPopupMenu();
									loc5.addItem(this.api.lang.getText("SHOW") + " >>",this,this.showGaugeModeSelectMenu);
									if(this._sCurrentCircleXtra == "helper")
									{
										loc5.addStaticItem(this.api.lang.getText("HELP_ME"));
										loc5.addItem(this.api.lang.getText("KB_TITLE"),this.api.ui,this.api.ui.loadUIComponent,["KnownledgeBase","KnownledgeBase"],true);
										loc5.addStaticItem(this.api.lang.getText("OTHER_DISPLAY_OPTIONS"));
									}
									loc5.addItem(this.api.lang.getText("BANNER_ARTWORK"),this,this.showCircleXtra,["artwork",true,{bMask:true}],this._sCurrentCircleXtra != "artwork");
									loc5.addItem(this.api.lang.getText("BANNER_CLOCK"),this,this.showCircleXtra,["clock",true,{bMask:true}],this._sCurrentCircleXtra != "clock");
									loc5.addItem(this.api.lang.getText("BANNER_COMPASS"),this,this.showCircleXtra,["compass",true],this._sCurrentCircleXtra != "compass");
									loc5.addItem(this.api.lang.getText("BANNER_HELPER"),this,this.showCircleXtra,["helper",true],this._sCurrentCircleXtra != "helper");
									loc5.addItem(this.api.lang.getText("BANNER_MAP"),this,this.showCircleXtra,["map",true,{bMask:true}],this._sCurrentCircleXtra != "map");
									loc5.show(_root._xmouse,_root._ymouse,true);
								}
								else
								{
									this.api.kernel.GameManager.showPlayerPopupMenu(undefined,this.api.datacenter.Player.Name);
								}
								break loop0;
						}
				}
		}
	}
	function dblClick(loc2)
	{
		if(loc2.target == this._mcbMovableBar)
		{
			this._mcbMovableBar.size = this._mcbMovableBar.size != 0?0:this.api.kernel.OptionsManager.getOption("MovableBarSize");
			return undefined;
		}
	}
	function beforeFinalCountDown(loc2)
	{
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FINAL_COUNTDOWN);
	}
	function finalCountDown(loc2)
	{
		this._mcXtra._visible = false;
		this._lblFinalCountDown.text = loc2.value;
	}
	function tictac(loc2)
	{
		this.api.sounds.events.onBannerTimer();
	}
	function finish(loc2)
	{
		this._mcXtra._visible = true;
		if(this._lblFinalCountDown.text != undefined)
		{
			this._lblFinalCountDown.text = "";
		}
	}
	function complete(loc2)
	{
		var loc3 = this.api.kernel.OptionsManager.getOption("BannerIllustrationMode");
		if(loc2.target.contentPath.indexOf("artworks") != -1 && loc3 == "helper")
		{
			this.showCircleXtra("helper",true);
		}
		else
		{
			this.api.colors.addSprite(this._mcXtra.content,this._oData.data);
		}
	}
	function over(loc2)
	{
		if(!this.gapi.isCursorHidden())
		{
			return undefined;
		}
		loop0:
		switch(loc2.target._name)
		{
			case "_btnHelp":
				this.gapi.showTooltip(this.api.lang.getText("CHAT_MENU"),loc2.target,-20,{bXLimit:false,bYLimit:false});
				break;
			case "_btnGiveUp":
				if(this.api.datacenter.Game.isSpectator)
				{
					var loc3 = this.api.lang.getText("GIVE_UP_SPECTATOR");
				}
				else if(this.api.datacenter.Game.fightType == dofus.managers.GameManager.FIGHT_TYPE_CHALLENGE || !this.api.datacenter.Basics.aks_current_server.isHardcore())
				{
					loc3 = this.api.lang.getText("GIVE_UP");
				}
				else
				{
					loc3 = this.api.lang.getText("SUICIDE");
				}
				this.gapi.showTooltip(loc3,loc2.target,-20,{bXLimit:true,bYLimit:false});
				break;
			case "_btnPvP":
				this.gapi.showTooltip(this.api.lang.getText("CONQUEST_WORD"),loc2.target,-20,{bXLimit:true,bYLimit:false});
				break;
			default:
				switch(null)
				{
					case "_btnMount":
						this.gapi.showTooltip(this.api.lang.getText("MY_MOUNT"),loc2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					case "_btnGuild":
						this.gapi.showTooltip(this.api.lang.getText("YOUR_GUILD"),loc2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					case "_btnStatsJob":
						this.gapi.showTooltip(this.api.lang.getText("YOUR_STATS_JOB"),loc2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					case "_btnSpells":
						this.gapi.showTooltip(this.api.lang.getText("YOUR_SPELLS"),loc2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					case "_btnQuests":
						this.gapi.showTooltip(this.api.lang.getText("YOUR_QUESTS"),loc2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					default:
						switch(null)
						{
							case "_btnInventory":
								var loc4 = new ank.utils.(this.api.datacenter.Player.currentWeight).addMiddleChar(" ",3);
								var loc5 = new ank.utils.(this.api.datacenter.Player.maxWeight).addMiddleChar(" ",3);
								var loc6 = this.api.lang.getText("PLAYER_WEIGHT",[loc4,loc5]);
								this.gapi.showTooltip(this.api.lang.getText("YOUR_INVENTORY") + "\n\n" + loc6,loc2.target,-43,{bXLimit:true,bYLimit:false});
								break loop0;
							case "_btnMap":
								this.gapi.showTooltip(this.api.lang.getText("YOUR_BOOK"),loc2.target,-20,{bXLimit:true,bYLimit:false});
								break loop0;
							case "_btnFriends":
								this.gapi.showTooltip(this.api.lang.getText("YOUR_FRIENDS"),loc2.target,-20,{bXLimit:true,bYLimit:false});
								break loop0;
							case "_btnFights":
								if(this._nFightsCount != 0)
								{
									this.gapi.showTooltip(ank.utils.PatternDecoder.combine(this.api.lang.getText("FIGHTS_ON_MAP",[this._nFightsCount]),"m",this._nFightsCount < 2),loc2.target,-20,{bYLimit:false});
								}
								break loop0;
							default:
								switch(null)
								{
									case "_btnNextTurn":
										this.gapi.showTooltip(this.api.lang.getText("NEXT_TURN"),loc2.target,-20,{bXLimit:true,bYLimit:false});
										break loop0;
									case "_pvAP":
										this.gapi.showTooltip(this.api.lang.getText("ACTIONPOINTS"),loc2.target,-20,{bXLimit:true,bYLimit:false});
										break loop0;
									case "_pvMP":
										this.gapi.showTooltip(this.api.lang.getText("MOVEPOINTS"),loc2.target,-20,{bXLimit:true,bYLimit:false});
										break loop0;
									case "_mcXtra":
										switch(this._sCurrentCircleXtra)
										{
											case "compass":
												var loc7 = loc2.target.targetCoords;
												if(loc7 == undefined)
												{
													this.gapi.showTooltip(this.api.lang.getText("BANNER_SET_FLAG"),loc2.target,0,{bXLimit:true,bYLimit:false});
												}
												else
												{
													this.gapi.showTooltip(loc7[0] + ", " + loc7[1],loc2.target,0,{bXLimit:true,bYLimit:false});
												}
												break;
											case "clock":
												this.gapi.showTooltip(this.api.kernel.NightManager.time + "\n" + this.api.kernel.NightManager.getCurrentDateString(),loc2.target,0,{bXLimit:true,bYLimit:false});
												break;
											default:
												if(loc0 !== "map")
												{
													break;
												}
												this.gapi.showTooltip(loc2.target.tooltip,loc2.target,0,{bXLimit:true,bYLimit:false});
												break;
										}
										break loop0;
									default:
										if(loc0 !== "_hHeart")
										{
											switch(this._msShortcuts.currentTab)
											{
												case "Spells":
													var loc8 = loc2.target.contentData;
													if(loc8 != undefined)
													{
														this.gapi.showTooltip(loc8.name + " (" + loc8.apCost + " " + this.api.lang.getText("AP") + (loc8.actualCriticalHit <= 0?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + loc8.actualCriticalHit) + ")",loc2.target,-20,{bXLimit:true,bYLimit:false});
													}
													break;
												case "Items":
													var loc9 = loc2.target.contentData;
													if(loc9 != undefined)
													{
														var loc10 = loc9.name;
														if(this.gapi.getUIComponent("Inventory") == undefined)
														{
															if(loc9.canUse && loc9.canTarget)
															{
																loc10 = loc10 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK_CLICK"));
															}
															else
															{
																if(loc9.canUse)
																{
																	loc10 = loc10 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK"));
																}
																if(loc9.canTarget)
																{
																	loc10 = loc10 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_CLICK"));
																}
															}
														}
														this.gapi.showTooltip(loc10,loc2.target,-30,{bXLimit:true,bYLimit:false});
														break;
													}
											}
											break loop0;
										}
										this.gapi.showTooltip(this.api.lang.getText("HELP_LIFE"),loc2.target,-20);
										break loop0;
								}
						}
				}
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function drag(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(loc3 == undefined)
		{
			return undefined;
		}
		switch(this._msShortcuts.currentTab)
		{
			case "Spells":
				if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				break;
			case "Items":
				if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				break;
		}
		this.gapi.removeCursor();
		this.gapi.setCursor(loc3);
	}
	function drop(loc2)
	{
		if((var loc0 = loc2.target) !== this._mcbMovableBar)
		{
			switch(this._msShortcuts.currentTab)
			{
				case "Spells":
					if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
					{
						return undefined;
					}
					var loc3 = this.gapi.getCursor();
					if(loc3 == undefined)
					{
						return undefined;
					}
					this.gapi.removeCursor();
					var loc4 = loc3.position;
					var loc5 = loc2.target.params.position;
					if(loc4 == loc5)
					{
						return undefined;
					}
					if(loc4 != undefined)
					{
						this._msShortcuts.getContainer(loc4).contentData = undefined;
						this._oData.SpellsUsed.removeItemAt(loc4);
					}
					var loc6 = this._msShortcuts.getContainer(loc5).contentData;
					if(loc6 != undefined)
					{
						loc6.position = undefined;
					}
					loc3.position = loc5;
					loc2.target.contentData = loc3;
					this._oData.SpellsUsed.addItemAt(loc5,loc3);
					this.api.network.Spells.moveToUsed(loc3.ID,loc5);
					this.addToQueue({object:this._msShortcuts,method:this._msShortcuts.setSpellStateOnAllContainers});
					break;
				case "Items":
					if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
					{
						return undefined;
					}
					var loc7 = this.gapi.getCursor();
					if(loc7 == undefined)
					{
						return undefined;
					}
					if(!loc7.canMoveToShortut)
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_MOVE_ITEM_HERE"),"ERROR_BOX");
						return undefined;
					}
					this.gapi.removeCursor();
					var loc8 = loc2.target.params.position + dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
					if(loc7.position == loc8)
					{
						return undefined;
					}
					if(loc7.Quantity > 1)
					{
						var loc9 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:loc7.Quantity,max:loc7.Quantity,useAllStage:true,params:{type:"drop",item:loc7,position:loc8}},{bAlwaysOnTop:true});
						loc9.addEventListener("validate",this);
						break;
					}
					this.api.network.Items.movement(loc7.ID,loc8,1);
					break;
			}
		}
		else
		{
			this.api.kernel.OptionsManager.setOption("MovableBarCoord",{x:this._mcbMovableBar._x,y:this._mcbMovableBar._y});
		}
	}
	function filterChanged(loc2)
	{
		this.api.network.Chat.subscribeChannels(loc2.filter,loc2.selected);
	}
	function lpChanged(loc2)
	{
		this._hHeart.value = loc2.value;
	}
	function lpMaxChanged(loc2)
	{
		this._hHeart.max = loc2.value;
	}
	function apChanged(loc2)
	{
		this._pvAP.value = loc2.value;
		if(!this.api.datacenter.Game.isFight)
		{
		}
		this._msShortcuts.setSpellStateOnAllContainers();
	}
	function mpChanged(loc2)
	{
		this._pvMP.value = Math.max(0,loc2.value);
	}
	function selectSmiley(loc2)
	{
		this.api.network.Chat.useSmiley(loc2.index);
	}
	function selectEmote(loc2)
	{
		this.api.network.Emotes.useEmote(loc2.index);
	}
	function spellLaunched(loc2)
	{
		this._msShortcuts.setSpellStateOnContainer(loc2.spell.position);
	}
	function nextTurn(loc2)
	{
		this._msShortcuts.setSpellStateOnAllContainers();
	}
	function href(loc2)
	{
		var loc3 = loc2.params.split(",");
		loop0:
		switch(loc3[0])
		{
			case "OpenGuildTaxCollectors":
				this.addToQueue({object:this.gapi,method:this.gapi.loadUIAutoHideComponent,params:["Guild","Guild",{currentTab:"TaxCollectors"},{bStayIfPresent:true}]});
				break;
			case "OpenPayZoneDetails":
				this.addToQueue({object:this.gapi,method:this.gapi.loadUIComponent,params:["PayZoneDialog2","PayZoneDialog2",{name:"El Pemy",gfx:"9059",dialogID:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS},{bForceLoad:true}]});
				break;
			default:
				switch(null)
				{
					case "ShowPlayerPopupMenu":
						if(loc3[2] != undefined && (String(loc3[2]).length > 0 && loc3[2] != ""))
						{
							this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showPlayerPopupMenu,params:[undefined,_global.unescape(loc3[1]),null,null,null,loc3[2],this.api.datacenter.Player.isAuthorized]});
						}
						else
						{
							this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showPlayerPopupMenu,params:[undefined,_global.unescape(loc3[1]),null,null,null,null,this.api.datacenter.Player.isAuthorized]});
						}
						break loop0;
					case "ShowMessagePopupMenu":
						if(loc3[3] != undefined && (String(loc3[3]).length > 0 && loc3[3] != ""))
						{
							this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showMessagePopupMenu,params:[loc3[1],_global.unescape(loc3[2]),loc3[3]]});
						}
						else
						{
							this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showMessagePopupMenu,params:[loc3[1],_global.unescape(loc3[2])]});
						}
						break loop0;
					case "ShowItemViewer":
						var loc4 = this.api.kernel.ChatManager.getItemFromBuffer(Number(loc3[1]));
						if(loc4 == undefined)
						{
							this.addToQueue({object:this.api.kernel,method:this.api.kernel.showMessage,params:[this.api.lang.getText("ERROR_WORD"),this.api.lang.getText("ERROR_ITEM_CANT_BE_DISPLAYED"),"ERROR_BOX"]});
							break loop0;
						}
						this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["ItemViewer","ItemViewer",{item:loc4},{bAlwaysOnTop:true}]});
						break loop0;
					case "updateCompass":
						this.api.kernel.GameManager.updateCompass(Number(loc3[1]),Number(loc3[2]));
						break loop0;
					default:
						if(loc0 !== "ShowLinkWarning")
						{
							break loop0;
						}
						this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["AskLinkWarning","AskLinkWarning",{text:this.api.lang.getText(loc3[1])}]});
						break loop0;
				}
		}
	}
	function validate(loc2)
	{
		if((var loc0 = loc2.params.type) === "drop")
		{
			this.gapi.removeCursor();
			if(loc2.value > 0 && !_global.isNaN(Number(loc2.value)))
			{
				this.api.network.Items.movement(loc2.params.item.ID,loc2.params.position,Math.min(loc2.value,loc2.params.item.Quantity));
			}
		}
	}
	function drawBar(loc2)
	{
		this.linkMovableContainer();
		this._msShortcuts.updateCurrentTabInformations();
		this.updateEye();
	}
	function onSetFocus()
	{
		if(this.api.config.isLinux || this.api.config.isMac)
		{
			getURL("FSCommand:" add "trapallkeys","false");
		}
		else
		{
			this._bIsOnFocus = true;
		}
	}
	function onKillFocus()
	{
		if(this.api.config.isLinux || this.api.config.isMac)
		{
			getURL("FSCommand:" add "trapallkeys","true");
		}
		else
		{
			this._bIsOnFocus = false;
		}
	}
}
