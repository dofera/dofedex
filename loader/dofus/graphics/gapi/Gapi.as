class dofus.graphics.gapi.Gapi extends ank.gapi.Gapi
{
	function Gapi()
	{
		super();
	}
	function loadUIComponent(§\x1e\x10\x1b§, §\x1e\x11\x15§, §\x1e\x1a\x07§, §\x1e\x17\x15§)
	{
		this.api.kernel.TipsManager.onNewInterface(var3);
		this.api.kernel.StreamingDisplayManager.onNewInterface(var3);
		var var7 = super.loadUIComponent(var3,var4,var5,var6);
		return var7;
	}
	function unloadUIComponent(§\x1e\x11\x15§)
	{
		this.api.kernel.StreamingDisplayManager.onInterfaceClose(var3);
		return super.unloadUIComponent(var3);
	}
}
