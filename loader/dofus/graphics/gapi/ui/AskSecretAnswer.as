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
	function __set__charToDelete(var2)
	{
		this._char = var2;
		return this.__get__charToDelete();
	}
	function initWindowContent()
	{
		var var2 = this._winBackground.content;
		var2._txtHelp.text = this.api.lang.getText("DELETING_CHARACTER_ANSWER") + GuildRights + _global.unescape(this.api.datacenter.Basics.aks_secret_question);
		var2._btnOk.label = this.api.lang.getText("OK");
		var2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		var2._btnOk.addEventListener("click",this);
		var2._btnCancel.addEventListener("click",this);
		var2._tiNickName.setFocus();
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnOk":
				var var3 = this._winBackground.content._tiNickName.text;
				if(var3.length > 0)
				{
					this.api.kernel.showMessage(this.api.lang.getText("DELETE_WORD"),this.api.lang.getText("DO_U_DELETE_A",[this._char.name]),"CAUTION_YESNO",{name:"SecretAnswer",params:{nickname:var3},listener:this});
				}
				break;
			case "_btnCancel":
				this.unloadThis();
		}
	}
	function onShortcut(var2)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG" && this.api.ui.getUIComponent("AskYesNoSecretAnswer") == undefined)
		{
			this.click({target:this._winBackground.content._btnOk});
			return false;
		}
		return true;
	}
	function yes(var2)
	{
		this.api.network.Account.deleteCharacter(this._char.id,var2.params.nickname);
		this.unloadThis();
	}
	function no(var2)
	{
		this.unloadThis();
	}
}
