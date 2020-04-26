class dofus.Kernel extends dofus.utils.ApiElement
{
	var XTRA_LANG_FILES_LOADED = false;
	function Kernel(loc3)
	{
		super();
		this.initialize(loc3);
		if(this.AudioManager == null)
		{
			dofus.sounds.AudioManager.initialize(_root.createEmptyMovieClip("SoundNest",99999),loc3);
			this.AudioManager = dofus.sounds.AudioManager.getInstance();
		}
		if((this.CharactersManager = dofus.managers.CharactersManager.getInstance()) == null)
		{
			this.CharactersManager = new dofus.managers.CharactersManager(loc3);
		}
		if((this.ChatManager = dofus.managers.ChatManager.getInstance()) == null)
		{
			this.ChatManager = new dofus.managers.ChatManager(loc3);
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
			this.GameManager = new dofus.managers.GameManager(loc3);
		}
		if((this.KeyManager = dofus.managers.KeyManager.getInstance()) == null)
		{
			this.KeyManager = new dofus.managers.KeyManager(loc3);
		}
		if((this.NightManager = dofus.managers.NightManager.getInstance()) == null)
		{
			this.NightManager = new dofus.managers.NightManager(loc3);
		}
		if((this.AreasManager = dofus.managers.AreasManager.getInstance()) == null)
		{
			this.AreasManager = new dofus.managers.AreasManager();
		}
		if((this.TutorialManager = dofus.managers.TutorialManager.getInstance()) == null)
		{
			this.TutorialManager = new dofus.managers.TutorialManager(loc3);
		}
		this.Console = new dofus.utils.consoleParsers.(loc3);
		this.DebugConsole = new dofus.utils.consoleParsers.(loc3);
		if((this.OptionsManager = dofus.managers.OptionsManager.getInstance()) == null)
		{
			this.OptionsManager = new dofus.managers.OptionsManager(loc3);
		}
		if((this.AdminManager = dofus.managers.AdminManager.getInstance()) == null)
		{
			this.AdminManager = new dofus.managers.AdminManager(loc3);
		}
		if((this.DebugManager = dofus.managers.DebugManager.getInstance()) == null)
		{
			this.DebugManager = new dofus.managers.DebugManager(loc3);
		}
		if((this.TipsManager = dofus.managers.TipsManager.getInstance()) == null)
		{
			this.TipsManager = new dofus.managers.TipsManager(loc3);
		}
		if((this.SpellsBoostsManager = dofus.managers.SpellsBoostsManager.getInstance()) == null)
		{
			this.SpellsBoostsManager = new dofus.managers.SpellsBoostsManager(loc3);
		}
		if((this.SpeakingItemsManager = dofus.managers.SpeakingItemsManager.getInstance()) == null)
		{
			this.SpeakingItemsManager = new dofus.managers.SpeakingItemsManager(loc3);
		}
		if((this.StreamingDisplayManager = dofus.managers.StreamingDisplayManager.getInstance()) == null)
		{
			this.StreamingDisplayManager = new dofus.managers.StreamingDisplayManager(loc3);
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
	function initialize(loc2)
	{
		super.initialize(loc3);
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
	function quit(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = true;
		}
		if(!loc2)
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
	function setQuality(loc2)
	{
		_root._quality = loc2;
	}
	function setDisplayStyle(loc2, loc3)
	{
		if(System.capabilities.playerType == "StandAlone" && System.capabilities.os.indexOf("Windows") != -1)
		{
			var loc4 = new ank.external.display.();
			switch(loc2)
			{
				case "normal":
					loc4.disable();
					break;
				case "medium":
					loc4.addEventListener("onScreenResolutionError",this);
					loc4.addEventListener("onScreenResolutionSuccess",this);
					if(loc3 != true)
					{
						loc4.addEventListener("onExternalError",this);
					}
					loc4.enable(800,600,32);
					break;
				default:
					if(loc0 !== "maximized")
					{
						break;
					}
					loc4.addEventListener("onScreenResolutionError",this);
					loc4.addEventListener("onScreenResolutionSuccess",this);
					if(loc3 != true)
					{
						loc4.addEventListener("onExternalError",this);
					}
					loc4.enable(1024,768,32);
					break;
			}
		}
		else
		{
			_root._loader.setDisplayStyle(loc2);
		}
	}
	function changeServer(loc2)
	{
		if(loc2 == true)
		{
			this.api.network.disconnect(true,false,true);
		}
		else
		{
			this.showMessage(undefined,this.api.lang.getText("DO_U_SWITCH_CHARACTER"),"CAUTION_YESNO",{name:"ChangeCharacter"});
		}
	}
	function showMessage(loc2, loc3, loc4, loc5, loc6)
	{
		loop0:
		switch(loc4)
		{
			case "CAUTION_YESNO":
				if(loc2 == undefined)
				{
					loc2 = this.api.lang.getText("CAUTION");
				}
				var loc7 = this.api.ui.loadUIComponent("AskYesNo","AskYesNo" + (loc5.name == undefined?"":loc5.name),{title:loc2,text:loc3,params:loc5.params},{bForceLoad:true});
				loc7.addEventListener("yes",loc5.listener != undefined?loc5.listener:this);
				loc7.addEventListener("no",loc5.listener != undefined?loc5.listener:this);
				break;
			case "CAUTION_YESNOIGNORE":
				if(loc2 == undefined)
				{
					loc2 = this.api.lang.getText("CAUTION");
				}
				var loc8 = this.api.ui.loadUIComponent("AskYesNoIgnore","AskYesNoIgnore" + (loc5.name == undefined?"":loc5.name),{title:loc2,text:loc3,player:loc5.player,params:loc5.params},{bForceLoad:true});
				loc8.addEventListener("yes",loc5.listener != undefined?loc5.listener:this);
				loc8.addEventListener("no",loc5.listener != undefined?loc5.listener:this);
				loc8.addEventListener("ignore",loc5.listener != undefined?loc5.listener:this);
				break;
			case "ERROR_BOX":
				if(loc2 == undefined)
				{
					loc2 = this.api.lang.getText("ERROR_WORD");
				}
				this.api.ui.loadUIComponent("AskOK","AskOK" + (loc5.name == undefined?"":loc5.name),{title:loc2,text:loc3,params:loc5.params},{bForceLoad:true});
				break;
			case "WAIT_BOX":
				if(loc2 == undefined)
				{
					loc2 = this.api.lang.getText("CHAT_LINK_WARNING");
				}
				this.api.ui.loadUIComponent("AskOKWait","AskOKWait",{title:loc2,text:loc3,params:loc5.params},{bForceLoad:true});
				break;
			default:
				switch(null)
				{
					case "INFO_CANCEL":
						if(loc2 == undefined)
						{
							loc2 = this.api.lang.getText("INFORMATION");
						}
						var loc9 = this.api.ui.loadUIComponent("AskCancel","AskCancel" + (loc5.name == undefined?"":loc5.name),{title:loc2,text:loc3,params:loc5.params},{bForceLoad:true});
						loc9.addEventListener("cancel",loc5.listener != undefined?loc5.listener:this);
						break loop0;
					case "ERROR_CHAT":
						this.ChatManager.addText(loc2 != undefined?"<b>" + loc2 + "</b> : " + loc3:loc3,dofus.Constants.ERROR_CHAT_COLOR,true,loc6);
						break loop0;
					case "MESSAGE_CHAT":
						this.ChatManager.addText(loc3,dofus.Constants.MSG_CHAT_COLOR,true,loc6);
						break loop0;
					case "EMOTE_CHAT":
						this.ChatManager.addText(loc3,dofus.Constants.EMOTE_CHAT_COLOR,true,loc6);
						break loop0;
					case "THINK_CHAT":
						this.ChatManager.addText(loc3,dofus.Constants.THINK_CHAT_COLOR,true,loc6);
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
								this.ChatManager.addText(loc3,dofus.Constants.INFO_CHAT_COLOR,true,loc6);
								break loop0;
							case "PVP_CHAT":
								loc3 = this.api.kernel.ChatManager.parseInlinePos(loc3);
								this.ChatManager.addText(loc3,dofus.Constants.PVP_CHAT_COLOR,true,loc6);
								break loop0;
							case "WHISP_CHAT":
								this.ChatManager.addText(loc3,dofus.Constants.MSGCHUCHOTE_CHAT_COLOR,true,loc6);
								break loop0;
							default:
								switch(null)
								{
									case "PARTY_CHAT":
										this.ChatManager.addText(loc3,dofus.Constants.GROUP_CHAT_COLOR,true,loc6);
										break loop0;
									case "GUILD_CHAT":
										this.ChatManager.addText(loc3,dofus.Constants.GUILD_CHAT_COLOR,false,loc6);
										break loop0;
									case "GUILD_CHAT_SOUND":
										this.ChatManager.addText(loc3,dofus.Constants.GUILD_CHAT_COLOR,true,loc6);
										break loop0;
									case "RECRUITMENT_CHAT":
										this.ChatManager.addText(loc3,dofus.Constants.RECRUITMENT_CHAT_COLOR,false,loc6);
										break loop0;
									default:
										switch(null)
										{
											case "TRADE_CHAT":
												this.ChatManager.addText(loc3,dofus.Constants.TRADE_CHAT_COLOR,false,loc6);
												break loop0;
											case "MEETIC_CHAT":
												this.ChatManager.addText(loc3,dofus.Constants.MEETIC_CHAT_COLOR,false,loc6);
												break loop0;
											case "ADMIN_CHAT":
												this.ChatManager.addText(loc3,dofus.Constants.ADMIN_CHAT_COLOR,false,loc6);
												break loop0;
											case "DEBUG_LOG":
												this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#FFFFFF\">" + loc3 + "</font>");
												this.api.ui.getUIComponent("Debug").setLogsText(this.api.datacenter.Basics.aks_a_logs);
												break loop0;
											case "DEBUG_ERROR":
												this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#FF0000\">" + loc3 + "</font>");
												this.api.ui.getUIComponent("Debug").refresh();
												break loop0;
											default:
												if(loc0 !== "DEBUG_INFO")
												{
													break loop0;
												}
												this.api.datacenter.Basics.aks_a_logs = this.api.datacenter.Basics.aks_a_logs + ("<br/><font color=\"#00FF00\">" + loc3 + "</font>");
												this.api.ui.getUIComponent("Debug").refresh();
												break loop0;
										}
								}
						}
				}
		}
	}
	function manualLogon()
	{
		this.api.electron.updateWindowTitle();
		this.api.electron.setLoginDiscordActivity();
		this.api.ui.loadUIComponent("MainMenu","MainMenu",{quitMode:(!(System.capabilities.playerType == "PlugIn" && !this.api.electron.enabled)?"quit":"no")},{bStayIfPresent:true,bAlwaysOnTop:true});
		this.addToQueue({object:this.api.ui,method:this.api.ui.loadUIComponent,params:["Login","Login",{language:this.api.config.language},{bStayIfPresent:true}]});
		this.addToQueue({object:_root._loader,method:_root._loader.onCoreDisplayed});
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
			var loc2 = this.api.ui.loadUIComponent("Dragger","Dragger",undefined,{bForceLoad:true,bAlwaysOnTop:true});
			loc2.api = this.api;
			loc2.onRelease = function()
			{
				this.stopDrag();
				this.api.network.Basics.onAuthorizedCommand(true,"2" + new ank.utils.(this._dropTarget).replace("/","."));
				this.startDrag(true);
			};
			loc2.startDrag(true);
		}
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
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
		var loc2 = this.api.lang.getTimeZoneText();
		this.NightManager.initialize(loc2.tz.slice(),loc2.m.slice(),loc2.z,this.api.gfx);
		this.XTRA_LANG_FILES_LOADED = true;
		this.api.network.Account.getServersList();
	}
	function onScreenResolutionError(loc2)
	{
		var loc3 = (ank.external.display.ScreenResolution)loc2.target;
		loc3.removeListeners();
	}
	function onScreenResolutionSuccess(loc2)
	{
		var loc3 = (ank.external.display.ScreenResolution)loc2.target;
		loc3.removeListeners();
	}
	function onExternalError(loc2)
	{
	}
}
