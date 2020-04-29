class dofus.graphics.gapi.ui.waypoints.WaypointsItem extends ank.gapi.core.UIBasicComponent
{
	function WaypointsItem()
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
			this._lblCost.text = var4.cost != 0?var4.cost + "k":"-";
			this._lblCoords.text = var4.coordinates;
			this._lblName.text = var4.name;
			this._mcRespawn._visible = var4.isRespawn;
			this._mcCurrent._visible = var4.isCurrent;
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
	function click(var2)
	{
		this._mcList.gapi.loadUIAutoHideComponent("MapExplorer","MapExplorer",{mapID:this._oItem.id});
	}
}
