class dofus.graphics.gapi.ui.AskPrivateChat extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskPrivateChat";
	function AskPrivateChat()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.AskPrivateChat.CLASS_NAME);
		this.gapi.getUIComponent("Banner").chatAutoFocus = false;
	}
	function destroy()
	{
		this.gapi.getUIComponent("Banner").chatAutoFocus = true;
	}
	function draw()
	{
		var var2 = this.getStyle();
	}
	function initWindowContent()
	{
		var var2 = this._winBackground.content;
		var2._txtMessage.maxChars = dofus.Constants.MAX_MESSAGE_LENGTH;
		var2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		var2._btnAddFriend.label = this.api.lang.getText("ADD_TO_FRIENDS");
		var2._btnSend.label = this.api.lang.getText("SEND");
		var2._btnCancel.addEventListener("click",this);
		var2._btnAddFriend.addEventListener("click",this);
		var2._btnSend.addEventListener("click",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		Selection.setFocus(var2._txtMessage._tText);
	}
	function onShortcut(§\x1e\x0e\x04§)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.click({target:this._winBackground.content._btnSend});
			return false;
		}
		return true;
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnCancel":
				this.dispatchEvent({type:"cancel",params:this.params});
				this.unloadThis();
				break;
			case "_btnSend":
				var var3 = this._winBackground.content._txtMessage.text;
				var3 = new ank.utils.(var3).replace(String.fromCharCode(13)," ");
				this.dispatchEvent({type:"send",message:var3,params:this.params});
				this.unloadThis();
				break;
			case "_btnAddFriend":
				this.dispatchEvent({type:"addfriend",params:this.params});
		}
	}
}
