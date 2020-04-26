class eval("\n\x0b").events.EventDispatcher
{
	static var _fEventDispatcher = undefined;
	function EventDispatcher()
	{
	}
	static function _removeEventListener(queue, §\x10\x04§, §\x0e\n§)
	{
		if(queue != undefined)
		{
			var loc5 = queue.length;
			var loc6 = 0;
			while(loc6 < loc5)
			{
				var loc7 = queue[loc6];
				if(loc7 == loc4)
				{
					queue.splice(loc6,1);
					return undefined;
				}
				loc6 = loc6 + 1;
			}
		}
	}
	static function initialize(loc2)
	{
		if(eval("\n\x0b").events.EventDispatcher._fEventDispatcher == undefined)
		{
			eval("\n\x0b").events.EventDispatcher._fEventDispatcher = new eval("\n\x0b").events.();
		}
		loc2.__proto__.addEventListener = eval("\n\x0b").events.EventDispatcher._fEventDispatcher.addEventListener;
		loc2.__proto__.removeEventListener = eval("\n\x0b").events.EventDispatcher._fEventDispatcher.removeEventListener;
		loc2.__proto__.dispatchEvent = eval("\n\x0b").events.EventDispatcher._fEventDispatcher.dispatchEvent;
		loc2.__proto__.dispatchQueue = eval("\n\x0b").events.EventDispatcher._fEventDispatcher.dispatchQueue;
	}
	function dispatchQueue(loc2, loc3)
	{
		var loc4 = "__q_" + loc3.type;
		var loc5 = loc2[loc4];
		if(loc5 != undefined)
		{
			for(var loc6 in loc5)
			{
				var loc7 = loc5[loc6];
				var loc8 = typeof loc7;
				if(loc8 == "object" || loc8 == "movieclip")
				{
					if(loc7.handleEvent == undefined)
					{
						loc7[loc3.type](loc3);
					}
					else
					{
						loc7.handleEvent(loc3);
					}
				}
				else
				{
					loc7.apply(loc2,[loc3]);
				}
			}
		}
	}
	function dispatchEvent(loc2)
	{
		if(loc2.target == undefined)
		{
			loc2.target = this;
		}
		this[loc2.type + "Handler"](loc2);
		this.dispatchQueue(this,loc2);
	}
	function addEventListener(loc2, loc3)
	{
		var loc4 = "__q_" + loc2;
		if(this[loc4] == undefined)
		{
			this[loc4] = new Array();
		}
		_global.ASSetPropFlags(this,loc4,1);
		eval("\n\x0b").events.EventDispatcher._removeEventListener(this[loc4],loc2,loc3);
		this[loc4].push(loc3);
	}
	function removeEventListener(loc2, loc3)
	{
		var loc4 = "__q_" + loc2;
		eval("\n\x0b").events.EventDispatcher._removeEventListener(this[loc4],loc2,loc3);
	}
}
