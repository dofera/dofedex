class dofus.graphics.gapi.ui.quests.QuestsStepItem extends ank.gapi.core.UIBasicComponent
{
	function QuestsStepItem()
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
			this._lblName.text = var4.name;
			this._lblName.styleName = !var4.isFinished?"BrownLeftSmallLabel":"GreyLeftSmallLabel";
			this._mcCheckFinished._visible = var4.isFinished;
			this._mcArrow._visible = var4.isCurrent;
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
