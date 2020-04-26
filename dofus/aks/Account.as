class dofus.aks.Account extends dofus.aks.Handler
{
	function Account(loc3, loc4)
	{
		super.initialize(loc3,loc4);
		this.WaitQueueTimer = new Object();
	}
	function logon(loc2, loc3)
	{
		if(this.api.datacenter.Basics.connexionKey == undefined)
		{
			this.onLogin(false,"n");
			return undefined;
		}
		if(loc2 == undefined)
		{
			loc2 = this.api.datacenter.Basics.login;
		}
		else
		{
			this.api.datacenter.Basics.login = loc2;
		}
		if(loc3 == undefined)
		{
			loc3 = this.api.datacenter.Basics.password;
		}
		else
		{
			this.api.datacenter.Basics.password = loc3;
		}
		this.aks.send(dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION <= 0?"":"." + dofus.Constants.BETAVERSION) + (!this.api.electron.enabled?"":"e") + (!this.api.config.isStreaming?"":"s"),true,this.api.lang.getText("CONNECTING"));
		if(this.api.lang.getConfigText("CRYPTO_METHOD") == 2)
		{
			var loc4 = new ank.utils.();
			var loc5 = "#2" + loc4.hex_md5(loc4.hex_md5(loc3) + this.api.datacenter.Basics.connexionKey);
			this.aks.send(loc2 + "\n" + loc5);
		}
		else
		{
			this.aks.send(loc2 + "\n" + ank.utils.Crypt.cryptPassword(loc3,this.api.datacenter.Basics.connexionKey));
		}
	}
	function setNickName(loc2)
	{
		this.aks.send(loc2,true,this.api.lang.getText("WAITING_MSG_LOADING"));
	}
	function getCharacters()
	{
		this.aks.send("AL",true,this.api.lang.getText("CONNECTING"));
	}
	function getCharactersForced()
	{
		this.aks.send("ALf",true,this.api.lang.getText("CONNECTING"));
	}
	function getServersList()
	{
		this.aks.send("Ax",true,this.api.lang.getText("WAITING_MSG_LOADING"));
	}
	function setServer(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		this.api.datacenter.Basics.aks_incoming_server_id = loc2;
		this.aks.send("AX" + loc2,true,this.api.lang.getText("WAITING_MSG_LOADING"));
	}
	function searchForFriend(loc2)
	{
		this.aks.send("AF" + loc2);
	}
	function setCharacter(loc2)
	{
		this.aks.send("AS" + loc2,true,this.api.lang.getText("WAITING_MSG_LOADING"));
		this.api.ui.unloadUIComponent("ChooseCharacter");
		this.getQueuePosition();
	}
	function editCharacterName(loc2)
	{
		this.aks.send("AEn" + loc2,true);
	}
	function editCharacterColors(loc2, loc3, loc4)
	{
		this.aks.send("AEc" + loc2 + "|" + loc3 + "|" + loc4,true);
	}
	function addCharacter(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		this.aks.send("AA" + loc2 + "|" + loc3 + "|" + loc7 + "|" + loc4 + "|" + loc5 + "|" + loc6,true,this.api.lang.getText("WAITING_MSG_RECORDING"));
	}
	function deleteCharacter(loc2, loc3)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		if(loc3 == undefined)
		{
			loc3 = "";
		}
		var loc4 = new ank.utils.(_global.escape(loc3));
		this.aks.send("AD" + loc2 + "|" + loc4.replace(["|","\r","\n",String.fromCharCode(0)],["","","",""]),true,this.api.lang.getText("WAITING_MSG_DELETING"));
	}
	function resetCharacter(loc2)
	{
		this.aks.send("AR" + loc2);
	}
	function boost(loc2)
	{
		this.aks.send("AB" + loc2);
	}
	function sendTicket(loc2)
	{
		this.aks.send("AT" + loc2);
	}
	function rescue(loc2)
	{
		var loc3 = "";
		if(this.api.datacenter.Game.isFight)
		{
			loc3 = !this.api.datacenter.Game.isRunning?"|0":"|1";
		}
		this.aks.send("Ar" + loc2 + loc3);
	}
	function getGifts()
	{
		this.aks.send("Ag" + this.api.config.language);
	}
	function attributeGiftToCharacter(loc2, loc3)
	{
		this.aks.send("AG" + loc2 + "|" + loc3);
	}
	function getQueuePosition()
	{
		this.aks.send("Af",false);
		ank.utils.Timer.setTimer(this.WaitQueueTimer,"WaitQueue",this,this.getQueuePosition,Number(this.api.lang.getConfigText("DELAY_WAIT_QUEUE_REFRESH")));
	}
	function getRandomCharacterName()
	{
		this.aks.send("AP",false);
	}
	function useKey(loc2)
	{
		this.aks.send("Ak" + dofus.aks.Aks.HEX_CHARS[loc2],false);
	}
	function requestRegionalVersion()
	{
		this.aks.send("AV",true,this.api.lang.getText("WAITING_MSG_LOADING"));
	}
	function sendIdentity()
	{
		if(this.api.datacenter.Basics.aks_current_server == undefined)
		{
			_global.clearInterval(this._nIdentityTimer);
			return undefined;
		}
		if(!this.api.datacenter.Basics.aks_can_send_identity)
		{
			return undefined;
		}
		dofus.managers.UIdManager.getInstance().update();
		var loc2 = this.api.datacenter.Basics.aks_identity;
		var loc3 = SharedObject.getLocal(dofus.Constants.GLOBAL_SO_IDENTITY_NAME);
		var loc4 = loc3.data.identity;
		if(!this.api.network.isValidNetworkKey(loc4))
		{
			loc4 = this.api.network.getRandomNetworkKey();
			loc3.data.identity = loc4;
			loc3.flush();
		}
		else if(loc2 != loc4)
		{
			this.api.datacenter.Basics.aks_identity = loc4;
			this.aks.send("Ai" + this.api.datacenter.Basics.aks_identity,false);
		}
		loc3.close();
	}
	function validCharacterMigration(loc2, loc3)
	{
		this.aks.send("AM" + loc2 + ";" + loc3,false);
	}
	function deleteCharacterMigration(loc2)
	{
		this.aks.send("AM-" + loc2,false);
	}
	function askCharacterMigration(loc2, loc3)
	{
		this.aks.send("AM?" + loc2 + ";" + loc3,false);
	}
	function onRegionalVersion(loc2)
	{
		var loc3 = this.api.lang.getConfigText("MAXIMUM_ALLOWED_VERSION");
		var loc4 = Number(loc2);
		if(loc3 > 0)
		{
			if((loc4 <= 0 || loc4 > loc3) && !this.api.datacenter.Player.isAuthorized)
			{
				var loc5 = {name:"SwitchToEnglish",listener:this};
				this.api.kernel.showMessage(undefined,this.api.lang.getText("SWITCH_TO_ENGLISH"),"CAUTION_YESNO",loc5);
				return undefined;
			}
		}
		this.api.datacenter.Basics.aks_current_regional_version = !(loc4 > 0 && !_global.isNaN(loc4))?Number.MAX_VALUE:loc4;
		this.getGifts();
		_global.clearInterval(this._nIdentityTimer);
		this._nIdentityTimer = _global.setInterval(this,"sendIdentity",(Math.round(Math.random() * 120) + 60) * 1000);
		this.sendIdentity();
		this.getCharacters();
		this.api.network.Account.getQueuePosition();
	}
	function onCharacterDelete(loc2, loc3)
	{
		if(!loc2)
		{
			this.api.ui.unloadUIComponent("WaitingMessage");
			this.api.kernel.showMessage(undefined,this.api.lang.getText("CHARACTER_DELETION_FAILED"),"ERROR_BOX");
		}
	}
	function onSecretQuestion(loc2)
	{
		this.api.datacenter.Basics.aks_secret_question = loc2;
	}
	function onKey(loc2)
	{
		var loc3 = _global.parseInt(loc2.substr(0,1),16);
		var loc4 = loc2.substr(1);
		this.aks.addKeyToCollection(loc3,loc4);
		this.useKey(loc3);
		this.aks.startUsingKey(loc3);
	}
	function onDofusPseudo(loc2)
	{
		this.api.datacenter.Basics.dofusPseudo = loc2;
	}
	function onCommunity(loc2)
	{
		var loc3 = Number(loc2);
		if(loc3 >= 0)
		{
			this.api.datacenter.Basics.communityId = loc3;
		}
	}
	function onLogin(loc2, loc3)
	{
		ank.utils.Timer.removeTimer(this.WaitQueueTimer,"WaitQueue");
		this.api.ui.unloadUIComponent("CenterText");
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.unloadUIComponent("WaitingQueue");
		if(loc2)
		{
			this.api.datacenter.Basics.isLogged = true;
			this.api.ui.unloadUIComponent("Login");
			this.api.ui.unloadUIComponent("ChooseNickName");
			this.api.datacenter.Player.isAuthorized = loc3 == "1";
			_root._loader.loadXtra();
		}
		else
		{
			var loc4 = loc3.charAt(0);
			var loc6 = false;
			loop1:
			switch(loc4)
			{
				case "n":
					var loc5 = this.api.lang.getText("CONNECT_NOT_FINISHED");
					break;
				case "a":
					loc5 = this.api.lang.getText("ALREADY_LOGGED");
					break;
				case "c":
					loc5 = this.api.lang.getText("ALREADY_LOGGED_GAME_SERVER");
					break;
				case "v":
					loc5 = this.api.lang.getText("BAD_VERSION",[dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "." + dofus.Constants.SUBSUBVERSION + (dofus.Constants.BETAVERSION <= 0?"":" Beta " + dofus.Constants.BETAVERSION),loc3.substr(1)]);
					loc6 = true;
					break;
				default:
					switch(null)
					{
						case "p":
							loc5 = this.api.lang.getText("NOT_PLAYER");
							break loop1;
						case "b":
							loc5 = this.api.lang.getText("BANNED");
							break loop1;
						case "d":
							loc5 = this.api.lang.getText("U_DISCONNECT_ACCOUNT");
							break loop1;
						case "k":
							var loc7 = loc3.substr(1).split("|");
							var loc8 = 0;
							while(loc8 < loc7.length)
							{
								if(loc7[loc8] == 0)
								{
									loc7[loc8] = undefined;
								}
								loc8 = loc8 + 1;
							}
							loc5 = ank.utils.PatternDecoder.getDescription(this.api.lang.getText("KICKED"),loc7);
							break loop1;
						default:
							switch(null)
							{
								case "w":
									loc5 = this.api.lang.getText("SERVER_FULL");
									break loop1;
								case "o":
									loc5 = this.api.lang.getText("OLD_ACCOUNT",[this.api.datacenter.Basics.login]);
									break loop1;
								case "e":
									loc5 = this.api.lang.getText("OLD_ACCOUNT_USE_NEW",[this.api.datacenter.Basics.login]);
									break loop1;
								case "m":
									loc5 = this.api.lang.getText("MAINTAIN_ACCOUNT");
									break loop1;
								case "r":
									this.api.ui.loadUIComponent("ChooseNickName","ChooseNickName");
									return undefined;
								default:
									switch(null)
									{
										case "s":
											this.api.ui.getUIComponent("ChooseNickName").nickAlreadyUsed = true;
											return undefined;
										case "f":
											if(this.api.config.isStreaming)
											{
												loc5 = this.api.lang.getText("ACCESS_DENIED_MINICLIP");
												break loop1;
											}
										default:
											loc5 = this.api.lang.getText("ACCESS_DENIED");
									}
							}
					}
			}
			if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
			{
				getURL("JavaScript:WriteLog(\'LoginError;" + loc5 + "\')","_self");
			}
			this.aks.disconnect(false,false);
			var loc9 = this.api.ui.loadUIComponent("AskOk",!loc6?"AskOkOnLogin":"AskOkOnLoginCloseClient",{title:this.api.lang.getText("LOGIN"),text:loc5});
			loc9.addEventListener("ok",this);
			this.api.kernel.manualLogon();
		}
	}
	function onServersList(loc2, loc3)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		var loc4 = this.api.datacenter.Basics.aks_servers;
		this.api.ui.getUIComponent("MainMenu").quitMode = "menu";
		var loc5 = loc3.split("|");
		var loc6 = Number(loc5[0]);
		var loc7 = -1;
		this.api.datacenter.Player.subscriber = loc6 > 0;
		this.api.ui.getUIComponent("MainMenu").updateSubscribeButton();
		var loc8 = 0;
		var loc9 = 1;
		while(loc9 < loc5.length)
		{
			var loc10 = loc5[loc9].split(",");
			var loc11 = Number(loc10[0]);
			var loc12 = Number(loc10[1]);
			if(loc12 > 0)
			{
				loc7 = loc11;
			}
			loc8 = loc8 + loc12;
			var loc13 = 0;
			while(loc13 < loc4.length)
			{
				if(loc4[loc13].id == loc11)
				{
					loc4[loc13].charactersCount = loc12;
					break;
				}
				loc13 = loc13 + 1;
			}
			loc9 = loc9 + 1;
		}
		if(loc7 == -1)
		{
			loc7 = loc4[Math.floor(Math.random() * (loc4.length - 1))].id;
			if(!loc7)
			{
				loc7 = -1;
			}
		}
		this.api.ui.unloadUIComponent("CreateCharacter");
		this.api.ui.unloadUIComponent("ChooseCharacter");
		this.api.ui.unloadUIComponent("AutomaticServer");
		this.api.ui.unloadUIComponent("ChooseServer");
		if(!this.api.datacenter.Basics.forceAutomaticServerSelection && (loc8 > 0 || (this.api.config.isStreaming || this.api.datacenter.Basics.forceManualServerSelection)))
		{
			if(this.api.datacenter.Basics.forceManualServerSelection)
			{
				this.api.datacenter.Basics.hasForcedManualSelection = true;
			}
			else if(loc7 != -1 && this.api.config.isStreaming)
			{
				var loc14 = new dofus.datacenter.(loc7,1,0);
				if(loc14.isAllowed())
				{
					this.api.datacenter.Basics.aks_current_server = loc14;
					this.api.network.Account.setServer(loc7);
					return undefined;
				}
			}
			this.api.datacenter.Basics.forceManualServerSelection = false;
			this.api.ui.loadUIComponent("ChooseServer","ChooseServer",{servers:loc4,remainingTime:loc6});
		}
		else
		{
			this.api.datacenter.Basics.forceAutomaticServerSelection = false;
			this.api.ui.loadUIComponent("AutomaticServer","AutomaticServer",{servers:loc4,remainingTime:loc6});
		}
	}
	function onHosts(loc2)
	{
		var loc3 = this.api.datacenter.Basics.aks_servers;
		var loc4 = new Array();
		var loc5 = loc2.split("|");
		var loc6 = 0;
		while(loc6 < loc5.length)
		{
			var loc7 = loc5[loc6].split(";");
			var loc8 = Number(loc7[0]);
			var loc9 = Number(loc7[1]);
			var loc10 = Number(loc7[2]);
			var loc11 = loc7[3] == "1";
			var loc12 = new dofus.datacenter.(loc8,loc9,loc10,loc11);
			if(!(_global.CONFIG.onlyHardcore && loc12.typeNum != dofus.datacenter.Server.SERVER_HARDCORE))
			{
				var loc13 = loc3.findFirstItem("id",loc8).item;
				if(loc13 != undefined)
				{
					loc12.charactersCount = loc13.charactersCount;
				}
				loc4.push(loc12);
			}
			loc6 = loc6 + 1;
		}
		this.api.datacenter.Basics.aks_servers.createFromArray(loc4);
	}
	function onCharactersList(loc2, loc3, loc4)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.unloadUIComponent("WaitingQueue");
		var loc5 = new Array();
		var loc6 = loc3.split("|");
		var loc7 = Number(loc6[0]);
		var loc8 = Number(loc6[1]);
		var loc9 = new Array();
		this.api.datacenter.Sprites.clear();
		var loc10 = 2;
		while(loc10 < loc6.length)
		{
			var loc11 = loc6[loc10].split(";");
			var loc12 = new Object();
			var loc13 = loc11[0];
			var loc14 = loc11[1];
			loc12.level = loc11[2];
			loc12.gfxID = loc11[3];
			loc12.color1 = loc11[4];
			loc12.color2 = loc11[5];
			loc12.color3 = loc11[6];
			loc12.accessories = loc11[7];
			loc12.merchant = loc11[8];
			loc12.serverID = loc11[9];
			loc12.isDead = loc11[10];
			loc12.deathCount = loc11[11];
			loc12.lvlMax = loc11[12];
			var loc15 = this.api.kernel.CharactersManager.createCharacter(loc13,loc14,loc12);
			loc15.sortID = Number(loc13);
			loc5.push(loc15);
			loc9.push(Number(loc13));
			loc10 = loc10 + 1;
		}
		loc5.sortOn("sortID",Array.NUMERIC);
		this.api.ui.unloadUIComponent("ChooseCharacter");
		this.api.ui.unloadUIComponent("CreateCharacter");
		this.api.ui.unloadUIComponent("ChooseServer");
		this.api.ui.unloadUIComponent("AutomaticServer");
		ank.utils.Timer.removeTimer(this.WaitQueueTimer,"WaitQueue");
		this.api.ui.getUIComponent("MainMenu").quitMode = "menu";
		if(this.api.datacenter.Basics.hasCreatedCharacter)
		{
			this.api.datacenter.Basics.hasCreatedCharacter = false;
			if(this.api.datacenter.Basics.oldCharList == undefined && loc9.length == 1 || this.api.datacenter.Basics.oldCharList.length + 1 == loc9.length)
			{
				var loc16 = 0;
				while(true)
				{
					if(loc16 < loc9.length)
					{
						var loc17 = false;
						var loc18 = 0;
						while(loc18 < this.api.datacenter.Basics.oldCharList.length)
						{
							if(loc9[loc16] == this.api.datacenter.Basics.oldCharList[loc18])
							{
								loc17 = true;
								break;
							}
							loc18 = loc18 + 1;
						}
						if(!loc17)
						{
							break;
						}
						loc16 = loc16 + 1;
						continue;
					}
				}
				this.setCharacter(loc9[loc16]);
				return undefined;
			}
		}
		this.api.datacenter.Basics.oldCharList = loc9;
		if((!loc4 || this.api.datacenter.Basics.ignoreMigration) && ((this.api.datacenter.Basics.createCharacter || !loc8) && !this.api.datacenter.Basics.ignoreCreateCharacter))
		{
			this.api.ui.loadUIComponent("CreateCharacter","CreateCharacter",{remainingTime:loc7});
		}
		else
		{
			this.api.ui.unloadUIComponent("CharactersMigration");
			if(!loc4 || this.api.datacenter.Basics.ignoreMigration)
			{
				this.api.datacenter.Basics.createCharacter = false;
				this.api.ui.loadUIComponent("ChooseCharacter","ChooseCharacter",{spriteList:loc5,remainingTime:loc7,characterCount:loc8},{bForceLoad:true});
			}
			else
			{
				this.api.datacenter.Basics.ignoreMigration = false;
				this.api.datacenter.Basics.createCharacter = false;
				this.api.ui.loadUIComponent("CharactersMigration","CharactersMigration",{spriteList:loc5,remainingTime:loc7,characterCount:loc8},{bForceLoad:true});
			}
		}
		if(this.api.datacenter.Basics.aks_gifts_stack.length != 0 && loc5.length > 0)
		{
			this.api.ui.getUIComponent("CreateCharacter")._visible = false;
			this.api.ui.getUIComponent("ChooseCharacter")._visible = false;
			this.api.ui.loadUIComponent("Gifts","Gifts",{gift:this.api.datacenter.Basics.aks_gifts_stack.shift(),spriteList:loc5},{bForceLoad:true});
		}
	}
	function onMiniClipInfo()
	{
		this.api.datacenter.Basics.first_connection_from_miniclip = true;
	}
	function onCharacterAdd(loc2, loc3)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		if(dofus.Constants.USE_JS_LOG && _global.CONFIG.isNewAccount)
		{
			getURL("JavaScript:WriteLog(\'CharacterValidation;" + loc2 + "\')","_self");
		}
		if(!loc2)
		{
			switch(loc3)
			{
				case "s":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("SUBSCRIPTION_OUT"),"ERROR_BOX",{name:"CreateNameExists"});
					break;
				case "f":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CREATE_CHARACTER_FULL"),"ERROR_BOX",{name:"CreateNameExists"});
					break;
				case "a":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("NAME_ALEREADY_EXISTS"),"ERROR_BOX",{name:"CreateNameExists"});
					break;
				default:
					if(loc0 !== "n")
					{
						this.api.kernel.showMessage(undefined,this.api.lang.getText("CREATE_CHARACTER_ERROR"),"ERROR_BOX",{name:"CreateNameExists"});
						break;
					}
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CREATE_CHARACTER_BAD_NAME"),"ERROR_BOX",{name:"CreateNameExists"});
					break;
			}
		}
		else
		{
			this.api.datacenter.Basics.createCharacter = false;
		}
	}
	function onSelectServer(loc2, loc3, loc4)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		if(loc2)
		{
			if(loc3)
			{
				var loc8 = loc4.substr(0,8);
				var loc9 = loc4.substr(8,3);
				var loc7 = loc4.substr(11);
				var loc10 = new Array();
				var loc11 = 0;
				while(loc11 < 8)
				{
					var loc12 = loc8.charCodeAt(loc11) - 48;
					var loc13 = loc8.charCodeAt(loc11 + 1) - 48;
					loc10.push((loc12 & 15) << 4 | loc13 & 15);
					loc11 = loc11 + 2;
				}
				var loc5 = loc10.join(".");
				var loc6 = (ank.utils.Compressor.decode64(loc9.charAt(0)) & 63) << 12 | (ank.utils.Compressor.decode64(loc9.charAt(1)) & 63) << 6 | ank.utils.Compressor.decode64(loc9.charAt(2)) & 63;
			}
			else
			{
				var loc14 = loc4.split(";");
				var loc15 = loc14[0].split(":");
				loc5 = loc15[0];
				loc6 = loc15[1];
				loc7 = loc14[1];
			}
			var loc16 = this.api.config.getCustomIP(this.api.datacenter.Basics.aks_incoming_server_id);
			if(loc16 != undefined)
			{
				loc5 = loc16.ip;
				loc6 = loc16.port;
			}
			this.api.datacenter.Basics.aks_ticket = loc7;
			this.api.datacenter.Basics.aks_gameserver_ip = loc5;
			this.api.datacenter.Basics.aks_gameserver_port = loc6;
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
				ank.utils.Timer.setTimer(this,"connect",this.aks,this.aks.connect,_global.CONFIG.delay,[loc5,loc6,false]);
			}
			else
			{
				this.aks.connect(loc5,loc6,false);
			}
		}
		else
		{
			delete this.api.datacenter.Basics.aks_current_server;
			this.api.datacenter.Basics.createCharacter = false;
			switch(loc4.charAt(0))
			{
				case "d":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_DOWN"),"ERROR_BOX");
					break;
				case "f":
					var loc17 = this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_FULL");
					if(loc4.substr(1).length > 0)
					{
						var loc18 = loc4.substr(1).split("|");
						loc17 = loc17 + "<br/><br/>";
						loc17 = loc17 + (this.api.lang.getText("SERVERS_ACCESSIBLES") + " : <br/>");
						var loc19 = 0;
						while(loc19 < loc18.length)
						{
							var loc20 = new dofus.datacenter.(loc18[loc19]);
							loc17 = loc17 + loc20.label;
							loc17 = loc17 + (loc19 != loc18.length - 1?", ":".");
							loc19 = loc19 + 1;
						}
					}
					this.api.kernel.showMessage(undefined,loc17,"ERROR_BOX");
					break;
				case "F":
					this.api.kernel.showMessage(undefined,this.api.lang.getText("SERVER_FULL"),"ERROR_BOX");
					break;
				default:
					switch(null)
					{
						case "s":
							var loc21 = this.api.lang.getServerInfos(Number(loc4.substr(1))).n;
							this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_CHOOSE_CHARACTER_SHOP_OTHER_SERVER",[loc21]),"ERROR_BOX");
							break;
						case "r":
							this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_SELECT_THIS_SERVER"),"ERROR_BOX");
					}
			}
		}
	}
	function onRescue(loc2)
	{
		this.api.datacenter.Player.data.GameActionsManager.clear();
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.unloadUIComponent("WaitingQueue");
		ank.utils.Timer.removeTimer(this.WaitQueueTimer,"WaitQueue");
		if(!loc2)
		{
			this.api.datacenter.Basics.aks_rescue_count = -1;
			this.aks.disconnect(false,true);
		}
	}
	function onTicketResponse(loc2, loc3)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		if(loc2)
		{
			var loc4 = _global.parseInt(loc3.substr(0,1),16);
			if(_global.isNaN(loc4))
			{
				loc4 = -1;
			}
			if(loc4 > 0)
			{
				this.aks.addKeyToCollection(loc4,loc3.substr(1));
				this.useKey(loc4);
				this.aks.startUsingKey(loc4);
			}
			else if(loc4 == 0)
			{
				this.useKey(0);
			}
			else if(loc4 == -1)
			{
			}
			this.api.datacenter.Basics.aks_current_regional_version = Number.POSITIVE_INFINITY;
			this.api.datacenter.Basics.aks_can_send_identity = true;
			this.requestRegionalVersion();
		}
		else
		{
			this.aks.disconnect(false,true);
		}
	}
	function onCharacterSelected(loc2, loc3)
	{
		this.api.datacenter.Basics.inGame = true;
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.unloadUIComponent("ChooseCharacter");
		this.api.ui.unloadUIComponent("WaitingQueue");
		ank.utils.Timer.removeTimer(this.WaitQueueTimer,"WaitQueue");
		if(loc2)
		{
			var loc4 = loc3.split("|");
			var loc5 = new Object();
			var loc6 = Number(loc4[0]);
			var loc7 = loc4[1];
			loc5.level = loc4[2];
			loc5.guild = loc4[3];
			loc5.sex = loc4[4];
			loc5.gfxID = loc4[5];
			loc5.color1 = loc4[6];
			loc5.color2 = loc4[7];
			loc5.color3 = loc4[8];
			loc5.items = loc4[9];
			this.api.kernel.CharactersManager.setLocalPlayerData(loc6,loc7,loc5);
			this.aks.Game.create();
			if(this.api.datacenter.Player.isAuthorized)
			{
				this.api.kernel.AdminManager.characterEnteringGame();
			}
			this.api.electron.updateWindowTitle(loc7);
			this.api.electron.setIngameDiscordActivity();
		}
		else
		{
			this.aks.disconnect(false,true);
		}
	}
	function onStats(loc2)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		var loc3 = loc2.split("|");
		var loc4 = this.api.datacenter.Player;
		var loc5 = loc3[0].split(",");
		loc4.XP = loc5[0];
		loc4.XPlow = loc5[1];
		loc4.XPhigh = loc5[2];
		loc4.Kama = loc3[1];
		loc4.BonusPoints = loc3[2];
		loc4.BonusPointsSpell = loc3[3];
		loc5 = loc3[4].split(",");
		var loc6 = 0;
		if(loc5[0].indexOf("~"))
		{
			var loc7 = loc5[0].split("~");
			loc4.haveFakeAlignment = loc7[0] != loc7[1];
			loc5[0] = loc7[0];
			loc6 = Number(loc7[1]);
		}
		var loc8 = Number(loc5[0]);
		var loc9 = Number(loc5[1]);
		loc4.alignment = new dofus.datacenter.(loc8,loc9);
		loc4.fakeAlignment = new dofus.datacenter.(loc6,loc9);
		loc4.data.alignment = loc4.alignment.clone();
		var loc10 = Number(loc5[2]);
		var loc11 = Number(loc5[3]);
		var loc12 = Number(loc5[4]);
		var loc13 = loc5[5] != "1"?false:true;
		var loc14 = loc4.rank.disgrace;
		loc4.rank = new dofus.datacenter.Rank(loc10,loc11,loc12,loc13);
		loc4.data.rank = loc4.rank.clone();
		if(loc14 != undefined && (loc14 != loc12 && loc12 > 0))
		{
			this.api.kernel.GameManager.showDisgraceSanction();
		}
		loc5 = loc3[5].split(",");
		loc4.LP = loc5[0];
		loc4.data.LP = loc5[0];
		loc4.LPmax = loc5[1];
		loc4.data.LPmax = loc5[1];
		loc5 = loc3[6].split(",");
		loc4.Energy = loc5[0];
		loc4.EnergyMax = loc5[1];
		loc4.Initiative = loc3[7];
		loc4.Discernment = loc3[8];
		var loc15 = new Array();
		var loc16 = 3;
		while(loc16 > -1)
		{
			loc15[loc16] = new Array();
			loc16 = loc16 - 1;
		}
		var loc17 = 9;
		while(loc17 < 51)
		{
			loc5 = loc3[loc17].split(",");
			var loc18 = Number(loc5[0]);
			var loc19 = Number(loc5[1]);
			var loc20 = Number(loc5[2]);
			var loc21 = Number(loc5[3]);
			loop2:
			switch(loc17)
			{
				case 9:
					loc15[0].push({id:loc17,o:7,s:loc18,i:loc19,d:loc20,b:loc21,p:"Star"});
					if(!this.api.datacenter.Game.isFight)
					{
						loc4.AP = loc18 + loc19 + loc20;
					}
					break;
				case 10:
					loc15[0].push({id:loc17,o:8,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconMP"});
					if(!this.api.datacenter.Game.isFight)
					{
						loc4.MP = loc18 + loc19 + loc20;
					}
					break;
				case 11:
					loc15[0].push({id:loc17,o:3,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconEarthBonus"});
					loc4.Force = loc18;
					loc4.ForceXtra = loc19 + loc20;
					break;
				case 12:
					loc15[0].push({id:loc17,o:1,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconVita"});
					loc4.Vitality = loc18;
					loc4.VitalityXtra = loc19 + loc20;
					break;
				default:
					switch(null)
					{
						case 13:
							loc15[0].push({id:loc17,o:2,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconWisdom"});
							loc4.Wisdom = loc18;
							loc4.WisdomXtra = loc19 + loc20;
							break loop2;
						case 14:
							loc15[0].push({id:loc17,o:5,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconWaterBonus"});
							loc4.Chance = loc18;
							loc4.ChanceXtra = loc19 + loc20;
							break loop2;
						case 15:
							loc15[0].push({id:loc17,o:6,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconAirBonus"});
							loc4.Agility = loc18;
							loc4.AgilityXtra = loc19 + loc20;
							loc4.AgilityTotal = loc18 + loc19 + loc20 + loc21;
							break loop2;
						case 16:
							loc15[0].push({id:loc17,o:4,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconFireBonus"});
							loc4.Intelligence = loc18;
							loc4.IntelligenceXtra = loc19 + loc20;
							break loop2;
						case 17:
							loc15[0].push({id:loc17,o:9,s:loc18,i:loc19,d:loc20,b:loc21});
							loc4.RangeModerator = loc18 + loc19 + loc20;
							break loop2;
						default:
							switch(null)
							{
								case 18:
									loc15[0].push({id:loc17,o:10,s:loc18,i:loc19,d:loc20,b:loc21});
									loc4.MaxSummonedCreatures = loc18 + loc19 + loc20;
									break loop2;
								case 19:
									loc15[1].push({id:loc17,o:1,s:loc18,i:loc19,d:loc20,b:loc21});
									break loop2;
								case 20:
									loc15[1].push({id:loc17,o:2,s:loc18,i:loc19,d:loc20,b:loc21});
									break loop2;
								case 21:
									loc15[1].push({id:loc17,o:3,s:loc18,i:loc19,d:loc20,b:loc21});
									break loop2;
								case 22:
									loc15[1].push({id:loc17,o:4,s:loc18,i:loc19,d:loc20,b:loc21});
									break loop2;
								default:
									switch(null)
									{
										case 23:
											loc15[1].push({id:loc17,o:7,s:loc18,i:loc19,d:loc20,b:loc21});
											break loop2;
										case 24:
											loc15[1].push({id:loc17,o:5,s:loc18,i:loc19,d:loc20,b:loc21});
											break loop2;
										case 25:
											loc15[1].push({id:loc17,o:6,s:loc18,i:loc19,d:loc20,b:loc21});
											break loop2;
										case 26:
											loc15[1].push({id:loc17,o:8,s:loc18,i:loc19,d:loc20,b:loc21});
											break loop2;
										case 27:
											loc15[1].push({id:loc17,o:9,s:loc18,i:loc19,d:loc20,b:loc21});
											loc4.CriticalHitBonus = loc18 + loc19 + loc20 + loc21;
											break loop2;
										case 28:
											loc15[1].push({id:loc17,o:10,s:loc18,i:loc19,d:loc20,b:loc21});
											break loop2;
										default:
											switch(null)
											{
												case 29:
													loc15[1].push({id:loc17,o:11,s:loc18,i:loc19,d:loc20,b:loc21,p:"Star"});
													break loop2;
												case 30:
													loc15[1].push({id:loc17,o:12,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconMP"});
													break loop2;
												case 31:
													loc15[2].push({id:loc17,o:1,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconNeutral"});
													break loop2;
												case 32:
													loc15[2].push({id:loc17,o:2,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconNeutral"});
													break loop2;
												default:
													switch(null)
													{
														case 33:
															loc15[3].push({id:loc17,o:11,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconNeutral"});
															break loop2;
														case 34:
															loc15[3].push({id:loc17,o:12,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconNeutral"});
															break loop2;
														case 35:
															loc15[2].push({id:loc17,o:3,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconEarth"});
															break loop2;
														case 36:
															loc15[2].push({id:loc17,o:4,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconEarth"});
															break loop2;
														case 37:
															loc15[3].push({id:loc17,o:13,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconEarth"});
															break loop2;
														default:
															switch(null)
															{
																case 38:
																	loc15[3].push({id:loc17,o:14,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconEarth"});
																	break loop2;
																case 39:
																	loc15[2].push({id:loc17,o:7,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconWater"});
																	break loop2;
																case 40:
																	loc15[2].push({id:loc17,o:8,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconWater"});
																	break loop2;
																case 41:
																	loc15[3].push({id:loc17,o:17,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconWater"});
																	break loop2;
																case 42:
																	loc15[3].push({id:loc17,o:18,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconWater"});
																	break loop2;
																default:
																	switch(null)
																	{
																		case 43:
																			loc15[2].push({id:loc17,o:9,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconAir"});
																			break loop2;
																		case 44:
																			loc15[2].push({id:loc17,o:10,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconAir"});
																			break loop2;
																		case 45:
																			loc15[3].push({id:loc17,o:19,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconAir"});
																			break loop2;
																		case 46:
																			loc15[3].push({id:loc17,o:20,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconAir"});
																			break loop2;
																		default:
																			switch(null)
																			{
																				case 47:
																					loc15[2].push({id:loc17,o:5,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconFire"});
																					break;
																				case 48:
																					loc15[2].push({id:loc17,o:6,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconFire"});
																					break;
																				case 49:
																					loc15[3].push({id:loc17,o:15,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconFire"});
																					break;
																				case 50:
																					loc15[3].push({id:loc17,o:16,s:loc18,i:loc19,d:loc20,b:loc21,p:"IconFire"});
																			}
																	}
															}
													}
											}
									}
							}
					}
			}
			loc17 = loc17 + 1;
		}
		loc4.FullStats = loc15;
		this.api.network.Basics.getDate();
	}
	function onNewLevel(loc2)
	{
		var loc3 = Number(loc2);
		this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("NEW_LEVEL",[loc3]),"ERROR_BOX",{name:"NewLevel"});
		this.api.datacenter.Player.Level = loc3;
		this.api.datacenter.Player.data.Level = loc3;
		this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_GAIN_LEVEL);
	}
	function onRestrictions(loc2)
	{
		this.api.datacenter.Player.restrictions = _global.parseInt(loc2,36);
	}
	function onGiftsList(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = loc3[2];
		var loc7 = loc3[3];
		var loc8 = loc3[4];
		var loc9 = loc3[5];
		var loc10 = new LoadVars();
		loc10.decode("&text=" + loc6);
		var loc11 = loc10.text;
		loc10 = new LoadVars();
		loc10.decode("&desc=" + loc7);
		var loc12 = loc10.desc;
		loc10 = new LoadVars();
		loc10.decode("&gfxurl=" + loc8);
		var loc13 = loc10.gfxurl;
		var loc14 = new Array();
		var loc15 = loc9.split(";");
		var loc16 = 0;
		while(loc16 < loc15.length)
		{
			if(loc15[loc16] != "")
			{
				var loc17 = this.api.kernel.CharactersManager.getItemObjectFromData(loc15[loc16]);
				loc14.push(loc17);
			}
			loc16 = loc16 + 1;
		}
		var loc18 = new Object();
		loc18.type = loc4;
		loc18.id = loc5;
		loc18.title = loc11;
		loc18.desc = loc12;
		loc18.gfxUrl = loc13;
		loc18.items = loc14;
		this.api.datacenter.Basics.aks_gifts_stack.push(loc18);
	}
	function onGiftStored(loc2)
	{
		this.api.ui.unloadUIComponent("WaitingMessage");
		this.api.ui.getUIComponent("Gifts").checkNextGift();
	}
	function onQueue(loc2)
	{
		var loc3 = Number(loc2);
		if(loc3 > 1)
		{
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("CONNECTING") + " ( " + this.api.lang.getText("WAIT_QUEUE_POSITION",[loc3]) + " )"},{bAlwaysOnTop:true,bForceLoad:true});
		}
	}
	function onNewQueue(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		var loc6 = Number(loc3[2]);
		switch(loc3[3])
		{
			case "0":
				var loc7 = false;
				break;
			case "1":
				loc7 = true;
		}
		var loc8 = Number(loc3[4]);
		if(loc4 > 1)
		{
			this.api.ui.loadUIComponent("WaitingQueue","WaitingQueue",{queueInfos:{position:loc4,totalAbo:loc5,totalNonAbo:loc6,subscriber:loc7,queueId:loc8}},{bAlwaysOnTop:true,bForceLoad:true});
		}
	}
	function onCharacterNameGenerated(loc2, loc3)
	{
		if(loc2)
		{
			if(this.api.ui.getUIComponent("CreateCharacter"))
			{
				this.api.ui.getUIComponent("CreateCharacter").characterName = loc3;
			}
			if(this.api.ui.getUIComponent("CharactersMigration"))
			{
				this.api.ui.getUIComponent("CharactersMigration").setNewName = loc3;
			}
			if(this.api.ui.getUIComponent("EditPlayer"))
			{
				this.api.ui.getUIComponent("EditPlayer").characterName = loc3;
			}
		}
		else
		{
			switch(loc3)
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
	}
	function onCharactersMigrationAskConfirm(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = _global.parseInt(loc3[0],10);
		var loc5 = loc3[1];
		var loc6 = {name:"ConfirmMigration",params:{nCharacterID:loc4,sName:loc5},listener:this};
		this.api.kernel.showMessage(undefined,this.api.lang.getText("CONFIRM_MIGRATION",[loc5]),"CAUTION_YESNO",loc6);
	}
	function onFriendServerList(loc2)
	{
		var loc3 = loc2.split(";");
		var loc4 = new Array();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			var loc6 = loc3[loc5].split(",");
			loc4.push({server:loc6[0],count:loc6[1]});
			loc5 = loc5 + 1;
		}
		this.api.ui.getUIComponent("ServerList").setSearchResult(loc4);
	}
	function yes(loc2)
	{
		switch(loc2.target._name)
		{
			case "AskYesNoSwitchToEnglish":
				this.api.config.language = "en";
				this.api.kernel.clearCache();
				break;
			case "AskYesNoConfirmMigration":
				this.validCharacterMigration(loc2.target.params.nCharacterID,loc2.target.params.sName);
		}
	}
	function no(loc2)
	{
		if((var loc0 = loc2.target._name) === "AskYesNoSwitchToEnglish")
		{
			this.api.kernel.changeServer(true);
		}
	}
}
