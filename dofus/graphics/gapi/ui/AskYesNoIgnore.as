class dofus.graphics.gapi.ui.AskYesNoIgnore extends ank.gapi.ui.FlyWindow
{
   static var CLASS_NAME = "AskYesNoIgnore";
   function AskYesNoIgnore()
   {
      super();
   }
   function __set__text(sText)
   {
      this._sText = sText;
      return this.__get__text();
   }
   function __get__text()
   {
      return this._sText;
   }
   function __set__player(sPlayer)
   {
      this._sPlayer = sPlayer;
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
      var _loc2_ = this._winBackground.content;
      _loc2_._txtText.text = this._sText;
      _loc2_._txtIgnore.text = "<u><font color=\'" + 255 + "\'><a href=\'asfunction:onHref,\'>" + this.api.lang.getText("POPUP_ADD_IGNORE",[this._sPlayer]) + "</a></font></u>";
      _loc2_._txtIgnore.addEventListener("href",this);
      _loc2_._btnYes.label = this.api.lang.getText("YES");
      _loc2_._btnNo.label = this.api.lang.getText("NO");
      _loc2_._btnYes.addEventListener("click",this);
      _loc2_._btnNo.addEventListener("click",this);
      _loc2_._txtText.addEventListener("change",this);
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnYes":
            this.dispatchEvent({type:"yes",params:this.params});
            break;
         case "_btnNo":
            this.dispatchEvent({type:"no",params:this.params});
      }
      this.unloadThis();
   }
   function change(oEvent)
   {
      var _loc3_ = this._winBackground.content;
      _loc3_._btnYes._y = _loc3_._txtText._y + _loc3_._txtText.height + 20;
      _loc3_._btnNo._y = _loc3_._txtText._y + _loc3_._txtText.height + 20;
      _loc3_._txtIgnore._y = _loc3_._btnNo._y + _loc3_._btnNo.height + 10;
      this._winBackground.setPreferedSize();
   }
   function onShortcut(sShortcut)
   {
      if(sShortcut == "ACCEPT_CURRENT_DIALOG")
      {
         this.click({target:this._winBackground.content._btnYes});
         return false;
      }
      return true;
   }
   function href(oEvent)
   {
      this.params.player = this._sPlayer;
      this.dispatchEvent({type:"ignore",params:this.params});
      this.unloadThis();
   }
}
