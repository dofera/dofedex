class dofus.graphics.gapi.ui.AskGameBegin extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "AskGameBegin";
   function AskGameBegin()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.AskGameBegin.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function addListeners()
   {
      this._btnOk.addEventListener("click",this);
   }
   function initTexts()
   {
      this._btnOk.label = this.api.lang.getText("OK");
      this._winBackground.title = this.api.lang.getText("POPUP_GAME_BEGINNING_TITLE");
      this._lblTitle.text = this.api.lang.getText("POPUP_GAME_BEGINNING_SUBTITLE");
      this._lblIncarnam.text = this.api.lang.getText("POPUP_GAME_BEGINNING_PARAGRAPH1");
      this._lblTemple.text = this.api.lang.getText("POPUP_GAME_BEGINNING_PARAGRAPH2");
      this._lblBoon.text = this.api.lang.getText("POPUP_GAME_BEGINNING_PARAGRAPH3");
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_btnOk")
      {
         this.api.kernel.TipsManager.showNewTip(dofus.managers.TipsManager.TIP_START_POPUP);
         this.dispatchEvent({type:"ok",params:this.params});
         this.unloadThis();
      }
   }
}
