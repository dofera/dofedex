class ank.utils.MouseEvents
{
	function MouseEvents()
	{
	}
	static function addListener(loc2)
	{
		Mouse.addListener(loc2);
		ank.utils.MouseEvents.garbageCollector();
	}
	static function garbageCollector()
	{
		var loc2 = Mouse._listeners;
		var loc3 = loc2.length;
		while(loc3 >= 0)
		{
			var loc4 = loc2[loc3];
			if(loc4 == undefined || loc4._target == undefined)
			{
				loc2.splice(loc3,1);
			}
			loc3 = loc3 - 1;
		}
	}
}
