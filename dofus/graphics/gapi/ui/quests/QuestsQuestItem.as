class dofus.graphics.gapi.ui.quests.QuestsQuestItem extends ank.gapi.core.UIBasicComponent
{
	function QuestsQuestItem()
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
			this._mcCheckFinished._visible = loc4.isFinished;
			this._mcCurrent._visible = !loc4.isFinished;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._mcCheckFinished._visible = false;
			this._mcCurrent._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._mcCurrent._visible = false;
		this._mcCheckFinished._visible = false;
	}
}
