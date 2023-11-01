class dofus.aks.Documents extends dofus.aks.Handler
{
	function Documents(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}
	function leave()
	{
		this.aks.send("dV");
	}
	function onCreate(var2, var3)
	{
		if(var2)
		{
			var var4 = var3;
			var var5 = this.api.config.language;
			this.api.ui.loadUIComponent("CenterText","CenterText",{text:this.api.lang.getText("LOADING"),background:false},{bForceLoad:true});
			this.api.kernel.DocumentsServersManager.loadDocument(var5 + "_" + var4);
		}
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("Document");
	}
}
