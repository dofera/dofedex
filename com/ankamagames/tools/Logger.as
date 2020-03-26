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
      com.ankamagames.tools.Logger.instance = new com.ankamagames.tools.Logger();
   }
   static function out()
   {
      var _loc2_ = arguments[0];
      var _loc3_ = arguments[arguments.length - 3];
      var _loc4_ = arguments[arguments.length - 2];
      var _loc5_ = arguments[arguments.length - 1];
      var _loc6_ = arguments.length <= 4?undefined:arguments[1];
      if(_loc6_ == 666)
      {
         _loc6_ = com.ankamagames.tools.Logger.LEVEL_FUNCTION_CALL;
      }
      var _loc7_ = new String(_loc2_);
      if(_loc7_.toUpperCase().indexOf("[EXCEPTION]") == 0)
      {
         _loc7_ = _loc7_.substr(12);
         _loc6_ = com.ankamagames.tools.Logger.LEVEL_EXCEPTION;
      }
      else if(_loc7_.toUpperCase().indexOf("[WTF]") == 0)
      {
         _loc7_ = _loc7_.substr(5);
         _loc6_ = com.ankamagames.tools.Logger.LEVEL_WIP;
      }
      else if(_loc7_.indexOf("[?!!]") == 0)
      {
         _loc7_ = _loc7_.substr(5);
         _loc6_ = com.ankamagames.tools.Logger.LEVEL_WHAT_TEH_FKCU;
      }
      com.ankamagames.tools.Logger.instance.trace(_loc7_,_loc6_);
   }
   function connect()
   {
      this._socket = new XMLSocket();
      this._connected = false;
      this._socket.onConnect = function(success)
      {
         var _loc3_ = arguments.callee.tracer;
         _loc3_.onConnected(success);
      };
      this._socket.onClose = function()
      {
         var _loc2_ = arguments.callee.tracer;
         _loc2_.onSocketClose();
      };
      this._socket.onConnect.tracer = this;
      this._socket.connect(com.ankamagames.tools.Logger.SERVER_HOST,com.ankamagames.tools.Logger.SERVER_PORT);
   }
   function trace(message, color)
   {
      if(this._connected)
      {
         this._socket.send("!SOS<showMessage key=\"KeyColor" + color + "\"><![CDATA[" + message + "]]></showMessage>");
      }
      else
      {
         var _loc4_ = new Array();
         _loc4_[0] = color;
         _loc4_[1] = message;
         this._buffer.push(_loc4_);
      }
   }
   function onSocketClose()
   {
      if(this._nCurrentReconnection < com.ankamagames.tools.Logger.MAX_RECONNECTION_COUNT)
      {
         this.connect();
         this._nCurrentReconnection = this._nCurrentReconnection + 1;
      }
   }
   function onConnected(success)
   {
      var _loc3_ = 0;
      while(_loc3_ < com.ankamagames.tools.Logger.LEVELS_LIST.length)
      {
         this._socket.send("!SOS<setKey><name>KeyColor" + com.ankamagames.tools.Logger.LEVELS_LIST[_loc3_] + "</name><color>" + com.ankamagames.tools.Logger.LEVELS_LIST[_loc3_] + "</color></setKey>");
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = 0;
      while(_loc4_ < this._buffer.length)
      {
         this._socket.send("!SOS<showMessage key=\"KeyColor" + this._buffer[_loc4_][0] + "\"><![CDATA[" + this._buffer[_loc4_][1] + "]]></showMessage>");
         _loc4_ = _loc4_ + 1;
      }
      this._connected = true;
      this._nCurrentReconnection = 0;
   }
}
