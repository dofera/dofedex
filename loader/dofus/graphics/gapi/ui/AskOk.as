class dofus.graphics.gapi.ui.AskOk extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskOk";
	function AskOk()
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
	function initWindowContent()
	{
		var var2 = this._winBackground.content;
		var2._btnOk.addEventListener("click",this);
		var2._txtText.addEventListener("change",this);
		var2._txtText.text = this._sText;
		var2._btnOk.label = this.api.lang.getText("OK");
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(§\x1e\x19\x18§)
	{
		this.api.kernel.KeyManager.removeShortcutsListener(this);
		this.dispatchEvent({type:"ok"});
		this.unloadThis();
	}
	function change(§\x1e\x19\x18§)
	{
		var var3 = this._winBackground.content;
		var3._btnOk._y = var3._txtText._y + var3._txtText.height + 20;
		this._winBackground.setPreferedSize();
	}
	function onShortcut(§\x1e\x0e\x04§)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG")
		{
			Selection.setFocus();
			this.click();
			return false;
		}
		return true;
	}
}
