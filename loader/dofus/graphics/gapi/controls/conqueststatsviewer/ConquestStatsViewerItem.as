class dofus.graphics.gapi.controls.conqueststatsviewer.ConquestStatsViewerItem extends ank.gapi.core.UIBasicComponent
{
	function ConquestStatsViewerItem()
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
