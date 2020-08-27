class dofus.graphics.gapi.ui.login.LoginNewsItem extends ank.gapi.core.UIBasicComponent
{
	function LoginNewsItem()
	{
		super();
	}
	function __set__list(var2)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			this._oItem = var4;
			this._lblDate.text = var4.getPubDateStr(_global.API.lang.getConfigText("LONG_DATE_FORMAT"),_global.API.config.language);
			this._lblTitle.bDisplayDebug = true;
			this._lblTitle.text = var4.getTitle();
			this._ldrImage.contentPath = var4.getIcon();
			this._mcSeparator._visible = true;
		}
		else if(this._lblDate.text != undefined)
		{
			this._lblDate.text = "";
			this._lblTitle.text = "";
			this._ldrImage.contentPath = "";
			this._mcSeparator._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._mcSeparator._visible = false;
	}
}
