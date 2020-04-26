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
		var loc2 = this._winBackground.content;
		loc2._btnChange.label = this.api.lang.getText("CHANGE_CHARACTER");
		loc2._btnDisconnect.label = this.api.lang.getText("LOGOFF");
		loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		loc2._btnQuit.label = this.api.lang.getText("QUIT_DOFUS");
		loc2._btnChange.addEventListener("click",this);
		loc2._btnDisconnect.addEventListener("click",this);
		loc2._btnCancel.addEventListener("click",this);
		loc2._btnQuit.addEventListener("click",this);
		this.setEnabledBtnQuit(System.capabilities.playerType == "StandAlone" || this.api.electron.enabled);
		this.setEnabledBtnChange(this.api.ui.getUIComponent("Banner") != undefined);
	}
	function setEnabledBtnChange(loc2)
	{
		var loc3 = this._winBackground.content._btnChange;
		loc3.enabled = loc2;
	}
	function setEnabledBtnQuit(loc2)
	{
		var loc3 = this._winBackground.content._btnQuit;
		loc3.enabled = loc2;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnChange":
				this.api.kernel.changeServer();
				break;
			case "_btnDisconnect":
				this.api.kernel.disconnect();
				break;
			default:
				if(loc0 !== "_btnQuit")
				{
					break;
				}
				this.api.kernel.quit();
				break;
		}
		this.unloadThis();
	}
}
