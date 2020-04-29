class ank.gapi.styles.StylesManager extends Object
{
	static var _styles = new Object();
	function StylesManager()
	{
		super();
	}
	static function setStyle(var2, var3)
	{
		if(!(var3 instanceof Object))
		{
			return undefined;
		}
		if(var2 == undefined)
		{
			return undefined;
		}
		if(var3 == undefined)
		{
			return undefined;
		}
		ank.gapi.styles.StylesManager._styles[var2] = var3;
	}
	static function getStyle(var2)
	{
		return ank.gapi.styles.StylesManager._styles[var2];
	}
	static function loadStylePackage(var2)
	{
		for(var k in var2)
		{
			ank.gapi.styles.StylesManager.setStyle(k,var2[k]);
		}
	}
}
