class dofus.graphics.gapi.ui.AskCustomShortcut extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskCustomShortcut";
	function AskCustomShortcut()
	{
		super();
	}
	function __set__ShortcutCode(var2)
	{
		this._sShortcutCode = var2;
		return this.__get__ShortcutCode();
	}
	function __set__IsAlt(var2)
	{
		this._bIsAlt = var2;
		return this.__get__IsAlt();
	}
	function __set__Description(var2)
	{
		this._sDescription = var2;
		this._winBackground.content._txtHelp.text = this._sDescription;
		return this.__get__Description();
	}
	function destroy()
	{
		this.api.ui.getUIComponent("Shortcuts").refresh();
		this.api.kernel.KeyManager.Broadcasting = true;
	}
	function initWindowContent()
	{
		var var2 = this._winBackground.content;
		var2._txtHelp.text = this.api.lang.getText("SHORTCUTS_CUSTOM_HELP",[this._sDescription]);
		var2._btnOk.label = this.api.lang.getText("OK");
		var2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		var2._btnReset.label = this.api.lang.getText("DEFAUT");
		var2._btnOk.addEventListener("click",this);
		var2._btnCancel.addEventListener("click",this);
		var2._btnReset.addEventListener("click",this);
		var2._btnNone.addEventListener("click",this);
		var var3 = this.api.kernel.KeyManager.getCurrentShortcut(this._sShortcutCode);
		if(this._bIsAlt)
		{
			var2._lblShortcut.text = var3.d2 != undefined?var3.d2:this.api.lang.getText("KEY_UNDEFINED");
		}
		else
		{
			var2._lblShortcut.text = var3.d != undefined?var3.d:this.api.lang.getText("KEY_UNDEFINED");
		}
		this.api.kernel.KeyManager.Broadcasting = false;
		Key.addListener(this);
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnOk":
				if(this._nKeyCode != undefined && !_global.isNaN(this._nKeyCode))
				{
					this.api.kernel.KeyManager.setCustomShortcut(this._sShortcutCode,this._bIsAlt,this._nKeyCode,this._nCtrlCode,this._sAscii);
				}
				this.unloadThis();
				break;
			case "_btnCancel":
				this.unloadThis();
				break;
			default:
				switch(null)
				{
					case "_btnReset":
						var var3 = this._winBackground.content;
						var var4 = this.api.kernel.KeyManager.getDefaultShortcut(this._sShortcutCode);
						if(!this._bIsAlt)
						{
							this._nKeyCode = var4.k;
							this._nCtrlCode = var4.c;
							var3._lblShortcut.text = var0 = var4.s != undefined?var4.s:this.api.lang.getText("KEY_UNDEFINED");
							this._sAscii = var0;
						}
						else
						{
							this._nKeyCode = var4.k2;
							this._nCtrlCode = var4.c2;
							var3._lblShortcut.text = var0 = var4.s2 != undefined?var4.s2:this.api.lang.getText("KEY_UNDEFINED");
							this._sAscii = var0;
						}
						break;
					case "_btnNone":
						var var5 = this._winBackground.content;
						this._nKeyCode = -1;
						this._nCtrlCode = undefined;
						var5._lblShortcut.text = var0 = this.api.lang.getText("KEY_UNDEFINED");
						this._sAscii = var0;
				}
		}
	}
	function onKeyUp()
	{
		var var2 = Key.getCode();
		var var3 = Key.getAscii();
		if(var2 == Key.CONTROL || var2 == Key.SHIFT)
		{
			return undefined;
		}
		this._nKeyCode = var2;
		var var4 = 0;
		if(Key.isDown(Key.CONTROL))
		{
			var4 = var4 + 1;
		}
		if(Key.isDown(Key.SHIFT))
		{
			var4 = var4 + 2;
		}
		this._nCtrlCode = var4;
		var var5 = "";
		if(var3 > 32 && var3 < 256)
		{
			var5 = String.fromCharCode(var3);
		}
		else
		{
			var5 = this.api.lang.getKeyStringFromKeyCode(var2);
		}
		var5 = this.api.lang.getControlKeyString(var4) + var5;
		this._sAscii = this._winBackground.content._lblShortcut.text = var5;
	}
}
