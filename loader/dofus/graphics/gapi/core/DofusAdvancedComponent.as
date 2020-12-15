class dofus.graphics.gapi.core.DofusAdvancedComponent extends ank.gapi.core.UIAdvancedComponent
{
	function DofusAdvancedComponent()
	{
		super();
	}
	function __get__api()
	{
		return _global.API;
	}
	function __set__api(var2)
	{
		super.__set__api(var3);
		return this.__get__api();
	}
	function init(var2, var3)
	{
		super.init(var3,var4);
	}
}
