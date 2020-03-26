class dofus.graphics.gapi.ui.PayZoneDialog2 extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "PayZoneDialog2";
   function PayZoneDialog2()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.PayZoneDialog2.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function addListeners()
   {
      this._btnMoreInfo.onRelease = this.linkTo(this.api);
   }
   function linkTo(api)
   {
      return function()
      {
         getURL(api.lang.getConfigText("MEMBERS_LINK"),"_blank");
      };
   }
   function initTexts()
   {
      this._lblTitle.text = this.api.lang.getText("PAY_ZONE_TITLE");
      this._taContent.text = this.api.lang.getText("PAY_ZONE_DESC");
      this._btnMoreInfo._label.text = this.api.lang.getText("PAY_ZONE_BTN");
   }
}
