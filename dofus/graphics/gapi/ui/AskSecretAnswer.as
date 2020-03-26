class dofus.graphics.gapi.ui.AskSecretAnswer extends ank.gapi.ui.FlyWindow
{
   static var CLASS_NAME = "AskSecretAnswer";
   var isConfirming = false;
   function AskSecretAnswer()
   {
      super();
   }
   function __get__charToDelete()
   {
      return this._char;
   }
   function __set__charToDelete(c)
   {
      this._char = c;
      return this.__get__charToDelete();
   }
   function initWindowContent()
   {
      var _loc2_ = this._winBackground.content;
      _loc2_._txtHelp.text = this.api.lang.getText("DELETING_CHARACTER_ANSWER") + "\r\n" + _global.unescape(this.api.datacenter.Basics.aks_secret_question);
      _loc2_._btnOk.label = this.api.lang.getText("OK");
      _loc2_._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
      _loc2_._btnOk.addEventListener("click",this);
      _loc2_._btnCancel.addEventListener("click",this);
      _loc2_._tiNickName.setFocus();
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnOk":
            var _loc3_ = this._winBackground.content._tiNickName.text;
            if(_loc3_.length > 0)
            {
               this.api.kernel.showMessage(this.api.lang.getText("DELETE_WORD"),this.api.lang.getText("DO_U_DELETE_A",[this._char.name]),"CAUTION_YESNO",{name:"SecretAnswer",params:{nickname:_loc3_},listener:this});
            }
            break;
         case "_btnCancel":
            this.unloadThis();
      }
   }
   function onShortcut(sShortcut)
   {
      if(sShortcut == "ACCEPT_CURRENT_DIALOG" && this.api.ui.getUIComponent("AskYesNoSecretAnswer") == undefined)
      {
         this.click({target:this._winBackground.content._btnOk});
         return false;
      }
      return true;
   }
   function yes(oEvent)
   {
      this.api.network.Account.deleteCharacter(this._char.id,oEvent.params.nickname);
      this.unloadThis();
   }
   function no(oEvent)
   {
      this.unloadThis();
   }
}
