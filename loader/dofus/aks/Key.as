class dofus.aks.Key extends dofus.aks.Handler
{
	function Key(§\x1e\x1a\x0e§, oAPI)
	{
		super.initialize(var3,oAPI);
	}
	function leave()
	{
		this.aks.send("KV",false);
	}
	function sendKey(var2, var3)
	{
		this.aks.send("KK" + var2 + "|" + var3);
	}
	function onCreate(var2)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		this.api.ui.loadUIComponent("KeyCode","KeyCode",{title:this.api.lang.getText("TYPE_CODE"),changeType:var4,slotsCount:var5});
	}
	function onKey(var2)
	{
		var var3 = !var2?this.api.lang.getText("BAD_CODE"):this.api.lang.getText("CODE_CHANGED");
		this.api.kernel.showMessage(this.api.lang.getText("CODE"),var3,"ERROR_BOX",{name:"Key"});
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("KeyCode");
	}
}
