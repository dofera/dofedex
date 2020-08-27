class ank.utils.Crypt
{
	static var HASH = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","-","_");
	function Crypt()
	{
	}
	static function cryptPassword(var2, var3)
	{
		var var4 = "#1";
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = var2.charCodeAt(var5);
			var var7 = var3.charCodeAt(var5);
			var var8 = Math.floor(var6 / 16);
			var var9 = var6 % 16;
			var4 = var4 + (ank.utils.Crypt.HASH[(var8 + var7 % ank.utils.Crypt.HASH.length) % ank.utils.Crypt.HASH.length] + ank.utils.Crypt.HASH[(var9 + var7 % ank.utils.Crypt.HASH.length) % ank.utils.Crypt.HASH.length]);
			var5 = var5 + 1;
		}
		return var4;
	}
}
