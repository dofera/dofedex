class ank.utils.PatternDecoder
{
	function PatternDecoder()
	{
	}
	static function getDescription(var2, var3)
	{
		ank.utils.Extensions.addExtensions();
		var var4 = var2.split("");
		var var5 = ank.utils.PatternDecoder.decodeDescription(var4,var3).join("");
		return var5;
	}
	static function combine(var2, var3, var4)
	{
		ank.utils.Extensions.addExtensions();
		var var5 = var2.split("");
		var var6 = new Object();
		var6.m = var3 == "m";
		var6.f = var3 == "f";
		var6.n = var3 == "n";
		var6.p = !var4;
		var6.s = var4;
		var var7 = ank.utils.PatternDecoder.decodeCombine(var5,var6).join("");
		return var7;
	}
	static function replace(var2, var3)
	{
		var var4 = var2.split("##");
		var var5 = 1;
		while(var5 < var4.length)
		{
			var var6 = var4[var5].split(",");
			var4[var5] = ank.utils.PatternDecoder.getDescription(var3,var6);
			var5 = var5 + 2;
		}
		return var4.join("");
	}
	static function replaceStr(var2, var3, var4)
	{
		var var5 = var2.split(var3);
		return var5.join(var4);
	}
	static function decodeDescription(var2, var3)
	{
		var var4 = 0;
		var var5 = new String();
		var var6 = var2.length;
		while(var4 < var6)
		{
			var5 = var2[var4];
			switch(var5)
			{
				case "#":
					var var7 = var2[var4 + 1];
					if(!_global.isNaN(var7))
					{
						if(var3[var7 - 1] != undefined)
						{
							var2.splice(var4,2,var3[var7 - 1]);
							var4 = var4 - 1;
						}
						else
						{
							var2.splice(var4,2);
							var4 = var4 - 2;
						}
					}
					break;
				case "~":
					var var8 = var2[var4 + 1];
					if(!_global.isNaN(var8))
					{
						if(var3[var8 - 1] != undefined)
						{
							var2.splice(var4,2);
							var4 = var4 - 2;
						}
						else
						{
							return var2.slice(0,var4);
						}
					}
					break;
				case "{":
					var var9 = ank.utils.PatternDecoder.find(var2.slice(var4),"}");
					var var10 = ank.utils.PatternDecoder.decodeDescription(var2.slice(var4 + 1,var4 + var9),var3).join("");
					var2.splice(var4,var9 + 1,var10);
					break;
				default:
					if(var0 !== "[")
					{
						break;
					}
					var var11 = ank.utils.PatternDecoder.find(var2.slice(var4),"]");
					var var12 = Number(var2.slice(var4 + 1,var4 + var11).join(""));
					if(!_global.isNaN(var12))
					{
						var2.splice(var4,var11 + 1,var3[var12] + " ");
						var4 = var4 - var11;
						break;
					}
					break;
			}
			var4 = var4 + 1;
		}
		return var2;
	}
	static function decodeCombine(var2, var3)
	{
		var var4 = 0;
		var var5 = new String();
		var var6 = var2.length;
		while(var4 < var6)
		{
			var5 = var2[var4];
			switch(var5)
			{
				case "~":
					var var7 = var2[var4 + 1];
					if(var3[var7])
					{
						var2.splice(var4,2);
						var4 = var4 - 2;
						break;
					}
					return var2.slice(0,var4);
					break;
				case "{":
					var var8 = ank.utils.PatternDecoder.find(var2.slice(var4),"}");
					var var9 = ank.utils.PatternDecoder.decodeCombine(var2.slice(var4 + 1,var4 + var8),var3).join("");
					var2.splice(var4,var8 + 1,var9);
			}
			var4 = var4 + 1;
		}
		return var2;
	}
	static function find(var2, var3)
	{
		var var4 = var2.length;
		var var5 = 0;
		while(var5 < var4)
		{
			if(var2[var5] == var3)
			{
				return var5;
			}
			var5 = var5 + 1;
		}
		return -1;
	}
}
