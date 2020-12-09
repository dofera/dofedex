class dofus.graphics.gapi.controls.guildhousesviewer.GuildHousesViewerHouses extends ank.gapi.core.UIBasicComponent
{
	function GuildHousesViewerHouses()
	{
		super();
		this._mcIcon._visible = false;
	}
	function setValue(§\x14\t§, §\x1e\r\x11§, §\x1e\x19\r§)
	{
		if(var2)
		{
			this._oItem = (dofus.datacenter.House)var4;
			this._lblName.text = this._oItem.name;
			this._lblOwner.text = this._oItem.ownerName;
			this._mcIcon._visible = true;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblOwner.text = "";
			this._mcIcon._visible = false;
		}
	}
	function init()
	{
		super.init(false);
	}
}
