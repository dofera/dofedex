class dofus.graphics.gapi.ui.AskOk extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskOk";
	function AskOk()
	{
		super();
	}
	function __set__text(loc2)
	{
		this._sText = loc2;
		return this.__get__text();
	}
	function __get__text()
	{
		return this._sText;
	}
	function initWindowContent()
	{
		var loc2 = this._winBackground.content;
		loc2._btnOk.addEventListener("click",this);
		loc2._txtText.addEventListener("change",this);
		loc2._txtText.text = this._sText;
		loc2._btnOk.label = this.api.lang.getText("OK");
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(loc2)
	{
		this.api.kernel.KeyManager.removeShortcutsListener(this);
		this.dispatchEvent({type:"ok"});
		this.unloadThis();
	}
	function change(loc2)
	{
		var loc3 = this._winBackground.content;
		loc3._btnOk._y = loc3._txtText._y + loc3._txtText.height + 20;
		this._winBackground.setPreferedSize();
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG")
		{
			Selection.setFocus();
			this.click();
			return false;
		}
		return true;
	}
}
