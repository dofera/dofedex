class com.ankamagames.tools.Logger
{
	static var SERVER_HOST = "localhost";
	static var SERVER_PORT = 4444;
	static var LEVEL_STANDARD = 16777215;
	static var LEVEL_NETWORK = 13421772;
	static var LEVEL_GOOD = 39219;
	static var LEVEL_MEDIUM = 16750848;
	static var LEVEL_EXCEPTION = 16711680;
	static var LEVEL_WIP = 6723993;
	static var LEVEL_WHAT_TEH_FKCU = 16711935;
	static var LEVEL_FUNCTION_CALL = 11190271;
	static var LEVELS_LIST = [com.ankamagames.tools.Logger.LEVEL_STANDARD,com.ankamagames.tools.Logger.LEVEL_NETWORK,com.ankamagames.tools.Logger.LEVEL_GOOD,com.ankamagames.tools.Logger.LEVEL_MEDIUM,com.ankamagames.tools.Logger.LEVEL_EXCEPTION,com.ankamagames.tools.Logger.LEVEL_WIP,com.ankamagames.tools.Logger.LEVEL_WHAT_TEH_FKCU,com.ankamagames.tools.Logger.LEVEL_FUNCTION_CALL];
	static var MAX_RECONNECTION_COUNT = 10;
	var _nCurrentReconnection = 0;
	function Logger()
	{
		this._buffer = new Array();
		this.connect();
	}
	static function initialize()
	{
		com.ankamagames.tools.Logger.instance = new com.ankamagames.tools.();
	}
	static function out()
	{
		var var2 = arguments[0];
		var var3 = arguments[arguments.length - 3];
		var var4 = arguments[arguments.length - 2];
		var var5 = arguments[arguments.length - 1];
		var var6 = arguments.length <= 4?undefined:arguments[1];
		if(var6 == 666)
		{
			var6 = com.ankamagames.tools.Logger.LEVEL_FUNCTION_CALL;
		}
		var var7 = new String(var2);
		if(var7.toUpperCase().indexOf("[EXCEPTION]") == 0)
		{
			var7 = var7.substr(12);
			var6 = com.ankamagames.tools.Logger.LEVEL_EXCEPTION;
		}
		else if(var7.toUpperCase().indexOf("[WTF]") == 0)
		{
			var7 = var7.substr(5);
			var6 = com.ankamagames.tools.Logger.LEVEL_WIP;
		}
		else if(var7.indexOf("[?!!]") == 0)
		{
			var7 = var7.substr(5);
			var6 = com.ankamagames.tools.Logger.LEVEL_WHAT_TEH_FKCU;
		}
		com.ankamagames.tools.Logger.instance.trace(var7,var6);
	}
	function connect()
	{
		this._socket = new XMLSocket();
		this._connected = false;
		this._socket.onConnect = function(var2)
		{
			var var3 = arguments.callee.tracer;
			var3.onConnected(var2);
		};
		this._socket.onClose = function()
		{
			var var2 = arguments.callee.tracer;
			var2.onSocketClose();
		};
		this._socket.onConnect.tracer = this;
		this._socket.connect(com.ankamagames.tools.Logger.SERVER_HOST,com.ankamagames.tools.Logger.SERVER_PORT);
	}
	function trace(var2, var3)
	{
		if(this._connected)
		{
			this._socket.send("!SOS<showMessage key=\"KeyColor" + var3 + "\"><![CDATA[" + var2 + "]]></showMessage>");
		}
		else
		{
			var var4 = new Array();
			var4[0] = var3;
			var4[1] = var2;
			this._buffer.push(var4);
		}
	}
	function onSocketClose()
	{
		if(this._nCurrentReconnection < com.ankamagames.tools.Logger.MAX_RECONNECTION_COUNT)
		{
			this.connect();
			this._nCurrentReconnection++;
		}
	}
	function onConnected(var2)
	{
		var var3 = 0;
		while(var3 < com.ankamagames.tools.Logger.LEVELS_LIST.length)
		{
			this._socket.send("!SOS<setKey><name>KeyColor" + com.ankamagames.tools.Logger.LEVELS_LIST[var3] + "</name><color>" + com.ankamagames.tools.Logger.LEVELS_LIST[var3] + "</color></setKey>");
			var3 = var3 + 1;
		}
		var var4 = 0;
		while(var4 < this._buffer.length)
		{
			this._socket.send("!SOS<showMessage key=\"KeyColor" + this._buffer[var4][0] + "\"><![CDATA[" + this._buffer[var4][1] + "]]></showMessage>");
			var4 = var4 + 1;
		}
		this._connected = true;
		this._nCurrentReconnection = 0;
	}
}
