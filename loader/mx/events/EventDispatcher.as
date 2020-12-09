class mx.events.EventDispatcher
{
	static var _fEventDispatcher = undefined;
	function EventDispatcher()
	{
	}
	static function _removeEventListener(queue, §\x0f\r§, §\r\x12§)
	{
		if(queue != undefined)
		{
			var var5 = queue.length;
			var var6 = 0;
			while(var6 < var5)
			{
				var var7 = queue[var6];
				if(var7 == var4)
				{
					queue.splice(var6,1);
					return undefined;
				}
				var6 = var6 + 1;
			}
		}
	}
	static function initialize(§\x1e\x1a\x11§)
	{
		if(mx.events.EventDispatcher._fEventDispatcher == undefined)
		{
			mx.events.EventDispatcher._fEventDispatcher = new mx.events.();
		}
		var2.__proto__.addEventListener = mx.events.EventDispatcher._fEventDispatcher.addEventListener;
		var2.__proto__.removeEventListener = mx.events.EventDispatcher._fEventDispatcher.removeEventListener;
		var2.__proto__.dispatchEvent = mx.events.EventDispatcher._fEventDispatcher.dispatchEvent;
		var2.__proto__.dispatchQueue = mx.events.EventDispatcher._fEventDispatcher.dispatchQueue;
	}
	function dispatchQueue(§\x1e\x15\x1b§, §\x0f\x0b§)
	{
		var var4 = "__q_" + var3.type;
		var var5 = var2[var4];
		if(var5 != undefined)
		{
			for(var var6 in var5)
			{
				var var7 = var5[var6];
				var var8 = typeof var7;
				if(var8 == "object" || var8 == "movieclip")
				{
					if(var7.handleEvent == undefined)
					{
						var7[var3.type](var3);
					}
					else
					{
						var7.handleEvent(var3);
					}
				}
				else
				{
					var7.apply(var2,[var3]);
				}
			}
		}
	}
	function dispatchEvent(§\x0f\x0b§)
	{
		if(var2.target == undefined)
		{
			var2.target = this;
		}
		this[var2.type + "Handler"](var2);
		this.dispatchQueue(this,var2);
	}
	function addEventListener(§\x0f\r§, §\r\x12§)
	{
		var var4 = "__q_" + var2;
		if(this[var4] == undefined)
		{
			this[var4] = new Array();
		}
		_global.ASSetPropFlags(this,var4,1);
		mx.events.EventDispatcher._removeEventListener(this[var4],var2,var3);
		this[var4].push(var3);
	}
	function removeEventListener(§\x0f\r§, §\r\x12§)
	{
		var var4 = "__q_" + var2;
		mx.events.EventDispatcher._removeEventListener(this[var4],var2,var3);
	}
}
