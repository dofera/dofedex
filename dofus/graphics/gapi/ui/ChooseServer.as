class dofus.graphics.gapi.ui.ChooseServer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ChooseServer";
   function ChooseServer()
   {
      super();
   }
   function __set__servers(eaServers)
   {
      this._eaServers = eaServers;
      return this.__get__servers();
   }
   function __set__serverID(nServerID)
   {
      this._nServerID = nServerID;
      return this.__get__serverID();
   }
   function __set__remainingTime(nRemainingTime)
   {
      this._nRemainingTime = nRemainingTime;
      return this.__get__remainingTime();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ChooseServer.CLASS_NAME);
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
   }
   function addListeners()
   {
      this._btnSelect.addEventListener("click",this);
      this._btnCreate.addEventListener("click",this);
      this._btnSubscribe.addEventListener("click",this);
      this._btnAutomaticSelection.addEventListener("click",this);
   }
   function initTexts()
   {
      this._lblTitle.text = this.api.lang.getText("CHOOSE_SERVER");
      this._lblWhy.text = this.api.lang.getText("CHOOSE_SERVER_WHY");
      this._btnSelect.label = this.api.lang.getText("SELECT");
      this._btnCreate.label = this.api.lang.getText("CREATE_CHARACTER");
      this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
      this._lblAccount.text = this.api.lang.getText("ACCOUNT_INFO");
      this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
      if(!this.api.config.isStreaming)
      {
         this._lblLogin.text = this.api.lang.getText("PSEUDO_DOFUS",[this.api.datacenter.Basics.dofusPseudo]);
      }
      else
      {
         this._lblLogin.text = this.api.lang.getText("POPUP_GAME_BEGINNING_TITLE");
      }
   }
   function initData()
   {
      this.api.datacenter.Basics.createCharacter = false;
      this._nServerStartIndex = 0;
      this._lblRemainingTime.text = this.api.kernel.GameManager.getRemainingString(this._nRemainingTime);
      this._lblRemainingTime.styleName = this._nRemainingTime != 0?"WhiteRightSmallBoldLabel":"RedRightSmallBoldLabel";
      this._btnSubscribe.enabled = this._nRemainingTime != -1;
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
      this._eaFavoriteServers = new ank.utils.ExtendedArray();
      var _loc2_ = 0;
      while(_loc2_ < this._eaServers.length)
      {
         if(this._eaServers[_loc2_].charactersCount > 0)
         {
            this._eaFavoriteServers.push(this._eaServers[_loc2_]);
         }
         _loc2_ = _loc2_ + 1;
      }
      this._eaFavoriteServers.bubbleSortOn("charactersCount",Array.DESCENDING);
      this._btnArrowLeft._visible = this._btnArrowRight._visible = this._eaFavoriteServers.length > 5;
      this._btnArrowLeft.onRelease = function()
      {
         this._parent._btnArrowLeft.gotoAndStop("on");
         this._parent._btnArrowRight.gotoAndStop("on");
         this._parent._nServerStartIndex = this._parent._nServerStartIndex - 1;
         if(this._parent._nServerStartIndex <= 0)
         {
            this._parent._nServerStartIndex = 0;
            this.gotoAndStop("off");
         }
         this._parent.updateServerList();
      };
      this._btnArrowRight.onRelease = function()
      {
         this._parent._btnArrowLeft.gotoAndStop("on");
         this._parent._btnArrowRight.gotoAndStop("on");
         this._parent._nServerStartIndex = this._parent._nServerStartIndex + 1;
         if(this._parent._nServerStartIndex >= this._parent._eaFavoriteServers.length - 5)
         {
            this._parent._nServerStartIndex = this._parent._eaFavoriteServers.length - 5;
            this.gotoAndStop("off");
         }
         this._parent.updateServerList();
      };
      this._btnArrowLeft.onRelease();
      if(this.api.datacenter.Basics.first_connection_from_miniclip)
      {
         this.click({target:{_name:"_btnCreate"}});
      }
   }
   function updateServerList()
   {
      if(this._eaFavoriteServers.length > 0)
      {
         var _loc2_ = 0;
         while(_loc2_ < 5)
         {
            var _loc3_ = this._eaFavoriteServers[_loc2_ + this._nServerStartIndex];
            if(_loc3_ != undefined)
            {
               var _loc4_ = this["_css" + _loc2_];
               _loc4_._visible = true;
               _loc4_.index = _loc2_;
               _loc4_.serverID = _loc3_.id;
               _loc4_.addEventListener("select",this);
               _loc4_.addEventListener("unselect",this);
               _loc4_.addEventListener("remove",this);
               this["_mcServerEmpty" + _loc2_]._visible = false;
            }
            else
            {
               this["_css" + _loc2_]._visible = false;
               this["_mcServerEmpty" + _loc2_]._visible = true;
            }
            _loc2_ = _loc2_ + 1;
         }
         this._txtWhy._visible = false;
         this._btnAutomaticSelection._visible = false;
      }
      else
      {
         var _loc5_ = 0;
         while(_loc5_ < 5)
         {
            this["_mcServerEmpty" + _loc5_]._visible = false;
            this["_css" + _loc5_]._visible = false;
            _loc5_ = _loc5_ + 1;
         }
         this._btnAutomaticSelection.label = this.api.lang.getText("AUTOMATIC_SERVER_SELECTION");
         this._txtWhy.text = this.api.lang.getText("CHOOSE_SERVER_WHY_BLABLA");
      }
      if(this.api.datacenter.Basics.isCreatingNewCharacter)
      {
         this.api.datacenter.Basics.hasForcedManualSelection = true;
         this.click({target:this._btnCreate});
         this.api.datacenter.Basics.isCreatingNewCharacter = false;
         this.api.datacenter.Basics.hasForcedManualSelection = false;
      }
   }
   function selectServer(nServerID)
   {
      if(_global.isNaN(nServerID))
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CHOOSE_SERVER"),"ERROR_BOX");
      }
      else
      {
         var _loc3_ = this.api.datacenter.Basics.aks_servers.findFirstItem("id",nServerID).item;
         if(_loc3_.state == dofus.datacenter.Server.SERVER_ONLINE)
         {
            var _loc4_ = new dofus.datacenter.Server(nServerID,1,0);
            if(_loc4_.isAllowed())
            {
               this.api.datacenter.Basics.aks_current_server = _loc4_;
               this.api.network.Account.setServer(nServerID);
            }
            else
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("SERVER_NOT_ALLOWED_IN_YOUR_LANGUAGE"),"ERROR_BOX");
            }
         }
         else
         {
            this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_CHOOSE_CHARACTER_SERVER_DOWN"),"ERROR_BOX");
         }
      }
   }
   function select(oEvent)
   {
      var _loc3_ = 0;
      while(_loc3_ < 5)
      {
         this["_css" + _loc3_].selected = false;
         _loc3_ = _loc3_ + 1;
      }
      oEvent.target.selected = true;
      var _loc4_ = oEvent.target.serverID;
      var _loc5_ = this._nServerID;
      this._nServerID = _loc4_;
      if(_loc5_ == _loc4_)
      {
         this.click({target:this._btnSelect});
      }
   }
   function unselect(oEvent)
   {
      var _loc3_ = oEvent.target.serverID;
      if(this._nServerID == _loc3_)
      {
         delete this._nServerID;
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnSelect":
            var _loc3_ = this.gapi.getUIComponent("ServerList");
            if(_loc3_ != undefined)
            {
               this._nServerID = _loc3_.selectedServerID;
               _loc3_.onServerSelected();
            }
            else
            {
               this.api.datacenter.Basics.createCharacter = false;
               this.selectServer(this._nServerID);
            }
            break;
         case "_btnCreate":
            if(this.api.datacenter.Basics.hasForcedManualSelection || this.api.datacenter.Basics.first_connection_from_miniclip)
            {
               this.gapi.loadUIComponent("ServerList","ServerList",{servers:this.api.datacenter.Basics.aks_servers});
               this.gapi.getUIComponent("ServerList").addEventListener("serverSelected",this);
               this.api.datacenter.Basics.hasForcedManualSelection = false;
               break;
            }
         case "_btnAutomaticSelection":
            this.api.datacenter.Basics.forceAutomaticServerSelection = true;
            this.api.network.Account.getServersList();
            this.api.datacenter.Basics.isCreatingNewCharacter = true;
            break;
         case "_btnSubscribe":
            _root.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
      }
   }
   function serverSelected(oEvent)
   {
      this.api.datacenter.Basics.createCharacter = true;
      this.gapi.unloadUIComponent("ServerList");
      this.selectServer(oEvent.serverID);
   }
}
