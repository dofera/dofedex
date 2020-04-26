class dofus.graphics.gapi.controls.guildhousesviewer.GuildHousesViewerHouses extends ank.gapi.core.UIBasicComponent
{
	function GuildHousesViewerHouses()
	{
		super();
		this._mcIcon._visible = false;
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._oItem = (dofus.datacenter.House)loc4;
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
