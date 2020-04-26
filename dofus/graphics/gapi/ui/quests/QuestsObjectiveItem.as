class dofus.graphics.gapi.ui.quests.QuestsObjectiveItem extends ank.gapi.core.UIBasicComponent
{
	function QuestsObjectiveItem()
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
			this._txtDescription.text = loc4.description;
			this._txtDescription.styleName = !loc4.isFinished?"BrownLeftSmallTextArea":"GreyLeftSmallTextArea";
			this._mcCheckFinished._visible = loc4.isFinished;
			this._mcCompass._visible = loc4.x != undefined && loc4.y != undefined && !loc4.isFinished;
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
