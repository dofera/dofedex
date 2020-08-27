class dofus.graphics.gapi.ui.AskAlertServer extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskAlertServer";
	var _bHideNext = false;
	function AskAlertServer()
	{
		super();
	}
	function __set__text(var2)
	{
		this._sText = var2;
		return this.__get__text();
	}
	function __set__hideNext(var2)
	{
		this._bHideNext = var2;
		return this.__get__hideNext();
	}
	function initWindowContent()
	{
		var c = this._winBackground.content;
		c._btnClose.addEventListener("click",this);
		c._btnHideNext.addEventListener("click",this);
		c._txtText.text = this._sText;
		c._btnClose.label = this.api.lang.getText("CLOSE");
		c._lblHideNext.text = this.api.lang.getText("ALERT_HIDENEXT");
		SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).onStatus = function(var2)
		{
			if(var2.level == "status" && var2.code == "SharedObject.Flush.Success")
			{
				c._btnHideNext._visible = true;
				c._lblHideNext._visible = true;
				c._btnHideNext.enabled = true;
				c._btnHideNext.selected = false;
			}
		};
		if(SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).flush() != true)
		{
			c._btnHideNext.enabled = false;
			c._btnHideNext.selected = false;
			c._btnHideNext._visible = false;
			c._lblHideNext._visible = false;
		}
		else
		{
			c._btnHideNext.selected = this._bHideNext;
		}
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
				this.api.kernel.KeyManager.removeShortcutsListener(this);
				this.dispatchEvent({type:"close",hideNext:this._bHideNext});
				this.unloadThis();
				break;
			case "_btnHideNext":
				this._bHideNext = var2.target.selected;
		}
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
			this.click(this._winBackground.content._btnClose);
			return false;
		}
		return true;
	}
}
