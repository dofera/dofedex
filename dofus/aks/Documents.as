class dofus.aks.Documents extends dofus.aks.Handler
{
	function Documents(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function leave()
	{
		this.aks.send("dV");
	}
	function onCreate(loc2, loc3)
	{
		if(loc2)
		{
			var loc4 = loc3;
			var loc5 = this.api.config.language;
			this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("LOADING"),background:false},{bForceLoad:true});
			this.api.kernel.DocumentsServersManager.loadDocument(loc5 + "_" + loc4);
		}
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("Document");
	}
}
