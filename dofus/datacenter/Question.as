class dofus.datacenter.Question extends Object
{
	function Question(var3, var4, var5)
	{
		super();
		this.initialize(var3,var4,var5);
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
	function initialize(var2, var3, var4)
	{
		this.api = _global.API;
		this._nQuestionID = var2;
		this._sQuestionText = ank.utils.PatternDecoder.getDescription(this.api.lang.getDialogQuestionText(var2),var4);
		this._eaResponsesObjects = new ank.utils.();
		var var5 = 0;
		while(var5 < var3.length)
		{
			var var6 = Number(var3[var5]);
			this._eaResponsesObjects.push({label:this.api.lang.fetchString(this.api.lang.getDialogResponseText(var6)),id:var6});
			var5 = var5 + 1;
		}
	}
}
