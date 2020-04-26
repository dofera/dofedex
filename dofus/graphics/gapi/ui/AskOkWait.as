class dofus.graphics.gapi.ui.AskOkWait extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskOkWait";
	function AskOkWait()
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
		this._nWaitClosureDuration = 5;
		var loc2 = this._winBackground.content;
		var loc3 = loc2._btnOk;
		loc3.enabled = false;
		loc3.label = this.api.lang.getText("OK") + " (" + this._nWaitClosureDuration + ")";
		loc3.addEventListener("click",this);
		loc2._txtText.addEventListener("change",this);
		loc2._txtText.text = this._sText;
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
		this.startTimer();
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
		if(loc2 == "ACCEPT_CURRENT_DIALOG" && this._winBackground.content._btnOk.enabled)
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
		var loc2 = this._winBackground.content._btnOk;
		loc2.label = this.api.lang.getText("OK") + " (" + this._nWaitClosureDuration + ")";
		if(this._nWaitClosureDuration == 0)
		{
			loc2.label = this.api.lang.getText("OK");
			loc2.enabled = true;
			this.stopTimer();
		}
	}
}
