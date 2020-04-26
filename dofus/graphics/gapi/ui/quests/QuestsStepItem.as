class dofus.graphics.gapi.ui.quests.QuestsStepItem extends ank.gapi.core.UIBasicComponent
{
	function QuestsStepItem()
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
			this._lblName.text = loc4.name;
			this._lblName.styleName = !loc4.isFinished?"BrownLeftSmallLabel":"GreyLeftSmallLabel";
			this._mcCheckFinished._visible = loc4.isFinished;
			this._mcArrow._visible = loc4.isCurrent;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._mcCheckFinished._visible = false;
			this._mcArrow._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._mcArrow._visible = false;
		this._mcCheckFinished._visible = false;
	}
}
