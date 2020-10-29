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
	function initialize(var2, var3)
	{
		super.initialize(var4);
		this._oAKS = var3;
		this._oAPI = var4;
	}
}
