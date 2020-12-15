class dofus.graphics.gapi.ui.quests.QuestsStepRewardItem extends ank.gapi.core.UIBasicComponent
{
	function QuestsStepRewardItem()
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
			this._lblName.text = var4.label;
			this._ldrIcon.contentPath = var4.iconFile;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._ldrIcon.contentPath = "";
		}
	}
}
