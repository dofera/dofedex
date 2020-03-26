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
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = this.api.lang.getKeyboardShortcutsSets();
      _loc3_.sortOn("d");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         if(_loc3_[_loc4_] != undefined)
         {
            _loc2_.push({label:_loc3_[_loc4_].d,id:_loc3_[_loc4_].i});
            if(_loc3_[_loc4_].i == this.api.kernel.OptionsManager.getOption("ShortcutSetDefault"))
            {
               this._cbSetList.selectedIndex = _loc4_;
            }
         }
         _loc4_ = _loc4_ + 1;
      }
      var _loc5_ = this.api.lang.getKeyboardShortcutsCategories();
      _loc5_.sortOn("o",Array.NUMERIC);
      var _loc6_ = this.api.lang.getKeyboardShortcuts();
      var _loc7_ = new ank.utils.ExtendedArray();
      var _loc8_ = 0;
      while(_loc8_ < _loc5_.length)
      {
         if(_loc5_[_loc8_] != undefined)
         {
            _loc7_.push({c:true,d:_loc5_[_loc8_].d});
            for(var k in _loc6_)
            {
               if(_loc6_[k] != undefined)
               {
                  if(!(k == "CONSOLE" && !this.api.datacenter.Player.isAuthorized))
                  {
                     if(_loc6_[k].c == _loc5_[_loc8_].i)
                     {
                        _loc7_.push({c:false,d:_loc6_[k].d,s:this.api.kernel.KeyManager.getCurrentShortcut(k),k:k,l:_loc6_[k].s});
                     }
                  }
               }
            }
         }
         _loc8_ = _loc8_ + 1;
      }
      this._lstShortcuts.dataProvider = _loc7_;
      this._cbSetList.dataProvider = _loc2_;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
         case "_btnClose2":
            this.callClose();
            break;
         case "_btnApplyDefault":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("SHORTCUTS_RESET_TO_DEFAULT"),"CAUTION_YESNO",{listener:this});
      }
   }
   function itemSelected(oEvent)
   {
      this.api.kernel.OptionsManager.setOption("ShortcutSetDefault",this._cbSetList.selectedItem.id);
   }
   function yes(oEvent)
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
