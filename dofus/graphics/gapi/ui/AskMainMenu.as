class dofus.graphics.gapi.ui.AskMainMenu extends ank.gapi.ui.FlyWindow
{
   static var CLASS_NAME = "AskMainMenu";
   function AskMainMenu()
   {
      super();
   }
   function initWindowContent()
   {
      this._winBackground.title = this.api.lang.getText("MENU");
      var _loc2_ = this._winBackground.content;
      _loc2_._btnChange.label = this.api.lang.getText("CHANGE_CHARACTER");
      _loc2_._btnDisconnect.label = this.api.lang.getText("LOGOFF");
      _loc2_._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
      _loc2_._btnQuit.label = this.api.lang.getText("QUIT_DOFUS");
      _loc2_._btnChange.addEventListener("click",this);
      _loc2_._btnDisconnect.addEventListener("click",this);
      _loc2_._btnCancel.addEventListener("click",this);
      _loc2_._btnQuit.addEventListener("click",this);
      this.setEnabledBtnQuit(System.capabilities.playerType == "StandAlone" || this.api.electron.enabled);
      this.setEnabledBtnChange(this.api.ui.getUIComponent("Banner") != undefined);
   }
   function setEnabledBtnChange(bEnable)
   {
      var _loc3_ = this._winBackground.content._btnChange;
      _loc3_.enabled = bEnable;
   }
   function setEnabledBtnQuit(bEnable)
   {
      var _loc3_ = this._winBackground.content._btnQuit;
      _loc3_.enabled = bEnable;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnChange":
            this.api.kernel.changeServer();
            break;
         case "_btnDisconnect":
            this.api.kernel.disconnect();
            break;
         case "_btnQuit":
            this.api.kernel.quit();
      }
      this.unloadThis();
   }
}
