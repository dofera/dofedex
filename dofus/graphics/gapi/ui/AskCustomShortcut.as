class dofus.graphics.gapi.ui.AskCustomShortcut extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskCustomShortcut";
	function AskCustomShortcut()
	{
		super();
	}
	function __set__ShortcutCode(loc2)
	{
		this._sShortcutCode = loc2;
		return this.__get__ShortcutCode();
	}
	function __set__IsAlt(loc2)
	{
		this._bIsAlt = loc2;
		return this.__get__IsAlt();
	}
	function __set__Description(loc2)
	{
		this._sDescription = loc2;
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
		var loc2 = this._winBackground.content;
		loc2._txtHelp.text = this.api.lang.getText("SHORTCUTS_CUSTOM_HELP",[this._sDescription]);
		loc2._btnOk.label = this.api.lang.getText("OK");
		loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		loc2._btnReset.label = this.api.lang.getText("DEFAUT");
		loc2._btnOk.addEventListener("click",this);
		loc2._btnCancel.addEventListener("click",this);
		loc2._btnReset.addEventListener("click",this);
		loc2._btnNone.addEventListener("click",this);
		var loc3 = this.api.kernel.KeyManager.getCurrentShortcut(this._sShortcutCode);
		if(this._bIsAlt)
		{
			loc2._lblShortcut.text = loc3.d2 != undefined?loc3.d2:this.api.lang.getText("KEY_UNDEFINED");
		}
		else
		{
			loc2._lblShortcut.text = loc3.d != undefined?loc3.d:this.api.lang.getText("KEY_UNDEFINED");
		}
		this.api.kernel.KeyManager.Broadcasting = false;
		Key.addListener(this);
	}
	function click(loc2)
	{
		switch(loc2.target._name)
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
			case "_btnReset":
				var loc3 = this._winBackground.content;
				var loc4 = this.api.kernel.KeyManager.getDefaultShortcut(this._sShortcutCode);
				if(!this._bIsAlt)
				{
					this._nKeyCode = loc4.k;
					this._nCtrlCode = loc4.c;
					loc3._lblShortcut.text = loc0 = loc4.s != undefined?loc4.s:this.api.lang.getText("KEY_UNDEFINED");
					this._sAscii = loc0;
				}
				else
				{
					this._nKeyCode = loc4.k2;
					this._nCtrlCode = loc4.c2;
					loc3._lblShortcut.text = loc0 = loc4.s2 != undefined?loc4.s2:this.api.lang.getText("KEY_UNDEFINED");
					this._sAscii = loc0;
				}
				break;
			default:
				if(loc0 !== "_btnNone")
				{
					break;
				}
				var loc5 = this._winBackground.content;
				this._nKeyCode = -1;
				this._nCtrlCode = undefined;
				loc5._lblShortcut.text = loc0 = this.api.lang.getText("KEY_UNDEFINED");
				this._sAscii = loc0;
				break;
		}
	}
	function onKeyUp()
	{
		var loc2 = Key.getCode();
		var loc3 = Key.getAscii();
		if(loc2 == Key.CONTROL || loc2 == Key.SHIFT)
		{
			return undefined;
		}
		this._nKeyCode = loc2;
		var loc4 = 0;
		if(Key.isDown(Key.CONTROL))
		{
			loc4 = loc4 + 1;
		}
		if(Key.isDown(Key.SHIFT))
		{
			loc4 = loc4 + 2;
		}
		this._nCtrlCode = loc4;
		var loc5 = "";
		if(loc3 > 32 && loc3 < 256)
		{
			loc5 = String.fromCharCode(loc3);
		}
		else
		{
			loc5 = this.api.lang.getKeyStringFromKeyCode(loc2);
		}
		loc5 = this.api.lang.getControlKeyString(loc4) + loc5;
		this._sAscii = this._winBackground.content._lblShortcut.text = loc5;
	}
}
