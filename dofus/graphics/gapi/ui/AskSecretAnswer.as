class dofus.graphics.gapi.ui.AskSecretAnswer extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskSecretAnswer";
	var isConfirming = false;
	function AskSecretAnswer()
	{
		super();
	}
	function __get__charToDelete()
	{
		return this._char;
	}
	function __set__charToDelete(loc2)
	{
		this._char = loc2;
		return this.__get__charToDelete();
	}
	function initWindowContent()
	{
		var loc2 = this._winBackground.content;
		loc2._txtHelp.text = this.api.lang.getText("DELETING_CHARACTER_ANSWER") + "\r\n" + _global.unescape(this.api.datacenter.Basics.aks_secret_question);
		loc2._btnOk.label = this.api.lang.getText("OK");
		loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		loc2._btnOk.addEventListener("click",this);
		loc2._btnCancel.addEventListener("click",this);
		loc2._tiNickName.setFocus();
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnOk":
				var loc3 = this._winBackground.content._tiNickName.text;
				if(loc3.length > 0)
				{
					this.api.kernel.showMessage(this.api.lang.getText("DELETE_WORD"),this.api.lang.getText("DO_U_DELETE_A",[this._char.name]),"CAUTION_YESNO",{name:"SecretAnswer",params:{nickname:loc3},listener:this});
				}
				break;
			case "_btnCancel":
				this.unloadThis();
		}
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG" && this.api.ui.getUIComponent("AskYesNoSecretAnswer") == undefined)
		{
			this.click({target:this._winBackground.content._btnOk});
			return false;
		}
		return true;
	}
	function yes(loc2)
	{
		this.api.network.Account.deleteCharacter(this._char.id,loc2.params.nickname);
		this.unloadThis();
	}
	function no(loc2)
	{
		this.unloadThis();
	}
}
