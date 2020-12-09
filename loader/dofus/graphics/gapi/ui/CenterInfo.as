class dofus.graphics.gapi.ui.CenterInfo extends dofus.graphics.gapi.ui.CenterText
{
	static var CLASS_NAME = "CenterInfo";
	function CenterInfo()
	{
		super();
	}
	function __set__textInfo(§\x1e\r\x02§)
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
		org.flashdevelop.utils.FlashConnect.mtrace(this._sDesc,"dofus.graphics.gapi.ui.CenterInfo::initText","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/graphics/gapi/ui/CenterInfo.as",49);
	}
}
