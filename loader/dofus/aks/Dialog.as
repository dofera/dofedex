class dofus.aks.Dialog extends dofus.aks.Handler
{
	function Dialog(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function begining(§\x1e\x0f\x1d§)
	{
		this.aks.send("DB" + var2,true);
	}
	function create(§\x1e\x0f\x1d§)
	{
		this.aks.send("DC" + var2,true);
	}
	function leave()
	{
		this.aks.send("DV",true);
	}
	function response(§\x01\b§, §\x1e\x1e\x15§)
	{
		this.aks.send("DR" + var2 + "|" + var3,true);
	}
	function onCustomAction(§\x1e\x12\x1a§)
	{
		if((var var0 = var2) === "1")
		{
			getURL("javascript:DownloadOs()","_self");
		}
	}
	function onCreate(§\x14\x1b§, §\x1e\x12\x1a§)
	{
		if(!var2)
		{
			return undefined;
		}
		var var4 = Number(var3);
		var var5 = this.api.datacenter.Sprites.getItemAt(var4);
		var var6 = new Array();
		var var7 = var5.name;
		if(dofus.Constants.DEBUG && var5.unicID != undefined)
		{
			var7 = var7 + " (" + var5.unicID + ")";
		}
		var6[1] = var5.color1 != undefined?var5.color1:-1;
		var6[2] = var5.color2 != undefined?var5.color2:-1;
		var6[3] = var5.color3 != undefined?var5.color3:-1;
		this.api.ui.loadUIComponent("NpcDialog","NpcDialog",{name:var7,gfx:var5.gfxID,id:var4,customArtwork:var5.customArtwork,colors:var6});
	}
	function onQuestion(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = var3[0].split(";");
		var var5 = Number(var4[0]);
		var var6 = var4[1].split(",");
		var var7 = var3[1].split(";");
		var var8 = new dofus.datacenter.(var5,var7,var6);
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
