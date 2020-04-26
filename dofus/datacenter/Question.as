class dofus.datacenter.Question extends Object
{
	function Question(loc3, loc4, loc5)
	{
		super();
		this.initialize(loc3,loc4,loc5);
	}
	function __get__id()
	{
		return this._nQuestionID;
	}
	function __get__label()
	{
		return this.api.lang.fetchString(this._sQuestionText);
	}
	function __get__responses()
	{
		return this._eaResponsesObjects;
	}
	function initialize(loc2, loc3, loc4)
	{
		this.api = _global.API;
		this._nQuestionID = loc2;
		this._sQuestionText = ank.utils.PatternDecoder.getDescription(this.api.lang.getDialogQuestionText(loc2),loc4);
		this._eaResponsesObjects = new ank.utils.();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			var loc6 = Number(loc3[loc5]);
			this._eaResponsesObjects.push({label:this.api.lang.fetchString(this.api.lang.getDialogResponseText(loc6)),id:loc6});
			loc5 = loc5 + 1;
		}
	}
}
