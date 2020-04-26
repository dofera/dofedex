class dofus.graphics.gapi.ui.AskYesNoIgnore extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskYesNoIgnore";
	function AskYesNoIgnore()
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
	function __set__player(loc2)
	{
		this._sPlayer = loc2;
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
		var loc2 = this._winBackground.content;
		loc2._txtText.text = this._sText;
		loc2._txtIgnore.text = "<u><font color=\'" + 255 + "\'><a href=\'asfunction:onHref,\'>" + this.api.lang.getText("POPUP_ADD_IGNORE",[this._sPlayer]) + "</a></font></u>";
		loc2._txtIgnore.addEventListener("href",this);
		loc2._btnYes.label = this.api.lang.getText("YES");
		loc2._btnNo.label = this.api.lang.getText("NO");
		loc2._btnYes.addEventListener("click",this);
		loc2._btnNo.addEventListener("click",this);
		loc2._txtText.addEventListener("change",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnYes":
				this.dispatchEvent({type:"yes",params:this.params});
				break;
			case "_btnNo":
				this.dispatchEvent({type:"no",params:this.params});
		}
		this.unloadThis();
	}
	function change(loc2)
	{
		var loc3 = this._winBackground.content;
		loc3._btnYes._y = loc3._txtText._y + loc3._txtText.height + 20;
		loc3._btnNo._y = loc3._txtText._y + loc3._txtText.height + 20;
		loc3._txtIgnore._y = loc3._btnNo._y + loc3._btnNo.height + 10;
		this._winBackground.setPreferedSize();
	}
	function onShortcut(loc2)
	{
		if(loc2 == "ACCEPT_CURRENT_DIALOG")
		{
			this.click({target:this._winBackground.content._btnYes});
			return false;
		}
		return true;
	}
	function href(loc2)
	{
		this.params.player = this._sPlayer;
		this.dispatchEvent({type:"ignore",params:this.params});
		this.unloadThis();
	}
}
