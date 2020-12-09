class dofus.graphics.gapi.ui.quests.QuestsObjectiveItem extends ank.gapi.core.UIBasicComponent
{
	function QuestsObjectiveItem()
	{
		super();
	}
	function __set__list(§\x0b\x05§)
	{
		this._mcList = var2;
		return this.__get__list();
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._oItem = var4;
			this._txtDescription.text = var4.description;
			this._txtDescription.styleName = !var4.isFinished?"BrownLeftSmallTextArea":"GreyLeftSmallTextArea";
			this._mcCheckFinished._visible = var4.isFinished;
			this._mcCompass._visible = var4.x != undefined && var4.y != undefined && !var4.isFinished;
		}
		else if(this._txtDescription.text != undefined)
		{
			this._txtDescription.text = "";
			this._mcCheckFinished._visible = false;
			this._mcCompass._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._mcCheckFinished._visible = false;
		this._mcCompass._visible = false;
	}
}
