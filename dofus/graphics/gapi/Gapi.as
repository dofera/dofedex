class dofus.graphics.gapi.Gapi extends ank.gapi.Gapi
{
	function Gapi()
	{
		super();
	}
	function loadUIComponent(loc2, loc3, loc4, loc5)
	{
		this.api.kernel.TipsManager.onNewInterface(loc3);
		this.api.kernel.StreamingDisplayManager.onNewInterface(loc3);
		var loc7 = super.loadUIComponent(loc3,loc4,loc5,loc6);
		return loc7;
	}
	function unloadUIComponent(loc2)
	{
		this.api.kernel.StreamingDisplayManager.onInterfaceClose(loc3);
		return super.unloadUIComponent(loc3);
	}
}
