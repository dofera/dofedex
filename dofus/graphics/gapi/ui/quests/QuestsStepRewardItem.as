class dofus.graphics.gapi.ui.quests.QuestsStepRewardItem extends ank.gapi.core.UIBasicComponent
{
	function QuestsStepRewardItem()
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
			this._lblName.text = loc4.label;
			this._ldrIcon.contentPath = loc4.iconFile;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._ldrIcon.contentPath = "";
		}
	}
}
