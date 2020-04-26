class dofus.aks.Aks extends dofus.utils.ApiElement
{
	static var EVALUATE_AVERAGE_PING_ON_COMMANDS = 50;
	var _bConnected = false;
	var _bConnecting = false;
	static var HEX_CHARS = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
	function Aks(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		this.Basics = new dofus.aks.Basics(this,loc3);
		this.Account = new dofus.aks.Account(this,loc3);
		this.Friends = new dofus.aks.Friends(this,loc3);
		this.Enemies = new dofus.aks.Enemies(this,loc3);
		this.Chat = new dofus.aks.Chat(this,loc3);
		this.Dialog = new dofus.aks.Dialog(this,loc3);
		this.Exchange = new dofus.aks.Exchange(this,loc3);
		this.Game = new dofus.aks.Game(this,loc3);
		this.GameActions = new dofus.aks.GameActions(this,loc3);
		this.Houses = new dofus.aks.Houses(this,loc3);
		this.Infos = new dofus.aks.Infos(this,loc3);
		this.Items = new dofus.aks.Items(this,loc3);
		this.Job = new dofus.aks.Job(this,loc3);
		this.Key = new dofus.aks.Key(this,loc3);
		this.Spells = new dofus.aks.Spells(this,loc3);
		this.Storages = new dofus.aks.Storages(this,loc3);
		this.Emotes = new dofus.aks.Emotes(this,loc3);
		this.Documents = new dofus.aks.Documents(this,loc3);
		this.Guild = new dofus.aks.Guild(this,loc3);
		this.Waypoints = new dofus.aks.Waypoints(this,loc3);
		this.Subareas = new dofus.aks.Subareas(this,loc3);
		this.Specialization = new dofus.aks.Specialization(this,loc3);
		this.Fights = new dofus.aks.Fights(this,loc3);
		this.Tutorial = new dofus.aks.Tutorial(this,loc3);
		this.Quests = new dofus.aks.Quests(this,loc3);
		this.Party = new dofus.aks.Party(this,loc3);
		this.Subway = new dofus.aks.Subway(this,loc3);
		this.Mount = new dofus.aks.Mount(this,loc3);
		this.Conquest = new dofus.aks.Conquest(this,loc3);
		this.Ping = new Object();
		this.Lag = new Object();
		this.Deco = new Object();
		this._bLag = false;
		this._bAutoReco = this.api.lang.getConfigText("AUTO_RECONNECT") == true;
		this._oDataProcessor = new dofus.aks.(this,loc3);
		this._xSocket = new XMLSocket();
		this._aLastPings = new Array();
		var aks = this;
		this._xSocket.onClose = function()
		{
			aks.onClose();
			aks.resetKeys();
		};
		this._xSocket.onConnect = function(loc2)
		{
			aks.onConnect(loc2);
		};
		this._xSocket.onData = function(loc2)
		{
			aks.onData(loc2);
		};
		this._oLoader = new LoadVars();
		this._oLoader.onLoad = function(loc2)
		{
			aks.onLoad(loc2);
		};
	}
	function connect(loc2, loc3, loc4)
	{
		if(loc4 == undefined)
		{
			loc4 = true;
		}
		if(this._bConnected)
		{
			return null;
		}
		if(this._bConnecting)
		{
			return null;
		}
		this.api.ui.loadUIComponent("Waiting","Waiting",undefined,{bStayIfPresent:true});
		if(loc2 == undefined)
		{
			loc2 = this.api.datacenter.Basics.serverHost;
		}
		else if(loc4)
		{
			this.api.datacenter.Basics.serverHost = loc2;
		}
		if(loc3 == undefined)
		{
			loc3 = this.api.datacenter.Basics.serverPort;
		}
		else if(loc4)
		{
			this.api.datacenter.Basics.serverPort = loc3;
		}
		this._bConnecting = true;
		this._aLastPings = new Array();
		var loc5 = this._xSocket.connect(loc2,loc3);
		return loc5;
	}
	function softDisconnect()
	{
		if(this._bConnected)
		{
			this._xSocket.close();
		}
		this.api.electron.updateWindowTitle();
		this.api.electron.setLoginDiscordActivity();
		this.resetKeys();
		this._bConnected = false;
	}
	function disconnect(loc2, loc3, loc4)
	{
		this.softDisconnect();
		if(!loc4)
		{
			this.onClose(loc2,loc3,true);
		}
		else
		{
			ank.utils.Timer.setTimer(this.Deco,"disconnect",this,this.onClose,1000,[loc2,loc3,true]);
		}
	}
	function send(loc2, loc3, loc4, loc5, loc6)
	{
		if(loc5 != true && loc2.length > dofus.Constants.MAX_MESSAGE_LENGTH)
		{
			loc2 = loc2.substring(0,dofus.Constants.MAX_MESSAGE_LENGTH - 1);
		}
		this.api.kernel.GameManager.signalActivity();
		if(loc3 || loc3 == undefined)
		{
			if(loc4 != undefined)
			{
				this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:loc4},{bAlwaysOnTop:true,bForceLoad:true});
			}
			this._sDebug = loc2;
			this.api.ui.loadUIComponent("Waiting","Waiting");
			this._isWaitingForData = true;
			if(this.api.datacenter.Basics.inGame && this._bAutoReco)
			{
				ank.utils.Timer.setTimer(this.Lag,"lag",this,this.onLag,Number(this.api.lang.getConfigText("DELAY_RECO_MESSAGE")));
			}
		}
		if(dofus.Constants.DEBUG_DATAS)
		{
			this.api.electron.debugRequest(true,loc2);
		}
		if(!loc6)
		{
			loc2 = this.prepareData(loc2);
		}
		if(loc2.charAt(loc2.length - 1) != "\n")
		{
			loc2 = loc2 + "\n";
		}
		this._xSocket.send(loc2);
		if(loc3 || loc3 == undefined)
		{
			this._nLastWaitingSend = getTimer();
		}
		if(dofus.Constants.DEBUG_DATAS && dofus.Constants.DEBUG_ENCRYPTION)
		{
		}
	}
	function processCommand(loc2)
	{
		this._oDataProcessor.process(loc2);
	}
	function startUsingKey(loc2)
	{
		this._nCurrentKey = loc2;
	}
	function resetKeys()
	{
		this._nCurrentKey = 0;
		this._aKeys = new Array();
	}
	function unprepareData(loc2)
	{
		if(this._nCurrentKey == 0 || (this._nCurrentKey == undefined || _global.isNaN(this._nCurrentKey)))
		{
			return loc2;
		}
		var loc3 = this._aKeys[_global.parseInt(loc2.substr(0,1),16)];
		if(loc3 == undefined)
		{
			return loc2;
		}
		var loc4 = loc2.substr(1,1).toUpperCase();
		var loc5 = dofus.aks.Aks.decypherData(loc2.substr(2),loc3,_global.parseInt(loc4,16) * 2);
		if(dofus.aks.Aks.checksum(loc5) != loc4)
		{
			return loc2;
		}
		return loc5;
	}
	function prepareData(loc2)
	{
		if(this._nCurrentKey == 0 || (this._nCurrentKey == undefined || _global.isNaN(this._nCurrentKey)))
		{
			return loc2;
		}
		if(this._aKeys[this._nCurrentKey] == undefined)
		{
			return loc2;
		}
		var loc3 = dofus.aks.Aks.HEX_CHARS[this._nCurrentKey];
		var loc4 = dofus.aks.Aks.checksum(loc2);
		loc3 = loc3 + loc4;
		return loc3 + dofus.aks.Aks.cypherData(loc2,this._aKeys[this._nCurrentKey],_global.parseInt(loc4,16) * 2);
	}
	static function prepareKey(loc2)
	{
		var loc3 = new String();
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			loc3 = loc3 + String.fromCharCode(_global.parseInt(loc2.substr(loc4,2),16));
			loc4 = loc4 + 2;
		}
		loc3 = _global.unescape(loc3);
		return loc3;
	}
	static function checksum(loc2)
	{
		var loc3 = 0;
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			loc3 = loc3 + loc2.charCodeAt(loc4) % 16;
			loc4 = loc4 + 1;
		}
		return dofus.aks.Aks.HEX_CHARS[loc3 % 16];
	}
	static function d2h(loc2)
	{
		if(loc2 > 255)
		{
			loc2 = 255;
		}
		return dofus.aks.Aks.HEX_CHARS[Math.floor(loc2 / 16)] + dofus.aks.Aks.HEX_CHARS[loc2 % 16];
	}
	static function preEscape(loc2)
	{
		var loc3 = new String();
		var loc4 = 0;
		while(loc4 < loc2.length)
		{
			var loc5 = loc2.charAt(loc4);
			var loc6 = loc2.charCodeAt(loc4);
			if(loc6 < 32 || (loc6 > 127 || (loc5 == "%" || loc5 == "+")))
			{
				loc3 = loc3 + _global.escape(loc5);
			}
			else
			{
				loc3 = loc3 + loc5;
			}
			loc4 = loc4 + 1;
		}
		return loc3;
	}
	static function cypherData(loc2, loc3, loc4)
	{
		var loc5 = new String();
		var loc6 = loc3.length;
		loc2 = dofus.aks.Aks.preEscape(loc2);
		var loc7 = 0;
		while(loc7 < loc2.length)
		{
			loc5 = loc5 + dofus.aks.Aks.d2h(loc2.charCodeAt(loc7) ^ loc3.charCodeAt((loc7 + loc4) % loc6));
			loc7 = loc7 + 1;
		}
		return loc5;
	}
	static function decypherData(loc2, loc3, loc4)
	{
		var loc5 = new String();
		var loc6 = loc3.length;
		var loc7 = 0;
		var loc8 = 0;
		var loc9 = 0;
		while(loc9 < loc2.length)
		{
			loc7;
			loc5 = loc5 + String.fromCharCode(_global.parseInt(loc2.substr(loc9,2),16) ^ loc3.charCodeAt((loc7++ + loc4) % loc6));
			loc9 = loc9 + 2;
		}
		loc5 = _global.unescape(loc5);
		return loc5;
	}
	function addKeyToCollection(loc2, loc3)
	{
		if(this._aKeys == undefined)
		{
			this._aKeys = new Array();
		}
		this._aKeys[loc2] = dofus.aks.Aks.prepareKey(loc3);
	}
	function ping()
	{
		this.api.datacenter.Basics.lastPingTimer = getTimer();
		this.send("ping");
	}
	function quickPing()
	{
		this.send("qping");
	}
	function getAveragePing()
	{
		var loc2 = 0;
		var loc3 = 0;
		while(loc3 < this._aLastPings.length)
		{
			loc2 = loc2 + this._aLastPings[loc3];
			loc3 = loc3 + 1;
		}
		return Math.round(loc2 / this._aLastPings.length);
	}
	function getAveragePingPacketsCount()
	{
		return this._aLastPings.length;
	}
	function getAveragePingBufferSize()
	{
		return dofus.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS;
	}
	function getRandomNetworkKey()
	{
		var loc2 = "";
		var loc3 = Math.round(Math.random() * 20) + 10;
		var loc4 = 0;
		while(loc4 < loc3)
		{
			loc2 = loc2 + this.getRandomChar();
			loc4 = loc4 + 1;
		}
		var loc5 = dofus.aks.Aks.checksum(loc2) + loc2;
		return loc5 + dofus.aks.Aks.checksum(loc5);
	}
	function isValidNetworkKey(loc2)
	{
		if(loc2 == undefined || (loc2.length == 0 || (loc2 == "" || (dofus.aks.Aks.checksum(loc2.substr(0,loc2.length - 1)) != loc2.substr(loc2.length - 1) || dofus.aks.Aks.checksum(loc2.substr(1,loc2.length - 2)) != loc2.substr(0,1)))))
		{
			return false;
		}
		return true;
	}
	function defaultProcessAction(loc2, loc3, loc4, loc5)
	{
		this.api.network.send(String(loc5.substr(0,2) + dofus.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS),false);
	}
	function getRandomChar()
	{
		var loc2 = Math.ceil(Math.random() * 100);
		if(loc2 <= 40)
		{
			return String.fromCharCode(Math.floor(Math.random() * 26) + 65);
		}
		if(loc2 <= 80)
		{
			return String.fromCharCode(Math.floor(Math.random() * 26) + 97);
		}
		return String.fromCharCode(Math.floor(Math.random() * 10) + 48);
	}
	function onLag()
	{
		this._bLag = true;
		this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("WAIT_FOR_SERVER")},{bAlwaysOnTop:true,bForceLoad:true});
		if(this._bAutoReco)
		{
			ank.utils.Timer.setTimer(this.Deco,"deco",this,this.onDeco,Number(this.api.lang.getConfigText("DELAY_RECO_START")));
		}
	}
	function onDeco()
	{
		if(this._bConnected)
		{
			this.resetKeys();
			this._xSocket.close();
			this._bConnected = false;
		}
		this.onClose(true,false,false);
	}
	function onConnect(loc2)
	{
		this._bConnecting = false;
		if(!loc2)
		{
			if(this.api.datacenter.Basics.aks_rescue_count > 0)
			{
				this.api.datacenter.Basics.aks_rescue_count--;
				ank.utils.Timer.setTimer(this,"connect",this,this.connect,_global.CONFIG.rdelay,[this.api.datacenter.Basics.aks_gameserver_ip,this.api.datacenter.Basics.aks_gameserver_port,false]);
				this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("TRYING_TO_RECONNECT",[this.api.datacenter.Basics.aks_rescue_count])},{bAlwaysOnTop:true,bForceLoad:true});
				return undefined;
			}
			if(this.api.datacenter.Basics.aks_rescue_count == 0)
			{
				this.onClose(false,true);
				return undefined;
			}
			if(this.api.ui.getUIComponent("Login") && (this.api.datacenter.Basics.aks_connection_server && this.api.datacenter.Basics.aks_connection_server.length))
			{
				var loc3 = String(this.api.datacenter.Basics.aks_connection_server.shift());
				ank.utils.Timer.setTimer(this,"connect",this,this.connect,_global.CONFIG.rdelay,[loc3,this.api.datacenter.Basics.aks_connection_server_port,false]);
				return undefined;
			}
			this.api.ui.unloadUIComponent("Waiting");
			this.api.ui.unloadUIComponent("WaitingMessage");
			this.api.ui.unloadUIComponent("ChooseCharacter");
			this.api.kernel.manualLogon();
			this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),this.api.lang.getText("CANT_CONNECT"),"ERROR_BOX",{name:"OnConnect"});
			this.softDisconnect();
		}
		else
		{
			this.api.ui.unloadUIComponent("Waiting");
			this.api.ui.unloadUIComponent("WaitingMessage");
			if(!this.api.datacenter.Basics.isLogged)
			{
				this.api.ui.loadUIComponent("MainMenu","MainMenu",{quitMode:(!(System.capabilities.playerType == "PlugIn" && !this.api.electron.enabled)?"quit":"no")},{bStayIfPresent:true,bAlwaysOnTop:true});
			}
			this._bConnected = true;
		}
	}
	function onData(loc2)
	{
		ank.utils.Timer.removeTimer(this.Lag,"lag");
		if(this._bLag)
		{
			dofus.utils.Api.getInstance().ui.unloadUIComponent("WaitingMessage");
			ank.utils.Timer.removeTimer(this.Deco,"deco");
			this._bLag = false;
		}
		if(dofus.Constants.DEBUG_DATAS && dofus.Constants.DEBUG_ENCRYPTION)
		{
		}
		loc2 = this.unprepareData(loc2);
		if(dofus.Constants.DEBUG_DATAS)
		{
			this.api.electron.debugRequest(false,loc2);
		}
		if(this._isWaitingForData)
		{
			this._isWaitingForData = false;
			this.api.ui.unloadUIComponent("Waiting");
			var loc3 = getTimer() - this._nLastWaitingSend;
			if(loc3 > 100)
			{
			}
			this._aLastPings.push(loc3);
			if(this._aLastPings.length > dofus.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS)
			{
				this._aLastPings.shift();
			}
		}
		this._oDataProcessor.process(loc2);
	}
	function onLoad(loc2)
	{
		if(!loc2)
		{
			this.sendNextDisconnectionState();
		}
	}
	function sendNextDisconnectionState()
	{
		if(this._aDisconnectionUrl.length <= 0)
		{
			return undefined;
		}
		var loc2 = this._aDisconnectionUrl.shift() + this._sDisconnectionParams;
		this._oLoader.load(loc2);
	}
	function onClose(loc2, loc3, loc4)
	{
		if(loc4 == undefined)
		{
			loc4 = false;
		}
		if(!loc4 && (this.api.datacenter.Basics.aks_current_server != undefined && (!this.api.datacenter.Basics.aks_server_will_disconnect && this.api.lang.getConfigText("FORWARD_UNWANTED_DISCONNECTION"))))
		{
			this._aDisconnectionUrl = String(this.api.lang.getConfigText("FORWARD_UNWANTED_DISCONNECTION_URL")).split("|");
			this._sDisconnectionParams = new String();
			this._sDisconnectionParams = this._sDisconnectionParams + ("?serverid=" + this.api.datacenter.Basics.aks_current_server);
			this._sDisconnectionParams = this._sDisconnectionParams + ("&serverip=" + this.api.datacenter.Basics.aks_gameserver_ip);
			this._sDisconnectionParams = this._sDisconnectionParams + ("&serverport=" + this.api.datacenter.Basics.aks_gameserver_port);
			this._sDisconnectionParams = this._sDisconnectionParams + ("&login=" + this.api.datacenter.Basics.login);
			this.sendNextDisconnectionState();
		}
		this._bConnecting = false;
		this._bConnected = false;
		if(this.api.datacenter.Basics.aks_current_server != undefined && (this.api.datacenter.Basics.aks_rescue_count == -1 && (!loc4 && (this.api.lang.getConfigText("AUTO_RECONNECT") && !this.api.datacenter.Basics.aks_server_will_disconnect))))
		{
			ank.utils.Timer.removeTimer(this.Deco,"deco");
			this.api.datacenter.Basics.aks_rescue_count = _global.CONFIG.rcount;
			ank.utils.Timer.setTimer(this,"connect",this,this.connect,_global.CONFIG.rdelay,[this.api.datacenter.Basics.aks_gameserver_ip,this.api.datacenter.Basics.aks_gameserver_port,false]);
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("TRYING_TO_RECONNECT",[this.api.datacenter.Basics.aks_rescue_count])},{bAlwaysOnTop:true,bForceLoad:true});
			return undefined;
		}
		if(loc2 == undefined)
		{
			loc2 = false;
		}
		if(loc3 == undefined)
		{
			loc3 = !this.api.datacenter.Basics.aks_server_will_disconnect;
		}
		if(this.api.datacenter.Basics.isLogged)
		{
			this.api.ui.clear();
			this.api.gfx.clear();
			this.api.kernel.TutorialManager.clear();
			ank.utils.Timer.clear();
		}
		else
		{
			this.api.ui.unloadUIComponent("CenterText");
			this.api.ui.unloadUIComponent("ChooseNickName");
		}
		this.api.sounds.stopAllSounds();
		if(loc2)
		{
			this.connect();
		}
		else if(this.api.datacenter.Basics.isLogged)
		{
			this.api.ui.setScreenSize(742,550);
			this.api.kernel.manualLogon();
			this.api.kernel.ChatManager.clear();
		}
		if(loc3)
		{
			var loc5 = this.api.lang.getText("DISCONNECT");
			if(this.api.datacenter.Basics.serverMessageID != -1)
			{
				loc5 = loc5 + ("\n\n" + this.api.lang.getText("SRV_MSG_" + this.api.datacenter.Basics.serverMessageID,this.api.datacenter.Basics.serverMessageParams));
				this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),loc5,"ERROR_BOX",{name:"OnClose"});
			}
			else if(this.api.lang.getConfigText("SIMPLE_AUTO_RECONNECT"))
			{
				loc5 = loc5 + ("\n\n" + this.api.lang.getText("ATTEMPT_RECONNECT"));
				var loc6 = {name:"OnClose",listener:this,params:{login:this.api.datacenter.Player.login,pass:this.api.datacenter.Player.password}};
				this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),loc5,"CAUTION_YESNO",loc6);
			}
			else
			{
				this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),loc5,"ERROR_BOX",{name:"OnClose"});
			}
		}
		this.api.datacenter.clear();
	}
	function onHelloConnectionServer(loc2)
	{
		this.api.datacenter.Basics.connexionKey = loc2;
		this.Account.logon(this.api.datacenter.Player.login,this.api.datacenter.Player.password);
		this.api.network.Account.getQueuePosition();
	}
	function onHelloGameServer(loc2)
	{
		this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("CONNECTING")},{bAlwaysOnTop:true,bForceLoad:true});
		if(this.api.datacenter.Basics.aks_rescue_count == -1)
		{
			this.Account.sendTicket(this.api.datacenter.Basics.aks_ticket);
		}
		else
		{
			this.Account.rescue(this.api.datacenter.Basics.aks_ticket);
		}
		this.api.datacenter.Basics.aks_rescue_count = -1;
	}
	function onPong()
	{
		var loc2 = getTimer() - this.api.datacenter.Basics.lastPingTimer;
		this.api.kernel.showMessage(undefined,"Ping : " + loc2 + "ms",this.api.ui.getUIComponent("Debug") != undefined?"DEBUG_LOG":"INFO_CHAT");
	}
	function onQuickPong()
	{
	}
	function onServerMessage(loc2)
	{
		var loc3 = loc2.charAt(0);
		loop0:
		switch(loc3)
		{
			case "0":
				var loc4 = loc2.substr(1).split("|");
				var loc5 = Number(loc4[0]);
				var loc6 = loc4[1].split(";");
				this.api.datacenter.Basics.serverMessageID = loc5;
				this.api.datacenter.Basics.serverMessageParams = loc6;
				break;
			case "1":
				var loc7 = loc2.substr(1).split("|");
				var loc8 = loc7[0];
				var loc9 = loc7[1].split(";");
				var loc10 = String(loc7[2]).length <= 0?undefined:loc7[2];
				switch(Number(loc8))
				{
					case 23:
						var loc11 = Number(loc9[0]);
						loc9[0] = this.api.lang.getSpellText(loc11).n;
					default:
						this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_" + loc8,loc9),"ERROR_BOX",{name:loc10});
						break loop0;
					case 12:
						this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_12"),"ERROR_CHAT");
						this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_12") + "\n\n" + this.api.lang.getText("DO_U_RELEASE_NOW"),"CAUTION_YESNO",{name:loc10,listener:this});
						return undefined;
				}
		}
	}
	function onBadVersion()
	{
		this.api.kernel.quit(false);
	}
	function onServerWillDisconnect()
	{
		this.api.datacenter.Basics.aks_server_will_disconnect = true;
	}
	function yes(loc2)
	{
		if((var loc0 = loc2.target._name) !== "AskYesNoOnClose")
		{
			this.api.network.Game.freeMySoul();
		}
		else
		{
			this.api.ui.getUIComponent("Login").autoLogin(loc2.params.login,loc2.params.pass);
		}
	}
}
