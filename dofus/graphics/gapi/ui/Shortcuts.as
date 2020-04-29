class dofus.graphics.gapi.ui.Shortcuts extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Shortcuts";
	function Shortcuts()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Shortcuts.CLASS_NAME);
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._winBg.title = this.api.lang.getText("KEYBORD_SHORTCUT");
		this._btnClose2.label = this.api.lang.getText("CLOSE");
		this._lblDescription.text = this.api.lang.getText("SHORTCUTS_DESCRIPTION");
		this._lblKeys.text = this.api.lang.getText("SHORTCUTS_KEYS");
		this._lblDefaultSet.text = this.api.lang.getText("SHORTCUTS_SET_CHOICE");
		this._btnApplyDefault.label = this.api.lang.getText("SHORTCUTS_APPLY_DEFAULT");
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnClose2.addEventListener("click",this);
		this._cbSetList.addEventListener("itemSelected",this);
		this._btnApplyDefault.addEventListener("click",this);
	}
	function initData()
	{
		var var2 = new ank.utils.();
		var var3 = this.api.lang.getKeyboardShortcutsSets();
		var3.sortOn("d");
		var var4 = 0;
		while(var4 < var3.length)
		{
			if(var3[var4] != undefined)
			{
				var2.push({label:var3[var4].d,id:var3[var4].i});
				if(var3[var4].i == this.api.kernel.OptionsManager.getOption("ShortcutSetDefault"))
				{
					this._cbSetList.selectedIndex = var4;
				}
			}
			var4 = var4 + 1;
		}
		var var5 = this.api.lang.getKeyboardShortcutsCategories();
		var5.sortOn("o",Array.NUMERIC);
		var var6 = this.api.lang.getKeyboardShortcuts();
		var var7 = new ank.utils.();
		var var8 = 0;
		while(var8 < var5.length)
		{
			if(var5[var8] != undefined)
			{
				var7.push({c:true,d:var5[var8].d});
				for(var k in var6)
				{
					if(var6[k] != undefined)
					{
						if(!(k == "CONSOLE" && !this.api.datacenter.Player.isAuthorized))
						{
							if(var6[k].c == var5[var8].i)
							{
								var7.push({c:false,d:var6[k].d,s:this.api.kernel.KeyManager.getCurrentShortcut(k),k:k,l:var6[k].s});
							}
						}
					}
				}
			}
			var8 = var8 + 1;
		}
		this._lstShortcuts.dataProvider = var7;
		this._cbSetList.dataProvider = var2;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			case "_btnApplyDefault":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("SHORTCUTS_RESET_TO_DEFAULT"),"CAUTION_YESNO",{listener:this});
		}
	}
	function itemSelected(var2)
	{
		this.api.kernel.OptionsManager.setOption("ShortcutSetDefault",this._cbSetList.selectedItem.id);
	}
	function yes(var2)
	{
		this.api.kernel.KeyManager.clearCustomShortcuts();
		this.api.kernel.OptionsManager.setOption("ShortcutSet",this._cbSetList.selectedItem.id);
		this.initData();
	}
	function refresh()
	{
		this.initData();
	}
}
