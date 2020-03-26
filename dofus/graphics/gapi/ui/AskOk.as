class dofus.graphics.gapi.ui.AskOk extends ank.gapi.ui.FlyWindow
{
   static var CLASS_NAME = "AskOk";
   function AskOk()
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
   function initWindowContent()
   {
      var _loc2_ = this._winBackground.content;
      _loc2_._btnOk.addEventListener("click",this);
      _loc2_._txtText.addEventListener("change",this);
      _loc2_._txtText.text = this._sText;
      _loc2_._btnOk.label = this.api.lang.getText("OK");
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function click(oEvent)
   {
      this.api.kernel.KeyManager.removeShortcutsListener(this);
      this.dispatchEvent({type:"ok"});
      this.unloadThis();
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
         Selection.setFocus();
         this.click();
         return false;
      }
      return true;
   }
}
