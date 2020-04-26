class ank.gapi.styles.StylesManager extends Object
{
	static var _styles = new Object();
	function StylesManager()
	{
		super();
	}
	static function setStyle(loc2, loc3)
	{
		if(!(loc3 instanceof Object))
		{
			return undefined;
		}
		if(loc2 == undefined)
		{
			return undefined;
		}
		if(loc3 == undefined)
		{
			return undefined;
		}
		ank.gapi.styles.StylesManager._styles[loc2] = loc3;
	}
	static function getStyle(loc2)
	{
		return ank.gapi.styles.StylesManager._styles[loc2];
	}
	static function loadStylePackage(loc2)
	{
		for(var k in loc2)
		{
			ank.gapi.styles.StylesManager.setStyle(k,loc2[k]);
		}
	}
}
