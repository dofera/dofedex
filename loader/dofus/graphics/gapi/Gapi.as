class dofus.graphics.gapi.Gapi extends ank.gapi.Gapi
{
	function Gapi()
	{
		super();
	}
	function loadUIComponent(var2, var3, var4, var5)
	{
		this.api.kernel.TipsManager.onNewInterface(var3);
		this.api.kernel.StreamingDisplayManager.onNewInterface(var3);
		var var7 = super.loadUIComponent(var3,var4,var5,var6);
		return var7;
	}
	function unloadUIComponent(var2)
	{
		this.api.kernel.StreamingDisplayManager.onInterfaceClose(var3);
		return super.unloadUIComponent(var3);
	}
}
