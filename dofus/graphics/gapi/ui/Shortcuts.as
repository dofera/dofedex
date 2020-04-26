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
		var loc2 = new ank.utils.();
		var loc3 = this.api.lang.getKeyboardShortcutsSets();
		loc3.sortOn("d");
		var loc4 = 0;
		while(loc4 < loc3.length)
		{
			if(loc3[loc4] != undefined)
			{
				loc2.push({label:loc3[loc4].d,id:loc3[loc4].i});
				if(loc3[loc4].i == this.api.kernel.OptionsManager.getOption("ShortcutSetDefault"))
				{
					this._cbSetList.selectedIndex = loc4;
				}
			}
			loc4 = loc4 + 1;
		}
		var loc5 = this.api.lang.getKeyboardShortcutsCategories();
		loc5.sortOn("o",Array.NUMERIC);
		var loc6 = this.api.lang.getKeyboardShortcuts();
		var loc7 = new ank.utils.();
		var loc8 = 0;
		while(loc8 < loc5.length)
		{
			if(loc5[loc8] != undefined)
			{
				loc7.push({c:true,d:loc5[loc8].d});
				for(var k in loc6)
				{
					if(loc6[k] != undefined)
					{
						if(!(k == "CONSOLE" && !this.api.datacenter.Player.isAuthorized))
						{
							if(loc6[k].c == loc5[loc8].i)
							{
								loc7.push({c:false,d:loc6[k].d,s:this.api.kernel.KeyManager.getCurrentShortcut(k),k:k,l:loc6[k].s});
							}
						}
					}
				}
			}
			loc8 = loc8 + 1;
		}
		this._lstShortcuts.dataProvider = loc7;
		this._cbSetList.dataProvider = loc2;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnClose":
			case "_btnClose2":
				this.callClose();
				break;
			case "_btnApplyDefault":
				this.api.kernel.showMessage(undefined,this.api.lang.getText("SHORTCUTS_RESET_TO_DEFAULT"),"CAUTION_YESNO",{listener:this});
		}
	}
	function itemSelected(loc2)
	{
		this.api.kernel.OptionsManager.setOption("ShortcutSetDefault",this._cbSetList.selectedItem.id);
	}
	function yes(loc2)
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
