class dofus.aks.Key extends dofus.aks.Handler
{
	function Key(§\x1e\x1a\x19§, §\x1e\x1a\x16§)
	{
		super.initialize(var3,var4);
	}
	function leave()
	{
		this.aks.send("KV",false);
	}
	function sendKey(§\x1e\x1c\x03§, §\x1e\x11\x0f§)
	{
		this.aks.send("KK" + var2 + "|" + var3);
	}
	function onCreate(§\x1e\x12\x1a§)
	{
		var var3 = var2.split("|");
		var var4 = Number(var3[0]);
		var var5 = Number(var3[1]);
		this.api.ui.loadUIComponent("KeyCode","KeyCode",{title:this.api.lang.getText("TYPE_CODE"),changeType:var4,slotsCount:var5});
	}
	function onKey(§\x14\x1b§)
	{
		var var3 = !var2?this.api.lang.getText("BAD_CODE"):this.api.lang.getText("CODE_CHANGED");
		this.api.kernel.showMessage(this.api.lang.getText("CODE"),var3,"ERROR_BOX",{name:"Key"});
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("KeyCode");
	}
}
