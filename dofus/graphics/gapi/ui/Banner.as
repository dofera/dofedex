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
   function __set__data(oData)
   {
      this._oData = oData;
      return this.__get__data();
   }
   function __set__fightsCount(nFightsCount)
   {
      this._nFightsCount = nFightsCount;
      this._btnFights._visible = nFightsCount != 0 && (!this.api.datacenter.Game.isFight && this._msShortcuts.currentTab == dofus.graphics.gapi.controls.MouseShortcuts.TAB_ITEMS);
      if(this._btnFights.icon == "")
      {
         this._btnFights.icon = "Eye2";
      }
      return this.__get__fightsCount();
   }
   function __get__chatAutoFocus()
   {
      return this._bChatAutoFocus;
   }
   function __set__chatAutoFocus(bChatAutoFocus)
   {
      this._bChatAutoFocus = bChatAutoFocus;
      return this.__get__chatAutoFocus();
   }
   function __set__txtConsole(sText)
   {
      this._txtConsole.text = sText;
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
      this._btnFights._visible = this._nFightsCount != 0 && (!this.api.datacenter.Game.isFight && this._msShortcuts.currentTab == dofus.graphics.gapi.controls.MouseShortcuts.TAB_ITEMS);
      if(this._btnFights.icon == "")
      {
         this._btnFights.icon = "Eye2";
      }
   }
   function setSelectable(bSelectable)
   {
      this._cChat.selectable = bSelectable;
   }
   function insertChat(sText)
   {
      this._txtConsole.text = this._txtConsole.text + sText;
   }
   function showNextTurnButton(bShow)
   {
      this._btnNextTurn._visible = bShow;
   }
   function showGiveUpButton(bShow)
   {
      this.setXtraFightMask(bShow);
      this._btnGiveUp._visible = bShow;
   }
   function showPoints(bShow)
   {
      this._pvAP._visible = bShow;
      this._pvMP._visible = bShow;
      this._cChat.showSitDown(!bShow);
      if(bShow)
      {
         this._oData.data.addEventListener("lpChanged",this);
         this._oData.data.addEventListener("apChanged",this);
         this._oData.data.addEventListener("mpChanged",this);
         this.apChanged({value:Math.max(0,this._oData.data.AP)});
         this.mpChanged({value:Math.max(0,this._oData.data.MP)});
      }
   }
   function setXtraFightMask(bInFight)
   {
      if(!bInFight)
      {
         if(this._sDefaultMaskType == "big")
         {
            this._mcXtra.setMask(this._mcCircleXtraMaskBig);
         }
         else
         {
            this._mcXtra.setMask(this._mcCircleXtraMask);
         }
      }
      else
      {
         this._mcXtra.setMask(this._mcCircleXtraMask);
      }
      this.displayMovableBar(this.api.kernel.OptionsManager.getOption("MovableBar") && (!this.api.kernel.OptionsManager.getOption("HideSpellBar") || this.api.datacenter.Game.isFight));
   }
   function showCircleXtra(sXtraName, bShow, oParams, oComponentParams)
   {
      if(sXtraName == undefined)
      {
         return null;
      }
      if(sXtraName == this._sCurrentCircleXtra && bShow)
      {
         return null;
      }
      if(sXtraName != this._sCurrentCircleXtra && !bShow)
      {
         return null;
      }
      if(this._sCurrentCircleXtra != undefined && bShow)
      {
         this.showCircleXtra(this._sCurrentCircleXtra,false);
      }
      var _loc7_ = new Object();
      var _loc8_ = new Array();
      if(oComponentParams == undefined)
      {
         oComponentParams = new Object();
      }
      this.api.kernel.OptionsManager.setOption("BannerIllustrationMode",sXtraName);
      switch(sXtraName)
      {
         case "artwork":
            var _loc6_ = "Loader";
            _loc7_ = {_x:this._mcCircleXtraMask._x,_y:this._mcCircleXtraMask._y,contentPath:dofus.Constants.GUILDS_FACES_PATH + this._oData.data.gfxID + ".swf",enabled:true};
            _loc8_ = ["complete","click"];
            break;
         case "compass":
            var _loc9_ = this.api.datacenter.Map;
            _loc6_ = "Compass";
            _loc7_ = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height,arrow:"UI_BannerCompassArrow",noArrow:"UI_BannerCompassNoArrow",background:"UI_BannerCompassBack",targetCoords:this.api.datacenter.Basics.banner_targetCoords,currentCoords:[_loc9_.x,_loc9_.y]};
            _loc8_ = ["click","over","out"];
            break;
         case "clock":
            _loc6_ = "Clock";
            _loc7_ = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height,arrowHours:"UI_BannerClockArrowHours",arrowMinutes:"UI_BannerClockArrowMinutes",background:"UI_BannerClockBack",updateFunction:{object:this.api.kernel.NightManager,method:this.api.kernel.NightManager.getCurrentTime}};
            _loc8_ = ["click","over","out"];
            break;
         case "helper":
            _loc6_ = "Loader";
            if(_global.doubleFramerate)
            {
               _loc7_ = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Helper_DoubleFramerate",enabled:true};
            }
            else
            {
               _loc7_ = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Helper",enabled:true};
            }
            _loc8_ = ["click","over","out"];
            break;
         case "map":
            _loc6_ = "MiniMap";
            _loc7_ = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,contentPath:"Map",enabled:true};
            _loc8_ = [];
            break;
         default:
            _loc6_ = "Loader";
            _loc7_ = {_x:this._mcCircleXtraPlacer._x,_y:this._mcCircleXtraPlacer._y,_width:this._mcCircleXtraPlacer._width,_height:this._mcCircleXtraPlacer._height};
      }
      var _loc10_ = null;
      if(bShow)
      {
         for(var k in _loc7_)
         {
            oComponentParams[k] = _loc7_[k];
         }
         _loc10_ = this.attachMovie(_loc6_,"_mcXtra",this.getNextHighestDepth(),oComponentParams);
         if(oParams.bMask)
         {
            this._sDefaultMaskType = oParams.sMaskSize;
            if(oParams.sMaskSize == "big" && !this.api.datacenter.Game.isFight)
            {
               this._mcXtra.setMask(this._mcCircleXtraMaskBig);
            }
            else
            {
               this._mcXtra.setMask(this._mcCircleXtraMask);
            }
         }
         for(var k in _loc8_)
         {
            this._mcXtra.addEventListener(_loc8_[k],this);
         }
         this._mcXtra.swapDepths(this._mcCircleXtraPlacer);
         this._sCurrentCircleXtra = sXtraName;
      }
      else if(this._mcXtra != undefined)
      {
         for(var k in _loc8_)
         {
            this._mcXtra.removeEventListener(_loc8_[k],this);
         }
         this._mcCircleXtraPlacer.swapDepths(this._mcXtra);
         this._mcXtra.removeMovieClip();
         delete this._sCurrentCircleXtra;
      }
      return _loc10_;
   }
   function setCircleXtraParams(oParams)
   {
      for(var k in oParams)
      {
         this._mcXtra[k] = oParams[k];
      }
   }
   function startTimer(nDuration)
   {
      this.setXtraFightMask(true);
      this._ccChrono.startTimer(nDuration);
   }
   function stopTimer()
   {
      this._ccChrono.stopTimer();
   }
   function setChatText(sText)
   {
      this._cChat.setText(sText);
   }
   function showRightPanel(sPanelName, oParams)
   {
      if(this._mcRightPanel.className == sPanelName)
      {
         return undefined;
      }
      if(this._mcRightPanel != undefined)
      {
         this.hideRightPanel();
      }
      oParams._x = this._mcRightPanelPlacer._x;
      oParams._y = this._mcRightPanelPlacer._y;
      var _loc4_ = this.attachMovie(sPanelName,"_mcRightPanel",this.getNextHighestDepth(),oParams);
      _loc4_.swapDepths(this._mcRightPanelPlacer);
   }
   function hideRightPanel()
   {
      if(this._mcRightPanel != undefined)
      {
         this._mcRightPanel.swapDepths(this._mcRightPanelPlacer);
         this._mcRightPanel.removeMovieClip();
      }
   }
   function updateSmileysEmotes()
   {
      this._cChat.updateSmileysEmotes();
   }
   function showSmileysEmotesPanel(bShow)
   {
      if(bShow == undefined)
      {
         bShow = true;
      }
      this._cChat.hideSmileys(!bShow);
      this._cChat._btnSmileys.selected = bShow;
   }
   function updateLocalPlayer()
   {
      if(this._sCurrentCircleXtra == "artwork")
      {
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
      var _loc2_ = this._mcbMovableBar.containers;
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         var _loc4_ = _loc2_[_loc3_];
         this._msShortcuts.setContainer(_loc3_ + 15,_loc4_);
         _loc4_.addEventListener("click",this);
         _loc4_.addEventListener("dblClick",this);
         _loc4_.addEventListener("over",this);
         _loc4_.addEventListener("out",this);
         _loc4_.addEventListener("drag",this);
         _loc4_.addEventListener("drop",this);
         _loc4_.params = {position:_loc3_ + 15};
         _loc3_ = _loc3_ + 1;
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
      this._oData.addEventListener("lpmaxChanged",this);
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
         case "compass":
            this.showCircleXtra("compass",true);
         case "helper":
            this.showCircleXtra("helper",true);
         case "map":
            this.showCircleXtra("map",true,{bMask:true,sMaskSize:"big"});
      }
      this.drawBar();
      this.lpmaxChanged({value:this._oData.LPmax});
      this.lpChanged({value:this._oData.LP});
      this.api.kernel.ChatManager.refresh();
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
   function setChatPrefix(sPrefix)
   {
      this._sChatPrefix = sPrefix;
      if(sPrefix != "")
      {
         this._btnHelp.label = sPrefix;
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
      var _loc2_ = this._txtConsole.text;
      var _loc3_ = _loc2_.split(" ");
      if(_loc3_[0].charAt(0) == "/")
      {
         return _loc2_;
      }
      if(this._sChatPrefix != "")
      {
         return this._sChatPrefix + " " + _loc2_;
      }
      return _loc2_;
   }
   function hideEpisodicContent()
   {
      this._btnPvP._visible = this.api.datacenter.Basics.aks_current_regional_version >= 16;
      this._btnMount._visible = this.api.datacenter.Basics.aks_current_regional_version >= 20;
      this._btnGuild._visible = !this.api.config.isStreaming;
      var _loc2_ = this._btnStatsJob._x;
      var _loc3_ = this._btnPvP._x;
      var _loc4_ = new Array();
      _loc4_.push(this._btnStatsJob);
      _loc4_.push(this._btnSpells);
      _loc4_.push(this._btnInventory);
      _loc4_.push(this._btnQuests);
      _loc4_.push(this._btnMap);
      _loc4_.push(this._btnFriends);
      if(this._btnGuild._visible)
      {
         _loc4_.push(this._btnGuild);
      }
      if(this._btnMount._visible)
      {
         _loc4_.push(this._btnMount);
      }
      if(this._btnPvP._visible)
      {
         _loc4_.push(this._btnPvP);
      }
      var _loc5_ = (_loc3_ - _loc2_) / (_loc4_.length - 1);
      var _loc6_ = 0;
      while(_loc6_ < _loc4_.length)
      {
         _loc4_[_loc6_]._x = _loc6_ * _loc5_ + _loc2_;
         _loc6_ = _loc6_ + 1;
      }
   }
   function displayChatHelp()
   {
      this.api.kernel.Console.process("/help");
      this._cChat.open(false);
   }
   function displayMovableBar(bShow)
   {
      if(bShow == undefined)
      {
         bShow = this._mcbMovableBar == undefined;
      }
      if(bShow)
      {
         if(this._mcbMovableBar._name != undefined)
         {
            return undefined;
         }
         this._mcbMovableBar = (dofus.graphics.gapi.ui.MovableContainerBar)this.api.ui.loadUIComponent("MovableContainerBar","MovableBar",[],{bAlwaysOnTop:true});
         this._mcbMovableBar.addEventListener("drawBar",this);
         this._mcbMovableBar.addEventListener("drop",this);
         this._mcbMovableBar.addEventListener("dblClick",this);
         var _loc3_ = {left:0,top:0,right:this.gapi.screenWidth,bottom:this.gapi.screenHeight};
         var _loc4_ = this.api.kernel.OptionsManager.getOption("MovableBarSize");
         var _loc5_ = this.api.kernel.OptionsManager.getOption("MovableBarCoord");
         _loc5_ = !_loc5_?{x:0,y:(this.gapi.screenHeight - this._mcbMovableBar._height) / 2}:_loc5_;
         this.addToQueue({object:this._mcbMovableBar,method:this._mcbMovableBar.setOptions,params:[9,20,_loc3_,_loc4_,_loc5_]});
      }
      else
      {
         this.api.ui.unloadUIComponent("MovableBar");
      }
   }
   function setMovableBarSize(nSize)
   {
      this._mcbMovableBar.size = nSize;
   }
   function onKeys(sKey)
   {
      if(this._lastKeyIsShortcut)
      {
         this._lastKeyIsShortcut = false;
         return undefined;
      }
      this.setChatFocusWithLastKey();
   }
   function onShortcut(sShortcut)
   {
      var _loc3_ = true;
      switch(sShortcut)
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
         case "ESCAPE":
            if(this.isChatFocus())
            {
               Selection.setFocus(null);
               _loc3_ = false;
            }
            break;
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
                  _loc3_ = false;
               }
            }
            else if(Selection.getFocus() == undefined && this._bChatAutoFocus)
            {
               this.setChatFocus();
            }
            break;
         case "TEAM_MESSAGE":
            if(this.isChatFocus())
            {
               if(this._txtConsole.text.length != 0)
               {
                  var _loc4_ = this.getChatCommand();
                  if(_loc4_.charAt(0) == "/")
                  {
                     _loc4_ = _loc4_.substr(_loc4_.indexOf(" ") + 1);
                  }
                  this.api.kernel.Console.process("/t " + _loc4_,this.api.datacenter.Basics.chatParams);
                  this.api.datacenter.Basics.chatParams = new Object();
                  if(this._txtConsole.text != undefined)
                  {
                     this._txtConsole.text = "";
                  }
                  _loc3_ = false;
               }
            }
            else if(Selection.getFocus() == undefined && this._bChatAutoFocus)
            {
               this.setChatFocus();
            }
            break;
         case "GUILD_MESSAGE":
            if(this.isChatFocus())
            {
               if(this._txtConsole.text.length != 0)
               {
                  var _loc5_ = this.getChatCommand();
                  if(_loc5_.charAt(0) == "/")
                  {
                     _loc5_ = _loc5_.substr(_loc5_.indexOf(" ") + 1);
                  }
                  this.api.kernel.Console.process("/g " + _loc5_,this.api.datacenter.Basics.chatParams);
                  this.api.datacenter.Basics.chatParams = new Object();
                  if(this._txtConsole.text != undefined)
                  {
                     this._txtConsole.text = "";
                  }
                  _loc3_ = false;
               }
            }
            else if(Selection.getFocus() == undefined && this._bChatAutoFocus)
            {
               this.setChatFocus();
            }
            break;
         case "WHISPER_HISTORY_UP":
            if(this.isChatFocus())
            {
               this._txtConsole.text = this.api.kernel.Console.getWhisperHistoryUp();
               this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
               _loc3_ = false;
            }
            break;
         case "WHISPER_HISTORY_DOWN":
            if(this.isChatFocus())
            {
               this._txtConsole.text = this.api.kernel.Console.getWhisperHistoryDown();
               this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
               _loc3_ = false;
            }
            break;
         case "HISTORY_UP":
            if(this.isChatFocus())
            {
               var _loc6_ = this.api.kernel.Console.getHistoryUp();
               if(_loc6_ != undefined)
               {
                  this.api.datacenter.Basics.chatParams = _loc6_.params;
                  this._txtConsole.text = _loc6_.value;
               }
               this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
               _loc3_ = false;
            }
            break;
         case "HISTORY_DOWN":
            if(this.isChatFocus())
            {
               var _loc7_ = this.api.kernel.Console.getHistoryDown();
               if(_loc7_ != undefined)
               {
                  this.api.datacenter.Basics.chatParams = _loc7_.params;
                  this._txtConsole.text = _loc7_.value;
               }
               else
               {
                  this._txtConsole.text = "";
               }
               this.addToQueue({object:this,method:this.placeCursorAtTheEnd});
               _loc3_ = false;
            }
            break;
         case "AUTOCOMPLETE":
            var _loc8_ = new Array();
            var _loc9_ = this.api.datacenter.Sprites.getItems();
            for(var k in _loc9_)
            {
               if(_loc9_[k] instanceof dofus.datacenter.Character)
               {
                  _loc8_.push(_loc9_[k].name);
               }
            }
            var _loc10_ = this.api.kernel.Console.autoCompletion(_loc8_,this._txtConsole.text);
            if(!_loc10_.isFull)
            {
               if(_loc10_.list == undefined || _loc10_.list.length == 0)
               {
                  this.api.sounds.events.onError();
               }
               else
               {
                  this.api.ui.showTooltip(_loc10_.list.sort().join(", "),0,520);
               }
            }
            this._txtConsole.text = _loc10_.result + (!_loc10_.isFull?"":" ");
            this.placeCursorAtTheEnd();
            break;
         case "NEXTTURN":
            if(this.api.datacenter.Game.isFight)
            {
               this.api.network.Game.turnEnd();
               _loc3_ = false;
            }
            break;
         case "MAXI":
            this._cChat.open(false);
            _loc3_ = false;
            break;
         case "MINI":
            this._cChat.open(true);
            _loc3_ = false;
            break;
         case "CHARAC":
            if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
            {
               this.click({target:this._btnStatsJob});
               _loc3_ = false;
            }
            break;
         case "SPELLS":
            if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
            {
               this.click({target:this._btnSpells});
               _loc3_ = false;
            }
            break;
         case "INVENTORY":
            if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
            {
               this.click({target:this._btnInventory});
               _loc3_ = false;
            }
            break;
         case "QUESTS":
            if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
            {
               this.click({target:this._btnQuests});
               _loc3_ = false;
            }
            break;
         case "MAP":
            if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
            {
               this.click({target:this._btnMap});
               _loc3_ = false;
            }
            break;
         case "FRIENDS":
            if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
            {
               this.click({target:this._btnFriends});
               _loc3_ = false;
            }
            break;
         case "GUILD":
            if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
            {
               this.click({target:this._btnGuild});
               _loc3_ = false;
            }
            break;
         case "MOUNT":
            if(this.api.kernel.OptionsManager.getOption("BannerShortcuts"))
            {
               this.click({target:this._btnMount});
               _loc3_ = false;
            }
      }
      this._lastKeyIsShortcut = _loc3_;
      return _loc3_;
   }
   function click(oEvent)
   {
      this.api.kernel.GameManager.signalFightActivity();
      switch(oEvent.target._name)
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
               if(this.gapi.getUIComponent("MountAncestorsViewer") != undefined)
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
         case "_btnInventory":
            this.api.sounds.events.onBannerRoundButtonClick();
            this.showSmileysEmotesPanel(false);
            this.gapi.loadUIAutoHideComponent("Inventory","Inventory");
            break;
         case "_btnQuests":
            this.api.sounds.events.onBannerRoundButtonClick();
            this.showSmileysEmotesPanel(false);
            this.gapi.loadUIAutoHideComponent("Quests","Quests");
            break;
         case "_btnMap":
            this.api.sounds.events.onBannerRoundButtonClick();
            this.showSmileysEmotesPanel(false);
            this.gapi.loadUIAutoHideComponent("MapExplorer","MapExplorer");
            break;
         case "_btnFriends":
            this.api.sounds.events.onBannerRoundButtonClick();
            this.showSmileysEmotesPanel(false);
            this.gapi.loadUIAutoHideComponent("Friends","Friends");
            break;
         case "_btnFights":
            if(!this.api.datacenter.Game.isFight)
            {
               this.gapi.loadUIComponent("FightsInfos","FightsInfos");
            }
            break;
         case "_btnHelp":
            var _loc3_ = this.api.lang.getConfigText("CHAT_FILTERS");
            var _loc4_ = this.api.ui.createPopupMenu();
            _loc4_.addStaticItem(this.api.lang.getText("CHAT_PREFIX"));
            _loc4_.addItem(this.api.lang.getText("DEFAUT"),this,this.setChatPrefix,[""]);
            _loc4_.addItem(this.api.lang.getText("TEAM") + " (/t)",this,this.setChatPrefix,["/t"],this.api.datacenter.Game.isFight);
            _loc4_.addItem(this.api.lang.getText("PARTY") + " (/p)",this,this.setChatPrefix,["/p"],this.api.ui.getUIComponent("Party") != undefined);
            _loc4_.addItem(this.api.lang.getText("GUILD") + " (/g)",this,this.setChatPrefix,["/g"],this.api.datacenter.Player.guildInfos != undefined);
            if(_loc3_[4])
            {
               _loc4_.addItem(this.api.lang.getText("ALIGNMENT") + " (/a)",this,this.setChatPrefix,["/a"],this.api.datacenter.Player.alignment.index != 0);
            }
            if(_loc3_[5])
            {
               _loc4_.addItem(this.api.lang.getText("RECRUITMENT") + " (/r)",this,this.setChatPrefix,["/r"]);
            }
            if(_loc3_[6])
            {
               _loc4_.addItem(this.api.lang.getText("TRADE") + " (/b)",this,this.setChatPrefix,["/b"]);
            }
            if(_loc3_[7])
            {
               _loc4_.addItem(this.api.lang.getText("MEETIC") + " (/i)",this,this.setChatPrefix,["/i"]);
            }
            if(this.api.datacenter.Player.isAuthorized)
            {
               _loc4_.addItem(this.api.lang.getText("PRIVATE_CHANNEL") + " (/q)",this,this.setChatPrefix,["/q"]);
            }
            _loc4_.addItem(this.api.lang.getText("HELP"),this,this.displayChatHelp,[]);
            _loc4_.show(this._btnHelp._x,this._btnHelp._y,true);
            break;
         case "_btnNextTurn":
            if(this.api.datacenter.Game.isFight)
            {
               this.api.network.Game.turnEnd();
            }
            break;
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
            break;
         case "_mcXtra":
            if(!Key.isDown(Key.SHIFT))
            {
               if(this._sCurrentCircleXtra == "helper" && dofus.managers.TipsManager.getInstance().hasNewTips())
               {
                  dofus.managers.TipsManager.getInstance().displayNextTips();
                  break;
               }
               var _loc5_ = this.api.ui.createPopupMenu();
               if(this._sCurrentCircleXtra == "helper")
               {
                  _loc5_.addStaticItem(this.api.lang.getText("HELP_ME"));
                  _loc5_.addItem(this.api.lang.getText("KB_TITLE"),this.api.ui,this.api.ui.loadUIComponent,["KnownledgeBase","KnownledgeBase"],true);
                  _loc5_.addStaticItem(this.api.lang.getText("OTHER_DISPLAY_OPTIONS"));
               }
               _loc5_.addItem(this.api.lang.getText("BANNER_ARTWORK"),this,this.showCircleXtra,["artwork",true,{bMask:true}],this._sCurrentCircleXtra != "artwork");
               _loc5_.addItem(this.api.lang.getText("BANNER_CLOCK"),this,this.showCircleXtra,["clock",true,{bMask:true}],this._sCurrentCircleXtra != "clock");
               _loc5_.addItem(this.api.lang.getText("BANNER_COMPASS"),this,this.showCircleXtra,["compass",true],this._sCurrentCircleXtra != "compass");
               _loc5_.addItem(this.api.lang.getText("BANNER_HELPER"),this,this.showCircleXtra,["helper",true],this._sCurrentCircleXtra != "helper");
               _loc5_.addItem(this.api.lang.getText("BANNER_MAP"),this,this.showCircleXtra,["map",true,{bMask:true,sMaskSize:"big"}],this._sCurrentCircleXtra != "map");
               _loc5_.show(_root._xmouse,_root._ymouse,true);
            }
            else
            {
               this.api.kernel.GameManager.showPlayerPopupMenu(undefined,this.api.datacenter.Player.Name);
            }
            break;
         default:
            switch(this._msShortcuts.currentTab)
            {
               case "Spells":
                  this.api.sounds.events.onBannerSpellSelect();
                  if(this.api.kernel.TutorialManager.isTutorialMode)
                  {
                     this.api.kernel.TutorialManager.onWaitingCase({code:"SPELL_CONTAINER_SELECT",params:[Number(oEvent.target._name.substr(4))]});
                     break;
                  }
                  if(this.gapi.getUIComponent("Spells") != undefined)
                  {
                     return undefined;
                  }
                  var _loc6_ = oEvent.target.contentData;
                  if(_loc6_ == undefined)
                  {
                     return undefined;
                  }
                  this.api.kernel.GameManager.switchToSpellLaunch(_loc6_,true);
                  break;
               case "Items":
                  if(this.api.kernel.TutorialManager.isTutorialMode)
                  {
                     this.api.kernel.TutorialManager.onWaitingCase({code:"OBJECT_CONTAINER_SELECT",params:[Number(oEvent.target._name.substr(4))]});
                     break;
                  }
                  if(Key.isDown(dofus.Constants.CHAT_INSERT_ITEM_KEY) && (oEvent.target.contentData != undefined && !oEvent.target.notInChat))
                  {
                     this.api.kernel.GameManager.insertItemInChat(oEvent.target.contentData);
                     return undefined;
                  }
                  oEvent.target.notInChat = false;
                  var _loc7_ = this.gapi.getUIComponent("Inventory");
                  if(_loc7_ != undefined)
                  {
                     _loc7_.showItemInfos(oEvent.target.contentData);
                  }
                  else
                  {
                     var _loc8_ = oEvent.target.contentData;
                     if(_loc8_ == undefined)
                     {
                        return undefined;
                     }
                     if(this.api.datacenter.Player.canUseObject)
                     {
                        if(_loc8_.canTarget)
                        {
                           this.api.kernel.GameManager.switchToItemTarget(_loc8_);
                        }
                        else if(_loc8_.canUse && oEvent.keyBoard)
                        {
                           this.api.network.Items.use(_loc8_.ID);
                        }
                     }
                  }
                  break;
            }
      }
   }
   function dblClick(oEvent)
   {
      if(oEvent.target == this._mcbMovableBar)
      {
         this._mcbMovableBar.size = this._mcbMovableBar.size != 0?0:this.api.kernel.OptionsManager.getOption("MovableBarSize");
         return undefined;
      }
   }
   function beforeFinalCountDown(oEvent)
   {
      this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_FINAL_COUNTDOWN);
   }
   function finalCountDown(oEvent)
   {
      this._mcXtra._visible = false;
      this._lblFinalCountDown.text = oEvent.value;
   }
   function tictac(oEvent)
   {
      this.api.sounds.events.onBannerTimer();
   }
   function finish(oEvent)
   {
      this._mcXtra._visible = true;
      if(this._lblFinalCountDown.text != undefined)
      {
         this._lblFinalCountDown.text = "";
      }
   }
   function complete(oEvent)
   {
      var _loc3_ = this.api.kernel.OptionsManager.getOption("BannerIllustrationMode");
      if(oEvent.target.contentPath.indexOf("artworks") != -1 && _loc3_ == "helper")
      {
         this.showCircleXtra("helper",true);
      }
      else
      {
         this.api.colors.addSprite(this._mcXtra.content,this._oData.data);
      }
   }
   function over(oEvent)
   {
      if(!this.gapi.isCursorHidden())
      {
         return undefined;
      }
      switch(oEvent.target._name)
      {
         case "_btnHelp":
            this.gapi.showTooltip(this.api.lang.getText("CHAT_MENU"),oEvent.target,-20,{bXLimit:false,bYLimit:false});
            break;
         case "_btnGiveUp":
            if(this.api.datacenter.Game.isSpectator)
            {
               var _loc3_ = this.api.lang.getText("GIVE_UP_SPECTATOR");
            }
            else if(this.api.datacenter.Game.fightType == dofus.managers.GameManager.FIGHT_TYPE_CHALLENGE || !this.api.datacenter.Basics.aks_current_server.isHardcore())
            {
               _loc3_ = this.api.lang.getText("GIVE_UP");
            }
            else
            {
               _loc3_ = this.api.lang.getText("SUICIDE");
            }
            this.gapi.showTooltip(_loc3_,oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnPvP":
            this.gapi.showTooltip(this.api.lang.getText("CONQUEST_WORD"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnMount":
            this.gapi.showTooltip(this.api.lang.getText("MY_MOUNT"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnGuild":
            this.gapi.showTooltip(this.api.lang.getText("YOUR_GUILD"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnStatsJob":
            this.gapi.showTooltip(this.api.lang.getText("YOUR_STATS_JOB"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnSpells":
            this.gapi.showTooltip(this.api.lang.getText("YOUR_SPELLS"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnQuests":
            this.gapi.showTooltip(this.api.lang.getText("YOUR_QUESTS"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnInventory":
            this.gapi.showTooltip(this.api.lang.getText("YOUR_INVENTORY"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnMap":
            this.gapi.showTooltip(this.api.lang.getText("YOUR_BOOK"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnFriends":
            this.gapi.showTooltip(this.api.lang.getText("YOUR_FRIENDS"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_btnFights":
            if(this._nFightsCount != 0)
            {
               this.gapi.showTooltip(ank.utils.PatternDecoder.combine(this.api.lang.getText("FIGHTS_ON_MAP",[this._nFightsCount]),"m",this._nFightsCount < 2),oEvent.target,-20,{bYLimit:false});
            }
            break;
         case "_btnNextTurn":
            this.gapi.showTooltip(this.api.lang.getText("NEXT_TURN"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_pvAP":
            this.gapi.showTooltip(this.api.lang.getText("ACTIONPOINTS"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_pvMP":
            this.gapi.showTooltip(this.api.lang.getText("MOVEPOINTS"),oEvent.target,-20,{bXLimit:true,bYLimit:false});
            break;
         case "_mcXtra":
            switch(this._sCurrentCircleXtra)
            {
               case "compass":
                  var _loc4_ = oEvent.target.targetCoords;
                  if(_loc4_ == undefined)
                  {
                     this.gapi.showTooltip(this.api.lang.getText("BANNER_SET_FLAG"),oEvent.target,0,{bXLimit:true,bYLimit:false});
                  }
                  else
                  {
                     this.gapi.showTooltip(_loc4_[0] + ", " + _loc4_[1],oEvent.target,0,{bXLimit:true,bYLimit:false});
                  }
                  break;
               case "clock":
                  this.gapi.showTooltip(this.api.kernel.NightManager.time + "\n" + this.api.kernel.NightManager.getCurrentDateString(),oEvent.target,0,{bXLimit:true,bYLimit:false});
                  break;
               case "map":
                  this.gapi.showTooltip(oEvent.target.tooltip,oEvent.target,0,{bXLimit:true,bYLimit:false});
            }
            break;
         case "_hHeart":
            this.gapi.showTooltip(this.api.lang.getText("HELP_LIFE"),oEvent.target,-20);
            break;
         default:
            switch(this._msShortcuts.currentTab)
            {
               case "Spells":
                  var _loc5_ = oEvent.target.contentData;
                  if(_loc5_ != undefined)
                  {
                     this.gapi.showTooltip(_loc5_.name + " (" + _loc5_.apCost + " " + this.api.lang.getText("AP") + (_loc5_.actualCriticalHit <= 0?"":", " + this.api.lang.getText("ACTUAL_CRITICAL_CHANCE") + ": 1/" + _loc5_.actualCriticalHit) + ")",oEvent.target,-20,{bXLimit:true,bYLimit:false});
                  }
                  break;
               case "Items":
                  var _loc6_ = oEvent.target.contentData;
                  if(_loc6_ != undefined)
                  {
                     var _loc7_ = _loc6_.name;
                     if(this.gapi.getUIComponent("Inventory") == undefined)
                     {
                        if(_loc6_.canUse && _loc6_.canTarget)
                        {
                           _loc7_ = _loc7_ + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK_CLICK"));
                        }
                        else
                        {
                           if(_loc6_.canUse)
                           {
                              _loc7_ = _loc7_ + ("\n" + this.api.lang.getText("HELP_SHORTCUT_DBLCLICK"));
                           }
                           if(_loc6_.canTarget)
                           {
                              _loc7_ = _loc7_ + ("\n" + this.api.lang.getText("HELP_SHORTCUT_CLICK"));
                           }
                        }
                     }
                     this.gapi.showTooltip(_loc7_,oEvent.target,-30,{bXLimit:true,bYLimit:false});
                  }
            }
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function drag(oEvent)
   {
      var _loc3_ = oEvent.target.contentData;
      if(_loc3_ == undefined)
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
      this.gapi.setCursor(_loc3_);
   }
   function drop(oEvent)
   {
      if((var _loc0_ = oEvent.target) !== this._mcbMovableBar)
      {
         switch(this._msShortcuts.currentTab)
         {
            case "Spells":
               if(this.gapi.getUIComponent("Spells") == undefined && !Key.isDown(Key.SHIFT))
               {
                  return undefined;
               }
               var _loc3_ = this.gapi.getCursor();
               if(_loc3_ == undefined)
               {
                  return undefined;
               }
               this.gapi.removeCursor();
               var _loc4_ = _loc3_.position;
               var _loc5_ = oEvent.target.params.position;
               if(_loc4_ == _loc5_)
               {
                  return undefined;
               }
               if(_loc4_ != undefined)
               {
                  this._msShortcuts.getContainer(_loc4_).contentData = undefined;
                  this._oData.SpellsUsed.removeItemAt(_loc4_);
               }
               var _loc6_ = this._msShortcuts.getContainer(_loc5_).contentData;
               if(_loc6_ != undefined)
               {
                  _loc6_.position = undefined;
               }
               _loc3_.position = _loc5_;
               oEvent.target.contentData = _loc3_;
               this._oData.SpellsUsed.addItemAt(_loc5_,_loc3_);
               this.api.network.Spells.moveToUsed(_loc3_.ID,_loc5_);
               this.addToQueue({object:this._msShortcuts,method:this._msShortcuts.setSpellStateOnAllContainers});
               break;
            case "Items":
               if(this.gapi.getUIComponent("Inventory") == undefined && !Key.isDown(Key.SHIFT))
               {
                  return undefined;
               }
               var _loc7_ = this.gapi.getCursor();
               if(_loc7_ == undefined)
               {
                  return undefined;
               }
               if(!_loc7_.canMoveToShortut)
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_MOVE_ITEM_HERE"),"ERROR_BOX");
                  return undefined;
               }
               this.gapi.removeCursor();
               var _loc8_ = oEvent.target.params.position + dofus.graphics.gapi.controls.MouseShortcuts.ITEM_OFFSET;
               if(_loc7_.position == _loc8_)
               {
                  return undefined;
               }
               if(_loc7_.Quantity > 1)
               {
                  var _loc9_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:_loc7_.Quantity,max:_loc7_.Quantity,useAllStage:true,params:{type:"drop",item:_loc7_,position:_loc8_}},{bAlwaysOnTop:true});
                  _loc9_.addEventListener("validate",this);
               }
               else
               {
                  this.api.network.Items.movement(_loc7_.ID,_loc8_,1);
               }
               break;
         }
      }
      else
      {
         this.api.kernel.OptionsManager.setOption("MovableBarCoord",{x:this._mcbMovableBar._x,y:this._mcbMovableBar._y});
      }
   }
   function filterChanged(oEvent)
   {
      this.api.network.Chat.subscribeChannels(oEvent.filter,oEvent.selected);
   }
   function lpChanged(oEvent)
   {
      this._hHeart.value = oEvent.value;
   }
   function lpmaxChanged(oEvent)
   {
      this._hHeart.max = oEvent.value;
   }
   function apChanged(oEvent)
   {
      this._pvAP.value = oEvent.value;
      if(!this.api.datacenter.Game.isFight)
      {
      }
      this._msShortcuts.setSpellStateOnAllContainers();
   }
   function mpChanged(oEvent)
   {
      this._pvMP.value = Math.max(0,oEvent.value);
   }
   function selectSmiley(oEvent)
   {
      this.api.network.Chat.useSmiley(oEvent.index);
   }
   function selectEmote(oEvent)
   {
      this.api.network.Emotes.useEmote(oEvent.index);
   }
   function spellLaunched(oEvent)
   {
      this._msShortcuts.setSpellStateOnContainer(oEvent.spell.position);
   }
   function nextTurn(oEvent)
   {
      this._msShortcuts.setSpellStateOnAllContainers();
   }
   function href(oEvent)
   {
      var _loc3_ = oEvent.params.split(",");
      switch(_loc3_[0])
      {
         case "OpenGuildTaxCollectors":
            this.addToQueue({object:this.gapi,method:this.gapi.loadUIAutoHideComponent,params:["Guild","Guild",{currentTab:"TaxCollectors"},{bStayIfPresent:true}]});
            break;
         case "OpenPayZoneDetails":
            this.addToQueue({object:this.gapi,method:this.gapi.loadUIComponent,params:["PayZoneDialog2","PayZoneDialog2",{name:"El Pemy",gfx:"9059",dialogID:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS},{bForceLoad:true}]});
            break;
         case "ShowPlayerPopupMenu":
            if(_loc3_[2] != undefined && (String(_loc3_[2]).length > 0 && _loc3_[2] != ""))
            {
               this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showPlayerPopupMenu,params:[undefined,_loc3_[1],null,null,null,_loc3_[2],this.api.datacenter.Player.isAuthorized]});
            }
            else
            {
               this.addToQueue({object:this.api.kernel.GameManager,method:this.api.kernel.GameManager.showPlayerPopupMenu,params:[undefined,_loc3_[1]]});
            }
            break;
         case "ShowItemViewer":
            var _loc4_ = this.api.kernel.ChatManager.getItemFromBuffer(Number(_loc3_[1]));
            if(_loc4_ == undefined)
            {
               this.addToQueue({object:this.api.kernel,method:this.api.kernel.showMessage,params:[this.api.lang.getText("ERROR_WORD"),this.api.lang.getText("ERROR_ITEM_CANT_BE_DISPLAYED"),"ERROR_BOX"]});
               break;
            }
            this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["ItemViewer","ItemViewer",{item:_loc4_},{bAlwaysOnTop:true}]});
            break;
         case "updateCompass":
            this.api.kernel.GameManager.updateCompass(Number(_loc3_[1]),Number(_loc3_[2]));
            break;
         case "ShowLinkWarning":
            this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["AskLinkWarning","AskLinkWarning",{text:this.api.lang.getText(_loc3_[1])}]});
      }
   }
   function validate(oEvent)
   {
      if((var _loc0_ = oEvent.params.type) === "drop")
      {
         this.gapi.removeCursor();
         if(oEvent.value > 0 && !_global.isNaN(Number(oEvent.value)))
         {
            this.api.network.Items.movement(oEvent.params.item.ID,oEvent.params.position,Math.min(oEvent.value,oEvent.params.item.Quantity));
         }
      }
   }
   function drawBar(oEvent)
   {
      this.linkMovableContainer();
      this._msShortcuts.updateCurrentTabInformations();
      if(this._msShortcuts.currentTab == dofus.graphics.gapi.controls.MouseShortcuts.TAB_SPELLS)
      {
         this._btnFights._visible = false;
      }
      else
      {
         this._btnFights._visible = this._nFightsCount != 0 && !this.api.datacenter.Game.isFight;
      }
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
