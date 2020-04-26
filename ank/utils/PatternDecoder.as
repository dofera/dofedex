class ank.utils.PatternDecoder
{
	function PatternDecoder()
	{
	}
	static function getDescription(loc2, loc3)
	{
		ank.utils.Extensions.addExtensions();
		var loc4 = loc2.split("");
		var loc5 = ank.utils.PatternDecoder.decodeDescription(loc4,loc3).join("");
		return loc5;
	}
	static function combine(loc2, loc3, loc4)
	{
		ank.utils.Extensions.addExtensions();
		var loc5 = loc2.split("");
		var loc6 = new Object();
		loc6.m = loc3 == "m";
		loc6.f = loc3 == "f";
		loc6.n = loc3 == "n";
		loc6.p = !loc4;
		loc6.s = loc4;
		var loc7 = ank.utils.PatternDecoder.decodeCombine(loc5,loc6).join("");
		return loc7;
	}
	static function replace(loc2, loc3)
	{
		var loc4 = loc2.split("##");
		var loc5 = 1;
		while(loc5 < loc4.length)
		{
			var loc6 = loc4[loc5].split(",");
			loc4[loc5] = ank.utils.PatternDecoder.getDescription(loc3,loc6);
			loc5 = loc5 + 2;
		}
		return loc4.join("");
	}
	static function replaceStr(loc2, loc3, loc4)
	{
		var loc5 = loc2.split(loc3);
		return loc5.join(loc4);
	}
	static function decodeDescription(loc2, loc3)
	{
		var loc4 = 0;
		var loc5 = new String();
		var loc6 = loc2.length;
		while(loc4 < loc6)
		{
			loc5 = loc2[loc4];
			switch(loc5)
			{
				case "#":
					var loc7 = loc2[loc4 + 1];
					if(!_global.isNaN(loc7))
					{
						if(loc3[loc7 - 1] != undefined)
						{
							loc2.splice(loc4,2,loc3[loc7 - 1]);
							loc4 = loc4 - 1;
						}
						else
						{
							loc2.splice(loc4,2);
							loc4 = loc4 - 2;
						}
					}
					break;
				case "~":
					var loc8 = loc2[loc4 + 1];
					if(!_global.isNaN(loc8))
					{
						if(loc3[loc8 - 1] != undefined)
						{
							loc2.splice(loc4,2);
							loc4 = loc4 - 2;
						}
						else
						{
							return loc2.slice(0,loc4);
						}
					}
					break;
				case "{":
					var loc9 = ank.utils.PatternDecoder.find(loc2.slice(loc4),"}");
					var loc10 = ank.utils.PatternDecoder.decodeDescription(loc2.slice(loc4 + 1,loc4 + loc9),loc3).join("");
					loc2.splice(loc4,loc9 + 1,loc10);
					break;
				default:
					if(loc0 !== "[")
					{
						break;
					}
					var loc11 = ank.utils.PatternDecoder.find(loc2.slice(loc4),"]");
					var loc12 = Number(loc2.slice(loc4 + 1,loc4 + loc11).join(""));
					if(!_global.isNaN(loc12))
					{
						loc2.splice(loc4,loc11 + 1,loc3[loc12] + " ");
						loc4 = loc4 - loc11;
						break;
					}
					break;
			}
			loc4 = loc4 + 1;
		}
		return loc2;
	}
	static function decodeCombine(loc2, loc3)
	{
		var loc4 = 0;
		var loc5 = new String();
		var loc6 = loc2.length;
		while(loc4 < loc6)
		{
			loc5 = loc2[loc4];
			if((var loc0 = loc5) !== "~")
			{
				if(loc0 === "{")
				{
					var loc8 = ank.utils.PatternDecoder.find(loc2.slice(loc4),"}");
					var loc9 = ank.utils.PatternDecoder.decodeCombine(loc2.slice(loc4 + 1,loc4 + loc8),loc3).join("");
					loc2.splice(loc4,loc8 + 1,loc9);
				}
			}
			else
			{
				var loc7 = loc2[loc4 + 1];
				if(loc3[loc7])
				{
					loc2.splice(loc4,2);
					loc4 = loc4 - 2;
				}
				else
				{
					return loc2.slice(0,loc4);
				}
			}
			loc4 = loc4 + 1;
		}
		return loc2;
	}
	static function find(loc2, loc3)
	{
		var loc4 = loc2.length;
		var loc5 = 0;
		while(loc5 < loc4)
		{
			if(loc2[loc5] == loc3)
			{
				return loc5;
			}
			loc5 = loc5 + 1;
		}
		return -1;
	}
}
