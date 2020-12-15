class eval(mx).events.EventDispatcher
{
	static var _fEventDispatcher = undefined;
	function EventDispatcher()
	{
	}
	static function _removeEventListener(queue, §\x0f\x04§, §\r\t§)
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
	static function initialize(var2)
	{
		if(eval(mx).events.EventDispatcher._fEventDispatcher == undefined)
		{
			eval(mx).events.EventDispatcher._fEventDispatcher = new eval(mx).events.();
		}
		var2.__proto__.addEventListener = eval(mx).events.EventDispatcher._fEventDispatcher.addEventListener;
		var2.__proto__.removeEventListener = eval(mx).events.EventDispatcher._fEventDispatcher.removeEventListener;
		var2.__proto__.dispatchEvent = eval(mx).events.EventDispatcher._fEventDispatcher.dispatchEvent;
		var2.__proto__.dispatchQueue = eval(mx).events.EventDispatcher._fEventDispatcher.dispatchQueue;
	}
	function dispatchQueue(var2, var3)
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
	function dispatchEvent(var2)
	{
		if(var2.target == undefined)
		{
			var2.target = this;
		}
		this[var2.type + "Handler"](var2);
		this.dispatchQueue(this,var2);
	}
	function addEventListener(var2, var3)
	{
		var var4 = "__q_" + var2;
		if(this[var4] == undefined)
		{
			this[var4] = new Array();
		}
		_global.ASSetPropFlags(this,var4,1);
		eval(mx).events.EventDispatcher._removeEventListener(this[var4],var2,var3);
		this[var4].push(var3);
	}
	function removeEventListener(var2, var3)
	{
		var var4 = "__q_" + var2;
		eval(mx).events.EventDispatcher._removeEventListener(this[var4],var2,var3);
	}
}
