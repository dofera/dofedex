class dofus.graphics.gapi.ui.AskCustomShortcut extends ank.gapi.ui.FlyWindow
{
   static var CLASS_NAME = "AskCustomShortcut";
   function AskCustomShortcut()
   {
      super();
   }
   function __set__ShortcutCode(sShortcutCode)
   {
      this._sShortcutCode = sShortcutCode;
      return this.__get__ShortcutCode();
   }
   function __set__IsAlt(bIsAlt)
   {
      this._bIsAlt = bIsAlt;
      return this.__get__IsAlt();
   }
   function __set__Description(sDescription)
   {
      this._sDescription = sDescription;
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
      var _loc2_ = this._winBackground.content;
      _loc2_._txtHelp.text = this.api.lang.getText("SHORTCUTS_CUSTOM_HELP",[this._sDescription]);
      _loc2_._btnOk.label = this.api.lang.getText("OK");
      _loc2_._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
      _loc2_._btnReset.label = this.api.lang.getText("DEFAUT");
      _loc2_._btnOk.addEventListener("click",this);
      _loc2_._btnCancel.addEventListener("click",this);
      _loc2_._btnReset.addEventListener("click",this);
      _loc2_._btnNone.addEventListener("click",this);
      var _loc3_ = this.api.kernel.KeyManager.getCurrentShortcut(this._sShortcutCode);
      if(this._bIsAlt)
      {
         _loc2_._lblShortcut.text = _loc3_.d2 != undefined?_loc3_.d2:this.api.lang.getText("KEY_UNDEFINED");
      }
      else
      {
         _loc2_._lblShortcut.text = _loc3_.d != undefined?_loc3_.d:this.api.lang.getText("KEY_UNDEFINED");
      }
      this.api.kernel.KeyManager.Broadcasting = false;
      Key.addListener(this);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
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
            var _loc3_ = this._winBackground.content;
            var _loc4_ = this.api.kernel.KeyManager.getDefaultShortcut(this._sShortcutCode);
            if(!this._bIsAlt)
            {
               this._nKeyCode = _loc4_.k;
               this._nCtrlCode = _loc4_.c;
               _loc3_._lblShortcut.text = _loc0_ = _loc4_.s != undefined?_loc4_.s:this.api.lang.getText("KEY_UNDEFINED");
               this._sAscii = _loc0_;
            }
            else
            {
               this._nKeyCode = _loc4_.k2;
               this._nCtrlCode = _loc4_.c2;
               _loc3_._lblShortcut.text = _loc0_ = _loc4_.s2 != undefined?_loc4_.s2:this.api.lang.getText("KEY_UNDEFINED");
               this._sAscii = _loc0_;
            }
            break;
         case "_btnNone":
            var _loc5_ = this._winBackground.content;
            this._nKeyCode = -1;
            this._nCtrlCode = undefined;
            _loc5_._lblShortcut.text = _loc0_ = this.api.lang.getText("KEY_UNDEFINED");
            this._sAscii = _loc0_;
      }
   }
   function onKeyUp()
   {
      var _loc2_ = Key.getCode();
      var _loc3_ = Key.getAscii();
      if(_loc2_ == Key.CONTROL || _loc2_ == Key.SHIFT)
      {
         return undefined;
      }
      this._nKeyCode = _loc2_;
      var _loc4_ = 0;
      if(Key.isDown(Key.CONTROL))
      {
         _loc4_ = _loc4_ + 1;
      }
      if(Key.isDown(Key.SHIFT))
      {
         _loc4_ = _loc4_ + 2;
      }
      this._nCtrlCode = _loc4_;
      var _loc5_ = "";
      if(_loc3_ > 32 && _loc3_ < 256)
      {
         _loc5_ = String.fromCharCode(_loc3_);
      }
      else
      {
         _loc5_ = this.api.lang.getKeyStringFromKeyCode(_loc2_);
      }
      _loc5_ = this.api.lang.getControlKeyString(_loc4_) + _loc5_;
      this._sAscii = this._winBackground.content._lblShortcut.text = _loc5_;
   }
}
