class ank.utils.Crypt
{
	static var HASH = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","-","_");
	function Crypt()
	{
	}
	static function cryptPassword(loc2, loc3)
	{
		var loc4 = "#1";
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = loc2.charCodeAt(loc5);
			var loc7 = loc3.charCodeAt(loc5);
			var loc8 = Math.floor(loc6 / 16);
			var loc9 = loc6 % 16;
			loc4 = loc4 + (ank.utils.Crypt.HASH[(loc8 + loc7 % ank.utils.Crypt.HASH.length) % ank.utils.Crypt.HASH.length] + ank.utils.Crypt.HASH[(loc9 + loc7 % ank.utils.Crypt.HASH.length) % ank.utils.Crypt.HASH.length]);
			loc5 = loc5 + 1;
		}
		return loc4;
	}
}
