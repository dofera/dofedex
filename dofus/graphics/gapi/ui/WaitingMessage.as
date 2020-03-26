class dofus.graphics.gapi.ui.WaitingMessage extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "WaitingMessage";
   var _sText = "";
   function WaitingMessage()
   {
      super();
   }
   function __set__text(sText)
   {
      this._sText = sText;
      return this.__get__text();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.WaitingMessage.CLASS_NAME);
   }
   function createChildren()
   {
      if(this._sText.length == 0)
      {
         return undefined;
      }
      this.addToQueue({object:this,method:this.initText});
   }
   function initText()
   {
      this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this._sText;
   }
}
