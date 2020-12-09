class ank.utils.MouseEvents
{
	function MouseEvents()
	{
	}
	static function addListener(§\x1e\x19\x06§)
	{
		Mouse.addListener(var2);
		ank.utils.MouseEvents.garbageCollector();
	}
	static function garbageCollector()
	{
		var var2 = Mouse._listeners;
		var var3 = var2.length;
		while(var3 >= 0)
		{
			var var4 = var2[var3];
			if(var4 == undefined || var4._target == undefined)
			{
				var2.splice(var3,1);
			}
			var3 = var3 - 1;
		}
	}
}
