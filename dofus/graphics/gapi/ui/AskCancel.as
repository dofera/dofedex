class dofus.graphics.gapi.ui.AskCancel extends ank.gapi.ui.FlyWindow
{
   static var CLASS_NAME = "AskCancel";
   function AskCancel()
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
      _loc2_._txtText.text = this._sText;
      _loc2_._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
      _loc2_._btnCancel.addEventListener("click",this);
      _loc2_._txtText.addEventListener("change",this);
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_btnCancel")
      {
         this.dispatchEvent({type:"cancel",params:this.params});
      }
      this.unloadThis();
   }
   function change(oEvent)
   {
      var _loc3_ = this._winBackground.content;
      _loc3_._btnCancel._y = _loc3_._txtText._y + _loc3_._txtText.height + 20;
      this._winBackground.setPreferedSize();
   }
}
