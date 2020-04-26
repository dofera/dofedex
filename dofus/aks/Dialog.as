class dofus.aks.Dialog extends dofus.aks.Handler
{
	function Dialog(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function begining(loc2)
	{
		this.aks.send("DB" + loc2,true);
	}
	function create(loc2)
	{
		this.aks.send("DC" + loc2,true);
	}
	function leave()
	{
		this.aks.send("DV",true);
	}
	function response(loc2, loc3)
	{
		this.aks.send("DR" + loc2 + "|" + loc3,true);
	}
	function onCustomAction(loc2)
	{
		if((var loc0 = loc2) === "1")
		{
			getURL("javascript:DownloadOs()","_self");
		}
	}
	function onCreate(loc2, loc3)
	{
		if(!loc2)
		{
			return undefined;
		}
		var loc4 = Number(loc3);
		var loc5 = this.api.datacenter.Sprites.getItemAt(loc4);
		var loc6 = new Array();
		loc6[1] = loc5.color1 != undefined?loc5.color1:-1;
		loc6[2] = loc5.color2 != undefined?loc5.color2:-1;
		loc6[3] = loc5.color3 != undefined?loc5.color3:-1;
		this.api.ui.loadUIComponent("NpcDialog","NpcDialog",{name:loc5.name,gfx:loc5.gfxID,id:loc4,customArtwork:loc5.customArtwork,colors:loc6});
	}
	function onQuestion(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = loc3[0].split(";");
		var loc5 = Number(loc4[0]);
		var loc6 = loc4[1].split(",");
		var loc7 = loc3[1].split(";");
		var loc8 = new dofus.datacenter.(loc5,loc7,loc6);
		this.api.ui.getUIComponent("NpcDialog").setQuestion(loc8);
	}
	function onPause()
	{
		this.api.ui.getUIComponent("NpcDialog").setPause();
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("NpcDialog");
	}
}
