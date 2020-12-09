class dofus.aks.Aks extends dofus.utils.ApiElement
{
	static var EVALUATE_AVERAGE_PING_ON_COMMANDS = 50;
	var _bConnected = false;
	var _bConnecting = false;
	static var HEX_CHARS = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
	static var CURRENT_IDENTITY_VERSION = 2;
	function Aks(§\x1e\x1a\x16§)
	{
		super();
		this.initialize(var3);
	}
	function __get__isConnected()
	{
		return this._bConnected;
	}
	function initialize(§\x1e\x1a\x16§)
	{
		super.initialize(var3);
		this.Basics = new dofus.aks.Basics(this,var3);
		this.Account = new dofus.aks.Account(this,var3);
		this.Friends = new dofus.aks.Friends(this,var3);
		this.Enemies = new dofus.aks.Enemies(this,var3);
		this.Chat = new dofus.aks.Chat(this,var3);
		this.Dialog = new dofus.aks.Dialog(this,var3);
		this.Exchange = new dofus.aks.Exchange(this,var3);
		this.Game = new dofus.aks.Game(this,var3);
		this.GameActions = new dofus.aks.GameActions(this,var3);
		this.Houses = new dofus.aks.Houses(this,var3);
		this.Infos = new dofus.aks.Infos(this,var3);
		this.Items = new dofus.aks.Items(this,var3);
		this.Job = new dofus.aks.Job(this,var3);
		this.Key = new dofus.aks.Key(this,var3);
		this.Spells = new dofus.aks.Spells(this,var3);
		this.Storages = new dofus.aks.Storages(this,var3);
		this.Emotes = new dofus.aks.Emotes(this,var3);
		this.Documents = new dofus.aks.Documents(this,var3);
		this.Guild = new dofus.aks.Guild(this,var3);
		this.Waypoints = new dofus.aks.Waypoints(this,var3);
		this.Subareas = new dofus.aks.Subareas(this,var3);
		this.Specialization = new dofus.aks.Specialization(this,var3);
		this.Fights = new dofus.aks.Fights(this,var3);
		this.Tutorial = new dofus.aks.Tutorial(this,var3);
		this.Quests = new dofus.aks.Quests(this,var3);
		this.Party = new dofus.aks.Party(this,var3);
		this.Subway = new dofus.aks.Subway(this,var3);
		this.Mount = new dofus.aks.Mount(this,var3);
		this.Conquest = new dofus.aks.Conquest(this,var3);
		this.Ping = new Object();
		this.Lag = new Object();
		this.Deco = new Object();
		this._bLag = false;
		this._bAutoReco = this.api.lang.getConfigText("AUTO_RECONNECT") == true;
		this._oDataProcessor = new dofus.aks.DataProcessor(this,var3);
		this._xSocket = new XMLSocket();
		this._aLastPings = new Array();
		var aks = this;
		this._xSocket.onClose = function()
		{
			aks.onClose();
			aks.resetKeys();
		};
		this._xSocket.onConnect = function(§\x14\x1b§)
		{
			aks.onConnect(var2);
		};
		this._xSocket.onData = function(§\x1e\x13\x10§)
		{
			aks.onData(var2);
		};
		this._oLoader = new LoadVars();
		this._oLoader.onLoad = function(§\x1e\f\x0e§)
		{
			aks.onLoad(var2);
		};
	}
	function connect(§\x1e\x11\x1d§, §\x01\x18§, §\x16\x04§)
	{
		org.flashdevelop.utils.FlashConnect.mtrace("connect " + var2 + ":" + var3,"dofus.aks.Aks::connect","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/Aks.as",165);
		if(var4 == undefined)
		{
			var4 = true;
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
		if(var2 == undefined)
		{
			var2 = this.api.datacenter.Basics.serverHost;
		}
		else if(var4)
		{
			this.api.datacenter.Basics.serverHost = var2;
		}
		if(var3 == undefined)
		{
			var3 = this.api.datacenter.Basics.serverPort;
		}
		else if(var4)
		{
			this.api.datacenter.Basics.serverPort = var3;
		}
		this._bConnecting = true;
		this._aLastPings = new Array();
		var var5 = this._xSocket.connect(var2,var3);
		return var5;
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
	function disconnect(§\x16\x0f§, §\x15\n§, §\x16\x0e§)
	{
		this.softDisconnect();
		if(!var4)
		{
			this.onClose(var2,var3,true);
		}
		else
		{
			ank.utils.Timer.setTimer(this.Deco,"disconnect",this,this.onClose,1000,[var2,var3,true]);
		}
	}
	function send(§\x1e\x13\x10§, §\x13\x1c§, §\x1e\f\x07§, §\x17\x0b§, §\x17\x10§)
	{
		if(var5 != true && var2.length > dofus.Constants.MAX_MESSAGE_LENGTH)
		{
			var2 = var2.substring(0,dofus.Constants.MAX_MESSAGE_LENGTH - 1);
		}
		this.api.kernel.GameManager.signalActivity();
		if(var3 || var3 == undefined)
		{
			if(var4 != undefined)
			{
				this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:var4},{bAlwaysOnTop:true,bForceLoad:true});
			}
			this._sDebug = var2;
			this.api.ui.loadUIComponent("Waiting","Waiting");
			this._isWaitingForData = true;
			if(this.api.datacenter.Basics.inGame && this._bAutoReco)
			{
				ank.utils.Timer.setTimer(this.Lag,"lag",this,this.onLag,Number(this.api.lang.getConfigText("DELAY_RECO_MESSAGE")));
			}
		}
		if(dofus.Constants.DEBUG_DATAS)
		{
			this.api.electron.debugRequest(true,var2);
		}
		if(!var6)
		{
			var2 = this.prepareData(var2);
		}
		if(var2.charAt(var2.length - 1) != "\n")
		{
			var2 = var2 + "\n";
		}
		this._xSocket.send(var2);
		if(var3 || var3 == undefined)
		{
			this._nLastWaitingSend = getTimer();
		}
		if(dofus.Constants.DEBUG_DATAS && dofus.Constants.DEBUG_ENCRYPTION)
		{
			org.flashdevelop.utils.FlashConnect.mtrace("SND (C) " + var2,com.ankamagames.tools.Logger.LEVEL_NETWORK,"dofus.aks.Aks::send","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/Aks.as",281);
		}
	}
	function processCommand(§\x1e\x14\b§)
	{
		this._oDataProcessor.process(var2);
	}
	function startUsingKey(§\x04\b§)
	{
		this._nCurrentKey = var2;
	}
	function resetKeys()
	{
		this._nCurrentKey = 0;
		this._aKeys = new Array();
	}
	function unprepareData(§\x1e\x15\n§)
	{
		if(this._nCurrentKey == 0 || (this._nCurrentKey == undefined || _global.isNaN(this._nCurrentKey)))
		{
			return var2;
		}
		var var3 = this._aKeys[_global.parseInt(var2.substr(0,1),16)];
		if(var3 == undefined)
		{
			org.flashdevelop.utils.FlashConnect.mtrace("[?!!] Le serveur a demandé une clé que je n\'ai pas...","dofus.aks.Aks::unprepareData","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/Aks.as",316);
			return var2;
		}
		var var4 = var2.substr(1,1).toUpperCase();
		var var5 = dofus.aks.Aks.decypherData(var2.substr(2),var3,_global.parseInt(var4,16) * 2);
		if(dofus.aks.Aks.checksum(var5) != var4)
		{
			org.flashdevelop.utils.FlashConnect.mtrace("[?!!] Checksum invalide! (Reçu : " + var2.substr(1,1) + ", Calculé : " + dofus.aks.Aks.checksum(var5) + ")","dofus.aks.Aks::unprepareData","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/Aks.as",329);
			org.flashdevelop.utils.FlashConnect.mtrace("[?!!] Données interpretées : " + var5,"dofus.aks.Aks::unprepareData","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/Aks.as",330);
			return var2;
		}
		return var5;
	}
	function prepareData(§\x1e\x15\n§)
	{
		if(this._nCurrentKey == 0 || (this._nCurrentKey == undefined || _global.isNaN(this._nCurrentKey)))
		{
			return var2;
		}
		if(this._aKeys[this._nCurrentKey] == undefined)
		{
			org.flashdevelop.utils.FlashConnect.mtrace("[?!!] La clé " + this._nCurrentKey + " définie en clé actuelle n\'existe pas dans le buffer...","dofus.aks.Aks::prepareData","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/Aks.as",346);
			return var2;
		}
		var var3 = dofus.aks.Aks.HEX_CHARS[this._nCurrentKey];
		var var4 = dofus.aks.Aks.checksum(var2);
		var3 = var3 + var4;
		return var3 + dofus.aks.Aks.cypherData(var2,this._aKeys[this._nCurrentKey],_global.parseInt(var4,16) * 2);
	}
	static function prepareKey(§\x11\x17§)
	{
		var var3 = new String();
		var var4 = 0;
		while(var4 < var2.length)
		{
			var3 = var3 + String.fromCharCode(_global.parseInt(var2.substr(var4,2),16));
			var4 = var4 + 2;
		}
		var3 = _global.unescape(var3);
		return var3;
	}
	static function checksum(§\x1e\x15\n§)
	{
		var var3 = 0;
		var var4 = 0;
		while(var4 < var2.length)
		{
			var3 = var3 + var2.charCodeAt(var4) % 16;
			var4 = var4 + 1;
		}
		return dofus.aks.Aks.HEX_CHARS[var3 % 16];
	}
	static function d2h(§\x11\x17§)
	{
		if(var2 > 255)
		{
			var2 = 255;
		}
		return dofus.aks.Aks.HEX_CHARS[Math.floor(var2 / 16)] + dofus.aks.Aks.HEX_CHARS[var2 % 16];
	}
	static function preEscape(§\x1e\x15\n§)
	{
		var var3 = new String();
		var var4 = 0;
		while(var4 < var2.length)
		{
			var var5 = var2.charAt(var4);
			var var6 = var2.charCodeAt(var4);
			if(var6 < 32 || (var6 > 127 || (var5 == "%" || var5 == "+")))
			{
				var3 = var3 + _global.escape(var5);
			}
			else
			{
				var3 = var3 + var5;
			}
			var4 = var4 + 1;
		}
		return var3;
	}
	static function cypherData(§\x11\x17§, §\f\x0f§, §\x13\x14§)
	{
		var var5 = new String();
		var var6 = var3.length;
		var2 = dofus.aks.Aks.preEscape(var2);
		var var7 = 0;
		while(var7 < var2.length)
		{
			var5 = var5 + dofus.aks.Aks.d2h(var2.charCodeAt(var7) ^ var3.charCodeAt((var7 + var4) % var6));
			var7 = var7 + 1;
		}
		return var5;
	}
	static function decypherData(§\x11\x17§, §\f\x0f§, §\x13\x14§)
	{
		var var5 = new String();
		var var6 = var3.length;
		var var7 = 0;
		var var8 = 0;
		var var9 = 0;
		while(var9 < var2.length)
		{
			var7;
			var5 = var5 + String.fromCharCode(_global.parseInt(var2.substr(var9,2),16) ^ var3.charCodeAt((var7++ + var4) % var6));
			var9 = var9 + 2;
		}
		var5 = _global.unescape(var5);
		return var5;
	}
	function addKeyToCollection(§\x04\b§, §\x1e\x11\x10§)
	{
		if(this._aKeys == undefined)
		{
			this._aKeys = new Array();
		}
		this._aKeys[var2] = dofus.aks.Aks.prepareKey(var3);
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
		var var2 = 0;
		var var3 = 0;
		while(var3 < this._aLastPings.length)
		{
			var2 = var2 + this._aLastPings[var3];
			var3 = var3 + 1;
		}
		return Math.round(var2 / this._aLastPings.length);
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
		if(this.api.electron.enabled)
		{
			var var2 = this.api.electron.getRandomNetworkKey();
		}
		else
		{
			var2 = "";
			var var3 = Math.round(Math.random() * 128) + 128;
			var var4 = 0;
			while(var4 < var3)
			{
				var2 = var2 + this.getRandomChar();
				var4 = var4 + 1;
			}
		}
		var var5 = dofus.aks.Aks.checksum(var2) + var2;
		return var5 + dofus.aks.Aks.checksum(var5);
	}
	function isValidNetworkKey(§\x1e\x11\x10§, §\x04\x1b§)
	{
		if(var3 == undefined || var3 != dofus.aks.Aks.CURRENT_IDENTITY_VERSION)
		{
			return false;
		}
		if(var2 == undefined || (var2.length == 0 || (var2 == "" || (dofus.aks.Aks.checksum(var2.substr(0,var2.length - 1)) != var2.substr(var2.length - 1) || dofus.aks.Aks.checksum(var2.substr(1,var2.length - 2)) != var2.substr(0,1)))))
		{
			return false;
		}
		return true;
	}
	function defaultProcessAction(§\x1e\f\x14§, §\x1e\x15\x07§, §\x1a\x10§, §\x1e\x13\x10§)
	{
		this.api.network.send(String(var5.substr(0,2) + dofus.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS),false);
	}
	function getRandomChar()
	{
		var var2 = Math.ceil(Math.random() * 100);
		if(var2 <= 40)
		{
			return String.fromCharCode(Math.floor(Math.random() * 26) + 65);
		}
		if(var2 <= 80)
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
	function onConnect(§\x14\x1b§)
	{
		this._bConnecting = false;
		if(!var2)
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
				var var3 = String(this.api.datacenter.Basics.aks_connection_server.shift());
				ank.utils.Timer.setTimer(this,"connect",this,this.connect,_global.CONFIG.rdelay,[var3,this.api.datacenter.Basics.aks_connection_server_port,false]);
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
	function onData(§\x1e\x13\x10§)
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
			org.flashdevelop.utils.FlashConnect.mtrace("RCV (C) " + var2,com.ankamagames.tools.Logger.LEVEL_NETWORK,"dofus.aks.Aks::onData","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/Aks.as",646);
		}
		var2 = this.unprepareData(var2);
		if(dofus.Constants.DEBUG_DATAS)
		{
			this.api.electron.debugRequest(false,var2);
		}
		if(this._isWaitingForData)
		{
			this._isWaitingForData = false;
			this.api.ui.unloadUIComponent("Waiting");
			var var3 = getTimer() - this._nLastWaitingSend;
			if(var3 > 100)
			{
				org.flashdevelop.utils.FlashConnect.mtrace("[wtf] " + this._sDebug + " (since " + var3 + "ms)","dofus.aks.Aks::onData","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/aks/Aks.as",662);
			}
			this._aLastPings.push(var3);
			if(this._aLastPings.length > dofus.aks.Aks.EVALUATE_AVERAGE_PING_ON_COMMANDS)
			{
				this._aLastPings.shift();
			}
		}
		this._oDataProcessor.process(var2);
	}
	function onLoad(§\x1e\f\x0e§)
	{
		if(!var2)
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
		var var2 = this._aDisconnectionUrl.shift() + this._sDisconnectionParams;
		this._oLoader.load(var2);
	}
	function onClose(§\x16\x0f§, §\x15\n§, §\x17\x1d§)
	{
		if(var4 == undefined)
		{
			var4 = false;
		}
		if(!var4 && (this.api.datacenter.Basics.aks_current_server != undefined && (!this.api.datacenter.Basics.aks_server_will_disconnect && this.api.lang.getConfigText("FORWARD_UNWANTED_DISCONNECTION"))))
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
		if(this.api.datacenter.Basics.aks_current_server != undefined && (this.api.datacenter.Basics.aks_rescue_count == -1 && (!var4 && (this.api.lang.getConfigText("AUTO_RECONNECT") && !this.api.datacenter.Basics.aks_server_will_disconnect))))
		{
			ank.utils.Timer.removeTimer(this.Deco,"deco");
			this.api.datacenter.Basics.aks_rescue_count = _global.CONFIG.rcount;
			ank.utils.Timer.setTimer(this,"connect",this,this.connect,_global.CONFIG.rdelay,[this.api.datacenter.Basics.aks_gameserver_ip,this.api.datacenter.Basics.aks_gameserver_port,false]);
			this.api.ui.loadUIComponent("WaitingMessage","WaitingMessage",{text:this.api.lang.getText("TRYING_TO_RECONNECT",[this.api.datacenter.Basics.aks_rescue_count])},{bAlwaysOnTop:true,bForceLoad:true});
			return undefined;
		}
		if(var2 == undefined)
		{
			var2 = false;
		}
		if(var3 == undefined)
		{
			var3 = !this.api.datacenter.Basics.aks_server_will_disconnect;
		}
		if(!var2 && dofus.Kernel.FAST_SWITCHING_SERVER_REQUEST != undefined)
		{
			this.api.kernel.onFastServerSwitchFail();
		}
		if(this.api.datacenter.Basics.isLogged)
		{
			this.api.kernel.GameManager.zoomGfxRoot(100);
			this.api.ui.clear();
			this.api.ui.loadUIComponent("Zoom","Zoom");
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
		if(var2)
		{
			var var5 = this.api.datacenter.Player.zaapToken != null;
			if(var5)
			{
				this.api.ui.setScreenSize(742,550);
				this.api.kernel.autoLogon();
			}
			else
			{
				this.connect();
			}
		}
		else if(this.api.datacenter.Basics.isLogged)
		{
			this.api.ui.setScreenSize(742,550);
			this.api.kernel.manualLogon();
			this.api.kernel.ChatManager.clear();
		}
		if(var3)
		{
			var var6 = this.api.lang.getText("DISCONNECT");
			if(this.api.datacenter.Basics.serverMessageID != -1)
			{
				var6 = var6 + (MountPark + this.api.lang.getText("SRV_MSG_" + this.api.datacenter.Basics.serverMessageID,this.api.datacenter.Basics.serverMessageParams));
				this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),var6,"ERROR_BOX",{name:"OnClose"});
			}
			else if(this.api.lang.getConfigText("SIMPLE_AUTO_RECONNECT"))
			{
				var6 = var6 + (MountPark + this.api.lang.getText("ATTEMPT_RECONNECT"));
				var var7 = {name:"OnClose",listener:this,params:{login:this.api.datacenter.Player.login,pass:this.api.datacenter.Player.password}};
				this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),var6,"CAUTION_YESNO",var7);
			}
			else
			{
				this.api.kernel.showMessage(this.api.lang.getText("CONNECTION"),var6,"ERROR_BOX",{name:"OnClose"});
			}
		}
		this.api.datacenter.clear();
	}
	function onHelloConnectionServer(§\x1e\x11\x10§)
	{
		this.api.datacenter.Basics.connexionKey = var2;
		var var3 = this.api.datacenter.Player.zaapToken != null;
		var var4 = !var3?this.api.datacenter.Player.password:this.api.datacenter.Player.zaapToken;
		this.Account.logon(this.api.datacenter.Player.login,var4,var3);
		this.api.network.Account.getQueuePosition();
	}
	function onHelloGameServer(§\x1e\x12\x1a§)
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
		var var2 = getTimer() - this.api.datacenter.Basics.lastPingTimer;
		this.api.kernel.showMessage(undefined,"Ping : " + var2 + "ms",this.api.ui.getUIComponent("Debug") != undefined?"DEBUG_LOG":"INFO_CHAT");
	}
	function onQuickPong()
	{
	}
	function onServerMessage(§\x1e\x12\x1a§)
	{
		var var3 = var2.charAt(0);
		loop0:
		switch(var3)
		{
			case "0":
				var var4 = var2.substr(1).split("|");
				var var5 = Number(var4[0]);
				var var6 = var4[1].split(";");
				this.api.datacenter.Basics.serverMessageID = var5;
				this.api.datacenter.Basics.serverMessageParams = var6;
				break;
			case "1":
				var var7 = var2.substr(1).split("|");
				var var8 = var7[0];
				var var9 = var7[1].split(";");
				var var10 = String(var7[2]).length <= 0?undefined:var7[2];
				switch(Number(var8))
				{
					case 23:
						var var11 = Number(var9[0]);
						var9[0] = this.api.lang.getSpellText(var11).n;
					default:
						this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_" + var8,var9),"ERROR_BOX",{name:var10});
						break loop0;
					case 12:
						this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_12"),"ERROR_CHAT");
						this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("SRV_MSG_12") + MountPark + this.api.lang.getText("DO_U_RELEASE_NOW"),"CAUTION_YESNO",{name:var10,listener:this});
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
	function yes(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) !== "AskYesNoOnClose")
		{
			this.api.network.Game.freeMySoul();
		}
		else
		{
			var var3 = (dofus.graphics.gapi.ui.Login)this.api.ui.getUIComponent("Login");
			if(var3 != undefined)
			{
				var var4 = var2.params.login;
				if(var4 == dofus.ZaapConnect.LOGIN_TOKEN_NAME)
				{
					var3.zaapAutoLogin(false);
				}
				else
				{
					var var5 = var2.params.pass;
					var3.autoLogin(var4,var5);
				}
			}
		}
	}
}
