class dofus.graphics.gapi.ui.crafterlist.CrafterListItem extends ank.gapi.core.UIBasicComponent
{
	function CrafterListItem()
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
			loc4.sortName = loc4.name;
			loc4.sortLevel = loc4.job.level;
			loc4.sortIsNotFree = loc4.job.options.isNotFree;
			loc4.sortMinSlots = Number(loc4.job.options.minSlots);
			loc4.sortSubarea = loc4.subarea != undefined?loc4.subarea:"-";
			var loc5 = loc4.coord;
			loc4.sortCoord = loc5 == undefined?"-":loc5.x + "," + loc5.y;
			loc4.sortInWorkshop = loc4.inWorkshop;
			this._lblName.text = loc4.sortName;
			this._lblLevel.text = loc4.sortLevel.toString();
			this._lblPlace.text = loc4.subarea != undefined?loc4.subarea:" ";
			var loc6 = this._mcList._parent._parent.api;
			this._lblWorkshop.text = !loc4.sortInWorkshop?loc6.lang.getText("NO"):loc6.lang.getText("YES");
			this._lblCoord.text = loc4.sortCoord;
			this._lblNotFree.text = !loc4.sortIsNotFree?loc6.lang.getText("NO"):loc6.lang.getText("YES");
			this._lblMinSlot.text = loc4.sortMinSlots.toString();
			this._ldrGuild.contentPath = loc4.gfxBreedFile;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblLevel.text = "";
			this._lblPlace.text = "";
			this._lblWorkshop.text = "";
			this._lblCoord.text = "";
			this._lblNotFree.text = "";
			this._lblMinSlot.text = "";
			this._ldrGuild.contentPath = "";
		}
	}
	function init()
	{
		super.init(false);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnProfil.addEventListener("click",this);
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target._name) === "_btnProfil")
		{
			this._mcList.gapi.loadUIComponent("CrafterCard","CrafterCard",{crafter:this._oItem});
		}
	}
}
