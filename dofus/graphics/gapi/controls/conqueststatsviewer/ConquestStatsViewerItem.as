class dofus.graphics.gapi.controls.conqueststatsviewer.ConquestStatsViewerItem extends ank.gapi.core.UIBasicComponent
{
	function ConquestStatsViewerItem()
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
			this._lblType.text = this._oItem.type;
			this._lblBonus.text = this._oItem.bonus;
			this._lblMalus.text = this._oItem.malus;
		}
		else if(this._lblType.text != undefined)
		{
			this._lblType.text = "";
			this._lblBonus.text = "";
			this._lblMalus.text = "";
		}
	}
}
