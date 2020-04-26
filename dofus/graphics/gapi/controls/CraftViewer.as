class dofus.graphics.gapi.controls.CraftViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CraftViewer";
	function CraftViewer()
	{
		super();
	}
	function __set__job(loc2)
	{
		this._oJob = loc2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__job();
	}
	function __set__skill(loc2)
	{
		var loc3 = new ank.utils.();
		loc3.push(loc2);
		this.job = new dofus.datacenter.Job(-1,loc3);
		return this.__get__skill();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.CraftViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this._lstCrafts._visible = false;
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
	}
	function addListeners()
	{
		this._btnSlot0.addEventListener("click",this);
		this._btnSlot1.addEventListener("click",this);
		this._btnSlot2.addEventListener("click",this);
		this._btnSlot3.addEventListener("click",this);
		this._btnSlot4.addEventListener("click",this);
		this._btnSlot5.addEventListener("click",this);
		this._btnSlot6.addEventListener("click",this);
		this._btnSlot7.addEventListener("click",this);
		this._btnSlot0.addEventListener("over",this);
		this._btnSlot1.addEventListener("over",this);
		this._btnSlot2.addEventListener("over",this);
		this._btnSlot3.addEventListener("over",this);
		this._btnSlot4.addEventListener("over",this);
		this._btnSlot5.addEventListener("over",this);
		this._btnSlot6.addEventListener("over",this);
		this._btnSlot7.addEventListener("over",this);
		this._btnSlot0.addEventListener("out",this);
		this._btnSlot1.addEventListener("out",this);
		this._btnSlot2.addEventListener("out",this);
		this._btnSlot3.addEventListener("out",this);
		this._btnSlot4.addEventListener("out",this);
		this._btnSlot5.addEventListener("out",this);
		this._btnSlot6.addEventListener("out",this);
		this._btnSlot7.addEventListener("out",this);
	}
	function initTexts()
	{
		this._lblCrafts.text = this.api.lang.getText("RECEIPTS");
		this._lblFilter.text = this.api.lang.getText("FILTER");
	}
	function layoutContent()
	{
		var loc2 = this.api.datacenter.Basics.craftViewer_filter;
		this._btnSlot0.selected = loc2[0];
		this._btnSlot1.selected = loc2[1];
		this._btnSlot2.selected = loc2[2];
		this._btnSlot3.selected = loc2[3];
		this._btnSlot4.selected = loc2[4];
		this._btnSlot5.selected = loc2[5];
		this._btnSlot6.selected = loc2[6];
		this._btnSlot7.selected = loc2[7];
		if(this._oJob == undefined)
		{
			return undefined;
		}
		var loc3 = this._oJob.crafts;
		var loc4 = new ank.utils.();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			var loc6 = loc3[loc5];
			if(loc2[loc6.itemsCount - 1])
			{
				loc4.push(loc6);
			}
			loc5 = loc5 + 1;
		}
		if(loc4.length != 0)
		{
			this._lstCrafts._visible = true;
			loc4.bubbleSortOn("itemsCount",Array.DESCENDING);
			this._lstCrafts.dataProvider = loc4;
			this._lblNoCraft.text = "";
		}
		else
		{
			this._lstCrafts._visible = false;
			this._lblNoCraft.text = this.api.lang.getText("NO_CRAFT_AVAILABLE");
		}
	}
	function craftItem(loc2)
	{
		this._parent.addCraft(loc2.unicID);
	}
	function click(loc2)
	{
		var loc3 = this.api.datacenter.Basics.craftViewer_filter;
		var loc4 = Number(loc2.target._name.substr(8));
		loc3[loc4] = loc2.target.selected;
		this.layoutContent();
	}
	function over(loc2)
	{
		var loc3 = Number(loc2.target._name.substr(8)) + 1;
		this.gapi.showTooltip(this.api.lang.getText("CRAFT_SLOT_FILTER",[loc3]),loc2.target,-20);
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
