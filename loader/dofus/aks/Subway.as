class dofus.aks.Subway extends dofus.aks.Handler
{
	function Subway(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}
	function leave()
	{
		this.aks.send("Wv");
	}
	function use(var2)
	{
		this.aks.send("Wu" + var2);
	}
	function prismLeave()
	{
		this.aks.send("Ww");
	}
	function prismUse(var2)
	{
		this.aks.send("Wp" + var2);
	}
	function onCreate(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = new ank.utils.();
		var var6 = 1;
		while(var6 < var3.length)
		{
			var var7 = var3[var6].split(";");
			var var8 = Number(var7[0]);
			var var9 = Number(var7[1]);
			var var10 = this.api.lang.getHintsByMapID(var8);
			var var11 = 0;
			while(var11 < var10.length)
			{
				var var12 = new dofus.datacenter.Subway(var10[var11],var9);
				if(var5[var12.categoryID] == undefined)
				{
					var5[var12.categoryID] = new ank.utils.();
				}
				var5[var12.categoryID].push(var12);
				var11 = var11 + 1;
			}
			var6 = var6 + 1;
		}
		this.api.ui.loadUIComponent("Subway","Subway",{data:var5});
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("Subway");
	}
	function onPrismCreate(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = new ank.utils.();
		var var6 = 1;
		while(var6 < var3.length)
		{
			var var7 = var3[var6].split(";");
			var var8 = Number(var7[0]);
			var var9 = false;
			var var10 = -1;
			var var11 = var7[1];
			if(var11.charAt(var11.length - 1) == "*")
			{
				var9 = true;
				var10 = Number(var11.substr(0,var11.length - 1));
			}
			else
			{
				var10 = Number(var11);
			}
			var5.push(new dofus.datacenter.	(var8,var10,var9));
			var6 = var6 + 1;
		}
		this.api.ui.loadUIComponent("Subway","Subway",{data:var5,type:dofus.graphics.gapi.ui.Subway.SUBWAY_TYPE_PRISM});
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
