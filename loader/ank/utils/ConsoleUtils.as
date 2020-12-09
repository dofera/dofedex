class ank.utils.ConsoleUtils
{
	function ConsoleUtils()
	{
	}
	static function autoCompletion(§\x1e\x0b§, §\x1e\x14\b§)
	{
		var var4 = ank.utils.ConsoleUtils.removeAndGetLastWord(var3);
		var var5 = var4.lastWord;
		var3 = var4.leftCmd;
		var5 = var5.toLowerCase();
		var var6 = ank.utils.ConsoleUtils.getStringsStartWith(var2,var5);
		if(var6.length > 1)
		{
			var var7 = "";
			var var8 = 0;
			while(var8 < var6.length)
			{
				var7 = String(var6[var8]).charAt(var5.length);
				if(var7 != "")
				{
					break;
				}
				var8 = var8 + 1;
			}
			if(var7 == "")
			{
				return {result:var3 + var5,full:false};
			}
			return ank.utils.ConsoleUtils.autoCompletionRecurcive(var6,var3,var5 + var7);
		}
		if(var6.length != 0)
		{
			return {result:var3 + var6[0],isFull:true};
		}
		return {result:var3 + var5,list:var6,isFull:false};
	}
	static function removeAndGetLastWord(§\x1e\x14\b§)
	{
		var var3 = var2.split(" ");
		if(var3.length == 0)
		{
			return {leftCmd:"",lastWord:""};
		}
		var var4 = String(var3.pop());
		return {leftCmd:(var3.length != 0?var3.join(" ") + " ":""),lastWord:var4};
	}
	static function autoCompletionRecurcive(§\x1e\x0b§, §\x1e\x10\x1d§, §\x1e\x0f\r§)
	{
		var4 = var4.toLowerCase();
		var var5 = ank.utils.ConsoleUtils.getStringsStartWith(var2,var4);
		if(var5.length > 1 && var5.length == var2.length)
		{
			var var6 = "";
			var var7 = 0;
			while(var7 < var5.length)
			{
				var6 = String(var5[var7]).charAt(var4.length);
				if(var6 != "")
				{
					break;
				}
				var7 = var7 + 1;
			}
			if(var6 == "")
			{
				return {result:var3 + var4,isFull:false};
			}
			return ank.utils.ConsoleUtils.autoCompletionRecurcive(var5,var3,var4 + var6);
		}
		if(var5.length != 0)
		{
			return {result:var3 + var4.substr(0,var4.length - 1),list:var2,isFull:false};
		}
		return {result:var3 + var4,list:var2,isFull:false};
	}
	static function getStringsStartWith(§\x1e\x0b§, §\x1e\x0f\r§)
	{
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = String(var2[var5]).toLowerCase().split(var3);
			if(var6[0] == "" && (var6.length != 0 && String(var2[var5]).length >= var3.length))
			{
				var4.push(var2[var5]);
			}
			var5 = var5 + 1;
		}
		return var4;
	}
}
