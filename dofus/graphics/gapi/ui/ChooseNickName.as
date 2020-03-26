class dofus.graphics.gapi.ui.ChooseNickName extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ChooseNickName";
   var isConfirming = false;
   function ChooseNickName()
   {
      super();
   }
   function __set__nickAlreadyUsed(bUsed)
   {
      this._lblError._visible = bUsed;
      if(bUsed)
      {
         this.state = 1;
      }
      else
      {
         this.state = 0;
      }
      return this.__get__nickAlreadyUsed();
   }
   function __set__state(nState)
   {
      this._nState = nState;
      switch(this._nState)
      {
         case 0:
            this._mcNickBg._visible = true;
            this._lblError._visible = false;
            this._tiNickName._visible = true;
            this._txtHelp._visible = true;
            this._txtHelp2._visible = false;
            this._tiNickName.setFocus();
            this._txtHelp.text = this.api.lang.getText("CHOOSE_NICKNAME_HELP");
            break;
         case 1:
            this._mcNickBg._visible = true;
            this._lblError._visible = true;
            this._tiNickName._visible = true;
            this._txtHelp._visible = true;
            this._txtHelp2._visible = false;
            this._tiNickName.setFocus();
            this._txtHelp.text = this.api.lang.getText("CHOOSE_NICKNAME_HELP");
            break;
         case 2:
            this._mcNickBg._visible = false;
            this._lblError._visible = false;
            this._tiNickName._visible = false;
            this._txtHelp._visible = false;
            this._txtHelp2._visible = true;
            this._txtHelp2.text = this.api.lang.getText("DO_CHOOSE_NICKNAME",[this._tiNickName.text]);
      }
      return this.__get__state();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ChooseNickName.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initInterface});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function initTexts()
   {
      this._btnOk.label = this.api.lang.getText("OK");
      this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
      this._lblError.text = this.api.lang.getText("NICKNAME_ALREADY_USED");
      this._lblTitle.text = this.api.lang.getText("CHOOSE_NICKNAME");
   }
   function addListeners()
   {
      this._btnOk.addEventListener("click",this);
      this._btnCancel.addEventListener("click",this);
      this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
      this.api.kernel.StreamingDisplayManager.onNicknameChoice();
   }
   function initInterface()
   {
      this.state = 0;
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnOk":
            var _loc3_ = this._tiNickName.text;
            if(_loc3_.length > 2)
            {
               if(_loc3_.toUpperCase() == this.api.datacenter.Player.login.toUpperCase())
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("NICKNAME_EQUALS_LOGIN"),"ERROR_BOX");
               }
               else
               {
                  if(this._nState == 2)
                  {
                     this.api.network.Account.setNickName(this._tiNickName.text);
                     return undefined;
                  }
                  this.state = 2;
                  return undefined;
               }
            }
            break;
         case "_btnCancel":
            if(this._nState == 2)
            {
               this.state = 0;
               return undefined;
            }
            this.api.network.disconnect(false,false);
            this.api.kernel.manualLogon();
            this.unloadThis();
            break;
      }
   }
   function onShortcut(sShortcut)
   {
      if(sShortcut == "ACCEPT_CURRENT_DIALOG" || sShortcut == "CTRL_STATE_CHANGED_OFF")
      {
         this.click({target:this._btnOk});
         return false;
      }
      return true;
   }
}
