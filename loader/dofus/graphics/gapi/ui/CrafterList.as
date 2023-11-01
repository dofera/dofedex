class dofus.graphics.gapi.ui.CrafterList extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CrafterList";
	function CrafterList()
	{
		super();
	}
	function __set__jobs(var2)
	{
		this._eaJobs = var2;
		if(this.initialized)
		{
			this.updateJobs();
		}
		return this.__get__jobs();
	}
	function __set__crafters(var2)
	{
		this._eaCrafters.removeEventListener("modelChanged",this);
		this._eaCrafters = var2;
		this._eaCrafters.addEventListener("modelChanged",this);
		if(this.initialized)
		{
			this.updateCrafters();
		}
		return this.__get__crafters();
	}
	function __get__crafters()
	{
		return this._eaCrafters;
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.CrafterList.CLASS_NAME);
	}
	function callClose()
	{
		ank.utils.Timer.removeTimer(this,"simulation");
		this.api.network.Exchange.leave();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._dgCrafter.addEventListener("itemSelected",this);
		this._dgCrafter.addEventListener("itemdblClick",this);
		this._cbJobs.addEventListener("itemSelected",this);
	}
	function initTexts()
	{
		this._lblJob.text = this.api.lang.getText("JOB");
		this._winBackground.title = this.api.lang.getText("CRAFTERS_LIST");
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._dgCrafter.columnsNames = ["",this.api.lang.getText("NAME_BIG"),this.api.lang.getText("LEVEL_SMALL"),this.api.lang.getText("SUBAREA"),this.api.lang.getText("COORDINATES"),this.api.lang.getText("IN_WORKSHOP"),this.api.lang.getText("NOT_FREE"),this.api.lang.getText("MIN_ITEM_IN_RECEIPT")];
	}
	function updateData()
	{
		this.updateJobs();
	}
	function updateJobs()
	{
		this._cbJobs.dataProvider = this._eaJobs;
		if(this._eaJobs != undefined && this._eaJobs.length > 0)
		{
			this._cbJobs.selectedIndex = 0;
			this.api.network.Exchange.getCrafterForJob(this._cbJobs.selectedItem.id);
		}
	}
	function updateCrafters()
	{
		this._dgCrafter.dataProvider = this._eaCrafters;
	}
	function click(var2)
	{
		switch(var2.target)
		{
			case this._btnClose:
			case this._btnClose2:
				this.callClose();
		}
	}
	function itemdblClick(var2)
	{
		this.itemSelected(var2);
	}
	function itemSelected(var2)
	{
		switch(var2.target)
		{
			case this._cbJobs:
				this._eaCrafters.removeAll();
				this.api.network.Exchange.getCrafterForJob(this._cbJobs.selectedItem.id);
				break;
			case this._dgCrafter:
				var var3 = var2.row.item;
				this.api.ui.loadUIComponent("CrafterCard","CrafterCard",{crafter:var3});
		}
	}
	function modelChanged(var2)
	{
		this.updateCrafters();
	}
}
