class dofus.datacenter.Quest extends Object
{
	function Quest(loc3, loc4, loc5)
	{
		super();
		this.initialize(loc3,loc4,loc5);
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
		return this.api.lang.getQuestText(this._nID);
	}
	function __get__currentStep()
	{
		return this._oCurrentStep;
	}
	function addStep(loc2)
	{
		this._eoSteps.addItemAt(loc2.id,loc2);
		if(loc2.isCurrent)
		{
			this._oCurrentStep = loc2;
		}
	}
	function initialize(loc2, loc3, loc4)
	{
		this.api = _global.API;
		this._eoSteps = new ank.utils.();
		this._nID = loc2;
		this._bFinished = loc3;
		this.sortOrder = loc4;
	}
}
