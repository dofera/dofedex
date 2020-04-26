class dofus.aks.Subway extends dofus.aks.Handler
{
	function Subway(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function leave()
	{
		this.aks.send("Wv");
	}
	function use(loc2)
	{
		this.aks.send("Wu" + loc2);
	}
	function prismLeave()
	{
		this.aks.send("Ww");
	}
	function prismUse(loc2)
	{
		this.aks.send("Wp" + loc2);
	}
	function onCreate(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = new ank.utils.();
		var loc6 = 1;
		while(loc6 < loc3.length)
		{
			var loc7 = loc3[loc6].split(";");
			var loc8 = Number(loc7[0]);
			var loc9 = Number(loc7[1]);
			var loc10 = this.api.lang.getHintsByMapID(loc8);
			var loc11 = 0;
			while(loc11 < loc10.length)
			{
				var loc12 = new dofus.datacenter.Subway(loc10[loc11],loc9);
				if(loc5[loc12.categoryID] == undefined)
				{
					loc5[loc12.categoryID] = new ank.utils.();
				}
				loc5[loc12.categoryID].push(loc12);
				loc11 = loc11 + 1;
			}
			loc6 = loc6 + 1;
		}
		this.api.ui.loadUIComponent("Subway","Subway",{data:loc5});
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("Subway");
	}
	function onPrismCreate(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = new ank.utils.();
		var loc6 = 1;
		while(loc6 < loc3.length)
		{
			var loc7 = loc3[loc6].split(";");
			var loc8 = Number(loc7[0]);
			var loc9 = false;
			var loc10 = -1;
			var loc11 = loc7[1];
			if(loc11.charAt(loc11.length - 1) == "*")
			{
				loc9 = true;
				loc10 = Number(loc11.substr(0,loc11.length - 1));
			}
			else
			{
				loc10 = Number(loc11);
			}
			loc5.push(new dofus.datacenter.(loc8,loc10,loc9));
			loc6 = loc6 + 1;
		}
		this.api.ui.loadUIComponent("Subway","Subway",{data:loc5,type:dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM});
	}
	function onPrismLeave()
	{
		this.api.ui.unloadUIComponent("Subway");
	}
	function onUseError()
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_USE_SUBWAY"),"ERROR_CHAT");
	}
}
