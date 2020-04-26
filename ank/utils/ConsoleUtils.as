class ank.utils.ConsoleUtils
{
	function ConsoleUtils()
	{
	}
	static function autoCompletion(loc2, loc3)
	{
		var loc4 = ank.utils.ConsoleUtils.removeAndGetLastWord(loc3);
		var loc5 = loc4.lastWord;
		loc3 = loc4.leftCmd;
		loc5 = loc5.toLowerCase();
		var loc6 = ank.utils.ConsoleUtils.getStringsStartWith(loc2,loc5);
		if(loc6.length > 1)
		{
			var loc7 = "";
			var loc8 = 0;
			while(loc8 < loc6.length)
			{
				loc7 = String(loc6[loc8]).charAt(loc5.length);
				if(loc7 != "")
				{
					break;
				}
				loc8 = loc8 + 1;
			}
			if(loc7 == "")
			{
				return {result:loc3 + loc5,full:false};
			}
			return ank.utils.ConsoleUtils.autoCompletionRecurcive(loc6,loc3,loc5 + loc7);
		}
		if(loc6.length != 0)
		{
			return {result:loc3 + loc6[0],isFull:true};
		}
		return {result:loc3 + loc5,list:loc6,isFull:false};
	}
	static function removeAndGetLastWord(loc2)
	{
		var loc3 = loc2.split(" ");
		if(loc3.length == 0)
		{
			return {leftCmd:"",lastWord:""};
		}
		var loc4 = String(loc3.pop());
		return {leftCmd:(loc3.length != 0?loc3.join(" ") + " ":""),lastWord:loc4};
	}
	static function autoCompletionRecurcive(loc2, loc3, loc4)
	{
		loc4 = loc4.toLowerCase();
		var loc5 = ank.utils.ConsoleUtils.getStringsStartWith(loc2,loc4);
		if(loc5.length > 1 && loc5.length == loc2.length)
		{
			var loc6 = "";
			var loc7 = 0;
			while(loc7 < loc5.length)
			{
				loc6 = String(loc5[loc7]).charAt(loc4.length);
				if(loc6 != "")
				{
					break;
				}
				loc7 = loc7 + 1;
			}
			if(loc6 == "")
			{
				return {result:loc3 + loc4,isFull:false};
			}
			return ank.utils.ConsoleUtils.autoCompletionRecurcive(loc5,loc3,loc4 + loc6);
		}
		if(loc5.length != 0)
		{
			return {result:loc3 + loc4.substr(0,loc4.length - 1),list:loc2,isFull:false};
		}
		return {result:loc3 + loc4,list:loc2,isFull:false};
	}
	static function getStringsStartWith(loc2, loc3)
	{
		var loc4 = new Array();
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = String(loc2[loc5]).toLowerCase().split(loc3);
			if(loc6[0] == "" && (loc6.length != 0 && String(loc2[loc5]).length >= loc3.length))
			{
				loc4.push(loc2[loc5]);
			}
			loc5 = loc5 + 1;
		}
		return loc4;
	}
}
