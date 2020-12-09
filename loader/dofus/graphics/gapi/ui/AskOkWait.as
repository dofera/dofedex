class dofus.graphics.gapi.ui.AskOkWait extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskOkWait";
	function AskOkWait()
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
		this._nWaitClosureDuration = 5;
		var var2 = this._winBackground.content;
		var var3 = var2._btnOk;
		var3.enabled = false;
		var3.label = this.api.lang.getText("OK") + " (" + this._nWaitClosureDuration + ")";
		var3.addEventListener("click",this);
		var2._txtText.addEventListener("change",this);
		var2._txtText.text = this._sText;
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		this.startTimer();
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
		if(var2 == "ACCEPT_CURRENT_DIALOG" && this._winBackground.content._btnOk.enabled)
		{
			Selection.setFocus();
			this.click();
		}
		return false;
	}
	function startTimer()
	{
		this.stopTimer();
		this._nInterval = _global.setInterval(this,"updateTimer",1000);
	}
	function stopTimer()
	{
		_global.clearInterval(this._nInterval);
	}
	function updateTimer()
	{
		this._nWaitClosureDuration = this._nWaitClosureDuration - 1;
		var var2 = this._winBackground.content._btnOk;
		var2.label = this.api.lang.getText("OK") + " (" + this._nWaitClosureDuration + ")";
		if(this._nWaitClosureDuration == 0)
		{
			var2.label = this.api.lang.getText("OK");
			var2.enabled = true;
			this.stopTimer();
		}
	}
}
