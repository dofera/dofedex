class dofus.graphics.gapi.ui.AskOk extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskOk";
	function AskOk()
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
	function initWindowContent()
	{
		var var2 = this._winBackground.content;
		var2._btnOk.addEventListener("click",this);
		var2._txtText.addEventListener("change",this);
		var2._txtText.text = this._sText;
		var2._btnOk.label = this.api.lang.getText("OK");
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(var2)
	{
		this.api.kernel.KeyManager.removeShortcutsListener(this);
		this.dispatchEvent({type:"ok"});
		this.unloadThis();
	}
	function change(var2)
	{
		var var3 = this._winBackground.content;
		var3._btnOk._y = var3._txtText._y + var3._txtText.height + 20;
		this._winBackground.setPreferedSize();
	}
	function onShortcut(var2)
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
