class dofus.aks.Handler extends dofus.utils.ApiElement
{
	function Handler()
	{
		super();
	}
	function __get__aks()
	{
		return this._oAKS;
	}
	function initialize(loc2, loc3)
	{
		super.initialize(loc4);
		this._oAKS = loc3;
		this._oAPI = loc4;
	}
}
