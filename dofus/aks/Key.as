class dofus.aks.Key extends dofus.aks.Handler
{
	function Key(loc3, loc4)
	{
		super.initialize(loc3,loc4);
	}
	function leave()
	{
		this.aks.send("KV",false);
	}
	function sendKey(loc3, loc4)
	{
		this.aks.send("KK" + loc2 + "|" + loc3);
	}
	function onCreate(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = Number(loc3[1]);
		this.api.ui.loadUIComponent("KeyCode","KeyCode",{title:this.api.lang.getText("TYPE_CODE"),changeType:loc4,slotsCount:loc5});
	}
	function onKey(loc2)
	{
		var loc3 = !loc2?this.api.lang.getText("BAD_CODE"):this.api.lang.getText("CODE_CHANGED");
		this.api.kernel.showMessage(this.api.lang.getText("CODE"),loc3,"ERROR_BOX",{name:"Key"});
	}
	function onLeave()
	{
		this.api.ui.unloadUIComponent("KeyCode");
	}
}
