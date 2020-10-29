class dofus.graphics.gapi.controls.CraftViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CraftViewer";
	function CraftViewer()
	{
		super();
	}
	function __set__job(var2)
	{
		this._oJob = var2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__job();
	}
	function __set__skill(var2)
	{
		var var3 = new ank.utils.();
		var3.push(var2);
		this.job = new dofus.datacenter.Job(-1,var3);
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
		var var2 = this.api.datacenter.Basics.craftViewer_filter;
		this._btnSlot0.selected = var2[0];
		this._btnSlot1.selected = var2[1];
		this._btnSlot2.selected = var2[2];
		this._btnSlot3.selected = var2[3];
		this._btnSlot4.selected = var2[4];
		this._btnSlot5.selected = var2[5];
		this._btnSlot6.selected = var2[6];
		this._btnSlot7.selected = var2[7];
		if(this._oJob == undefined)
		{
			return undefined;
		}
		var var3 = this._oJob.crafts;
		var var4 = new ank.utils.();
		var var5 = 0;
		while(var5 < var3.length)
		{
			var var6 = var3[var5];
			if(var2[var6.itemsCount - 1])
			{
				var4.push(var6);
			}
			var5 = var5 + 1;
		}
		if(var4.length != 0)
		{
			this._lstCrafts._visible = true;
			var4.bubbleSortOn("itemsCount",Array.DESCENDING);
			this._lstCrafts.dataProvider = var4;
			this._lblNoCraft.text = "";
		}
		else
		{
			this._lstCrafts._visible = false;
			this._lblNoCraft.text = this.api.lang.getText("NO_CRAFT_AVAILABLE");
		}
	}
	function craftItem(var2)
	{
		this._parent.addCraft(var2.unicID);
	}
	function click(var2)
	{
		var var3 = this.api.datacenter.Basics.craftViewer_filter;
		var var4 = Number(var2.target._name.substr(8));
		var3[var4] = var2.target.selected;
		this.layoutContent();
	}
	function over(var2)
	{
		var var3 = Number(var2.target._name.substr(8)) + 1;
		this.gapi.showTooltip(this.api.lang.getText("CRAFT_SLOT_FILTER",[var3]),var2.target,-20);
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
