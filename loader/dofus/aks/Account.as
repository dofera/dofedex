if(!dofus.aks.Account)
{
	if(!dofus)
	{
		_global.dofus = new Object();
	}
	if(!dofus.aks)
	{
		_global.dofus.aks = new Object();
	}
	dofus.aks.Account = function(var2, var3)
	{
		super.initialize(var3,var4);
		this.WaitQueueTimer = new Object();
	} extends dofus.aks.Handler;
	var var1 = dofus.aks.Account = function(var2, var3)
	{
		super.initialize(var3,var4);
		this.WaitQueueTimer = new Object();
	}.prototype;
	var1.logon = function logon(var2, var3, var4)
	{
		if(this.api.datacenter.Basics.connexionKey == undefined)
		{
			this.onLogin(false,"n");
			return undefined;
		}
		if(var2 == undefined)
		{
			var2 = this.api.datacenter.Basics.login;
		}
		else
		{
			this.api.datacenter.Basics.login = var2;
		}
		if(var3 == undefined)
		{
			var3 = this.api.datacenter.Basics.password;
		}
		else
		{
			this.api.datacenter.Basics.password = var3;
		}
		this.aks.send(dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION <= 0?"":"." + dofus.Constants.BETAVERSION) + (!this.api.electron.enabled?"":"e") + (!this.api.config.isStreaming?"":"s"),true,this.api.lang.getText("CONNECTING"));
		if(var4)
		{
			this.aks.send(var2 + "\n" + var3);
		}
		else if(this.api.lang.getConfigText("CRYPTO_METHOD") == 2)
		{
			var var5 = new ank.utils.
	();
			var var6 = "#2" + var5.hex_md5(var5.hex_md5(var3) + this.api.datacenter.Basics.connexionKey);
			this.aks.send(var2 + "\n" + var6);
		}
		else
		{
			this.aks.send(var2 + "\n" + ank.utils.Crypt.cryptPassword(var3,this.api.datacenter.Basics.connexionKey));
		}
	};
	var1.setNickName = function setNickName(var2)
	{
		this.aks.send(var2,true,this.api.lang.getText("WAITING_MSG_LOADING"));
	};
	var1.getCharacters = function getCharacters()
	{
		this.aks.send("AL",true,this.api.lang.getText("CONNECTING"));
	};
	var1.getCharactersForced = function getCharactersForced()
	{
		this.aks.send("ALf",true,this.api.lang.getText("CONNECTING"));
	};
	var1.getServersList = function getServersList()
	{
		this.aks.send("Ax",true,this.api.lang.getText("WAITING_MSG_LOADING"));
	};
	var1.setServer = function setServer(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		this.api.datacenter.Basics.aks_incoming_server_id = var2;
		this.aks.send("AX" + var2,true,this.api.lang.getText("WAITING_MSG_LOADING"));
	};
	var1.searchForFriend = function searchForFriend(var2)
	{
		this.aks.send("AF" + var2);
	};
	var1.setCharacter = function setCharacter(var2)
	{
		this.aks.send("AS" + var2,true,this.api.lang.getText("WAITING_MSG_LOADING"));
		this.api.ui.unloadUIComponent("ChooseCharacter");
		this.getQueuePosition();
	};
	var1.editCharacterName = function editCharacterName(var2)
	{
		this.aks.send("AEn" + var2,true);
	};
	var1.editCharacterColors = function editCharacterColors(var2, var3, var4)
	{
		this.aks.send("AEc" + var2 + "|" + var3 + "|" + var4,true);
	};
	var1.addCharacter = function addCharacter(var2, var3, var4, var5, var6, var7)
	{
		this.aks.send("AA" + var2 + "|" + var3 + "|" + var7 + "|" + var4 + "|" + var5 + "|" + var6,true,this.api.lang.getText("WAITING_MSG_RECORDING"));
	};
	var1.deleteCharacter = function deleteCharacter(var2, var3)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		if(var3 == undefined)
		{
			var3 = "";
		}
		var var4 = new ank.utils.(_global.escape(var3));
		this.aks.send("AD" + var2 + "|" + var4.replace(["|","\r","\n",String.fromCharCode(0)],["","","",""]),true,this.api.lang.getText("WAITING_MSG_DELETING"));
	};
	var1.resetCharacter = function resetCharacter(var2)
	{
		this.aks.send("AR" + var2);
	};
	var1.boost = function boost(var2)
	{
		this.aks.send("AB" + var2);
	};
	var1.sendTicket = function sendTicket(var2)
	{
		this.aks.send("AT" + var2);
	};
	var1.rescue = function rescue(var2)
	{
		var var3 = "";
		if(this.api.datacenter.Game.isFight)
		{
			var3 = !this.api.datacenter.Game.isRunning?"|0":"|1";
		}
		this.aks.send("Ar" + var2 + var3);
	};
	var1.getGifts = function getGifts()
	{
		this.aks.send("Ag" + this.api.config.language);
	};
	var1.attributeGiftToCharacter = function attributeGiftToCharacter(var2, var3)
	{
		this.aks.send("AG" + var2 + "|" + var3);
	};
	var1.getQueuePosition = function getQueuePosition()
	{
		this.aks.send("Af",false);
		ank.utils.Timer.setTimer(this.WaitQueueTimer,"WaitQueue",this,this.getQueuePosition,Number(this.api.lang.getConfigText("DELAY_WAIT_QUEUE_REFRESH")));
	};
	var1.getRandomCharacterName = function getRandomCharacterName()
	{
		this.aks.send("AP",false);
	};
	var1.useKey = function useKey(var2)
	{
		this.aks.send("Ak" + dofus.aks.Aks.HEX_CHARS[var2],false);
	};
	var1.requestRegionalVersion = function requestRegionalVersion()
	{
		this.aks.send("AV",true,this.api.lang.getText("WAITING_MSG_LOADING"));
	};
	var1.sendConfiguredPort = function sendConfiguredPort()
	{
		this.aks.send("Ap" + this.api.datacenter.Basics.aks_connection_server_port,false);
	};
	var1.sendIdentity = function sendIdentity()
	{
		dofus.managers.UIdManager.getInstance().update();
		var var2 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
		var var3 = var2.data.identityVersion;
		var var4 = var2.data.identity;
		if(!this.api.network.isValidNetworkKey(var4,var3))
		{
			var3 = dofus.aks.Aks.CURRENT_IDENTITY_VERSION;
			var4 = this.api.network.getRandomNetworkKey();
			var2.data.identityVersion = var3;
			var2.data.identity = var4;
			var2.flush();
		}
		if(this.api.datacenter.Basics.aks_identity != var4)
		{
			this.api.datacenter.Basics.aks_identity = var4;
		}
		this.aks.send("Ai" + this.api.datacenter.Basics.aks_identity,false);
		var2.close();
	};
	var1.validCharacterMigration = function validCharacterMigration(var2, var3)
	{
		this.aks.send("AM" + var2 + ";" + var3,false);
	};
	var1.deleteCharacterMigration = function deleteCharacterMigration(var2)
	{
		this.aks.send("AM-" + var2,false);
	};
	var1.askCharacterMigration = function askCharacterMigration(var2, var3)
	{
		this.aks.send("AM?" + var2 + ";" + var3,false);
	};
	var1.onRegionalVersion = function onRegionalVersion(var2)
	{
		var var3 = this.api.lang.getConfigText("MAXIMUM_ALLOWED_VERSION");
		var var4 = Number(var2);
		if(var3 > 0)
		{
			if((var4 <= 0 || var4 > var3) && !this.api.datacenter.Player.isAuthorized)
			{
				var var5 = {name:"SwitchToEnglish",listener:this};
				this.api.kernel.showMessage(undefined,this.api.lang.getText("SWITCH_TO_ENGLISH"),"CAUTION_YESNO",var5);
				return undefined;
			}
		}
		this.api.datacenter.Basics.aks_current_regional_version = !(var4 > 0 && !_global.isNaN(var4))?Number.MAX_VALUE:var4;
		this.getGifts();
		this.getCharacters();
		this.api.network.Account.getQueuePosition();
	};
	var1.onCharacterDelete = function onCharacterDelete(var2, var3)
	{
		if(!var2)
		{
			this.api.ui.unloadUIComponent("WaitingMessage");
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CHARACTER_DELETION_FAILED"),"ERROR_BOX");
		}
	};
	var1.onSecretQuestion = function onSecretQuestion(var2)
	{
		this.api.datacenter.Basics.aks_secret_question = var2;
	};
	var1.onKey = function onKey(var2)
	{
		var var3 = _global.parseInt(var2.substr(0,1),16);
		var var4 = var2.substr(1);
		this.aks.addKeyToCollection(var3,var4);
		this.useKey(var3);
		this.aks.startUsingKey(var3);
	};
	var1.onDofusPseudo = function onDofusPseudo(var2)
	{
		this.api.datacenter.Basics.dofusPseudo = var2;
	};
	var1.onCommunity = function onCommunity(var2)
	{
		var var3 = Number(var2);
		if(var3 >= 0)
		{
			this.api.datacenter.Basics.communityId = var3;
		}
	};
	var1.onLogin = function onLogin(var2, var3)
	{
		ank.utils.Timer.removeTimer(this.WaitQueueTimer,"WaitQueue");
		this.api.ui.unloadUIComponent("CenterText");
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.unloadUIComponent("WaitingQueue");
		if(var2)
		{
			this.api.datacenter.Basics.isLogged = true;
			this.api.ui.unloadUIComponent("Login");
			this.api.ui.unloadUIComponent("ChooseNickName");
			this.api.datacenter.Player.isAuthorized = var3 == "1";
			_root._loader.loadXtra();
		}
		else
		{
			var var4 = var3.charAt(0);
			var var6 = false;
			loop1:
			switch(var4)
			{
				case "n":
					var var5 = this.api.lang.getText("CONNECT_NOT_FINISHED");
					break;
				case "a":
					var5 = this.api.lang.getText("ALREADY_LOGGED");
					break;
				case "c":
					var5 = this.api.lang.getText("ALREADY_LOGGED_GAME_SERVER");
					break;
				default:
					switch(null)
					{
						case "v":
							var5 = this.api.lang.getText("BAD_VERSION",[dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION <= 0?"":" Beta " + dofus.Constants.BETAVERSION),var3.substr(1)]);
							var6 = true;
							break loop1;
						case "p":
							var5 = this.api.lang.getText("NOT_PLAYER");
							break loop1;
						case "b":
							var5 = this.api.lang.getText("BANNED");
							break loop1;
						case "d":
							var5 = this.api.lang.getText("U_DISCONNECT_ACCOUNT");
							break loop1;
						case "k":
							var var7 = var3.substr(1).split("|");
							var var8 = 0;
							while(var8 < var7.length)
							{
								if(var7[var8] == 0)
								{
									var7[var8] = undefined;
								}
								var8 = var8 + 1;
							}
							var5 = ank.utils.PatternDecoder.getDescription(this.api.lang.getText("KICKED"),var7);
							break loop1;
						default:
							switch(null)
							{
								case "w":
									var5 = this.api.lang.getText("SERVER_FULL");
									break loop1;
								case "o":
									var5 = this.api.lang.getText("OLD_ACCOUNT",[this.api.datacenter.Basics.login]);
									break loop1;
								case "e":
									var5 = this.api.lang.getText("OLD_ACCOUNT_USE_NEW",[this.api.datacenter.Basics.login]);
									break loop1;
								case "m":
									var5 = this.api.lang.getText("MAINTAIN_ACCOUNT");
									break loop1;
								default:
									switch(null)
									{
										case "r":
											this.api.ui.loadUIComponent("ChooseNickName","ChooseNickName");
											return undefined;
										case "s":
											this.api.ui.getUIComponent("ChooseNickName").nickAlreadyUsed = true;
											return undefined;
										case "i":
											var5 = this.api.lang.getText("LOGIN_ERROR_ANONYMOUS_IP");
											break loop1;
										case "f":
											if(this.api.config.isStreaming)
											{
												var5 = this.api.lang.getText("ACCESS_DENIED_MINICLIP");
												break loop1;
											}
										default:
											var5 = this.api.lang.getText("ACCESS_DENIED");
									}
							}
					}
			}
			if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
			{
				getURL("JavaScript:WriteLog(\'LoginError;" + var5 + "\')","_self");
			}
			this.aks.disconnect(false,false);
			var var9 = this.api.ui.loadUIComponent("AskOk",!var6?"AskOkOnLogin":"AskOkOnLoginCloseClient",{title:this.api.lang.getText("LOGIN"),text:var5});
			var9.addEventListener("ok",this);
			this.api.kernel.manualLogon();
		}
	};
	var1.onServersList = function onServersList(var2, var3)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		var var4 = this.api.datacenter.Basics.aks_servers;
		this.api.ui.getUIComponent("MainMenu").quitMode = "menu";
		var var5 = var3.split("|");
		var var6 = Number(var5[0]);
		var var7 = -1;
		this.api.datacenter.Player.subscriber = var6 > 0;
		this.api.ui.getUIComponent("MainMenu").updateSubscribeButton();
		var var8 = 0;
		var var9 = 1;
		while(var9 < var5.length)
		{
			var var10 = var5[var9].split(",");
			var var11 = Number(var10[0]);
			var var12 = Number(var10[1]);
			if(var12 > 0)
			{
				var7 = var11;
			}
			var8 = var8 + var12;
			var var13 = 0;
			while(var13 < var4.length)
			{
				if(var4[var13].id == var11)
				{
					var4[var13].charactersCount = var12;
					break;
				}
				var13 = var13 + 1;
			}
			var9 = var9 + 1;
		}
		if(var7 == -1)
		{
			var7 = var4[Math.floor(Math.random() * (var4.length - 1))].id;
			if(!var7)
			{
				var7 = -1;
			}
		}
		this.api.ui.unloadUIComponent("CreateCharacter");
		this.api.ui.unloadUIComponent("ChooseCharacter");
		this.api.ui.unloadUIComponent("AutomaticServer");
		this.api.ui.unloadUIComponent("ChooseServer");
		if(dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST != undefined)
		{
			var var14 = dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST;
			var var15 = var14.serverId;
			var var16 = undefined;
			var var17 = 0;
			while(var17 < var4.length)
			{
				var var18 = var4[var17];
				if(var18.id == var15)
				{
					if(!(var18.state != dofus.datacenter.Server.SERVER_ONLINE || !var18.isAllowed))
					{
						var16 = var18;
						break;
					}
				}
				var17 = var17 + 1;
			}
			if(var16 != undefined)
			{
				if(var16.charactersCount == 0)
				{
					this.api.kernel.onFastServerSwitchFail("You do not have any character on server " + var15);
				}
				else
				{
					this.api.datacenter.Basics.aks_current_server = var16;
					this.api.network.Account.setServer(var16.id);
					return undefined;
				}
			}
			else
			{
				this.api.kernel.onFastServerSwitchFail("Server " + var15 + " is not available now.");
			}
		}
		if(!this.api.datacenter.Basics.forceAutomaticServerSelection && (var8 > 0 || (this.api.config.isStreaming || this.api.datacenter.Basics.forceManualServerSelection)))
		{
			if(this.api.datacenter.Basics.forceManualServerSelection)
			{
				this.api.datacenter.Basics.hasForcedManualSelection = true;
			}
			else if(var7 != -1 && this.api.config.isStreaming)
			{
				var var19 = new dofus.datacenter.(var7,1,0);
				if(var19.isAllowed())
				{
					this.api.datacenter.Basics.aks_current_server = var19;
					this.api.network.Account.setServer(var7);
					return undefined;
				}
			}
			this.api.datacenter.Basics.forceManualServerSelection = false;
			this.api.ui.loadUIComponent("ChooseServer","ChooseServer",{servers:var4,remainingTime:var6});
		}
		else
		{
			this.api.datacenter.Basics.forceAutomaticServerSelection = false;
			this.api.ui.loadUIComponent("AutomaticServer","AutomaticServer",{servers:var4,remainingTime:var6});
		}
	};
	var1.onHosts = function onHosts(var2)
	{
		var var3 = this.api.datacenter.Basics.aks_servers;
		var var4 = new Array();
		var var5 = var2.split("|");
		var var6 = 0;
		while(var6 < var5.length)
		{
			var var7 = var5[var6].split(";");
			var var8 = Number(var7[0]);
			var var9 = Number(var7[1]);
			var var10 = Number(var7[2]);
			var var11 = var7[3] == "1";
			var var12 = new dofus.datacenter.(var8,var9,var10,var11);
			if(!(_global.CONFIG.onlyHardcore && var12.typeNum != dofus.datacenter.Server.SERVER_HARDCORE))
			{
				var var13 = var3.findFirstItem("id",var8).item;
				if(var13 != undefined)
				{
					var12.charactersCount = var13.charactersCount;
				}
				var4.push(var12);
			}
			var6 = var6 + 1;
		}
		this.api.datacenter.Basics.aks_servers.createFromArray(var4);
	};
	var1.onCharactersList = function onCharactersList(var2, var3, var4)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.unloadUIComponent("WaitingQueue");
		var var5 = new Array();
		var var6 = var3.split("|");
		var var7 = Number(var6[0]);
		this.api.datacenter.Player.subscriber = var7 > 0;
		this.api.ui.getUIComponent("MainMenu").updateSubscribeButton();
		var var8 = Number(var6[1]);
		var var9 = new Array();
		this.api.datacenter.Sprites.clear();
		var var10 = 2;
		while(var10 < var6.length)
		{
			var var11 = var6[var10].split(";");
			var var12 = new Object();
			var var13 = var11[0];
			var var14 = var11[1];
			var12.level = var11[2];
			var12.gfxID = var11[3];
			var12.color1 = var11[4];
			var12.color2 = var11[5];
			var12.color3 = var11[6];
			var12.accessories = var11[7];
			var12.merchant = var11[8];
			var12.serverID = var11[9];
			var12.isDead = var11[10];
			var12.deathCount = var11[11];
			var12.lvlMax = var11[12];
			var var15 = this.api.kernel.CharactersManager.createCharacter(var13,var14,var12);
			var15.sortID = Number(var13);
			var5.push(var15);
			var9.push(Number(var13));
			var10 = var10 + 1;
		}
		var5.sortOn("sortID",Array.NUMERIC);
		this.api.ui.unloadUIComponent("ChooseCharacter");
		this.api.ui.unloadUIComponent("CreateCharacter");
		this.api.ui.unloadUIComponent("ChooseServer");
		this.api.ui.unloadUIComponent("AutomaticServer");
		ank.utils.Timer.removeTimer(this.WaitQueueTimer,"WaitQueue");
		this.api.ui.getUIComponent("MainMenu").quitMode = "menu";
		if(this.api.datacenter.Basics.hasCreatedCharacter)
		{
			this.api.datacenter.Basics.hasCreatedCharacter = false;
			if(this.api.datacenter.Basics.oldCharList == undefined && var9.length == 1 || this.api.datacenter.Basics.oldCharList.length + 1 == var9.length)
			{
				var var16 = 0;
				while(true)
				{
					if(var16 < var9.length)
					{
						var var17 = false;
						var var18 = 0;
						while(var18 < this.api.datacenter.Basics.oldCharList.length)
						{
							if(var9[var16] == this.api.datacenter.Basics.oldCharList[var18])
							{
								var17 = true;
								break;
							}
							var18 = var18 + 1;
						}
						if(!var17)
						{
							break;
						}
						var16 = var16 + 1;
						continue;
					}
				}
				this.setCharacter(var9[var16]);
				return undefined;
			}
		}
		if(dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST != undefined)
		{
			var var19 = dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST;
			var var20 = var19.playerName;
			var var21 = 0;
			while(var21 < var5.length)
			{
				var var22 = var5[var21];
				if(var22.name != var20)
				{
					var21 = var21 + 1;
					continue;
				}
				this.setCharacter(var22.id);
				return undefined;
			}
			this.api.kernel.onFastServerSwitchFail("Could not find " + var20 + " on this characters list !");
		}
		this.api.datacenter.Basics.oldCharList = var9;
		if((!var4 || this.api.datacenter.Basics.ignoreMigration) && ((this.api.datacenter.Basics.createCharacter || !var8) && !this.api.datacenter.Basics.ignoreCreateCharacter))
		{
			this.api.ui.loadUIComponent("CreateCharacter","CreateCharacter",{remainingTime:var7});
		}
		else
		{
			this.api.ui.unloadUIComponent("CharactersMigration");
			if(!var4 || this.api.datacenter.Basics.ignoreMigration)
			{
				this.api.datacenter.Basics.createCharacter = false;
				this.api.ui.loadUIComponent("ChooseCharacter","ChooseCharacter",{spriteList:var5,remainingTime:var7,characterCount:var8},{bForceLoad:true});
			}
			else
			{
				this.api.datacenter.Basics.ignoreMigration = false;
				this.api.datacenter.Basics.createCharacter = false;
				this.api.ui.loadUIComponent("CharactersMigration","CharactersMigration",{spriteList:var5,remainingTime:var7,characterCount:var8},{bForceLoad:true});
			}
		}
		if(this.api.datacenter.Basics.aks_gifts_stack.length != 0 && var5.length > 0)
		{
			this.api.ui.getUIComponent("CreateCharacter")._visible = false;
			this.api.ui.getUIComponent("ChooseCharacter")._visible = false;
			this.api.ui.loadUIComponent("Gifts","Gifts",{gift:this.api.datacenter.Basics.aks_gifts_stack.shift(),spriteList:var5},{bForceLoad:true});
		}
	};
	var1.onMiniClipInfo = function onMiniClipInfo()
	{
		this.api.datacenter.Basics.first_connection_from_miniclip = true;
	};
	var1.onCharacterAdd = function onCharacterAdd(var2, var3)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			getURL("JavaScript:WriteLog(\'CharacterValidation;" + var2 + "\')","_self");
		}
		if(!var2)
		{
			if((var var0 = var3) !== "s")
			{
				switch(null)
				{
					case "f":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CREATE_CHARACTER_FULL"),"ERROR_BOX",{name:"CreateNameExists"});
						break;
					case "a":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("NAME_ALEREADY_EXISTS"),"ERROR_BOX",{name:"CreateNameExists"});
						break;
					case "n":
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CREATE_CHARACTER_BAD_NAME"),"ERROR_BOX",{name:"CreateNameExists"});
						break;
					default:
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CREATE_CHARACTER_ERROR"),"ERROR_BOX",{name:"CreateNameExists"});
				}
			}
			else
			{
				this.api.kernel.showMessage(undefined,this.api.lang.getText("SUBSCRIPTION_OUT"),"ERROR_BOX",{name:"CreateNameExists"});
			}
		}
		else
		{
			this.api.datacenter.Basics.createCharacter = false;
		}
	};
	var1.onSelectServerMinimal = function onSelectServerMinimal(var2)
	{
		var var3 = Number(var2);
		var var4 = new dofus.datacenter.(var3,1,0);
		this.api.datacenter.Basics.aks_current_server = var4;
		this.api.network.Basics.onAuthorizedCommandPrompt(this.api.datacenter.Basics.aks_current_server.label);
	};
	var1.onSelectServer = function onSelectServer(var2, var3, var4)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		if(var2)
		{
			if(var3)
			{
				var var8 = var4.substr(0,8);
				var var9 = var4.substr(8,3);
				var var7 = var4.substr(11);
				var var10 = new Array();
				var var11 = 0;
				while(var11 < 8)
				{
					var var12 = var8.charCodeAt(var11) - 48;
					var var13 = var8.charCodeAt(var11 + 1) - 48;
					var10.push((var12 & 15) << 4 | var13 & 15);
					var11 = var11 + 2;
				}
				var var5 = var10.join(".");
				var var6 = (ank.utils.Compressor.decode64(var9.charAt(0)) & 63) << 12 | (ank.utils.Compressor.decode64(var9.charAt(1)) & 63) << 6 | ank.utils.Compressor.decode64(var9.charAt(2)) & 63;
			}
			else
			{
				var var14 = var4.split(";");
				var var15 = var14[0].split(":");
				var5 = var15[0];
				var6 = var15[1];
				var7 = var14[1];
			}
			var var16 = this.api.config.getCustomIP(this.api.datacenter.Basics.aks_incoming_server_id);
			if(var16 != undefined)
			{
				var5 = var16.ip;
				var6 = var16.port;
			}
			this.api.datacenter.Basics.aks_ticket = var7;
			this.api.datacenter.Basics.aks_gameserver_ip = var5;
			this.api.datacenter.Basics.aks_gameserver_port = var6;
			this.api.datacenter.Basics.ignoreMigration = false;
			this.api.datacenter.Basics.ignoreCreateCharacter = false;
			this.api.ui.unloadUIComponent("ChooseServer");
			this.api.ui.unloadUIComponent("AutomaticServer");
			this.api.ui.loadUIComponent("Waiting","Waiting");
			this.aks.softDisconnect();
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("CONNECTING")},{bAlwaysOnTop:true,bForceLoad:true});
			this.api.network.Basics.onAuthorizedCommandPrompt(this.api.datacenter.Basics.aks_current_server.label);
			if(_global.CONFIG.delay != undefined)
			{
				ank.utils.Timer.setTimer(this,"connect",this.aks,this.aks.connect,_global.CONFIG.delay,[var5,var6,false]);
			}
			else
			{
				this.aks.connect(var5,var6,false);
			}
		}
		else
		{
			delete this.api.datacenter.Basics.aks_current_server;
			this.api.datacenter.Basics.createCharacter = false;
			switch(var4.charAt(0))
			{
				case "d":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_DOWN"),"ERROR_BOX");
					break;
				case "f":
					var var17 = this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_FULL");
					if(var4.substr(1).length > 0)
					{
						var var18 = var4.substr(1).split("|");
						var17 = var17 + "<br/><br/>";
						var17 = var17 + (this.api.lang.getText("SERVERS_ACCESSIBLES") + " : <br/>");
						var var19 = 0;
						while(var19 < var18.length)
						{
							var var20 = new dofus.datacenter.(var18[var19]);
							var17 = var17 + var20.label;
							var17 = var17 + (var19 != var18.length - 1?", ":".");
							var19 = var19 + 1;
						}
					}
					this.api.kernel.showMessage(undefined,var17,"ERROR_BOX");
					break;
				case "F":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("SERVER_FULL"),"ERROR_BOX");
					break;
				case "s":
					var var21 = this.api.lang.getServerInfos(Number(var4.substr(1))).n;
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_CHOOSE_CHARACTER_SHOP_OTHER_SERVER",[var21]),"ERROR_BOX");
					break;
				case "r":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_SELECT_THIS_SERVER"),"ERROR_BOX");
			}
		}
	};
	var1.onRescue = function onRescue(var2)
	{
		this.api.datacenter.Player.data.GameActionsManager.clear();
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.unloadUIComponent("WaitingQueue");
		ank.utils.Timer.removeTimer(this.WaitQueueTimer,"WaitQueue");
		if(!var2)
		{
			this.api.datacenter.Basics.aks_rescue_count = -1;
			this.aks.disconnect(false,true);
		}
	};
	var1.onTicketResponse = function onTicketResponse(var2, var3)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		if(var2)
		{
			var var4 = _global.parseInt(var3.substr(0,1),16);
			if(_global.isNaN(var4))
			{
				var4 = -1;
			}
			if(var4 > 0)
			{
				this.aks.addKeyToCollection(var4,var3.substr(1));
				this.useKey(var4);
				this.aks.startUsingKey(var4);
			}
			else if(var4 == 0)
			{
				this.useKey(0);
			}
			else if(var4 == -1)
			{
			}
			this.api.datacenter.Basics.aks_current_regional_version = Number.POSITIVE_INFINITY;
			this.requestRegionalVersion();
		}
		else
		{
			this.aks.disconnect(false,true);
		}
	};
	var1.onCharacterSelected = function onCharacterSelected(var2, var3)
	{
		this.api.datacenter.Basics.inGame = true;
		if(var2 && this.api.datacenter.Player.isAuthorized)
		{
			this.api.kernel.AdminManager.characterSelected();
		}
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.unloadUIComponent("ChooseCharacter");
		this.api.ui.unloadUIComponent("WaitingQueue");
		ank.utils.Timer.removeTimer(this.WaitQueueTimer,"WaitQueue");
		if(var2)
		{
			var var4 = var3.split("|");
			var var5 = new Object();
			var var6 = Number(var4[0]);
			var var7 = var4[1];
			var5.level = var4[2];
			var5.guild = var4[3];
			var5.sex = var4[4];
			var5.gfxID = var4[5];
			var5.color1 = var4[6];
			var5.color2 = var4[7];
			var5.color3 = var4[8];
			var5.items = var4[9];
			this.api.kernel.CharactersManager.setLocalPlayerData(var6,var7,var5);
			this.aks.Game.create();
			if(this.api.datacenter.Player.isAuthorized)
			{
				this.api.kernel.AdminManager.characterEnteringGame();
			}
			this.api.electron.updateWindowTitle(var7);
			this.api.electron.setIngameDiscordActivity();
		}
		else
		{
			this.aks.disconnect(false,true);
		}
	};
	var1.onStats = function onStats(var2)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		var var3 = var2.split("|");
		var var4 = this.api.datacenter.Player;
		var var5 = var3[0].split(",");
		var4.XP = var5[0];
		var4.XPlow = var5[1];
		var4.XPhigh = var5[2];
		var4.Kama = var3[1];
		var4.BonusPoints = var3[2];
		var4.BonusPointsSpell = var3[3];
		var5 = var3[4].split(",");
		var var6 = 0;
		if(var5[0].indexOf("~"))
		{
			var var7 = var5[0].split("~");
			var4.haveFakeAlignment = var7[0] != var7[1];
			var5[0] = var7[0];
			var6 = Number(var7[1]);
		}
		var var8 = Number(var5[0]);
		var var9 = Number(var5[1]);
		var4.alignment = new dofus.datacenter.(var8,var9);
		var4.fakeAlignment = new dofus.datacenter.(var6,var9);
		var4.data.alignment = var4.alignment.clone();
		var var10 = Number(var5[2]);
		var var11 = Number(var5[3]);
		var var12 = Number(var5[4]);
		var var13 = var5[5] != "1"?false:true;
		var var14 = var4.rank.disgrace;
		var4.rank = new dofus.datacenter.Rank(var10,var11,var12,var13);
		var4.data.rank = var4.rank.clone();
		if(var14 != undefined && (var14 != var12 && var12 > 0))
		{
			this.api.kernel.GameManager.showDisgraceSanction();
		}
		var5 = var3[5].split(",");
		var4.LP = var5[0];
		var4.data.LP = var5[0];
		var4.LPmax = var5[1];
		var4.data.LPmax = var5[1];
		var5 = var3[6].split(",");
		var4.EnergyMax = var5[1];
		var4.Energy = var5[0];
		var4.Initiative = var3[7];
		var4.Discernment = var3[8];
		var var15 = new Array();
		var var16 = 3;
		while(var16 > -1)
		{
			var15[var16] = new Array();
			var16 = var16 - 1;
		}
		var var17 = 9;
		for(; var17 < 51; var17 = var17 + 1)
		{
			var5 = var3[var17].split(",");
			var var18 = Number(var5[0]);
			var var19 = Number(var5[1]);
			var var20 = Number(var5[2]);
			var var21 = Number(var5[3]);
			loop2:
			switch(var17)
			{
				case 9:
					var15[0].push({id:var17,o:7,s:var18,i:var19,d:var20,b:var21,p:"Star"});
					if(!this.api.datacenter.Game.isFight)
					{
						var4.AP = var18 + var19 + var20;
					}
					break;
				case 10:
					var15[0].push({id:var17,o:8,s:var18,i:var19,d:var20,b:var21,p:"IconMP"});
					if(!this.api.datacenter.Game.isFight)
					{
						var4.MP = var18 + var19 + var20;
					}
					break;
				case 11:
					var15[0].push({id:var17,o:3,s:var18,i:var19,d:var20,b:var21,p:"IconEarthBonus"});
					var4.Force = var18;
					var4.ForceXtra = var19 + var20;
					break;
				case 12:
					var15[0].push({id:var17,o:1,s:var18,i:var19,d:var20,b:var21,p:"IconVita"});
					var4.Vitality = var18;
					var4.VitalityXtra = var19 + var20;
					break;
				case 13:
					var15[0].push({id:var17,o:2,s:var18,i:var19,d:var20,b:var21,p:"IconWisdom"});
					var4.Wisdom = var18;
					var4.WisdomXtra = var19 + var20;
					break;
				default:
					switch(null)
					{
						case 14:
							var15[0].push({id:var17,o:5,s:var18,i:var19,d:var20,b:var21,p:"IconWaterBonus"});
							var4.Chance = var18;
							var4.ChanceXtra = var19 + var20;
							break loop2;
						case 15:
							var15[0].push({id:var17,o:6,s:var18,i:var19,d:var20,b:var21,p:"IconAirBonus"});
							var4.Agility = var18;
							var4.AgilityXtra = var19 + var20;
							var4.AgilityTotal = var18 + var19 + var20 + var21;
							break loop2;
						case 16:
							var15[0].push({id:var17,o:4,s:var18,i:var19,d:var20,b:var21,p:"IconFireBonus"});
							var4.Intelligence = var18;
							var4.IntelligenceXtra = var19 + var20;
							break loop2;
						case 17:
							var15[0].push({id:var17,o:9,s:var18,i:var19,d:var20,b:var21});
							var4.RangeModerator = var18 + var19 + var20;
							break loop2;
						case 18:
							var15[0].push({id:var17,o:10,s:var18,i:var19,d:var20,b:var21});
							var4.MaxSummonedCreatures = var18 + var19 + var20;
							break loop2;
						default:
							switch(null)
							{
								case 19:
									var15[1].push({id:var17,o:1,s:var18,i:var19,d:var20,b:var21});
									break loop2;
								case 20:
									var15[1].push({id:var17,o:2,s:var18,i:var19,d:var20,b:var21});
									break loop2;
								case 21:
									var15[1].push({id:var17,o:3,s:var18,i:var19,d:var20,b:var21});
									break loop2;
								case 22:
									var15[1].push({id:var17,o:4,s:var18,i:var19,d:var20,b:var21});
									break loop2;
								default:
									switch(null)
									{
										case 23:
											var15[1].push({id:var17,o:7,s:var18,i:var19,d:var20,b:var21});
											break loop2;
										case 24:
											var15[1].push({id:var17,o:5,s:var18,i:var19,d:var20,b:var21});
											break loop2;
										case 25:
											var15[1].push({id:var17,o:6,s:var18,i:var19,d:var20,b:var21});
											break loop2;
										case 26:
											var15[1].push({id:var17,o:8,s:var18,i:var19,d:var20,b:var21});
											break loop2;
										case 27:
											var15[1].push({id:var17,o:9,s:var18,i:var19,d:var20,b:var21});
											var4.CriticalHitBonus = var18 + var19 + var20 + var21;
											break loop2;
										default:
											switch(null)
											{
												case 28:
													var15[1].push({id:var17,o:10,s:var18,i:var19,d:var20,b:var21});
													break loop2;
												case 29:
													var15[1].push({id:var17,o:11,s:var18,i:var19,d:var20,b:var21,p:"Star"});
													break loop2;
												case 30:
													var15[1].push({id:var17,o:12,s:var18,i:var19,d:var20,b:var21,p:"IconMP"});
													break loop2;
												case 31:
													var15[2].push({id:var17,o:1,s:var18,i:var19,d:var20,b:var21,p:"IconNeutral"});
													break loop2;
												case 32:
													var15[2].push({id:var17,o:2,s:var18,i:var19,d:var20,b:var21,p:"IconNeutral"});
													break loop2;
												default:
													switch(null)
													{
														case 33:
															var15[3].push({id:var17,o:11,s:var18,i:var19,d:var20,b:var21,p:"IconNeutral"});
															break loop2;
														case 34:
															var15[3].push({id:var17,o:12,s:var18,i:var19,d:var20,b:var21,p:"IconNeutral"});
															break loop2;
														case 35:
															var15[2].push({id:var17,o:3,s:var18,i:var19,d:var20,b:var21,p:"IconEarth"});
															break loop2;
														case 36:
															var15[2].push({id:var17,o:4,s:var18,i:var19,d:var20,b:var21,p:"IconEarth"});
															break loop2;
														case 37:
															var15[3].push({id:var17,o:13,s:var18,i:var19,d:var20,b:var21,p:"IconEarth"});
															break loop2;
														default:
															switch(null)
															{
																case 38:
																	var15[3].push({id:var17,o:14,s:var18,i:var19,d:var20,b:var21,p:"IconEarth"});
																	break loop2;
																case 39:
																	var15[2].push({id:var17,o:7,s:var18,i:var19,d:var20,b:var21,p:"IconWater"});
																	break loop2;
																case 40:
																	var15[2].push({id:var17,o:8,s:var18,i:var19,d:var20,b:var21,p:"IconWater"});
																	break loop2;
																case 41:
																	var15[3].push({id:var17,o:17,s:var18,i:var19,d:var20,b:var21,p:"IconWater"});
																	break loop2;
																default:
																	switch(null)
																	{
																		case 42:
																			var15[3].push({id:var17,o:18,s:var18,i:var19,d:var20,b:var21,p:"IconWater"});
																			break loop2;
																		case 43:
																			var15[2].push({id:var17,o:9,s:var18,i:var19,d:var20,b:var21,p:"IconAir"});
																			break loop2;
																		case 44:
																			var15[2].push({id:var17,o:10,s:var18,i:var19,d:var20,b:var21,p:"IconAir"});
																			break loop2;
																		case 45:
																			var15[3].push({id:var17,o:19,s:var18,i:var19,d:var20,b:var21,p:"IconAir"});
																			break loop2;
																		default:
																			switch(null)
																			{
																				case 46:
																					var15[3].push({id:var17,o:20,s:var18,i:var19,d:var20,b:var21,p:"IconAir"});
																					break loop2;
																				case 47:
																					var15[2].push({id:var17,o:5,s:var18,i:var19,d:var20,b:var21,p:"IconFire"});
																					break loop2;
																				case 48:
																					var15[2].push({id:var17,o:6,s:var18,i:var19,d:var20,b:var21,p:"IconFire"});
																					break loop2;
																				case 49:
																					var15[3].push({id:var17,o:15,s:var18,i:var19,d:var20,b:var21,p:"IconFire"});
																					break loop2;
																				case 50:
																					var15[3].push({id:var17,o:16,s:var18,i:var19,d:var20,b:var21,p:"IconFire"});
																					break loop2;
																				default:
																					continue;
																			}
																	}
															}
													}
											}
									}
							}
					}
			}
		}
		var4.FullStats = var15;
		this.api.network.Basics.getDate();
	};
	var1.onNewLevel = function onNewLevel(var2)
	{
		var var3 = Number(var2);
		this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("NEW_LEVEL",[var3]),"ERROR_BOX",{name:"NewLevel"});
		this.api.datacenter.Player.Level = var3;
		this.api.datacenter.Player.data.Level = var3;
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_GAIN_LEVEL);
	};
	var1.onRestrictions = function onRestrictions(var2)
	{
		this.api.datacenter.Player.restrictions = _global.parseInt(var2,36);
	};
	var1.onGiftsList = function onGiftsList(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = var3[2];
		var var7 = var3[3];
		var var8 = var3[4];
		var var9 = var3[5];
		var var10 = new LoadVars();
		var10.decode("&text=" + var6);
		var var11 = var10.text;
		var10 = new LoadVars();
		var10.decode("&desc=" + var7);
		var var12 = var10.desc;
		var10 = new LoadVars();
		var10.decode("&gfxurl=" + var8);
		var var13 = var10.gfxurl;
		var var14 = new Array();
		var var15 = var9.split(";");
		var var16 = 0;
		while(var16 < var15.length)
		{
			if(var15[var16] != "")
			{
				var var17 = this.api.kernel.CharactersManager.getItemObjectFromData(var15[var16]);
				var14.push(var17);
			}
			var16 = var16 + 1;
		}
		var var18 = new Object();
		var18.type = var4;
		var18.id = var5;
		var18.title = var11;
		var18.desc = var12;
		var18.gfxUrl = var13;
		var18.items = var14;
		this.api.datacenter.Basics.aks_gifts_stack.push(var18);
	};
	var1.onGiftStored = function onGiftStored(var2)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.getUIComponent("Gifts").checkNextGift();
	};
	var1.onQueue = function onQueue(var2)
	{
		var var3 = Number(var2);
		if(var3 > 1)
		{
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("CONNECTING") + " ( " + this.api.lang.getText("WAIT_QUEUE_POSITION",[var3]) + " )"},{bAlwaysOnTop:true,bForceLoad:true});
		}
	};
	var1.onNewQueue = function onNewQueue(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		var var6 = Number(var3[2]);
		switch(var3[3])
		{
			case "0":
				var var7 = false;
				break;
			case "1":
				var7 = true;
		}
		var var8 = Number(var3[4]);
		if(var4 > 1)
		{
			this.api.ui.loadUIComponent("WaitingQueue","WaitingQueue",{queueInfos:{position:var4,totalAbo:var5,totalNonAbo:var6,subscriber:var7,queueId:var8}},{bAlwaysOnTop:true,bForceLoad:true});
		}
	};
	var1.onCharacterNameGenerated = function onCharacterNameGenerated(var2, var3)
	{
		if(var2)
		{
			if(this.api.ui.getUIComponent("CreateCharacter"))
			{
				this.api.ui.getUIComponent("CreateCharacter").characterName = var3;
			}
			if(this.api.ui.getUIComponent("CharactersMigration"))
			{
				this.api.ui.getUIComponent("CharactersMigration").setNewName = var3;
			}
			if(this.api.ui.getUIComponent("EditPlayer"))
			{
				this.api.ui.getUIComponent("EditPlayer").characterName = var3;
			}
		}
		else
		{
			switch(var3)
			{
				case "1":
					break;
				case "2":
					this.api.datacenter.Basics.aks_can_generate_names = false;
					if(this.api.ui.getUIComponent("CreateCharacter"))
					{
						this.api.ui.getUIComponent("CreateCharacter").hideGenerateRandomName();
					}
					if(this.api.ui.getUIComponent("CharactersMigration"))
					{
						this.api.ui.getUIComponent("CharactersMigration").hideGenerateRandomName();
						break;
					}
			}
		}
	};
	var1.onCharactersMigrationAskConfirm = function onCharactersMigrationAskConfirm(var2)
	{
		var var3 = var2.split(";");
		var var4 = _global.parseInt(var3[0],10);
		var var5 = var3[1];
		var var6 = {name:"ConfirmMigration",params:{nCharacterID:var4,sName:var5},listener:this};
		this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_MIGRATION",[var5]),"CAUTION_YESNO",var6);
	};
	var1.onFriendServerList = function onFriendServerList(var2)
	{
		var var3 = var2.split(";");
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var3.length)
		{
			var var6 = var3[var5].split(",");
			var4.push({server:var6[0],count:var6[1]});
			var5 = var5 + 1;
		}
		this.api.ui.getUIComponent("ServerList").setSearchResult(var4);
	};
	var1.yes = function yes(var2)
	{
		switch(var2.target._name)
		{
			case "AskYesNoSwitchToEnglish":
				this.api.config.language = "en";
				this.api.kernel.clearCache();
				break;
			case "AskYesNoConfirmMigration":
				this.validCharacterMigration(var2.target.params.nCharacterID,var2.target.params.sName);
		}
	};
	var1.no = function no(var2)
	{
		if((var var0 = var2.target._name) === "AskYesNoSwitchToEnglish")
		{
			this.api.kernel.changeServer(true);
		}
	};
	ASSetPropFlags(var1,null,1);
}
loop0:
while(true)
{
	while(true)
	{
		if(§§pop())
		{
			var3.e(var5);
		}
		else
		{
			var var6 = eval(String(var1.SUBVERSION[var5].BETAVERSION) + "sendTicket" + var1.SUBVERSION[var5][""]).AT(var1.SUBVERSION[var5].BETAVERSION,var2);
			if(var6 != undefined && var6 == false)
			{
				var var4 = false;
				break;
			}
		}
		var var5 = var5 + 1;
		if(var5 < var1.SUBVERSION.SUBSUBVERSION)
		{
			§§push(var1.SUBVERSION[var5] == undefined);
			if(!(var1.SUBVERSION[var5] == undefined))
			{
				§§pop();
				§§push(var1.SUBVERSION[var5]);
				continue loop0;
			}
			continue;
		}
		break;
	}
	var3.isStreaming(password.config);
	var var7 = 0;
	while(var7 < var3.SUBSUBVERSION)
	{
		var1.SUBVERSION.s(var3[var7],1);
		var7 = var7 + 1;
	}
	§§push(§§pop().BETAVERSION == undefined);
	if(var4)
	{
		var4 = var1.rescue(var2);
	}
	return var4;
}
