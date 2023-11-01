class ank.utils.Extensions
{
	static var bExtended = false;
	function Extensions()
	{
	}
	static function addExtensions()
	{
		if(ank.utils.Extensions.bExtended == true)
		{
			return true;
		}
		var var2 = String.prototype;
		var2.removeAccents = function()
		{
			var var2 = "ÀÁÂÃÄÅàáâãäåßÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž";
			var var3 = "AAAAAAaaaaaaBOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz";
			var var4 = this.split("");
			var var5 = var4.length;
			var var6 = 0;
			while(var6 < var5)
			{
				var var7 = var2.indexOf(var4[var6]);
				if(var7 != -1)
				{
					var4[var6] = var3.charAt(var7);
				}
				var6 = var6 + 1;
			}
			return var4.join("");
		};
		var var3 = ank.utils.extensions.MovieClipExtensions.prototype;
		var var4 = MovieClip.prototype;
		var4.attachClassMovie = var3.attachClassMovie;
		var4.alignOnPixel = var3.alignOnPixel;
		var4.playFirstChildren = var3.playFirstChildren;
		var4.getFirstParentProperty = var3.getFirstParentProperty;
		var4.getActionClip = var3.getActionClip;
		var4.end = var3.end;
		var4.playAll = var3.playAll;
		var4.stopAll = var3.stopAll;
		ank.utils.Extensions.bExtended = true;
		return true;
	}
}
