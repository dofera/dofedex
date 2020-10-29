class dofus.Kernel extends dofus.utils.ApiElement
{
	var XTRA_LANG_FILES_LOADED = false;
	static var FAST_SWITCHING_SERVER_REQUEST = undefined;
	var _sPendingCommandsText = "";
	var _aPendingChatMessages = new Array();
	function Kernel(var3)
	{
		super();
		this.initialize(var3);
		if(this.AudioManager == null)
		{
			dofus.sounds.AudioManager.initialize(_root.createEmptyMovieClip("SoundNest",99999),var3);
			this.AudioManager = dofus.sounds.AudioManager.getInstance();
		}
		if((this.CharactersManager = dofus.managers.CharactersManager.getInstance()) == null)
		{
			this.CharactersManager = new dofus.managers.CharactersManager(var3);
		}
		if((this.ChatManager = dofus.managers.ChatManager.getInstance()) == null)
		{
			this.ChatManager = new dofus.managers.ChatManager(var3);
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
			this.GameManager = new dofus.managers.GameManager(var3);
		}
		if((this.KeyManager = dofus.managers.KeyManager.getInstance()) == null)
		{
			this.KeyManager = new dofus.managers.KeyManager(var3);
		}
		if((this.NightManager = dofus.managers.NightManager.getInstance()) == null)
		{
			this.NightManager = new dofus.managers.NightManager(var3);
		}
		if((this.AreasManager = dofus.managers.AreasManager.getInstance()) == null)
		{
			this.AreasManager = new dofus.managers.AreasManager();
		}
		if((this.TutorialManager = dofus.managers.TutorialManager.getInstance()) == null)
		{
			this.TutorialManager = new dofus.managers.TutorialManager(var3);
		}
		this.Console = new dofus.utils.consoleParsers.(var3);
		this.DebugConsole = new dofus.utils.consoleParsers.(var3);
		if((this.OptionsManager = dofus.managers.OptionsManager.getInstance()) == null)
		{
			this.OptionsManager = new dofus.managers.OptionsManager(var3);
		}
		if((this.AdminManager = dofus.managers.AdminManager.getInstance()) == null)
		{
			this.AdminManager = new dofus.managers.AdminManager(var3);
		}
		if((this.DebugManager = dofus.managers.DebugManager.getInstance()) == null)
		{
			this.DebugManager = new dofus.managers.DebugManager(var3);
		}
		if((this.TipsManager = dofus.managers.TipsManager.getInstance()) == null)
		{
			this.TipsManager = new dofus.managers.TipsManager(var3);
		}
		if((this.SpellsBoostsManager = dofus.managers.SpellsBoostsManager.getInstance()) == null)
		{
			this.SpellsBoostsManager = new dofus.managers.SpellsBoostsManager(var3);
		}
		if((this.SpeakingItemsManager = dofus.managers.SpeakingItemsManager.getInstance()) == null)
		{
			this.SpeakingItemsManager = new dofus.managers.SpeakingItemsManager(var3);
		}
		if((this.StreamingDisplayManager = dofus.managers.StreamingDisplayManager.getInstance()) == null)
		{
			this.StreamingDisplayManager = new dofus.managers.StreamingDisplayManager(var3);
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
	function initialize(var2)
	{
		super.initialize(var3);
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
		this.autoLogon();
	}
	function quit(var2)
	{
		if(var2 == undefined)
		{
			var2 = true;
		}
		if(!var2)
		{
			if(System.capabilities.playerType == "StandAlone")
			{
				getURL("FSCommand:" add "quit","");
			}
			else
			{
				_root._loader.closeBrowserWindow();
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
		this.addToQueue({object:_root._loader,method:_root._loader.reboot});
	}
	function setQuality(var2)
	{
		_root._quality = var2;
	}
	function setDisplayStyle(var2, var3)
	{
		if(System.capabilities.playerType == "StandAlone" && System.capabilities.os.indexOf("Windows") != -1)
		{
			var var4 = new ank.external.display.();
			switch(var2)
			{
				case "normal":
					var4.disable();
					break;
				case "medium":
					var4.addEventListener("onScreenResolutionError",this);
					var4.addEventListener("onScreenResolutionSuccess",this);
					if(var3 != true)
					{
						var4.addEventListener("onExternalError",this);
					}
					var4.enable(800,600,32);
					break;
				case "maximized":
					var4.addEventListener("onScreenResolutionError",this);
					var4.addEventListener("onScreenResolutionSuccess",this);
					if(var3 != true)
					{
						var4.addEventListener("onExternalError",this);
					}
					var4.enable(1024,768,32);
			}
		}
		else
		{
			_root._loader.setDisplayStyle(var2);
		}
	}
	function printConsolePendingCommands()
	{
		if(this._sPendingCommandsText == "")
		{
			return undefined;
		}
		this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + this._sPendingCommandsText;
		this.api.ui.getUIComponent("Debug").refresh();
		this._sPendingCommandsText = "";
	}
	function delayedPrintConsolePendingCommand(var2)
	{
		if(this._nPendingCommandsProcessTimeout != undefined)
		{
			_global.clearTimeout(this._nPendingCommandsProcessTimeout);
		}
		this._sPendingCommandsText = this._sPendingCommandsText + var2;
		var var3 = _global.setTimeout(this,"printConsolePendingCommands",dofus.Constants.DELAYED_DEBUG_CONSOLE_VISUAL_REFRESH);
		this._nPendingCommandsProcessTimeout = var3;
	}
	function printPendingChatMessages()
	{
		if(this._aPendingChatMessages.length == 0)
		{
			return undefined;
		}
		var var2 = 0;
		while(var2 < this._aPendingChatMessages.length)
		{
			var var3 = this._aPendingChatMessages[var2];
			this.ChatManager.addText(var3.text,var3.color,var3.sound,var3.uniqId);
			var2 = var2 + 1;
		}
		this._aPendingChatMessages = new Array();
	}
	function delayedPrintChatText(var2, var3, var4, var5)
	{
		if(this._nGroupChatMessagesTimeout != undefined)
		{
			_global.clearTimeout(this._nGroupChatMessagesTimeout);
		}
		var var6 = false;
		if(this._aPendingChatMessages.length > 0)
		{
			var var7 = this._aPendingChatMessages[this._aPendingChatMessages.length - 1];
			if(var7.color == var3 && (var7.sound == var4 && var7.uniqId == var5))
			{
				var6 = true;
				var7.text = var7.text + ("\n" + var2);
			}
		}
		if(!var6)
		{
			this._aPendingChatMessages.push({text:var2,color:var3,sound:var4,uniqId:var5});
		}
		var var8 = _global.setTimeout(this,"printPendingChatMessages",dofus.Constants.DELAYED_CHAT_VISUAL_REFRESH);
		this._nGroupChatMessagesTimeout = var8;
	}
	function onFastServerSwitchFail(var2)
	{
		dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST = undefined;
		if(var2 == undefined)
		{
			return undefined;
		}
		this.api.kernel.showMessage(undefined,"Fast server switching failed : " + var2,"ERROR_BOX");
	}
	function onFastServerSwitchSuccess(var2)
	{
		dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST = undefined;
		this.api.kernel.showMessage(undefined,"<b>(Fast server switch)</b> : Welcome on <b>" + this.api.datacenter.Basics.aks_current_server.label + "</b>","COMMANDS_CHAT");
	}
	function changeServer(var2)
	{
		if(var2 == true)
		{
			this.api.network.disconnect(true,false,true);
		}
		else
		{
			this.showMessage(undefined,this.api.lang.getText("DO_U_SWITCH_CHARACTER"),"CAUTION_YESNO",{name:"ChangeCharacter"});
		}
	}
	function showMessage(var2, var3, var4, var5, var6)
	{
		loop0:
		switch(var4)
		{
			case "CAUTION_YESNO":
				if(var2 == undefined)
				{
					var2 = this.api.lang.getText("CAUTION");
				}
				var var7 = this.api.ui.loadUIComponent("AskYesNo","AskYesNo" + (var5.name == undefined?"":var5.name),{title:var2,text:var3,params:var5.params},{bForceLoad:true});
				var7.addEventListener("yes",var5.listener != undefined?var5.listener:this);
				var7.addEventListener("no",var5.listener != undefined?var5.listener:this);
				break;
			case "CAUTION_YESNOIGNORE":
				if(var2 == undefined)
				{
					var2 = this.api.lang.getText("CAUTION");
				}
				var var8 = this.api.ui.loadUIComponent("AskYesNoIgnore","AskYesNoIgnore" + (var5.name == undefined?"":var5.name),{title:var2,text:var3,player:var5.player,params:var5.params},{bForceLoad:true});
				var8.addEventListener("yes",var5.listener != undefined?var5.listener:this);
				var8.addEventListener("no",var5.listener != undefined?var5.listener:this);
				var8.addEventListener("ignore",var5.listener != undefined?var5.listener:this);
				break;
			case "ERROR_BOX":
				if(var2 == undefined)
				{
					var2 = this.api.lang.getText("ERROR_WORD");
				}
				this.api.ui.loadUIComponent("AskOK","AskOK" + (var5.name == undefined?"":var5.name),{title:var2,text:var3,params:var5.params},{bForceLoad:true});
				break;
			case "WAIT_BOX":
				if(var2 == undefined)
				{
					var2 = this.api.lang.getText("CHAT_LINK_WARNING");
				}
				this.api.ui.loadUIComponent("AskOKWait","AskOKWait",{title:var2,text:var3,params:var5.params},{bForceLoad:true});
				break;
			default:
				switch(null)
				{
					case "INFO_CANCEL":
						if(var2 == undefined)
						{
							var2 = this.api.lang.getText("INFORMATION");
						}
						var var9 = this.api.ui.loadUIComponent("AskCancel","AskCancel" + (var5.name == undefined?"":var5.name),{title:var2,text:var3,params:var5.params},{bForceLoad:true});
						var9.addEventListener("cancel",var5.listener != undefined?var5.listener:this);
						break loop0;
					case "ERROR_CHAT":
						this.delayedPrintChatText(var2 != undefined?"<b>" + var2 + "</b> : " + var3:var3,dofus.Constants.ERROR_CHAT_COLOR,true,var6);
						break loop0;
					case "MESSAGE_CHAT":
						this.delayedPrintChatText(var3,dofus.Constants.MSG_CHAT_COLOR,true,var6);
						break loop0;
					case "EMOTE_CHAT":
						this.delayedPrintChatText(var3,dofus.Constants.EMOTE_CHAT_COLOR,true,var6);
						break loop0;
					case "THINK_CHAT":
						this.delayedPrintChatText(var3,dofus.Constants.THINK_CHAT_COLOR,true,var6);
						break loop0;
					default:
						switch(null)
						{
							case "INFO_FIGHT_CHAT":
								if(!this.api.kernel.OptionsManager.getOption("ChatEffects"))
								{
									return undefined;
								}
							case "INFO_CHAT":
								this.delayedPrintChatText(var3,dofus.Constants.INFO_CHAT_COLOR,true,var6);
								break loop0;
							case "PVP_CHAT":
								var3 = this.api.kernel.ChatManager.parseInlinePos(var3);
								this.delayedPrintChatText(var3,dofus.Constants.PVP_CHAT_COLOR,true,var6);
								break loop0;
							case "WHISP_CHAT":
								this.delayedPrintChatText(var3,dofus.Constants.MSGCHUCHOTE_CHAT_COLOR,true,var6);
								break loop0;
							case "PARTY_CHAT":
								this.delayedPrintChatText(var3,dofus.Constants.GROUP_CHAT_COLOR,true,var6);
								break loop0;
							default:
								switch(null)
								{
									case "GUILD_CHAT":
										this.delayedPrintChatText(var3,dofus.Constants.GUILD_CHAT_COLOR,false,var6);
										break loop0;
									case "GUILD_CHAT_SOUND":
										this.delayedPrintChatText(var3,dofus.Constants.GUILD_CHAT_COLOR,true,var6);
										break loop0;
									case "RECRUITMENT_CHAT":
										this.delayedPrintChatText(var3,dofus.Constants.RECRUITMENT_CHAT_COLOR,false,var6);
										break loop0;
									case "TRADE_CHAT":
										this.delayedPrintChatText(var3,dofus.Constants.TRADE_CHAT_COLOR,false,var6);
										break loop0;
									default:
										switch(null)
										{
											case "MEETIC_CHAT":
												this.delayedPrintChatText(var3,dofus.Constants.MEETIC_CHAT_COLOR,false,var6);
												break loop0;
											case "ADMIN_CHAT":
												this.delayedPrintChatText(var3,dofus.Constants.ADMIN_CHAT_COLOR,false,var6);
												break loop0;
											case "COMMANDS_CHAT":
												this.delayedPrintChatText(var3,dofus.Constants.COMMANDS_CHAT_COLOR,false,var6);
												break loop0;
											case "DEBUG_LOG":
												this.delayedPrintConsolePendingCommand("\n<font color=\"#FFFFFF\">" + var3 + "</font>");
												break loop0;
											default:
												switch(null)
												{
													case "DEBUG_ERROR":
														this.delayedPrintConsolePendingCommand("\n<font color=\"#FF0000\">" + var3 + "</font>");
														break;
													case "DEBUG_INFO":
														this.delayedPrintConsolePendingCommand("\n<font color=\"#00FF00\">" + var3 + "</font>");
												}
										}
								}
						}
				}
		}
	}
	function manualLogon()
	{
		this.initLogon();
		this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["Login","Login",{language:this.api.config.language,canAutoLogOn:false},{bStayIfPresent:true}]});
		this.addToQueue({object:_root._loader,method:_root._loader.onCoreDisplayed});
	}
	function autoLogon()
	{
		this.initLogon();
		this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["Login","Login",{language:this.api.config.language,canAutoLogOn:true},{bStayIfPresent:true}]});
		this.addToQueue({object:_root._loader,method:_root._loader.onCoreDisplayed});
	}
	function initLogon()
	{
		this.api.electron.updateWindowTitle();
		this.api.electron.setLoginDiscordActivity();
		this.api.ui.loadUIComponent("MainMenu","MainMenu",{quitMode:(!(System.capabilities.playerType == "PlugIn" && !this.api.electron.enabled)?"quit":"no")},{bStayIfPresent:true,bAlwaysOnTop:true});
	}
	function askClearCache()
	{
		this.showMessage(undefined,this.api.lang.getText("DO_U_CLEAR_CACHE"),"CAUTION_YESNO",{name:"ClearCache"});
	}
	function clearCache()
	{
		_root._loader.clearCache();
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
			var var2 = this.api.ui.loadUIComponent("Dragger","Dragger",undefined,{bForceLoad:true,bAlwaysOnTop:true});
			var2.api = this.api;
			var2.onRelease = function()
			{
				this.stopDrag();
				this.api.network.Basics.onAuthorizedCommand(true,"2" + new ank.utils.(this._dropTarget).replace("/","."));
				this.startDrag(true);
			};
			var2.startDrag(true);
		}
	}
	function yes(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoQuit":
				this.quit(false);
				break;
			case "AskYesNoDisconnect":
				this.api.network.disconnect(false,false);
				break;
			default:
				switch(null)
				{
					case "AskYesNoChangeCharacter":
						this.api.network.disconnect(true,false,true);
						break;
					case "AskYesNoClearCache":
						this.clearCache();
				}
		}
	}
	function onInitAndLoginFinished()
	{
		this.MapsServersManager.initialize(this.api);
		this.DocumentsServersManager.initialize(this.api);
		this.TutorialServersManager.initialize(this.api);
		this.AreasManager.initialize(this.api);
		this.AdminManager.initialize(this.api);
		var var2 = this.api.lang.getTimeZoneText();
		this.NightManager.initialize(var2.tz.slice(),var2.m.slice(),var2.z,this.api.gfx);
		this.api.kernel.KeyManager.onSetChange(this.api.kernel.OptionsManager.getOption("ShortcutSet"));
		this.XTRA_LANG_FILES_LOADED = true;
		this.api.network.Account.sendConfiguredPort();
		this.api.network.Account.sendIdentity();
		this.api.network.Account.getServersList();
	}
	function onScreenResolutionError(var2)
	{
		var var3 = (ank.external.display.ScreenResolution)var2.target;
		var3.removeListeners();
	}
	function onScreenResolutionSuccess(var2)
	{
		var var3 = (ank.external.display.ScreenResolution)var2.target;
		var3.removeListeners();
	}
	function onExternalError(var2)
	{
	}
}
