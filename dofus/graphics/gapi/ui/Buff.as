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
		var loc2 = 20;
		while(loc2 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
		{
			var loc3 = this["_ctr" + loc2];
			loc3.addEventListener("click",this);
			loc3.addEventListener("over",this);
			loc3.addEventListener("out",this);
			loc2 = loc2 + 1;
		}
		this.api.datacenter.Player.Inventory.addEventListener("modelChanged",this);
	}
	function updateData()
	{
		var loc2 = new Array();
		var loc3 = 20;
		while(loc3 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
		{
			loc2[loc3] = true;
			loc3 = loc3 + 1;
		}
		var loc4 = this.api.datacenter.Player.Inventory;
		for(var k in loc4)
		{
			var loc5 = loc4[k];
			if(!_global.isNaN(loc5.position))
			{
				var loc6 = loc5.position;
				if(loc6 < 20 || loc6 > dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
				{
					continue;
				}
				var loc7 = this["_ctr" + loc6];
				loc7.contentData = loc5;
				loc7.enabled = true;
				loc2[loc6] = false;
			}
		}
		var loc8 = 20;
		while(loc8 <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
		{
			if(loc2[loc8])
			{
				var loc9 = this["_ctr" + loc8];
				loc9.contentData = undefined;
				loc9.enabled = false;
			}
			loc8 = loc8 + 1;
		}
	}
	function modelChanged(loc2)
	{
		switch(loc2.eventName)
		{
			case "updateOne":
			case "updateAll":
		}
		this.updateData();
	}
	function click(loc2)
	{
		this.gapi.loadUIComponent("BuffInfos","BuffInfos",{data:loc2.target.contentData},{bStayIfPresent:true});
	}
	function over(loc2)
	{
		var loc3 = loc2.target.contentData;
		if(loc3 != undefined)
		{
			this.gapi.showTooltip(loc3.name + "\n" + loc3.visibleEffects,loc2.target,30);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
