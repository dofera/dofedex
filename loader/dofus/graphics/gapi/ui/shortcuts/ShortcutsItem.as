class dofus.graphics.gapi.ui.shortcuts.ShortcutsItem extends ank.gapi.core.UIBasicComponent
{
	function ShortcutsItem()
	{
		super();
	}
	function setValue(var2, var3, var4)
	{
		if(var2)
		{
			if(var4.c)
			{
				this._btnMain._visible = false;
				this._btnAlt._visible = false;
				this._rctCatBg._visible = true;
				this._lblDescription.styleName = "GrayLeftSmallBoldLabel";
				this._lblDescription.text = var4.d;
			}
			else
			{
				var var5 = _global.API;
				this._btnMain._visible = true;
				this._btnAlt._visible = true;
				this._rctCatBg._visible = false;
				this._lblDescription.styleName = "BrownLeftSmallLabel";
				this._lblDescription.text = "    " + var4.d;
				if(var4.s.k != undefined)
				{
					if(var4.s.d == undefined || (var4.s.d == "" || new ank.utils.(var4.s.d).trim().toString() == ""))
					{
						this._btnMain.label = var5.lang.getControlKeyString(var4.s.c) + var5.lang.getKeyStringFromKeyCode(var4.s.k);
					}
					else
					{
						this._btnMain.label = var4.s.d;
					}
				}
				else
				{
					this._btnMain.label = var5.lang.getText("KEY_UNDEFINED");
				}
				if(var4.s.k2 != undefined)
				{
					if(var4.s.d2 == undefined || (var4.s.d2 == "" || new ank.utils.(var4.s.d2).trim().toString() == ""))
					{
						this._btnAlt.label = var5.lang.getControlKeyString(var4.s.c2) + var5.lang.getKeyStringFromKeyCode(var4.s.k2);
					}
					else
					{
						this._btnAlt.label = var4.s.d2;
					}
				}
				else
				{
					this._btnAlt.label = var5.lang.getText("KEY_UNDEFINED");
				}
				this._btnMain.enabled = this._btnAlt.enabled = !var4.l;
			}
			this._sShortcut = var4.k;
		}
		else if(this._lblDescription.text != undefined)
		{
			this._lblDescription.styleName = "BrownLeftSmallLabel";
			this._lblDescription.text = "";
			this._rctCatBg._visible = false;
			this._btnMain._visible = false;
			this._btnMain.label = "";
			this._btnAlt._visible = false;
			this._btnAlt.label = "";
			this._sShortcut = undefined;
		}
	}
	function init()
	{
		super.init(false);
		this._rctCatBg._visible = false;
		this._btnMain._visible = false;
		this._btnAlt._visible = false;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnMain.addEventListener("click",this);
		this._btnAlt.addEventListener("click",this);
	}
	function click(var2)
	{
		if(this._sShortcut == undefined)
		{
			return undefined;
		}
		var var3 = _global.API;
		switch(var2.target._name)
		{
			case "_btnMain":
				var3.kernel.KeyManager.askCustomShortcut(this._sShortcut,false);
				break;
			case "_btnAlt":
				var3.kernel.KeyManager.askCustomShortcut(this._sShortcut,true);
		}
	}
}
