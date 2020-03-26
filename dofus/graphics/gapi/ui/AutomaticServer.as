class dofus.graphics.gapi.ui.AutomaticServer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "AutomaticServer";
   function AutomaticServer()
   {
      super();
   }
   function __set__servers(eaServers)
   {
      this._eaServers = eaServers;
      return this.__get__servers();
   }
   function __set__remainingTime(nRemainingTime)
   {
      this._nRemainingTime = nRemainingTime;
      return this.__get__remainingTime();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.AutomaticServer.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
   }
   function addListeners()
   {
      this._mcAutomaticSelect.onRelease = function()
      {
         this._parent.click({target:this});
      };
      this._mcManualSelect.onRelease = function()
      {
         this._parent.click({target:this});
      };
   }
   function initTexts()
   {
      if(this.api.datacenter.Basics.first_connection_from_miniclip)
      {
         this._taTitleLong.text = this.api.lang.getText("SERVER_FIRST_CONNECTION_MINICLIP");
         this._mcBgTitle._visible = false;
      }
      else
      {
         this._lblTitle.text = this.api.lang.getText("CHOOSE_GAME_SERVER");
         this._mcBgLongTitle._visible = false;
      }
      this._lblCopyright.text = this.api.lang.getText("COPYRIGHT");
      this._lblAutomaticSelect.text = this.api.lang.getText("AUTOMATIC_SERVER_SELECTION");
      this._lblManualSelect.text = this.api.lang.getText("MANUAL_SERVER_SELECT");
   }
   function getLessPopulatedServer(eaServers)
   {
      if(eaServers.length == 1)
      {
         return eaServers[0].id;
      }
      eaServers.sortOn("populationWeight",Array.NUMERIC | Array.ASCENDING);
      var _loc3_ = eaServers[0].populationWeight;
      var _loc4_ = new ank.utils.ExtendedArray();
      var _loc5_ = 0;
      while(_loc5_ < eaServers.length)
      {
         if(eaServers[_loc5_].populationWeight == _loc3_)
         {
            _loc4_.push(eaServers[_loc5_]);
         }
         _loc5_ = _loc5_ + 1;
      }
      _loc4_.sortOn("completion",Array.NUMERIC | Array.ASCENDING);
      var _loc6_ = _loc4_[0].completion;
      var _loc7_ = new ank.utils.ExtendedArray();
      var _loc8_ = 0;
      while(_loc8_ < _loc4_.length)
      {
         if(_loc4_[_loc8_].completion == _loc6_)
         {
            _loc7_.push(_loc4_[_loc8_]);
         }
         _loc8_ = _loc8_ + 1;
      }
      return _loc7_[Math.round(Math.random() * (_loc7_.length - 1))].id;
   }
   function selectServer(nServerID)
   {
      this.gapi.loadUIComponent("ServerInformations","ServerInformations",{server:nServerID});
      this.gapi.getUIComponent("ServerInformations").addEventListener("serverSelected",this);
      this.gapi.getUIComponent("ServerInformations").addEventListener("canceled",this);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_mcAutomaticSelect":
            var _loc3_ = new ank.utils.ExtendedArray();
            var _loc4_ = 0;
            while(_loc4_ < this._eaServers.length)
            {
               if(this._eaServers[_loc4_].state == dofus.datacenter.Server.SERVER_ONLINE && this._eaServers[_loc4_].isAllowed())
               {
                  _loc3_.push(this._eaServers[_loc4_]);
               }
               _loc4_ = _loc4_ + 1;
            }
            if(_loc3_.length <= 0)
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("ALL_SERVERS_ARE_DOWN"),"ERROR_BOX");
               break;
            }
            var _loc5_ = new ank.utils.ExtendedArray();
            var _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               if(_loc3_[_loc6_].canLog && _loc3_[_loc6_].typeNum == dofus.datacenter.Server.SERVER_CLASSIC)
               {
                  _loc5_.push(_loc3_[_loc6_]);
               }
               _loc6_ = _loc6_ + 1;
            }
            _loc3_ = _loc5_;
            if(_loc3_.length <= 0)
            {
               if(this._nRemainingTime <= 0)
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("ALL_SERVERS_ARE_FULL_NOT_FULL_MEMBER"),"ERROR_BOX");
               }
               else
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("ALL_SERVERS_ARE_FULL_FULL_MEMBER"),"ERROR_BOX");
               }
               break;
            }
            this._eaPreselectedServers = _loc3_;
            _loc5_ = new ank.utils.ExtendedArray();
            var _loc7_ = 0;
            while(_loc7_ < _loc3_.length)
            {
               if(_loc3_[_loc7_].community == this.api.datacenter.Basics.communityId)
               {
                  _loc5_.push(_loc3_[_loc7_]);
               }
               _loc7_ = _loc7_ + 1;
            }
            _loc3_ = _loc5_;
            if(_loc3_.length <= 0)
            {
               if(this._nRemainingTime <= 0)
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMUNITY_IS_FULL_NOT_FULL_MEMBER"),"CAUTION_YESNO",{name:"automaticServer",listener:this});
               }
               else
               {
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("COMMUNITY_IS_FULL_FULL_MEMBER"),"CAUTION_YESNO",{name:"automaticServer",listener:this});
               }
               break;
            }
            this.selectServer(this.getLessPopulatedServer(_loc3_));
            break;
         case "_mcManualSelect":
            this.api.datacenter.Basics.forceManualServerSelection = true;
            this.api.network.Account.getServersList();
      }
   }
   function yes(oEvent)
   {
      var _loc3_ = new ank.utils.ExtendedArray();
      var _loc4_ = 0;
      while(_loc4_ < this._eaPreselectedServers.length)
      {
         if(this._eaPreselectedServers[_loc4_].community == 2)
         {
            _loc3_.push(this._eaPreselectedServers[_loc4_]);
         }
         _loc4_ = _loc4_ + 1;
      }
      if(_loc3_.length > 0)
      {
         this.selectServer(this.getLessPopulatedServer(_loc3_));
      }
      else
      {
         this.selectServer(this.getLessPopulatedServer(this._eaPreselectedServers));
      }
   }
   function serverSelected(oEvent)
   {
      this.gapi.unloadUIComponent("ServerInformations");
      var _loc3_ = new dofus.datacenter.Server(oEvent.value,1,0);
      if(_loc3_.isAllowed())
      {
         this.api.datacenter.Basics.aks_current_server = _loc3_;
         this.api.datacenter.Basics.createCharacter = true;
         this.api.network.Account.setServer(oEvent.value);
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("SERVER_NOT_ALLOWED_IN_YOUR_LANGUAGE"),"ERROR_BOX");
      }
   }
   function canceled(oEvent)
   {
      this.gapi.unloadUIComponent("ServerInformations");
   }
}
