class dofus.graphics.gapi.ui.AskYesNoIgnore extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskYesNoIgnore";
	function AskYesNoIgnore()
	{
		super();
	}
	function __set__text(var2)
	{
		this._sText = var2;
		return this.__get__text();
	}
	function __get__text()
	{
		return this._sText;
	}
	function __set__player(var2)
	{
		this._sPlayer = var2;
		return this.__get__player();
	}
	function __get__player()
	{
		return this._sPlayer;
	}
	function callClose()
	{
		this.dispatchEvent({type:"no",params:this.params});
		return true;
	}
	function initWindowContent()
	{
		var var2 = this._winBackground.content;
		var2._txtText.text = this._sText;
		var2._txtIgnore.text = "<u><font color=\'" + 255 + "\'><a href=\'asfunction:onHref,\'>" + this.api.lang.getText("POPUP_ADD_IGNORE",[this._sPlayer]) + "</a></font></u>";
		var2._txtIgnore.addEventListener("href",this);
		var2._btnYes.label = this.api.lang.getText("YES");
		var2._btnNo.label = this.api.lang.getText("NO");
		var2._btnYes.addEventListener("click",this);
		var2._btnNo.addEventListener("click",this);
		var2._txtText.addEventListener("change",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnYes":
				this.dispatchEvent({type:"yes",params:this.params});
				break;
			case "_btnNo":
				this.dispatchEvent({type:"no",params:this.params});
		}
		this.unloadThis();
	}
	function change(var2)
	{
		var var3 = this._winBackground.content;
		var3._btnYes._y = var3._txtText._y + var3._txtText.height + 20;
		var3._btnNo._y = var3._txtText._y + var3._txtText.height + 20;
		var3._txtIgnore._y = var3._btnNo._y + var3._btnNo.height + 10;
		this._winBackground.setPreferedSize();
	}
	function onShortcut(var2)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.click({target:this._winBackground.content._btnYes});
			return false;
		}
		return true;
	}
	function href(var2)
	{
		this.params.player = this._sPlayer;
		this.dispatchEvent({type:"ignore",params:this.params});
		this.unloadThis();
	}
}
