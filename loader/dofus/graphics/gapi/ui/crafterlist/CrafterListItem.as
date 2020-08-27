class dofus.graphics.gapi.ui.crafterlist.CrafterListItem extends ank.gapi.core.UIBasicComponent
{
	function CrafterListItem()
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
			var4.sortName = var4.name;
			var4.sortLevel = var4.job.level;
			var4.sortIsNotFree = var4.job.options.isNotFree;
			var4.sortMinSlots = Number(var4.job.options.minSlots);
			var4.sortSubarea = var4.subarea != undefined?var4.subarea:"-";
			var var5 = var4.coord;
			var4.sortCoord = var5 == undefined?"-":var5.x + "," + var5.y;
			var4.sortInWorkshop = var4.inWorkshop;
			this._lblName.text = var4.sortName;
			this._lblLevel.text = var4.sortLevel.toString();
			this._lblPlace.text = var4.subarea != undefined?var4.subarea:" ";
			var var6 = this._mcList._parent._parent.api;
			this._lblWorkshop.text = !var4.sortInWorkshop?var6.lang.getText("NO"):var6.lang.getText("YES");
			this._lblCoord.text = var4.sortCoord;
			this._lblNotFree.text = !var4.sortIsNotFree?var6.lang.getText("NO"):var6.lang.getText("YES");
			this._lblMinSlot.text = var4.sortMinSlots.toString();
			this._ldrGuild.contentPath = var4.gfxBreedFile;
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
	function click(var2)
	{
		if((var var0 = var2.target._name) === "_btnProfil")
		{
			this._mcList.gapi.loadUIComponent("CrafterCard","CrafterCard",{crafter:this._oItem});
		}
	}
}
