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
		var loc2 = this.getStyle();
	}
	function initWindowContent()
	{
		var loc2 = this._winBackground.content;
		loc2._txtMessage.maxChars = dofus.Constants.MAX_MESSAGE_LENGTH;
		loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		loc2._btnAddFriend.label = this.api.lang.getText("ADD_TO_FRIENDS");
		loc2._btnSend.label = this.api.lang.getText("SEND");
		loc2._btnCancel.addEventListener("click",this);
		loc2._btnAddFriend.addEventListener("click",this);
		loc2._btnSend.addEventListener("click",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		Selection.setFocus(loc2._txtMessage._tText);
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.click({target:this._winBackground.content._btnSend});
			return false;
		}
		return true;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnCancel":
				this.dispatchEvent({type:"cancel",params:this.params});
				this.unloadThis();
				break;
			case "_btnSend":
				var loc3 = this._winBackground.content._txtMessage.text;
				loc3 = new ank.utils.(loc3).replace(String.fromCharCode(13)," ");
				this.dispatchEvent({type:"send",message:loc3,params:this.params});
				this.unloadThis();
				break;
			default:
				if(loc0 !== "_btnAddFriend")
				{
					break;
				}
				this.dispatchEvent({type:"addfriend",params:this.params});
				break;
		}
	}
}
