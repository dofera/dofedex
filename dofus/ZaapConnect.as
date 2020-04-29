class dofus.ZaapConnect extends dofus.utils.ApiElement
{
	static var TCP_DEFAULT_PORT = -1;
	static var LOGIN_TOKEN_NAME = "#Z";
	static var TCP_HOST = "127.0.0.1";
	static var HAAPI_GAME_ID = 101;
	static var ENABLED = true;
	static var instance = null;
	var _gameSessionToken = null;
	var _authToken = null;
	function ZaapConnect(bDebug)
	{
		super();
		this._api = _global.API;
		this._nPort = _global.CONFIG.zaapConnectPort;
		this._bDebug = dofus.Constants.DEBUG;
		this._xSocket = new XMLSocket();
		var ref = this;
		this._xSocket.onConnect = function(var2)
		{
			ref.setConnected(var2);
			ref.onConnect(var2);
		};
		this._xSocket.onData = function(var2)
		{
			ref.onData(var2);
		};
		this._xSocket.onClose = function(var2)
		{
			ref.setConnected(false);
		};
		this.connect();
	}
	static function newInstance()
	{
		if(!dofus.ZaapConnect.isEnabled())
		{
			return null;
		}
		if(dofus.ZaapConnect.instance != null)
		{
			delete dofus.ZaapConnect.instance;
		}
		dofus.ZaapConnect.instance = new dofus.();
		return dofus.ZaapConnect.instance;
	}
	static function getInstance()
	{
		return dofus.ZaapConnect.instance;
	}
	static function isEnabled()
	{
		return dofus.ZaapConnect.ENABLED && (_global.CONFIG.zaapConnectPort != undefined && _global.CONFIG.zaapConnectPort > 0);
	}
	function renewAuthKey()
	{
		if(this.isConnected() && this.getSessionToken() != undefined)
		{
			this.askAuthToken();
		}
		else
		{
			this.connect();
		}
	}
	function getSessionToken()
	{
		return this._gameSessionToken;
	}
	function consumeAuthToken()
	{
		var var2 = this._authToken;
		if(var2 == undefined)
		{
			return null;
		}
		delete this._authToken;
		return var2;
	}
	function isDebug()
	{
		return this._bDebug;
	}
	function isConnected()
	{
		return this._bConnected;
	}
	function setConnected(var2)
	{
		this._bConnected = var2;
	}
	function debugLog(var2)
	{
		if(!this.isDebug() || var2 == null)
		{
			return undefined;
		}
		var2 = "[ZaapConnect] " + var2;
		this.api.kernel.showMessage(undefined,var2,"DEBUG_LOG");
		this.api.electron.log(var2);
	}
	function processRequest(var2, var3)
	{
		switch(var2)
		{
			case "connect":
				this._gameSessionToken = var3[0];
				this.debugLog("New Session Token : " + this.getSessionToken());
				this.askAuthToken();
				break;
			case "auth_getGameToken":
				this._authToken = var3[0];
				this.debugLog("New Auth Token : " + this._authToken);
				this.doAutoLogin();
				break;
			case "ignored":
				this.debugLog("Zaap is ignoring your client. Closing socket...");
				this._xSocket.close();
		}
	}
	function connect()
	{
		this.debugLog("Connection to local port " + this._nPort);
		this._xSocket.connect(dofus.ZaapConnect.TCP_HOST,this._nPort);
	}
	function send(var2)
	{
		this.debugLog("--> " + var2);
		this._xSocket.send(var2);
	}
	function onData(var2)
	{
		this.debugLog("<-- " + var2);
		var var3 = var2.split(" ");
		var var4 = new Array();
		var var5 = var3[0];
		var var6 = 1;
		while(var6 < var3.length)
		{
			var4.push(var3[var6]);
			var6 = var6 + 1;
		}
		this.processRequest(var5,var4);
	}
	function onConnect(var2)
	{
		if(!var2)
		{
			this.debugLog("Could not connect to the launcher");
			return undefined;
		}
		this.debugLog("Connected to the zaap");
		this.askSessionToken();
	}
	function askSessionToken()
	{
		this.debugLog("Asking session token...");
		this.send("connect retro main -1 -1");
	}
	function askAuthToken()
	{
		this.debugLog("Asking auth token...");
		this.send("auth_getGameToken " + this.getSessionToken() + " " + dofus.ZaapConnect.HAAPI_GAME_ID);
	}
	function doAutoLogin()
	{
		var var2 = (dofus.graphics.gapi.ui.Login)this.api.ui.getUIComponent("Login");
		if(var2 == undefined)
		{
			this.debugLog("UI Login not found");
			return undefined;
		}
		if(!var2.isLoaded())
		{
			this.debugLog("UI Login is not fully loaded, can\'t auto login now");
			return undefined;
		}
		this.debugLog("Let\'s login automatically...");
		var2.zaapAutoLogin();
	}
}
