class dofus.graphics.gapi.ui.Buff extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Buff";
	static var LAST_CONTAINER = 27;
	function Buff()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Buff.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
	}
	function addListeners()
	{
		var var2 = 20;
		while(var2 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
		{
			var var3 = this["_ctr" + var2];
			var3.addEventListener("click",this);
			var3.addEventListener("over",this);
			var3.addEventListener("out",this);
			var2 = var2 + 1;
		}
		this.api.datacenter.Player.Inventory.addEventListener("modelChanged",this);
	}
	function updateData()
	{
		var var2 = new Array();
		var var3 = 20;
		while(var3 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
		{
			var2[var3] = true;
			var3 = var3 + 1;
		}
		var var4 = this.api.datacenter.Player.Inventory;
		for(var k in var4)
		{
			var var5 = var4[k];
			if(!_global.isNaN(var5.position))
			{
				var var6 = var5.position;
				if(var6 < 20 || var6 > dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
				{
					continue;
				}
				var var7 = this["_ctr" + var6];
				var7.contentData = var5;
				var7.enabled = true;
				var2[var6] = false;
			}
		}
		var var8 = 20;
		while(var8 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
		{
			if(var2[var8])
			{
				var var9 = this["_ctr" + var8];
				var9.contentData = undefined;
				var9.enabled = false;
			}
			var8 = var8 + 1;
		}
	}
	function modelChanged(var2)
	{
		switch(var2.eventName)
		{
			case "updateOne":
			case "updateAll":
		}
		this.updateData();
	}
	function click(var2)
	{
		this.gapi.loadUIComponent("BuffInfos","BuffInfos",{data:var2.target.contentData},{bStayIfPresent:true});
	}
	function over(var2)
	{
		var var3 = var2.target.contentData;
		if(var3 != undefined)
		{
			this.gapi.showTooltip(var3.name + "\n" + var3.visibleEffects,var2.target,30);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
