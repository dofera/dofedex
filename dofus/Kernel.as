class dofus.Kernel extends dofus.utils.ApiElement
{
   var XTRA_LANG_FILES_LOADED = false;
   function Kernel(oAPI)
   {
      super();
      this.initialize(oAPI);
      if(this.AudioManager == null)
      {
         dofus.sounds.AudioManager.initialize(_root.createEmptyMovieClip("SoundNest",99999),oAPI);
         this.AudioManager = dofus.sounds.AudioManager.getInstance();
      }
      if((this.CharactersManager = dofus.managers.CharactersManager.getInstance()) == null)
      {
         this.CharactersManager = new dofus.managers.CharactersManager(oAPI);
      }
      if((this.ChatManager = dofus.managers.ChatManager.getInstance()) == null)
      {
         this.ChatManager = new dofus.managers.ChatManager(oAPI);
      }
      if((this.MapsServersManager = dofus.managers.MapsServersManager.getInstance()) == null)
      {
         this.MapsServersManager = new dofus.managers.MapsServersManager();
      }
      if((this.DocumentsServersManager = dofus.managers.DocumentsServersManager.getInstance()) == null)
      {
         this.DocumentsServersManager = new dofus.managers.DocumentsServersManager();
      }
      if((this.TutorialServersManager = dofus.managers.TutorialServersManager.getInstance()) == null)
      {
         this.TutorialServersManager = new dofus.managers.TutorialServersManager();
      }
      if((this.GameManager = dofus.managers.GameManager.getInstance()) == null)
      {
         this.GameManager = new dofus.managers.GameManager(oAPI);
      }
      if((this.KeyManager = dofus.managers.KeyManager.getInstance()) == null)
      {
         this.KeyManager = new dofus.managers.KeyManager(oAPI);
      }
      if((this.NightManager = dofus.managers.NightManager.getInstance()) == null)
      {
         this.NightManager = new dofus.managers.NightManager(oAPI);
      }
      if((this.AreasManager = dofus.managers.AreasManager.getInstance()) == null)
      {
         this.AreasManager = new dofus.managers.AreasManager();
      }
      if((this.TutorialManager = dofus.managers.TutorialManager.getInstance()) == null)
      {
         this.TutorialManager = new dofus.managers.TutorialManager(oAPI);
      }
      this.Console = new dofus.utils.consoleParsers.ChatConsoleParser(oAPI);
      this.DebugConsole = new dofus.utils.consoleParsers.DebugConsoleParser(oAPI);
      if((this.OptionsManager = dofus.managers.OptionsManager.getInstance()) == null)
      {
         this.OptionsManager = new dofus.managers.OptionsManager(oAPI);
      }
      if((this.AdminManager = dofus.managers.AdminManager.getInstance()) == null)
      {
         this.AdminManager = new dofus.managers.AdminManager(oAPI);
      }
      if((this.DebugManager = dofus.managers.DebugManager.getInstance()) == null)
      {
         this.DebugManager = new dofus.managers.DebugManager(oAPI);
      }
      if((this.TipsManager = dofus.managers.TipsManager.getInstance()) == null)
      {
         this.TipsManager = new dofus.managers.TipsManager(oAPI);
      }
      if((this.SpellsBoostsManager = dofus.managers.SpellsBoostsManager.getInstance()) == null)
      {
         this.SpellsBoostsManager = new dofus.managers.SpellsBoostsManager(oAPI);
      }
      if((this.SpeakingItemsManager = dofus.managers.SpeakingItemsManager.getInstance()) == null)
      {
         this.SpeakingItemsManager = new dofus.managers.SpeakingItemsManager(oAPI);
      }
      if((this.StreamingDisplayManager = dofus.managers.StreamingDisplayManager.getInstance()) == null)
      {
         this.StreamingDisplayManager = new dofus.managers.StreamingDisplayManager(oAPI);
      }
      dofus.managers.UIdManager.getInstance().update();
      this._sendScreenInfoTimer = _global.setInterval(this,"sendScreenInfo",1000);
   }
   function sendScreenInfo()
   {
      if(!this.api.datacenter.Basics.inGame || (this.api.datacenter.Game.isFight || this.api.datacenter.Game.isRunning))
      {
         return undefined;
      }
      _global.clearInterval(this._sendScreenInfoTimer);
      this.OptionsManager.setOption("sendResolution",true);
      this.api.network.Infos.sendScreenInfo();
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
   }
   function start()
   {
      this.api.ui.setScreenSize(742,556);
      if(this.OptionsManager.getOption("DisplayStyle") == "medium" && (System.capabilities.screenResolutionY < 950 && System.capabilities.playerType != "StandAlone"))
      {
         this.OptionsManager.setOption("DisplayStyle","normal");
      }
      else
      {
         this.setDisplayStyle(this.OptionsManager.getOption("DisplayStyle"),true);
      }
      if(this.api.config.isStreaming)
      {
         if(this.api.config.streamingMethod == "explod")
         {
            this.api.gfx.setStreaming(true,dofus.Constants.GFX_OBJECTS_PATH,dofus.Constants.GFX_GROUNDS_PATH);
         }
         this.api.gfx.setStreamingMethod(this.api.config.streamingMethod);
      }
      this.setQuality(this.OptionsManager.getOption("DefaultQuality"));
      this.manualLogon();
   }
   function quit(bAsk)
   {
      if(bAsk == undefined)
      {
         bAsk = true;
      }
      if(!bAsk)
      {
         if(System.capabilities.playerType == "StandAlone")
         {
            getURL("FSCommand:" add "quit","");
         }
         else
         {
            _level0._loader.closeBrowserWindow();
         }
      }
      else
      {
         this.showMessage(undefined,this.api.lang.getText("DO_U_QUIT"),"CAUTION_YESNO",{name:"Quit"});
      }
   }
   function disconnect()
   {
      this.showMessage(undefined,this.api.lang.getText("DO_U_DISCONNECT"),"CAUTION_YESNO",{name:"Disconnect"});
   }
   function reboot()
   {
      this.api.network.disconnect(false,false);
      this.addToQueue({object:_level0._loader,method:_level0._loader.reboot});
   }
   function setQuality(quality)
   {
      _root._quality = quality;
   }
   function setDisplayStyle(sStyle, bDontShowError)
   {
      if(System.capabilities.playerType == "StandAlone" && System.capabilities.os.indexOf("Windows") != -1)
      {
         var _loc4_ = new ank.external.display.ScreenResolution();
         switch(sStyle)
         {
            case "normal":
               _loc4_.disable();
               break;
            case "medium":
               _loc4_.addEventListener("onScreenResolutionError",this);
               _loc4_.addEventListener("onScreenResolutionSuccess",this);
               if(bDontShowError != true)
               {
                  _loc4_.addEventListener("onExternalError",this);
               }
               _loc4_.enable(800,600,32);
               break;
            case "maximized":
               _loc4_.addEventListener("onScreenResolutionError",this);
               _loc4_.addEventListener("onScreenResolutionSuccess",this);
               if(bDontShowError != true)
               {
                  _loc4_.addEventListener("onExternalError",this);
               }
               _loc4_.enable(1024,768,32);
         }
      }
      else
      {
         _level0._loader.setDisplayStyle(sStyle);
      }
   }
   function changeServer(bNotConfirm)
   {
      if(bNotConfirm == true)
      {
         this.api.network.disconnect(true,false,true);
      }
      else
      {
         this.showMessage(undefined,this.api.lang.getText("DO_U_SWITCH_CHARACTER"),"CAUTION_YESNO",{name:"ChangeCharacter"});
      }
   }
   function showMessage(sTitle, sMsg, sType, oParams, sUniqId)
   {
      switch(sType)
      {
         case "CAUTION_YESNO":
            if(sTitle == undefined)
            {
               sTitle = this.api.lang.getText("CAUTION");
            }
            var _loc7_ = this.api.ui.loadUIComponent("AskYesNo","AskYesNo" + (oParams.name == undefined?"":oParams.name),{title:sTitle,text:sMsg,params:oParams.params},{bForceLoad:true});
            _loc7_.addEventListener("yes",oParams.listener != undefined?oParams.listener:this);
            _loc7_.addEventListener("no",oParams.listener != undefined?oParams.listener:this);
            break;
         case "CAUTION_YESNOIGNORE":
            if(sTitle == undefined)
            {
               sTitle = this.api.lang.getText("CAUTION");
            }
            var _loc8_ = this.api.ui.loadUIComponent("AskYesNoIgnore","AskYesNoIgnore" + (oParams.name == undefined?"":oParams.name),{title:sTitle,text:sMsg,player:oParams.player,params:oParams.params},{bForceLoad:true});
            _loc8_.addEventListener("yes",oParams.listener != undefined?oParams.listener:this);
            _loc8_.addEventListener("no",oParams.listener != undefined?oParams.listener:this);
            _loc8_.addEventListener("ignore",oParams.listener != undefined?oParams.listener:this);
            break;
         case "ERROR_BOX":
            if(sTitle == undefined)
            {
               sTitle = this.api.lang.getText("ERROR_WORD");
            }
            this.api.ui.loadUIComponent("AskOK","AskOK" + (oParams.name == undefined?"":oParams.name),{title:sTitle,text:sMsg,params:oParams.params},{bForceLoad:true});
            break;
         case "INFO_CANCEL":
            if(sTitle == undefined)
            {
               sTitle = this.api.lang.getText("INFORMATION");
            }
            var _loc9_ = this.api.ui.loadUIComponent("AskCancel","AskCancel" + (oParams.name == undefined?"":oParams.name),{title:sTitle,text:sMsg,params:oParams.params},{bForceLoad:true});
            _loc9_.addEventListener("cancel",oParams.listener != undefined?oParams.listener:this);
            break;
         case "ERROR_CHAT":
            this.ChatManager.addText(sTitle != undefined?"<b>" + sTitle + "</b> : " + sMsg:sMsg,dofus.Constants.ERROR_CHAT_COLOR,true,sUniqId);
            break;
         case "MESSAGE_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.MSG_CHAT_COLOR,true,sUniqId);
            break;
         case "EMOTE_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.EMOTE_CHAT_COLOR,true,sUniqId);
            break;
         case "THINK_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.THINK_CHAT_COLOR,true,sUniqId);
            break;
         case "INFO_FIGHT_CHAT":
            if(!this.api.kernel.OptionsManager.getOption("ChatEffects"))
            {
               return undefined;
            }
         case "INFO_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.INFO_CHAT_COLOR,true,sUniqId);
            break;
         case "PVP_CHAT":
            sMsg = this.api.kernel.ChatManager.parseInlinePos(sMsg);
            this.ChatManager.addText(sMsg,dofus.Constants.PVP_CHAT_COLOR,true,sUniqId);
            break;
         case "WHISP_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.MSGCHUCHOTE_CHAT_COLOR,true,sUniqId);
            break;
         case "PARTY_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.GROUP_CHAT_COLOR,true,sUniqId);
            break;
         case "GUILD_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.GUILD_CHAT_COLOR,false,sUniqId);
            break;
         case "GUILD_CHAT_SOUND":
            this.ChatManager.addText(sMsg,dofus.Constants.GUILD_CHAT_COLOR,true,sUniqId);
            break;
         case "RECRUITMENT_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.RECRUITMENT_CHAT_COLOR,false,sUniqId);
            break;
         case "TRADE_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.TRADE_CHAT_COLOR,false,sUniqId);
            break;
         case "MEETIC_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.MEETIC_CHAT_COLOR,false,sUniqId);
            break;
         case "ADMIN_CHAT":
            this.ChatManager.addText(sMsg,dofus.Constants.ADMIN_CHAT_COLOR,false,sUniqId);
            break;
         case "DEBUG_LOG":
            this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#FFFFFF\">" + sMsg + "</font>");
            this.api.ui.getUIComponent("Debug").setLogsText(this.api.datacenter.Basics.aks_a_logs);
            break;
         case "DEBUG_ERROR":
            this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#FF0000\">" + sMsg + "</font>");
            this.api.ui.getUIComponent("Debug").refresh();
            break;
         case "DEBUG_INFO":
            this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#00FF00\">" + sMsg + "</font>");
            this.api.ui.getUIComponent("Debug").refresh();
      }
   }
   function manualLogon()
   {
      this.api.electron.updateWindowTitle();
      this.api.electron.setLoginDiscordActivity();
      this.api.ui.loadUIComponent("MainMenu","MainMenu",{quitMode:(!(System.capabilities.playerType == "PlugIn" && !this.api.electron.enabled)?"quit":"no")},{bStayIfPresent:true,bAlwaysOnTop:true});
      this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["Login","Login",{language:this.api.config.language},{bStayIfPresent:true}]});
      this.addToQueue({object:_level0._loader,method:_level0._loader.onCoreDisplayed});
   }
   function askClearCache()
   {
      this.showMessage(undefined,this.api.lang.getText("DO_U_CLEAR_CACHE"),"CAUTION_YESNO",{name:"ClearCache"});
   }
   function clearCache()
   {
      _level0._loader.clearCache();
      this.reboot();
   }
   function findMovieClipPath()
   {
      if(this.api.ui.getUIComponent("Dragger") != undefined)
      {
         this.api.ui.unloadUIComponent("Dragger");
      }
      else
      {
         var _loc2_ = this.api.ui.loadUIComponent("Dragger","Dragger",undefined,{bForceLoad:true,bAlwaysOnTop:true});
         _loc2_.api = this.api;
         _loc2_.onRelease = function()
         {
            this.stopDrag();
            this.api.network.Basics.onAuthorizedCommand(true,"2" + new ank.utils.ExtendedString(this._dropTarget).replace("/","."));
            this.startDrag(true);
         };
         _loc2_.startDrag(true);
      }
   }
   function yes(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesNoQuit":
            this.quit(false);
            break;
         case "AskYesNoDisconnect":
            this.api.network.disconnect(false,false);
            break;
         case "AskYesNoChangeCharacter":
            this.api.network.disconnect(true,false,true);
            break;
         case "AskYesNoClearCache":
            this.clearCache();
      }
   }
   function onInitAndLoginFinished()
   {
      this.MapsServersManager.initialize(this.api);
      this.DocumentsServersManager.initialize(this.api);
      this.TutorialServersManager.initialize(this.api);
      this.AreasManager.initialize(this.api);
      this.AdminManager.initialize(this.api);
      var _loc2_ = this.api.lang.getTimeZoneText();
      this.NightManager.initialize(_loc2_.tz.slice(),_loc2_.m.slice(),_loc2_.z,this.api.gfx);
      this.XTRA_LANG_FILES_LOADED = true;
      this.api.network.Account.getServersList();
   }
   function onScreenResolutionError(oEvent)
   {
      var _loc3_ = (ank.external.display.ScreenResolution)oEvent.target;
      _loc3_.removeListeners();
   }
   function onScreenResolutionSuccess(oEvent)
   {
      var _loc3_ = (ank.external.display.ScreenResolution)oEvent.target;
      _loc3_.removeListeners();
   }
   function onExternalError(oEvent)
   {
   }
}
