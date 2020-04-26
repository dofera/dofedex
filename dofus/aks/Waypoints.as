class dofus.aks.Waypoints extends dofus.aks.Handler
{
	function Waypoints(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function leave()
	{
		this.aks.send("WV",true);
	}
	function use(loc2)
	{
		this.aks.send("WU" + loc2,true);
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
			var loc10 = new dofus.datacenter.(loc8,loc8 == this.api.datacenter.Map.id,loc8 == loc4,loc9);
			loc5.push(loc10);
			loc6 = loc6 + 1;
		}
		this.api.ui.loadUIComponent("Waypoints","Waypoints",{data:loc5});
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
