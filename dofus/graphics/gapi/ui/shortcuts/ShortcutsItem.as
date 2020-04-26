class dofus.graphics.gapi.ui.shortcuts.ShortcutsItem extends ank.gapi.core.UIBasicComponent
{
	function ShortcutsItem()
	{
		super();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			if(loc4.c)
			{
				this._btnMain._visible = false;
				this._btnAlt._visible = false;
				this._rctCatBg._visible = true;
				this._lblDescription.styleName = "GrayLeftSmallBoldLabel";
				this._lblDescription.text = loc4.d;
			}
			else
			{
				var loc5 = _global.API;
				this._btnMain._visible = true;
				this._btnAlt._visible = true;
				this._rctCatBg._visible = false;
				this._lblDescription.styleName = "BrownLeftSmallLabel";
				this._lblDescription.text = "    " + loc4.d;
				if(loc4.s.k != undefined)
				{
					if(loc4.s.d == undefined || (loc4.s.d == "" || new ank.utils.(loc4.s.d).trim().toString() == ""))
					{
						this._btnMain.label = loc5.lang.getControlKeyString(loc4.s.c) + loc5.lang.getKeyStringFromKeyCode(loc4.s.k);
					}
					else
					{
						this._btnMain.label = loc4.s.d;
					}
				}
				else
				{
					this._btnMain.label = loc5.lang.getText("KEY_UNDEFINED");
				}
				if(loc4.s.k2 != undefined)
				{
					if(loc4.s.d2 == undefined || (loc4.s.d2 == "" || new ank.utils.(loc4.s.d2).trim().toString() == ""))
					{
						this._btnAlt.label = loc5.lang.getControlKeyString(loc4.s.c2) + loc5.lang.getKeyStringFromKeyCode(loc4.s.k2);
					}
					else
					{
						this._btnAlt.label = loc4.s.d2;
					}
				}
				else
				{
					this._btnAlt.label = loc5.lang.getText("KEY_UNDEFINED");
				}
				this._btnMain.enabled = this._btnAlt.enabled = !loc4.l;
			}
			this._sShortcut = loc4.k;
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
	function click(loc2)
	{
		if(this._sShortcut == undefined)
		{
			return undefined;
		}
		var loc3 = _global.API;
		switch(loc2.target._name)
		{
			case "_btnMain":
				loc3.kernel.KeyManager.askCustomShortcut(this._sShortcut,false);
				break;
			case "_btnAlt":
				loc3.kernel.KeyManager.askCustomShortcut(this._sShortcut,true);
		}
	}
}
