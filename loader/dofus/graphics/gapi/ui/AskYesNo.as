class dofus.graphics.gapi.ui.AskYesNo extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskYesNo";
	function AskYesNo()
	{
		super();
	}
	function __set__text(§\x1e\r\x02§)
	{
		this._sText = var2;
		return this.__get__text();
	}
	function __get__text()
	{
		return this._sText;
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
		var2._btnYes.label = this.api.lang.getText("YES");
		var2._btnNo.label = this.api.lang.getText("NO");
		var2._btnYes.addEventListener("click",this);
		var2._btnNo.addEventListener("click",this);
		var2._txtText.addEventListener("change",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(§\x1e\x19\x18§)
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
	function change(§\x1e\x19\x18§)
	{
		var var3 = this._winBackground.content;
		var3._btnYes._y = var3._txtText._y + var3._txtText.height + 20;
		var3._btnNo._y = var3._txtText._y + var3._txtText.height + 20;
		this._winBackground.setPreferedSize();
	}
	function onShortcut(§\x1e\x0e\x04§)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.click({target:this._winBackground.content._btnYes});
			return false;
		}
		return true;
	}
}
