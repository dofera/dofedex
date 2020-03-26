class dofus.graphics.gapi.ui.ChooseCharacter extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ChooseCharacter";
   function ChooseCharacter()
   {
      super();
   }
   function __set__spriteList(aSpriteList)
   {
      this._aSpriteList = aSpriteList;
      if(this.initialized)
      {
         this.initData();
      }
      return this.__get__spriteList();
   }
   function __set__remainingTime(nRemainingTime)
   {
      this._nRemainingTime = nRemainingTime;
      return this.__get__remainingTime();
   }
   function __set__showComboBox(bShowComboBox)
   {
      this._bShowComboBox = bShowComboBox;
      return this.__get__showComboBox();
   }
   function __set__characterCount(nCharacterCount)
   {
      this._nCharacterCount = nCharacterCount;
      return this.__get__characterCount();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ChooseCharacter.CLASS_NAME);
      if(this.api.datacenter.Basics.aks_is_free_community)
      {
         this._btnSubscribe._visible = false;
      }
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.initTexts});
      this._btnPlay._visible = false;
   }
   function addListeners()
   {
      this._cciSprite0.addEventListener("select",this);
      this._cciSprite1.addEventListener("select",this);
      this._cciSprite2.addEventListener("select",this);
      this._cciSprite3.addEventListener("select",this);
      this._cciSprite4.addEventListener("select",this);
      this._cciSprite0.addEventListener("remove",this);
      this._cciSprite1.addEventListener("remove",this);
      this._cciSprite2.addEventListener("remove",this);
      this._cciSprite3.addEventListener("remove",this);
      this._cciSprite4.addEventListener("remove",this);
      this._cciSprite0.addEventListener("reset",this);
      this._cciSprite1.addEventListener("reset",this);
      this._cciSprite2.addEventListener("reset",this);
      this._cciSprite3.addEventListener("reset",this);
      this._cciSprite4.addEventListener("reset",this);
      this._btnPlay.addEventListener("click",this);
      this._btnCreate.addEventListener("click",this);
      this._btnSubscribe.addEventListener("click",this);
      this._btnBack.addEventListener("click",this);
      this.api.kernel.StreamingDisplayManager.onCharacterChoice();
   }
   function updateCharactersList()
   {
      var _loc2_ = 0;
      while(_loc2_ < 5)
      {
         var _loc3_ = this["_cciSprite" + _loc2_];
         _loc3_.showComboBox = this._bShowComboBox;
         _loc3_.params = {index:_loc2_ + this._nCharacterStartIndex};
         _loc3_.data = this._aSpriteList[_loc2_ + this._nCharacterStartIndex];
         _loc3_.enabled = this._aSpriteList[_loc2_ + this._nCharacterStartIndex] != undefined;
         _loc3_.isDead = _loc3_.data.isDead;
         _loc3_.death = _loc3_.data.deathCount;
         _loc3_.deathState = _loc3_.data.deathState;
         _loc2_ = _loc2_ + 1;
      }
   }
   function initData()
   {
      this.api.datacenter.Basics.inGame = false;
      this._btnArrowLeft._visible = this._btnArrowRight._visible = this._aSpriteList.length > 5;
      this._nCharacterStartIndex = 0;
      this._btnArrowLeft.onRelease = function()
      {
         this._parent._btnArrowLeft.gotoAndStop("on");
         this._parent._btnArrowRight.gotoAndStop("on");
         this._parent._nCharacterStartIndex = this._parent._nCharacterStartIndex - 1;
         if(this._parent._nCharacterStartIndex <= 0)
         {
            this._parent._nCharacterStartIndex = 0;
            this.gotoAndStop("off");
         }
         this._parent.updateCharactersList();
      };
      this._btnArrowRight.onRelease = function()
      {
         this._parent._btnArrowLeft.gotoAndStop("on");
         this._parent._btnArrowRight.gotoAndStop("on");
         this._parent._nCharacterStartIndex = this._parent._nCharacterStartIndex + 1;
         if(this._parent._nCharacterStartIndex >= this._parent._aSpriteList.length - 5)
         {
            this._parent._nCharacterStartIndex = this._parent._aSpriteList.length - 5;
            this.gotoAndStop("off");
         }
         this._parent.updateCharactersList();
      };
      this._lblRemainingTime.text = this.api.kernel.GameManager.getRemainingString(this._nRemainingTime);
      this._lblRemainingTime.styleName = this._nRemainingTime != 0?"WhiteRightSmallBoldLabel":"RedRightSmallBoldLabel";
      this._btnSubscribe.enabled = this._nRemainingTime != -1;
      if(this._aSpriteList.length == 0)
      {
         this._btnPlay._visible = false;
      }
      else
      {
         this._btnPlay._visible = true;
      }
      if(!this.api.config.isStreaming)
      {
         this._lblLogin.onRollOver = function()
         {
            this._parent.gapi.showTooltip(this._parent.api.lang.getText("PSEUDO_DOFUS_INFOS"),this,20,undefined);
         };
         this._lblLogin.onRollOut = function()
         {
            this._parent.gapi.hideTooltip();
         };
         this._lblLogin.onRelease = function()
         {
            var _loc2_ = this._parent.api.lang.getText("PSEUDO_DOFUS_LINK");
            if(_loc2_ != undefined && _loc2_ != "")
            {
               this.getURL(_loc2_,"_blank");
            }
         };
      }
      this._btnArrowLeft.onRelease();
      this._btnBack._visible = !this.api.config.isStreaming;
   }
   function initTexts()
   {
      this._lblTitle.text = this.api.lang.getText("CHOOSE_TITLE");
      this._btnPlay.label = this.api.lang.getText("MENU_PLAY");
      this._btnCreate.label = this.api.lang.getText("CREATE_CHARACTER");
      this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
      this._btnBack.label = this.api.lang.getText("CHANGE_SERVER");
      this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
      this._lblAccount.text = this.api.lang.getText("ACCOUNT_INFO");
      if(!this.api.config.isStreaming)
      {
         this._lblLogin.text = this.api.lang.getText("PSEUDO_DOFUS",[this.api.datacenter.Basics.dofusPseudo]);
      }
      else
      {
         this._lblLogin.text = this.api.lang.getText("POPUP_GAME_BEGINNING_TITLE");
      }
      this._lblServer.text = this.api.lang.getText("CURRENT_SERVER",[this.api.datacenter.Basics.aks_current_server.label]);
   }
   function select(oEvent)
   {
      var _loc3_ = oEvent.target.params.index;
      this["_cciSprite" + this._nSelectedIndex].selected = false;
      if(this._nSelectedIndex == _loc3_)
      {
         delete this._nSelectedIndex;
      }
      else
      {
         this._nSelectedIndex = _loc3_;
      }
      if(getTimer() - this._nSaveLastClick < ank.gapi.Gapi.DBLCLICK_DELAY)
      {
         this._nSelectedIndex = _loc3_;
         this.click({target:this._btnPlay});
         return undefined;
      }
      this._nSaveLastClick = getTimer();
   }
   function remove(oEvent)
   {
      var _loc3_ = oEvent.target.params.index;
      if(this.api.lang.getConfigText("SECRET_ANSWER_ON_DELETE") && (this._aSpriteList[_loc3_].Level >= this.api.lang.getConfigText("SECRET_ANSWER_SINCE_LEVEL") && (this.api.datacenter.Basics.aks_secret_question != undefined && this.api.datacenter.Basics.aks_secret_question.length > 0)))
      {
         this.gapi.loadUIComponent("AskSecretAnswer","AskSecretAnswer",{title:this.api.lang.getText("DELETE_WORD"),charToDelete:this._aSpriteList[_loc3_]});
      }
      else
      {
         this.api.kernel.showMessage(this.api.lang.getText("DELETE_WORD"),this.api.lang.getText("DO_U_DELETE_A",[this._aSpriteList[_loc3_].name]),"CAUTION_YESNO",{name:"Delete",listener:this,params:{index:_loc3_}});
      }
   }
   function reset(oEvent)
   {
      var _loc3_ = this._aSpriteList[oEvent.target.params.index].id;
      var _loc4_ = this.gapi.loadUIComponent("AskYesNo","AskYesReset",{title:this.api.lang.getText("RESET_SHORTCUT"),text:this.api.lang.getText("DO_U_RESET_CHARACTER"),params:{index:_loc3_}});
      _loc4_.addEventListener("yes",this);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnPlay":
            if(this._nSelectedIndex == undefined)
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("SELECT_CHARACTER"),"ERROR_BOX",{name:"NoSelect"});
            }
            else
            {
               this.api.network.Account.setCharacter(this._aSpriteList[this._nSelectedIndex].id);
            }
            break;
         case "_btnCreate":
            if(this._nCharacterCount >= 5 && !this.api.datacenter.Player.isAuthorized)
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("TOO_MUCH_CHARACTER"),"ERROR_BOX");
            }
            else
            {
               this.gapi.loadUIComponent("CreateCharacter","CreateCharacter",{remainingTime:this._nRemainingTime});
               this.gapi.unloadUIComponent("ChooseCharacter");
            }
            break;
         case "_btnSubscribe":
            _root.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
            break;
         case "_btnBack":
            this.api.kernel.changeServer(true);
            break;
         case "_btnChangeServer":
      }
   }
   function yes(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "AskYesReset":
            this.api.network.Account.resetCharacter(oEvent.params.index);
            break;
         case "AskYesNoDelete":
            this.api.network.Account.deleteCharacter(this._aSpriteList[oEvent.params.index].id);
      }
   }
}
