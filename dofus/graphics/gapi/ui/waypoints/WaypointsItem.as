class dofus.graphics.gapi.ui.waypoints.WaypointsItem extends ank.gapi.core.UIBasicComponent
{
	function WaypointsItem()
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
			this._lblCost.text = loc4.cost != 0?loc4.cost + "k":"-";
			this._lblCoords.text = loc4.coordinates;
			this._lblName.text = loc4.name;
			this._mcRespawn._visible = loc4.isRespawn;
			this._mcCurrent._visible = loc4.isCurrent;
			this._btnLocate._visible = true;
		}
		else if(this._lblCost.text != undefined)
		{
			this._lblCost.text = "";
			this._lblCoords.text = "";
			this._lblName.text = "";
			this._mcRespawn._visible = false;
			this._mcCurrent._visible = false;
			this._btnLocate._visible = false;
		}
	}
	function init()
	{
		super.init(false);
		this._mcRespawn._visible = false;
		this._mcCurrent._visible = false;
		this._btnLocate._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnLocate.addEventListener("click",this);
	}
	function click(loc2)
	{
		this._mcList.gapi.loadUIAutoHideComponent("MapExplorer","MapExplorer",{mapID:this._oItem.id});
	}
}
