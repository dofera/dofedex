class dofus.graphics.gapi.ui.CenterInfo extends dofus.graphics.gapi.ui.CenterText
{
	static var CLASS_NAME = "CenterInfo";
	function CenterInfo()
	{
		super();
	}
	function __set__textInfo(var2)
	{
		this._sDesc = var2;
		return this.__get__textInfo();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.CenterInfo.CLASS_NAME);
	}
	function initText()
	{
		super.initText();
		this._lblWhiteDesc.text = this._sDesc;
	}
}
