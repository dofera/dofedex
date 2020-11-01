class dofus.aks.Dialog extends dofus.aks.Handler
{
	function Dialog(var2, var3)
	{
		super.initialize(var3,var4);
	}
	function begining(var2)
	{
		this.aks.send("DB" + var2,true);
	}
	function create(var2)
	{
		this.aks.send("DC" + var2,true);
	}
	function leave()
	{
		this.aks.send("DV",true);
	}
	function response(var2, var3)
	{
		this.aks.send("DR" + var2 + "|" + var3,true);
	}
	function onCustomAction(var2)
	{
		if((var var0 = var2) === "1")
		{
			getURL("javascript:DownloadOs()","_self");
		}
	}
	function onCreate(var2, var3)
	{
		if(!var2)
		{
			return undefined;
		}
		var var4 = Number(var3);
		var var5 = this.api.datacenter.Sprites.getItemAt(var4);
		var var6 = new Array();
		var6[1] = var5.color1 != undefined?var5.color1:-1;
		var6[2] = var5.color2 != undefined?var5.color2:-1;
		var6[3] = var5.color3 != undefined?var5.color3:-1;
		this.api.ui.loadUIComponent("NpcDialog","NpcDialog",{name:var5.name,gfx:var5.gfxID,id:var4,customArtwork:var5.customArtwork,colors:var6});
	}
	function onQuestion(var2)
	{
		var var3 = var2.split("|");
		var var4 = var3[0].split(";");
		var var5 = Number(var4[0]);
		var var6 = var4[1].split(",");
		var var7 = var3[1].split(";");
		var var8 = new dofus.datacenter.(var5,var7,var6);
		this.api.ui.getUIComponent("NpcDialog").setQuestion(var8);
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
