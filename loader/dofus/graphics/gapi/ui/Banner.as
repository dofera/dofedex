class dofus.graphics.gapi.ui.Banner extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CHECK_MOUSE_POSITION_REFRESH_RATE = 250;
	static var CLASS_NAME = "Banner";
	static var NO_TRANSFORM = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
	static var INACTIVE_TRANSFORM = {ra:50,rb:0,ga:50,gb:0,ba:50,bb:0};
	var _nFightsCount = 0;
	var _bChatAutoFocus = true;
	var _sChatPrefix = "";
	var _bHeartMovedTop = false;
	function Banner()
	{
		super();
	}
	function __set__data(var2)
	{
		this._oData = var2;
		return this.__get__data();
	}
	function __get__fightsCount()
	{
		return this._nFightsCount;
	}
	function __set__fightsCount(var2)
	{
		this._nFightsCount = var2;
		this.updateEye();
		return this.__get__fightsCount();
	}
	function __get__chatAutoFocus()
	{
		return this._bChatAutoFocus;
	}
	function __set__chatAutoFocus(var2)
	{
		this._bChatAutoFocus = var2;
		return this.__get__chatAutoFocus();
	}
	function __set__txtConsole(var2)
	{
		this._txtConsole.text = var2;
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
		var var2 = this._nFightsCount != 0 && !this.api.datacenter.Game.isFight;
		this._btnFights._visible = var2;
	}
	function setSelectable(var2)
	{
		this._cChat.selectable = var2;
	}
	function insertChat(var2)
	{
		this._txtConsole.text = this._txtConsole.text + var2;
	}
	function showNextTurnButton(var2)
	{
		this._btnNextTurn._visible = var2;
	}
	function showGiveUpButton(var2)
	{
		if(var2)
		{
			this.setXtraFightMask(true);
		}
		this._btnGiveUp._visible = var2;
	}
	function moveHeart(var2)
	{
		if(var2)
		{
			if(!this._bHeartMovedTop)
			{
				this._hHeart._y = this._hHeart._y - 30;
			}
		}
		else if(this._bHeartMovedTop)
		{
			this._hHeart._y = this._hHeart._y + 30;
		}
		this._bHeartMovedTop = var2;
	}
	function showPoints(var2)
	{
		this._pvAP._visible = var2;
		this._pvMP._visible = var2;
		this._cChat.showSitDown(!var2);
		if(var2)
		{
			this._oData.data.addEventListener("lpChanged",this);
			this._oData.data.addEventListener("apChanged",this);
			this._oData.data.addEventListener("mpChanged",this);
			this.apChanged({value:Math.max(0,this._oData.data.AP)});
			this.mpChanged({value:Math.max(0,this._oData.data.MP)});
		}
	}
	function setXtraFightMask(var2)
	{
		this._mcChronoGrid._visible = var2;
		if(!var2)
		{
			this.setXtraMask(this._mcCircleXtraMaskBig);
			if(this._mcCurrentXtraMask == this._mcCircleXtraMaskBig)
			{
				this._ccChrono.setGaugeChrono(100,2109246);
			}
		}
		else
		{
			this.setXtraMask(this._mcCircleXtraMask);
		}
		if(this._mcCurrentXtraMask == this._mcCircleXtraMaskBig)
		{
			if(this._bHeartMovedTop)
			{
				this.setMiniMapScale(dofus.graphics.gapi.controls.MiniMap.SCALE_BIG);
			}
			else
			{
				this.setMiniMapScale(dofus.graphics.gapi.controls.MiniMap.SCALE_NORMAL);
			}
		}
		else
		{
			this.setMiniMapScale(dofus.graphics.gapi.controls.MiniMap.SCALE_SMALL);
		}
		this.displayMovableBar(this.api.kernel.OptionsManager.getOption("MovableBar") && (!this.api.kernel.OptionsManager.getOption("HideSpellBar") || this.api.datacenter.Game.isFight));
	}
	function setXtraMask(var2)
	{
		this._mcCurrentXtraMask = var2;
		this._mcXtra.setMask(var2);
	}
	function showCircleXtra(var2, var3, var4, var5)
	{
		if(var2 == undefined)
		{
			return null;
		}
		if(var2 == this._sCurrentCircleXtra && var3)
		{
			return null;
		}
		if(var2 != this._sCurrentCircleXtra && !var3)
		{
			return null;
		}
		if(this._sCurrentCircleXtra != undefined && var3)
		{
			this.showCircleXtra(this._sCurrentCircleXtra,false);
		}
		var var8 = new Object();
		var var9 = new Array();
		if(var5 == undefined)
		{
			var5 = new Object();
		}
		this.api.kernel.OptionsManager.setOption("BannerIllustrationMode",var2);
		if(this._nMiniMapCheckInterval != undefined)
		{
			_global.clearInterval(this._nMiniMapCheckInterval);
		}
		loop3:
		switch(var2)
		{
			case "artwork":
				var var10 = dofus.Constants.GUILDS_FACES_PATH + this.api.datacenter.Player.Guild + this.api.datacenter.Player.Sex + ".swf";
				var var6 = "Loader";
				var8 = {_x:this._mcCircleXtraMask._x,_y:this._mcCircleXtraMask._y,fallbackContentPath:var10,contentPath:dofus.Constants.GUILDS_FACES_PATH + this._oData.data.gfxID + ".swf",enabled:true};
				var9 = ["complete","click","over","out"];
				break;
			case "compass":
				var var11 = this.api.datacenter.Map;
				var6 = "Compass";
				var8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height,arrow:"UI_BannerCompassArrow",noArrow:"UI_BannerCompassNoArrow",background:"UI_BannerCompassBack",targetCoords:this.api.datacenter.Basics.banner_targetCoords,currentCoords:[var11.x,var11.y]};
				var9 = ["click","over","out"];
				break;
			default:
				switch(null)
				{
					case "clock":
						var6 = "Clock";
						var8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height,arrowHours:"UI_BannerClockArrowHours",arrowMinutes:"UI_BannerClockArrowMinutes",background:"UI_BannerClockBack",updateFunction:{object:this.api.kernel.NightManager,method:this.api.kernel.NightManager.getCurrentTime}};
						var9 = ["click","over","out"];
						break loop3;
					case "helper":
						var6 = "Loader";
						if(dofus.Constants.DOUBLEFRAMERATE)
						{
							var8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Helper_DoubleFramerate",enabled:true};
						}
						else
						{
							var8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Helper",enabled:true};
						}
						var9 = ["click","over","out"];
						break loop3;
					case "map":
						this._nMiniMapCheckInterval = _global.setInterval(this,"checkMouseOnMiniMap",dofus.graphics.gapi.ui.Banner.CHECK_MOUSE_POSITION_REFRESH_RATE);
						var6 = "MiniMap";
						var8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Map",enabled:true};
						var9 = ["over"];
						break loop3;
					default:
						var6 = "Loader";
						var8 = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height};
				}
		}
		var var12 = null;
		if(var3)
		{
			for(var k in var8)
			{
				var5[k] = var8[k];
			}
			var12 = this.attachMovie(var6,"_mcXtra",this.getNextHighestDepth(),var5);
			this._sCurrentCircleXtra = var2;
			if(var4.bMask)
			{
				this._sDefaultMaskType = var4.sMaskSize;
				if(!this.api.datacenter.Game.isFight && this.api.kernel.OptionsManager.getOption("BannerGaugeMode") == "none")
				{
					this.setXtraMask(this._mcCircleXtraMaskBig);
				}
				else
				{
					this.setXtraMask(this._mcCircleXtraMask);
				}
			}
			for(var k in var9)
			{
				this._mcXtra.addEventListener(var9[k],this);
			}
			this._mcXtra.swapDepths(this._mcCircleXtraPlacer);
		}
		else if(this._mcXtra != undefined)
		{
			for(var k in var9)
			{
				this._mcXtra.removeEventListener(var9[k],this);
			}
			this._mcCircleXtraPlacer.swapDepths(this._mcXtra);
			this._mcXtra.removeMovieClip();
			delete this._sCurrentCircleXtra;
		}
		if(var4.bUpdateGauge)
		{
			dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
		}
		return var12;
	}
	function setCircleXtraParams(var2)
	{
		for(var k in var2)
		{
			this._mcXtra[k] = var2[k];
		}
	}
	function startTimer(var2)
	{
		this.moveHeart(false);
		this.setXtraFightMask(true);
		this._ccChrono.startTimer(var2);
	}
	function redrawChrono()
	{
		this._ccChrono.redraw();
	}
	function stopTimer()
	{
		this._ccChrono.stopTimer();
	}
	function setChatText(var2)
	{
		this._cChat.setText(var2);
	}
	function showRightPanel(var2, var3, var4, var5)
	{
		if(this.api.datacenter.Game.isSpectator && this._mcRightPanel.bMouseSpriteRollover == true)
		{
			return undefined;
		}
		if(this._mcRightPanel.className == var2 && !(this.api.datacenter.Game.isSpectator && var4 == true))
		{
			return undefined;
		}
		if(!(this.api.datacenter.Game.isSpectator && var4 != true))
		{
			if(this._mcRightPanel.className == var2)
			{
				this._mcRightPanel.update(var3.data);
			}
			else
			{
				if(this._mcRightPanel != undefined)
				{
					this.hideRightPanel(true);
				}
				var3._x = this._mcRightPanelPlacer._x;
				var3._y = this._mcRightPanelPlacer._y;
				var var6 = this.attachMovie(var2,"_mcRightPanel",this.getNextHighestDepth(),var3);
				var6.swapDepths(this._mcRightPanelPlacer);
				var6.parent = this;
				var6.onRollOver = function()
				{
					this.parent.hideRightPanel(true);
				};
			}
			this._mcRightPanel.bMouseSpriteRollover = var5;
		}
	}
	function hideRightPanel(var2, var3)
	{
		if(var3)
		{
			this._mcRightPanel.bMouseSpriteRollover = false;
		}
		if(this._mcRightPanel != undefined && !(this.api.datacenter.Game.isSpectator && var2 != true))
		{
			this._mcRightPanel.swapDepths(this._mcRightPanelPlacer);
			this._mcRightPanel.removeMovieClip();
		}
	}
	function updateSmileysEmotes()
	{
		this._cChat.updateSmileysEmotes();
	}
	function showSmileysEmotesPanel(var2)
	{
		if(var2 == undefined)
		{
			var2 = true;
		}
		this._cChat.hideSmileys(!var2);
		this._cChat._btnSmileys.selected = var2;
	}
	function updateArtwork(var2)
	{
		if(this._sCurrentCircleXtra == "artwork")
		{
			if(var2)
			{
				this.showCircleXtra(this._sCurrentCircleXtra,false);
				this.showCircleXtra("artwork",true,{bMask:true});
			}
			else
			{
				var var3 = dofus.Constants.GUILDS_FACES_PATH + this.api.datacenter.Player.Guild + this.api.datacenter.Player.Sex + ".swf";
				this._mcXtra.fallbackContentPath = var3;
				this._mcXtra.contentPath = dofus.Constants.GUILDS_FACES_PATH + this._oData.data.gfxID + ".swf";
			}
		}
	}
	function updateLocalPlayer()
	{
		this.updateArtwork(false);
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
		var var2 = this._mcbMovableBar.containers;
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = var2[var3];
			this._msShortcuts.setContainer(var3 + 15,var4);
			var4.addEventListener("click",this._msShortcuts);
			var4.addEventListener("dblClick",this._msShortcuts);
			var4.addEventListener("over",this._msShortcuts);
			var4.addEventListener("out",this._msShortcuts);
			var4.addEventListener("drag",this._msShortcuts);
			var4.addEventListener("drop",this._msShortcuts);
			var4.addEventListener("onContentLoaded",this._msShortcuts);
			var4.params = {position:var3 + 15};
			var3 = var3 + 1;
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
		dofus.graphics.gapi.ui.banner.Gauge.setGaugeMode(this,this.api.kernel.OptionsManager.getOption("BannerGaugeMode"));
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
	function setChatPrefix(var2)
	{
		this._sChatPrefix = var2;
		if(var2 != "")
		{
			this._btnHelp.label = var2;
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
		var var2 = this._txtConsole.text;
		var var3 = var2.split(" ");
		if(var3[0].charAt(0) == "/")
		{
			return var2;
		}
		if(this._sChatPrefix != "")
		{
			return this._sChatPrefix + " " + var2;
		}
		return var2;
	}
	function hideEpisodicContent()
	{
		this._btnPvP._visible = this.api.datacenter.Basics.aks_current_regional_version >= 16;
		this._btnMount._visible = this.api.datacenter.Basics.aks_current_regional_version >= 20;
		this._btnGuild._visible = !this.api.config.isStreaming;
		var var2 = this._btnStatsJob._x;
		var var3 = this._btnPvP._x;
		var var4 = new Array();
		var4.push(this._btnStatsJob);
		var4.push(this._btnSpells);
		var4.push(this._btnInventory);
		var4.push(this._btnQuests);
		var4.push(this._btnMap);
		var4.push(this._btnFriends);
		if(this._btnGuild._visible)
		{
			var4.push(this._btnGuild);
		}
		if(this._btnMount._visible)
		{
			var4.push(this._btnMount);
		}
		if(this._btnPvP._visible)
		{
			var4.push(this._btnPvP);
		}
		var var5 = (var3 - var2) / (var4.length - 1);
		var var6 = 0;
		while(var6 < var4.length)
		{
			var4[var6]._x = var6 * var5 + var2;
			var6 = var6 + 1;
		}
	}
	function displayChatHelp()
	{
		this.api.kernel.Console.process("/help");
		this._cChat.open(false);
	}
	function xpChanged()
	{
		dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
	}
	function energyChanged()
	{
		dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
	}
	function currentWeightChanged()
	{
		dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
	}
	function mountChanged()
	{
		dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
	}
	function currentJobChanged()
	{
		dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
	}
	function setMiniMapScale(var2)
	{
		if(this._sCurrentCircleXtra != "map")
		{
			return undefined;
		}
		this._mcXtra.setScale(var2,true);
	}
	function displayMovableBar(var2)
	{
		if(var2 == undefined)
		{
			var2 = this._mcbMovableBar == undefined;
		}
		if(var2)
		{
			if(this._mcbMovableBar._name != undefined)
			{
				return undefined;
			}
			this._mcbMovableBar = (dofus.graphics.gapi.ui.MovableContainerBar)this.api.ui.loadUIComponent("MovableContainerBar","MovableBar",[],{bAlwaysOnTop:true});
			this._mcbMovableBar.addEventListener("drawBar",this);
			this._mcbMovableBar.addEventListener("drop",this);
			this._mcbMovableBar.addEventListener("dblClick",this);
			var var3 = {left:0,top:0,right:this.gapi.screenWidth,bottom:this.gapi.screenHeight};
			var var4 = this.api.kernel.OptionsManager.getOption("MovableBarSize");
			var var5 = this.api.kernel.OptionsManager.getOption("MovableBarCoord");
			var5 = !var5?{x:0,y:(this.gapi.screenHeight - this._mcbMovableBar._height) / 2}:var5;
			this.addToQueue({object:this._mcbMovableBar,method:this._mcbMovableBar.setOptions,params:[14,20,var3,var4,var5]});
		}
		else
		{
			this.api.ui.unloadUIComponent("MovableBar");
		}
	}
	function setMovableBarSize(var2)
	{
		this._mcbMovableBar.size = var2;
	}
	function chatInputHasText()
	{
		return this._txtConsole.text != undefined && this._txtConsole.text != "";
	}
	function onKeys(var2)
	{
		if(this._lastKeyIsShortcut)
		{
			this._lastKeyIsShortcut = false;
			return undefined;
		}
		this.setChatFocusWithLastKey();
	}
	function onShortcut(var2)
	{
		var var3 = true;
		loop1:
		switch(var2)
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
							var3 = false;
						}
						break loop1;
					case "ACCEPT_CURRENT_DIALOG":
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
								var3 = false;
							}
						}
						else if(this._bChatAutoFocus)
						{
							var var4 = (dofus.graphics.gapi.ui.Debug)this.gapi.getUIComponent("Debug");
							if(Selection.getFocus() != undefined && !(var4 != undefined && (var4.isFocused() && !var4.commandInputHasText())))
							{
								break loop1;
							}
							var3 = false;
							this.setChatFocus();
						}
						break loop1;
					case "TEAM_MESSAGE":
						if(this.isChatFocus())
						{
							if(this._txtConsole.text.length != 0)
							{
								var var5 = this.getChatCommand();
								if(var5.charAt(0) == "/")
								{
									var5 = var5.substr(var5.indexOf(" ") + 1);
								}
								this.api.kernel.Console.process("/t " + var5,this.api.datacenter.Basics.chatParams);
								this.api.datacenter.Basics.chatParams = new Object();
								if(this._txtConsole.text != undefined)
								{
									this._txtConsole.text = "";
								}
								var3 = false;
							}
						}
						else if(Selection.getFocus() == undefined && this._bChatAutoFocus)
						{
							var3 = false;
							this.setChatFocus();
						}
						break loop1;
					case "GUILD_MESSAGE":
						if(this.isChatFocus())
						{
							if(this._txtConsole.text.length != 0)
							{
								var var6 = this.getChatCommand();
								if(var6.charAt(0) == "/")
								{
									var6 = var6.substr(var6.indexOf(" ") + 1);
								}
								this.api.kernel.Console.process("/g " + var6,this.api.datacenter.Basics.chatParams);
								this.api.datacenter.Basics.chatParams = new Object();
								if(this._txtConsole.text != undefined)
								{
									this._txtConsole.text = "";
								}
								var3 = false;
							}
						}
						else if(Selection.getFocus() == undefined && this._bChatAutoFocus)
						{
							var3 = false;
							this.setChatFocus();
						}
						break loop1;
					default:
						switch(null)
						{
							case "WHISPER_HISTORY_UP":
								if(this.isChatFocus())
								{
									this._txtConsole.text = this.api.kernel.Console.getWhisperHistoryUp();
									this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
									var3 = false;
								}
								break loop1;
							case "WHISPER_HISTORY_DOWN":
								if(this.isChatFocus())
								{
									this._txtConsole.text = this.api.kernel.Console.getWhisperHistoryDown();
									this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
									var3 = false;
								}
								break loop1;
							case "HISTORY_UP":
								if(this.isChatFocus())
								{
									var var7 = this.api.kernel.Console.getHistoryUp();
									if(var7 != undefined)
									{
										this.api.datacenter.Basics.chatParams = var7.params;
										this._txtConsole.text = var7.value;
									}
									this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
									var3 = false;
								}
								break loop1;
							case "HISTORY_DOWN":
								if(this.isChatFocus())
								{
									var var8 = this.api.kernel.Console.getHistoryDown();
									if(var8 != undefined)
									{
										this.api.datacenter.Basics.chatParams = var8.params;
										this._txtConsole.text = var8.value;
									}
									else
									{
										this._txtConsole.text = "";
									}
									this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
									var3 = false;
								}
								break loop1;
							case "AUTOCOMPLETE":
								var var9 = new Array();
								var var10 = this.api.datacenter.Sprites.getItems();
								for(var k in var10)
								{
									if(var10[k] instanceof dofus.datacenter.Character)
									{
										var9.push(var10[k].name);
									}
								}
								var var11 = this.api.kernel.Console.autoCompletion(var9,this._txtConsole.text);
								if(!var11.isFull)
								{
									if(var11.list == undefined || var11.list.length == 0)
									{
										this.api.sounds.events.onError();
									}
									else
									{
										this.api.ui.showTooltip(var11.list.sort().join(", "),0,520);
									}
								}
								this._txtConsole.text = var11.result + (!var11.isFull?"":" ");
								this.placeCursorAtTheEnd();
								break loop1;
							default:
								switch(null)
								{
									case "NEXTTURN":
										if(this.api.datacenter.Game.isFight)
										{
											this.api.network.Game.prepareTurnEnd();
											var3 = false;
										}
										break loop1;
									case "MAXI":
										this._cChat.open(false);
										var3 = false;
										break loop1;
									case "MINI":
										this._cChat.open(true);
										var3 = false;
										break loop1;
									case "CHARAC":
										if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
										{
											this.click({target:this._btnStatsJob});
											var3 = false;
										}
										break loop1;
									default:
										switch(null)
										{
											case "SPELLS":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnSpells});
													var3 = false;
												}
												break loop1;
											case "INVENTORY":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnInventory});
													var3 = false;
												}
												break loop1;
											case "QUESTS":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnQuests});
													var3 = false;
												}
												break loop1;
											case "MAP":
												if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
												{
													this.click({target:this._btnMap});
													var3 = false;
												}
												break loop1;
											default:
												switch(null)
												{
													case "FRIENDS":
														if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
														{
															this.click({target:this._btnFriends});
															var3 = false;
														}
														break;
													case "GUILD":
														if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
														{
															this.click({target:this._btnGuild});
															var3 = false;
														}
														break;
													case "MOUNT":
														if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
														{
															this.click({target:this._btnMount});
															var3 = false;
															break;
														}
												}
										}
								}
						}
				}
		}
		this._lastKeyIsShortcut = var3;
		return var3;
	}
	function checkMouseOnMiniMap()
	{
		if(this._sCurrentCircleXtra != "map")
		{
			return undefined;
		}
		if(this._mcXtra.getMcBg().hitTest(_root._xmouse,_root._ymouse,true))
		{
			return undefined;
		}
		if(!this._bHeartMovedTop)
		{
			return undefined;
		}
		this.moveHeart(false);
		if(!this.api.datacenter.Game.isFight && this.api.kernel.OptionsManager.getOption("BannerGaugeMode") == "none")
		{
			this.setXtraMask(this._mcCircleXtraMaskBig);
		}
		else
		{
			this.setXtraMask(this._mcCircleXtraMask);
		}
		dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
	}
	function click(var2)
	{
		this.api.kernel.GameManager.signalFightActivity();
		loop0:
		switch(var2.target._name)
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
				if(this._oData.isMutant && !this.api.datacenter.Player.isAuthorized)
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
				if(this._oData.isMutant && !this.api.datacenter.Player.isAuthorized)
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
				if(this._oData.isMutant && !this.api.datacenter.Player.isAuthorized)
				{
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
					return undefined;
				}
				this.showSmileysEmotesPanel(false);
				this.gapi.loadUIAutoHideComponent("StatsJob","StatsJob");
				break;
			default:
				switch(null)
				{
					case "_btnSpells":
						this.api.sounds.events.onBannerRoundButtonClick();
						if(this._oData.isMutant && !this.api.datacenter.Player.isAuthorized)
						{
							this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_U_ARE_MUTANT"),"ERROR_CHAT");
							return undefined;
						}
						this.showSmileysEmotesPanel(false);
						this.gapi.loadUIAutoHideComponent("Spells","Spells");
						break loop0;
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
					case "_btnFights":
						if(!this.api.datacenter.Game.isFight)
						{
							this.gapi.loadUIComponent("FightsInfos","FightsInfos",null,{bAlwaysOnTop:true});
						}
						break loop0;
					default:
						switch(null)
						{
							case "_btnHelp":
								var var3 = this.api.lang.getConfigText("CHAT_FILTERS");
								var var4 = this.api.ui.createPopupMenu();
								var4.addStaticItem(this.api.lang.getText("CHAT_PREFIX"));
								var4.addItem(this.api.lang.getText("DEFAUT"),this,this.setChatPrefix,[""]);
								var4.addItem(this.api.lang.getText("TEAM") + " (/t)",this,this.setChatPrefix,["/t"],this.api.datacenter.Game.isFight);
								var4.addItem(this.api.lang.getText("PARTY") + " (/p)",this,this.setChatPrefix,["/p"],this.api.ui.getUIComponent("Party") != undefined);
								var4.addItem(this.api.lang.getText("GUILD") + " (/g)",this,this.setChatPrefix,["/g"],this.api.datacenter.Player.guildInfos != undefined);
								if(var3[4])
								{
									var4.addItem(this.api.lang.getText("ALIGNMENT") + " (/a)",this,this.setChatPrefix,["/a"],this.api.datacenter.Player.alignment.index != 0);
								}
								if(var3[5])
								{
									var4.addItem(this.api.lang.getText("RECRUITMENT") + " (/r)",this,this.setChatPrefix,["/r"]);
								}
								if(var3[6])
								{
									var4.addItem(this.api.lang.getText("TRADE") + " (/b)",this,this.setChatPrefix,["/b"]);
								}
								if(var3[7])
								{
									var4.addItem(this.api.lang.getText("MEETIC") + " (/i)",this,this.setChatPrefix,["/i"]);
								}
								if(this.api.datacenter.Player.isAuthorized)
								{
									var4.addItem(this.api.lang.getText("PRIVATE_CHANNEL") + " (/q)",this,this.setChatPrefix,["/q"]);
								}
								var4.addItem(this.api.lang.getText("HELP"),this,this.displayChatHelp,[]);
								var4.show(this._btnHelp._x,this._btnHelp._y,true);
								break loop0;
							case "_btnNextTurn":
								if(this.api.datacenter.Game.isFight)
								{
									this.api.network.Game.prepareTurnEnd();
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
							case "_mcXtra":
								if(!this.api.datacenter.Player.isAuthorized || this.api.datacenter.Player.isAuthorized && Key.isDown(Key.SHIFT))
								{
									if(this._sCurrentCircleXtra == "helper" && dofus.managers.TipsManager.getInstance().hasNewTips())
									{
										dofus.managers.TipsManager.getInstance().displayNextTips();
										break loop0;
									}
									var var5 = this.api.ui.createPopupMenu();
									var5.addItem(this.api.lang.getText("SHOW") + " >>",dofus.graphics.gapi.ui.banner.Gauge,dofus.graphics.gapi.ui.banner.Gauge.showGaugeModeSelectMenu,[this]);
									if(this._sCurrentCircleXtra == "helper")
									{
										var5.addStaticItem(this.api.lang.getText("HELP_ME"));
										var5.addItem(this.api.lang.getText("KB_TITLE"),this.api.ui,this.api.ui.loadUIComponent,["KnownledgeBase","KnownledgeBase"],true);
										var5.addStaticItem(this.api.lang.getText("OTHER_DISPLAY_OPTIONS"));
									}
									var5.addItem(this.api.lang.getText("BANNER_ARTWORK"),this,this.showCircleXtra,["artwork",true,{bMask:true,bUpdateGauge:true}],this._sCurrentCircleXtra != "artwork");
									var5.addItem(this.api.lang.getText("BANNER_CLOCK"),this,this.showCircleXtra,["clock",true,{bMask:true,bUpdateGauge:true}],this._sCurrentCircleXtra != "clock");
									var5.addItem(this.api.lang.getText("BANNER_COMPASS"),this,this.showCircleXtra,["compass",true,{bUpdateGauge:true}],this._sCurrentCircleXtra != "compass");
									var5.addItem(this.api.lang.getText("BANNER_HELPER"),this,this.showCircleXtra,["helper",true,{bUpdateGauge:true}],this._sCurrentCircleXtra != "helper");
									var5.addItem(this.api.lang.getText("BANNER_MAP"),this,this.showCircleXtra,["map",true,{bMask:true,bUpdateGauge:true}],this._sCurrentCircleXtra != "map");
									var5.show(_root._xmouse,_root._ymouse,true);
								}
								else
								{
									this.api.kernel.GameManager.showPlayerPopupMenu(undefined,this.api.datacenter.Player.Name);
								}
								break loop0;
							default:
								switch(this._msShortcuts.currentTab)
								{
									case "Spells":
										this.api.sounds.events.onBannerSpellSelect();
										if(this.api.kernel.TutorialManager.isTutorialMode)
										{
											this.api.kernel.TutorialManager.onWaitingCase({code:"SPELL_CONTAINER_SELECT",params:[Number(var2.target._name.substr(4))]});
											break;
										}
										if(this.gapi.getUIComponent("Spells") != undefined)
										{
											return undefined;
										}
										var var6 = var2.target.contentData;
										if(var6 == undefined)
										{
											return undefined;
										}
										this.api.kernel.GameManager.switchToSpellLaunch(var6,true);
										break;
									case "Items":
										if(this.api.kernel.TutorialManager.isTutorialMode)
										{
											this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_CONTAINER_SELECT",params:[Number(var2.target._name.substr(4))]});
											break;
										}
										if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && (var2.target.contentData != undefined && !var2.target.notInChat))
										{
											this.api.kernel.GameManager.insertItemInChat(var2.target.contentData);
											return undefined;
										}
										var2.target.notInChat = false;
										var var7 = this.gapi.getUIComponent("Inventory");
										if(var7 != undefined)
										{
											var7.showItemInfos(var2.target.contentData);
											break;
										}
										var var8 = var2.target.contentData;
										if(var8 == undefined)
										{
											return undefined;
										}
										if(this.api.datacenter.Player.canUseObject)
										{
											if(var8.canTarget)
											{
												this.api.kernel.GameManager.switchToItemTarget(var8);
												break;
											}
											if(var8.canUse && var2.keyBoard)
											{
												this.api.network.Items.use(var8.ID);
												break;
											}
											break;
										}
										break;
								}
						}
				}
		}
	}
	function dblClick(var2)
	{
		if(var2.target == this._mcbMovableBar)
		{
			this._mcbMovableBar.size = this._mcbMovableBar.size != 0?0:this.api.kernel.OptionsManager.getOption("MovableBarSize");
			return undefined;
		}
	}
	function beforeFinalCountDown(var2)
	{
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FINAL_COUNTDOWN);
	}
	function finalCountDown(var2)
	{
		this._mcXtra._visible = false;
		this._lblFinalCountDown.text = var2.value;
	}
	function tictac(var2)
	{
		this.api.sounds.events.onBannerTimer();
	}
	function finish(var2)
	{
		this._mcXtra._visible = true;
		if(this._lblFinalCountDown.text != undefined)
		{
			this._lblFinalCountDown.text = "";
		}
	}
	function complete(var2)
	{
		var var3 = this.api.kernel.OptionsManager.getOption("BannerIllustrationMode");
		if(var2.target.contentPath.indexOf("artworks") != -1 && var3 == "helper")
		{
			this.showCircleXtra("helper",true);
		}
		else
		{
			this.api.colors.addSprite(this._mcXtra.content,this._oData.data);
		}
	}
	function over(var2)
	{
		if(!this.gapi.isCursorHidden())
		{
			return undefined;
		}
		loop0:
		switch(var2.target._name)
		{
			case "_btnHelp":
				this.gapi.showTooltip(this.api.lang.getText("CHAT_MENU"),var2.target,-20,{bXLimit:false,bYLimit:false});
				break;
			case "_btnGiveUp":
				if(this.api.datacenter.Game.isSpectator)
				{
					var var3 = this.api.lang.getText("GIVE_UP_SPECTATOR");
				}
				else if(this.api.datacenter.Game.fightType == dofus.managers.GameManager.FIGHT_TYPE_CHALLENGE || !this.api.datacenter.Basics.aks_current_server.isHardcore())
				{
					var3 = this.api.lang.getText("GIVE_UP");
				}
				else
				{
					var3 = this.api.lang.getText("SUICIDE");
				}
				this.gapi.showTooltip(var3,var2.target,-20,{bXLimit:true,bYLimit:false});
				break;
			case "_btnPvP":
				this.gapi.showTooltip(this.api.lang.getText("CONQUEST_WORD"),var2.target,-20,{bXLimit:true,bYLimit:false});
				break;
			case "_btnMount":
				this.gapi.showTooltip(this.api.lang.getText("MY_MOUNT"),var2.target,-20,{bXLimit:true,bYLimit:false});
				break;
			default:
				switch(null)
				{
					case "_btnGuild":
						this.gapi.showTooltip(this.api.lang.getText("YOUR_GUILD"),var2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					case "_btnStatsJob":
						this.gapi.showTooltip(this.api.lang.getText("YOUR_STATS_JOB"),var2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					case "_btnSpells":
						this.gapi.showTooltip(this.api.lang.getText("YOUR_SPELLS"),var2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					case "_btnQuests":
						this.gapi.showTooltip(this.api.lang.getText("YOUR_QUESTS"),var2.target,-20,{bXLimit:true,bYLimit:false});
						break loop0;
					case "_btnInventory":
						var var4 = new ank.utils.(this.api.datacenter.Player.currentWeight).addMiddleChar(" ",3);
						var var5 = new ank.utils.(this.api.datacenter.Player.maxWeight).addMiddleChar(" ",3);
						var var6 = this.api.lang.getText("PLAYER_WEIGHT",[var4,var5]);
						this.gapi.showTooltip(this.api.lang.getText("YOUR_INVENTORY") + "\n\n" + var6,var2.target,-43,{bXLimit:true,bYLimit:false});
						break loop0;
					default:
						switch(null)
						{
							case "_btnMap":
								this.gapi.showTooltip(this.api.lang.getText("YOUR_BOOK"),var2.target,-20,{bXLimit:true,bYLimit:false});
								break loop0;
							case "_btnFriends":
								this.gapi.showTooltip(this.api.lang.getText("YOUR_FRIENDS"),var2.target,-20,{bXLimit:true,bYLimit:false});
								break loop0;
							case "_btnFights":
								if(this._nFightsCount != 0)
								{
									this.gapi.showTooltip(ank.utils.PatternDecoder.combine(this.api.lang.getText("FIGHTS_ON_MAP",[this._nFightsCount]),"m",this._nFightsCount < 2),var2.target,-20,{bYLimit:false});
								}
								break loop0;
							case "_btnNextTurn":
								this.gapi.showTooltip(this.api.lang.getText("NEXT_TURN"),var2.target,-20,{bXLimit:true,bYLimit:false});
								break loop0;
							default:
								switch(null)
								{
									case "_pvAP":
										this.gapi.showTooltip(this.api.lang.getText("ACTIONPOINTS"),var2.target,-20,{bXLimit:true,bYLimit:false});
										break loop0;
									case "_pvMP":
										this.gapi.showTooltip(this.api.lang.getText("MOVEPOINTS"),var2.target,-20,{bXLimit:true,bYLimit:false});
										break loop0;
									case "_mcXtra":
										switch(this._sCurrentCircleXtra)
										{
											case "compass":
												var var7 = var2.target.targetCoords;
												if(var7 == undefined)
												{
													this.gapi.showTooltip(this.api.lang.getText("BANNER_SET_FLAG"),var2.target,0,{bXLimit:true,bYLimit:false});
												}
												else
												{
													this.gapi.showTooltip(var7[0] + ", " + var7[1],var2.target,0,{bXLimit:true,bYLimit:false});
												}
												break;
											case "clock":
												this.gapi.showTooltip(this.api.kernel.NightManager.time + "\n" + this.api.kernel.NightManager.getCurrentDateString(),var2.target,0,{bXLimit:true,bYLimit:false});
										}
										if(!this.api.datacenter.Game.isFight)
										{
											this.setXtraMask(this._mcCircleXtraMaskBig);
											this.moveHeart(true);
											dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
										}
										break loop0;
									case "_hHeart":
										this.gapi.showTooltip(this.api.lang.getText("HELP_LIFE"),var2.target,-20);
										break loop0;
									default:
										switch(this._msShortcuts.currentTab)
										{
											case "Spells":
												var var8 = var2.target.contentData;
												if(var8 != undefined)
												{
													this.gapi.showTooltip(var8.name + " (" + var8.apCost + " " + this.api.lang.getText("AP") + (var8.actualCriticalHit <= 0?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + var8.actualCriticalHit) + ")",var2.target,-20,{bXLimit:true,bYLimit:false});
												}
												break;
											case "Items":
												var var9 = var2.target.contentData;
												if(var9 != undefined)
												{
													var var10 = var9.name;
													if(this.gapi.getUIComponent("Inventory") == undefined)
													{
														if(var9.canUse && var9.canTarget)
														{
															var10 = var10 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK_CLICK"));
														}
														else
														{
															if(var9.canUse)
															{
																var10 = var10 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK"));
															}
															if(var9.canTarget)
															{
																var10 = var10 + ("\n" + this.api.lang.getText("HELP_SHORTCUT_CLICK"));
															}
														}
													}
													this.gapi.showTooltip(var10,var2.target,-30,{bXLimit:true,bYLimit:false});
													break;
												}
										}
								}
						}
				}
		}
	}
	function out(var2)
	{
		if((var var0 = var2.target._name) === "_mcXtra")
		{
			this.moveHeart(false);
			if(!this.api.datacenter.Game.isFight && this.api.kernel.OptionsManager.getOption("BannerGaugeMode") == "none")
			{
				this.setXtraMask(this._mcCircleXtraMaskBig);
			}
			else
			{
				this.setXtraMask(this._mcCircleXtraMask);
			}
			dofus.graphics.gapi.ui.banner.Gauge.showGaugeMode(this);
		}
		this.gapi.hideTooltip();
	}
	function drag(var2)
	{
		var var3 = var2.target.contentData;
		if(var3 == undefined)
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
		this.gapi.setCursor(var3,undefined,this._msShortcuts.currentTab == "Spells");
	}
	function drop(var2)
	{
		if((var var0 = var2.target) !== this._mcbMovableBar)
		{
			if((var0 = this._msShortcuts.currentTab) !== "Spells")
			{
				if(var0 === "Items")
				{
					if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
					{
						return undefined;
					}
					var var7 = this.gapi.getCursor();
					if(var7 == undefined)
					{
						return undefined;
					}
					if(!var7.canMoveToShortut)
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_MOVE_ITEM_HERE"),"ERROR_BOX");
						return undefined;
					}
					this.gapi.removeCursor();
					var var8 = var2.target.params.position + dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
					if(var7.position == var8)
					{
						return undefined;
					}
					if(var7.Quantity > 1)
					{
						var var9 = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:var7.Quantity,max:var7.Quantity,useAllStage:true,params:{type:"drop",item:var7,position:var8}},{bAlwaysOnTop:true});
						var9.addEventListener("validate",this);
					}
					else
					{
						this.api.network.Items.movement(var7.ID,var8,1);
					}
				}
			}
			else
			{
				if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
				{
					return undefined;
				}
				var var3 = this.gapi.getCursor();
				if(var3 == undefined)
				{
					return undefined;
				}
				this.gapi.removeCursor();
				var var4 = var3.position;
				var var5 = var2.target.params.position;
				if(var4 == var5)
				{
					return undefined;
				}
				if(var4 != undefined)
				{
					this._msShortcuts.getContainer(var4).contentData = undefined;
					this._oData.SpellsUsed.removeItemAt(var4);
				}
				var var6 = this._msShortcuts.getContainer(var5).contentData;
				if(var6 != undefined)
				{
					var6.position = undefined;
				}
				var3.position = var5;
				var2.target.contentData = var3;
				this._oData.SpellsUsed.addItemAt(var5,var3);
				this.api.network.Spells.moveToUsed(var3.ID,var5);
				this.addToQueue({object:this._msShortcuts,method:this._msShortcuts.setSpellStateOnAllContainers});
			}
		}
		else
		{
			this.api.kernel.OptionsManager.setOption("MovableBarCoord",{x:this._mcbMovableBar._x,y:this._mcbMovableBar._y,v:this._mcbMovableBar._bVertical});
		}
	}
	function filterChanged(var2)
	{
		this.api.network.Chat.subscribeChannels(var2.filter,var2.selected);
	}
	function lpChanged(var2)
	{
		this._hHeart.value = var2.value;
	}
	function lpMaxChanged(var2)
	{
		this._hHeart.max = var2.value;
	}
	function apChanged(var2)
	{
		this._pvAP.value = var2.value;
		if(!this.api.datacenter.Game.isFight)
		{
		}
		this._msShortcuts.setSpellStateOnAllContainers();
	}
	function mpChanged(var2)
	{
		this._pvMP.value = Math.max(0,var2.value);
	}
	function selectSmiley(var2)
	{
		this.api.network.Chat.useSmiley(var2.index);
	}
	function selectEmote(var2)
	{
		this.api.network.Emotes.useEmote(var2.index);
	}
	function spellLaunched(var2)
	{
		this._msShortcuts.setSpellStateOnContainer(var2.spell.position);
	}
	function nextTurn(var2)
	{
		this._msShortcuts.setSpellStateOnAllContainers();
	}
	function href(var2)
	{
		var var3 = var2.params.split(",");
		loop0:
		switch(var3[0])
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
						if(var3[2] != undefined && (String(var3[2]).length > 0 && var3[2] != ""))
						{
							this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showPlayerPopupMenu,params:[undefined,_global.unescape(var3[1]),null,null,null,var3[2],this.api.datacenter.Player.isAuthorized]});
						}
						else
						{
							this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showPlayerPopupMenu,params:[undefined,_global.unescape(var3[1]),null,null,null,null,this.api.datacenter.Player.isAuthorized]});
						}
						break loop0;
					case "ShowMessagePopupMenu":
						if(var3[3] != undefined && (String(var3[3]).length > 0 && var3[3] != ""))
						{
							this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showMessagePopupMenu,params:[var3[1],_global.unescape(var3[2]),var3[3]]});
						}
						else
						{
							this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showMessagePopupMenu,params:[var3[1],_global.unescape(var3[2])]});
						}
						break loop0;
					case "ShowItemViewer":
						var var4 = this.api.kernel.ChatManager.getItemFromBuffer(Number(var3[1]));
						if(var4 == undefined)
						{
							this.addToQueue({object:this.api.kernel,method:this.api.kernel.showMessage,params:[this.api.lang.getText("ERROR_WORD"),this.api.lang.getText("ERROR_ITEM_CANT_BE_DISPLAYED"),"ERROR_BOX"]});
							break loop0;
						}
						this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["ItemViewer","ItemViewer",{item:var4},{bAlwaysOnTop:true}]});
						break loop0;
					case "updateCompass":
						this.api.kernel.GameManager.updateCompass(Number(var3[1]),Number(var3[2]));
						break loop0;
					default:
						if(var0 !== "ShowLinkWarning")
						{
							break loop0;
						}
						this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["AskLinkWarning","AskLinkWarning",{text:this.api.lang.getText(var3[1])}]});
						break loop0;
				}
		}
	}
	function validate(var2)
	{
		if((var var0 = var2.params.type) === "drop")
		{
			this.gapi.removeCursor();
			if(var2.value > 0 && !_global.isNaN(Number(var2.value)))
			{
				this.api.network.Items.movement(var2.params.item.ID,var2.params.position,Math.min(var2.value,var2.params.item.Quantity));
			}
		}
	}
	function drawBar(var2)
	{
		this.linkMovableContainer();
		this._msShortcuts.updateCurrentTabInformations();
		this.updateEye();
	}
	function onSetFocus()
	{
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
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
