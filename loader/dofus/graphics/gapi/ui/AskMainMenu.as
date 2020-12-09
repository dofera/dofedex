class dofus.graphics.gapi.ui.AskMainMenu extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskMainMenu";
	function AskMainMenu()
	{
		super();
	}
	function initWindowContent()
	{
		this._winBackground.title = this.api.lang.getText("MENU");
		var var2 = this._winBackground.content;
		var2._btnChange.label = this.api.lang.getText("CHANGE_CHARACTER");
		var2._btnDisconnect.label = this.api.lang.getText("LOGOFF");
		var2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		var2._btnQuit.label = this.api.lang.getText("QUIT_DOFUS");
		var2._btnChange.addEventListener("click",this);
		var2._btnDisconnect.addEventListener("click",this);
		var2._btnCancel.addEventListener("click",this);
		var2._btnQuit.addEventListener("click",this);
		this.setEnabledBtnQuit(System.capabilities.playerType == "StandAlone" || this.api.electron.enabled);
		this.setEnabledBtnChange(this.api.ui.getUIComponent("Banner") != undefined);
	}
	function setEnabledBtnChange(§\x1a\x12§)
	{
		var var3 = this._winBackground.content._btnChange;
		var3.enabled = var2;
	}
	function setEnabledBtnQuit(§\x1a\x12§)
	{
		var var3 = this._winBackground.content._btnQuit;
		var3.enabled = var2;
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnChange":
				this.api.kernel.changeServer();
				break;
			case "_btnDisconnect":
				this.api.kernel.disconnect();
				break;
			case "_btnQuit":
				this.api.kernel.quit();
		}
		this.unloadThis();
	}
}
