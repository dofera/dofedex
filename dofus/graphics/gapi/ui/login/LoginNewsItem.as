class dofus.graphics.gapi.ui.login.LoginNewsItem extends ank.gapi.core.UIBasicComponent
{
	function LoginNewsItem()
	{
		super();
	}
	function __set__list(loc2)
	{
		this._mcList = loc2;
		return this.__get__list();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = loc4;
			this._lblDate.text = loc4.getPubDateStr(_global.API.lang.getConfigText("LONG_DATE_FORMAT"),_global.API.config.language);
			this._lblTitle.bDisplayDebug = true;
			this._lblTitle.text = loc4.getTitle();
			this._ldrImage.contentPath = loc4.getIcon();
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
