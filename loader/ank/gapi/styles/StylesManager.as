class ank.gapi.styles.StylesManager extends Object
{
	static var _styles = new Object();
	function StylesManager()
	{
		super();
	}
	static function setStyle(§\x1e\r\x14§, §\x1e\x17\x1a§)
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
	static function getStyle(§\x1e\r\x14§)
	{
		return ank.gapi.styles.StylesManager._styles[var2];
	}
	static function loadStylePackage(§\x1e\x18\x17§)
	{
		for(var k in var2)
		{
			ank.gapi.styles.StylesManager.setStyle(k,var2[k]);
		}
	}
}
