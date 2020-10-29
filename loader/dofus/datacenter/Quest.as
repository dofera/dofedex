class dofus.datacenter.Quest extends Object
{
	function Quest(var3, var4, var5)
	{
		super();
		this.initialize(var3,var4,var5);
	}
	function __get__id()
	{
		return this._nID;
	}
	function __get__isFinished()
	{
		return this._bFinished;
	}
	function __get__name()
	{
		var var2 = this.api.lang.getQuestText(this._nID);
		if(var2 != null && dofus.Constants.DEBUG)
		{
			var2 = var2 + " (" + this._nID + ")";
		}
		return var2;
	}
	function __get__currentStep()
	{
		return this._oCurrentStep;
	}
	function addStep(var2)
	{
		this._eoSteps.addItemAt(var2.id,var2);
		if(var2.isCurrent)
		{
			this._oCurrentStep = var2;
		}
	}
	function initialize(var2, var3, var4)
	{
		this.api = _global.API;
		this._eoSteps = new ank.utils.();
		this._nID = var2;
		this._bFinished = var3;
		this.sortOrder = var4;
	}
}
