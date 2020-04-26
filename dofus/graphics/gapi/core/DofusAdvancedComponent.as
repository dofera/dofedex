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
	function __set__api(loc2)
	{
		super.__set__api(loc3);
		return this.__get__api();
	}
	function init(loc2, loc3)
	{
		super.init(loc3,loc4);
	}
}
