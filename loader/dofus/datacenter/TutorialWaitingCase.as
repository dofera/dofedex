class dofus.datacenter.TutorialWaitingCase extends Object
{
	static var CASE_TIMEOUT = "TIMEOUT";
	static var CASE_DEFAULT = "DEFAULT";
	function TutorialWaitingCase(sCode, §\x1e\x02§, §\x0b\x06§)
	{
		super();
		this._sCode = sCode;
		this._aParams = var4;
		this._mNextBlocID = var5;
	}
	function __get__code()
	{
		return this._sCode;
	}
	function __get__params()
	{
		return this._aParams;
	}
	function __get__nextBlocID()
	{
		return this._mNextBlocID;
	}
}
