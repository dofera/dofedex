class org.flashdevelop.utils.FlashConnect
{
	static var status = 0;
	static var limit = 1000;
	static var host = "127.0.0.1";
	static var port = 1978;
	function FlashConnect()
	{
	}
	static function send(§\n\x15§)
	{
		if(org.flashdevelop.utils.FlashConnect.messages == null)
		{
			org.flashdevelop.utils.FlashConnect.initialize();
		}
		org.flashdevelop.utils.FlashConnect.messages.push(var2);
	}
	static function trace(§\x1e\n\x0f§, §\f\x01§)
	{
		var var4 = org.flashdevelop.utils.FlashConnect.createMsgNode(var2.toString(),var3);
		org.flashdevelop.utils.FlashConnect.send(var4);
	}
	static function mtrace(§\x1e\n\x0f§, §\n\x14§, §\x1e\x17\b§, §\x0b\x1b§)
	{
		if(var4.charAt(1) != ":")
		{
			var4 = "~/" + var4;
		}
		var var6 = var4 + ":" + var5 + ":" + var2;
		org.flashdevelop.utils.FlashConnect.trace(var6,org.flashdevelop.utils.TraceLevel.DEBUG);
	}
	static function initialize()
	{
		org.flashdevelop.utils.FlashConnect.counter = 0;
		org.flashdevelop.utils.FlashConnect.messages = new Array();
		org.flashdevelop.utils.FlashConnect.socket = new XMLSocket();
		org.flashdevelop.utils.FlashConnect.socket.onData = function(§\x11\x15§)
		{
			org.flashdevelop.utils.FlashConnect.onReturnData(var2);
		};
		org.flashdevelop.utils.FlashConnect.socket.onConnect = function(§\x1e\f\x0e§)
		{
			if(var2)
			{
				org.flashdevelop.utils.FlashConnect.status = 1;
			}
			else
			{
				org.flashdevelop.utils.FlashConnect.status = -1;
			}
			org.flashdevelop.utils.FlashConnect.onConnection();
		};
		org.flashdevelop.utils.FlashConnect.interval = _global.setInterval(org.flashdevelop.utils.FlashConnect.sendStack,50);
		org.flashdevelop.utils.FlashConnect.socket.connect(org.flashdevelop.utils.FlashConnect.host,org.flashdevelop.utils.FlashConnect.port);
	}
	static function createMsgNode(§\n\x15§, §\f\x01§)
	{
		if(_global.isNaN(var3))
		{
			var3 = org.flashdevelop.utils.TraceLevel.DEBUG;
		}
		var var4 = new XMLNode(1,null);
		var var5 = new XMLNode(3,_global.escape(var2));
		var4.attributes.state = var3.toString();
		var4.attributes.cmd = "trace";
		var4.nodeName = "message";
		var4.appendChild(var5);
		return var4;
	}
	static function sendStack()
	{
		if(org.flashdevelop.utils.FlashConnect.messages.length > 0 && org.flashdevelop.utils.FlashConnect.status == 1)
		{
			var var2 = new XML();
			var var3 = var2.createElement("flashconnect");
			while(org.flashdevelop.utils.FlashConnect.messages.length != 0)
			{
				org.flashdevelop.utils.FlashConnect.counter++;
				if(org.flashdevelop.utils.FlashConnect.counter > org.flashdevelop.utils.FlashConnect.limit)
				{
					_global.clearInterval(org.flashdevelop.utils.FlashConnect.interval);
					var var4 = new String("FlashConnect aborted. You have reached the limit of maximum messages.");
					var var5 = org.flashdevelop.utils.FlashConnect.createMsgNode(var4,org.flashdevelop.utils.TraceLevel.ERROR);
					var3.appendChild(var5);
					org.flashdevelop.utils.FlashConnect.messages = new Array();
					break;
				}
				var var6 = (XMLNode)org.flashdevelop.utils.FlashConnect.messages.shift();
				var3.appendChild(var6);
			}
			var2.appendChild(var3);
			org.flashdevelop.utils.FlashConnect.socket.send(var2);
			org.flashdevelop.utils.FlashConnect.counter = 0;
		}
	}
}
