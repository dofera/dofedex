class dofus.graphics.gapi.ui.AskAlertServer extends ank.gapi.ui.FlyWindow
{
   static var CLASS_NAME = "AskAlertServer";
   var _bHideNext = false;
   function AskAlertServer()
   {
      super();
   }
   function __set__text(sText)
   {
      this._sText = sText;
      return this.__get__text();
   }
   function __set__hideNext(bHideNext)
   {
      this._bHideNext = bHideNext;
      return this.__get__hideNext();
   }
   function initWindowContent()
   {
      var c = this._winBackground.content;
      c._btnClose.addEventListener("click",this);
      c._btnHideNext.addEventListener("click",this);
      c._txtText.text = this._sText;
      c._btnClose.label = this.api.lang.getText("CLOSE");
      c._lblHideNext.text = this.api.lang.getText("ALERT_HIDENEXT");
      SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).onStatus = function(oEvent)
      {
         if(oEvent.level == "status" && oEvent.code == "SharedObject.Flush.Success")
         {
            c._btnHideNext._visible = true;
            c._lblHideNext._visible = true;
            c._btnHideNext.enabled = true;
            c._btnHideNext.selected = false;
         }
      };
      if(SharedObject.getLocal(dofus.Constants.OPTIONS_SHAREDOBJECT_NAME).flush() != true)
      {
         c._btnHideNext.enabled = false;
         c._btnHideNext.selected = false;
         c._btnHideNext._visible = false;
         c._lblHideNext._visible = false;
      }
      else
      {
         c._btnHideNext.selected = this._bHideNext;
      }
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
            this.api.kernel.KeyManager.removeShortcutsListener(this);
            this.dispatchEvent({type:"close",hideNext:this._bHideNext});
            this.unloadThis();
            break;
         case "_btnHideNext":
            this._bHideNext = oEvent.target.selected;
      }
   }
   function change(oEvent)
   {
      var _loc3_ = this._winBackground.content;
      _loc3_._btnOk._y = _loc3_._txtText._y + _loc3_._txtText.height + 20;
      this._winBackground.setPreferedSize();
   }
   function onShortcut(sShortcut)
   {
      if(sShortcut == "ACCEPT_CURRENT_DIALOG")
      {
         this.click(this._winBackground.content._btnClose);
         return false;
      }
      return true;
   }
}
