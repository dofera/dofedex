class dofus.aks.Waypoints extends dofus.aks.Handler
{
	function Waypoints(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function leave()
	{
		this.aks.send("WV",true);
	}
	function use(§\x1e\x1b\x11§)
	{
		this.aks.send("WU" + var2,true);
	}
	function onCreate(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = new ank.utils.
();
		var var6 = 1;
		while(var6 < var3.length)
		{
			var var7 = var3[var6].split(";");
			var var8 = Number(var7[0]);
			var var9 = Number(var7[1]);
			var var10 = new dofus.datacenter.
	(var8,var8 == this.api.datacenter.Map.id,var8 == var4,var9);
			var5.push(var10);
			var6 = var6 + 1;
		}
		this.api.ui.loadUIComponent("Waypoints","Waypoints",{data:var5});
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("Waypoints");
	}
	function onUseError()
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_USE_WAYPOINT"),"ERROR_CHAT");
	}
}
