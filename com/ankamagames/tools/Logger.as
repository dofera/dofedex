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
		com.ankamagames.tools.Logger.instance = new com.ankamagames.tools.();
	}
	static function out()
	{
		var loc2 = arguments[0];
		var loc3 = arguments[arguments.length - 3];
		var loc4 = arguments[arguments.length - 2];
		var loc5 = arguments[arguments.length - 1];
		var loc6 = arguments.length <= 4?undefined:arguments[1];
		if(loc6 == 666)
		{
			loc6 = com.ankamagames.tools.Logger.LEVEL_FUNCTION_CALL;
		}
		var loc7 = new String(loc2);
		if(loc7.toUpperCase().indexOf("[EXCEPTION]") == 0)
		{
			loc7 = loc7.substr(12);
			loc6 = com.ankamagames.tools.Logger.LEVEL_EXCEPTION;
		}
		else if(loc7.toUpperCase().indexOf("[WTF]") == 0)
		{
			loc7 = loc7.substr(5);
			loc6 = com.ankamagames.tools.Logger.LEVEL_WIP;
		}
		else if(loc7.indexOf("[?!!]") == 0)
		{
			loc7 = loc7.substr(5);
			loc6 = com.ankamagames.tools.Logger.LEVEL_WHAT_TEH_FKCU;
		}
		com.ankamagames.tools.Logger.instance.trace(loc7,loc6);
	}
	function connect()
	{
		this._socket = new XMLSocket();
		this._connected = false;
		this._socket.onConnect = function(loc2)
		{
			var loc3 = arguments.callee.tracer;
			loc3.onConnected(loc2);
		};
		this._socket.onClose = function()
		{
			var loc2 = arguments.callee.tracer;
			loc2.onSocketClose();
		};
		this._socket.onConnect.tracer = this;
		this._socket.connect(com.ankamagames.tools.Logger.SERVER_HOST,com.ankamagames.tools.Logger.SERVER_PORT);
	}
	function trace(loc2, loc3)
	{
		if(this._connected)
		{
			this._socket.send("!SOS<showMessage key=\"KeyColor" + loc3 + "\"><![CDATA[" + loc2 + "]]></showMessage>");
		}
		else
		{
			var loc4 = new Array();
			loc4[0] = loc3;
			loc4[1] = loc2;
			this._buffer.push(loc4);
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
	function onConnected(loc2)
	{
		var loc3 = 0;
		while(loc3 < com.ankamagames.tools.Logger.LEVELS_LIST.length)
		{
			this._socket.send("!SOS<setKey><name>KeyColor" + com.ankamagames.tools.Logger.LEVELS_LIST[loc3] + "</name><color>" + com.ankamagames.tools.Logger.LEVELS_LIST[loc3] + "</color></setKey>");
			loc3 = loc3 + 1;
		}
		var loc4 = 0;
		while(loc4 < this._buffer.length)
		{
			this._socket.send("!SOS<showMessage key=\"KeyColor" + this._buffer[loc4][0] + "\"><![CDATA[" + this._buffer[loc4][1] + "]]></showMessage>");
			loc4 = loc4 + 1;
		}
		this._connected = true;
		this._nCurrentReconnection = 0;
	}
}
