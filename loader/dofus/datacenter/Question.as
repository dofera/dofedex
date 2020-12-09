class dofus.datacenter.Question extends Object
{
	function Question(§\x01\b§, §\x1d\x15§, §\x1d\x18§)
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
	function initialize(§\x01\b§, §\x1d\x15§, §\x1d\x18§)
	{
		this.api = _global.API;
		this._nQuestionID = var2;
		var var5 = ank.utils.PatternDecoder.getDescription(this.api.lang.getDialogQuestionText(var2),var4);
		if(dofus.Constants.DEBUG)
		{
			var5 = var5 + " (" + var2 + ")";
		}
		this._sQuestionText = var5;
		this._eaResponsesObjects = new ank.utils.
();
		var var6 = 0;
		while(var6 < var3.length)
		{
			var var7 = Number(var3[var6]);
			this._eaResponsesObjects.push({label:this.api.lang.fetchString(this.api.lang.getDialogResponseText(var7)),id:var7});
			var6 = var6 + 1;
		}
	}
}
