class dofus.graphics.gapi.ui.CenterInfo extends dofus.graphics.gapi.ui.CenterText
{
   static var CLASS_NAME = "CenterInfo";
   function CenterInfo()
   {
      super();
   }
   function __set__textInfo(sText)
   {
      this._sDesc = sText;
      return this.__get__textInfo();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.CenterInfo.CLASS_NAME);
   }
   function initText()
   {
      super.initText();
      this._lblWhiteDesc.text = this._sDesc;
   }
}
