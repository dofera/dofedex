class dofus.graphics.gapi.ui.Guild extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Guild";
   var _sCurrentTab = "Members";
   function Guild()
   {
      super();
   }
   function __set__currentTab(sTab)
   {
      this._sCurrentTab = sTab;
      return this.__get__currentTab();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Guild.CLASS_NAME);
   }
   function destroy()
   {
      this.gapi.unloadUIComponent("GuildMemberInfos");
      this.gapi.hideTooltip();
      this.api.datacenter.Player.guildInfos.removeEventListener("modelChanged",this);
      this.checkIfLocalPlayerIsDefender();
      if(this._sCurrentTab == "TaxCollectors")
      {
         this.api.network.Guild.leaveTaxInterface();
      }
   }
   function callClose()
   {
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.setCurrentTab,params:[this._sCurrentTab]});
      this._mcPlacer._visible = false;
      this._mcCaution._visible = this._lblValid._visible = false;
   }
   function initTexts()
   {
      this._btnTabMembers.label = this.api.lang.getText("GUILD_MEMBERS");
      this._btnTabBoosts.label = this.api.lang.getText("GUILD_BOOSTS");
      this._btnTabTaxCollectors.label = this.api.lang.getText("GUILD_TAXCOLLECTORS");
      this._btnTabMountParks.label = this.api.lang.getText("MOUNT_PARK");
      this._btnTabGuildHouses.label = this.api.lang.getText("HOUSES_WORD");
      this._lblXP.text = this.api.lang.getText("EXPERIMENT");
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnTabMembers.addEventListener("click",this);
      this._btnTabBoosts.addEventListener("click",this);
      this._btnTabTaxCollectors.addEventListener("click",this);
      this._btnTabMountParks.addEventListener("click",this);
      this._btnTabGuildHouses.addEventListener("click",this);
      this.api.datacenter.Player.guildInfos.addEventListener("modelChanged",this);
      this._pbXP.addEventListener("over",this);
      this._pbXP.addEventListener("out",this);
   }
   function initData()
   {
      var _loc2_ = this.api.datacenter.Player.guildInfos;
      var _loc3_ = _loc2_.emblem;
      this._eEmblem.backID = _loc3_.backID;
      this._eEmblem.backColor = _loc3_.backColor;
      this._eEmblem.upID = _loc3_.upID;
      this._eEmblem.upColor = _loc3_.upColor;
      this._winBg.title = this.api.lang.getText("GUILD") + " \'" + _loc2_.name + "\'";
      this.api.network.Guild.getInfosGeneral();
   }
   function updateCurrentTabInformations()
   {
      this._mcTabViewer.removeMovieClip();
      switch(this._sCurrentTab)
      {
         case "Members":
            this.attachMovie("GuildMembersViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
            this.api.datacenter.Player.guildInfos.members.removeAll();
            this.api.network.Guild.getInfosMembers();
            break;
         case "Boosts":
            this.attachMovie("GuildBoostsViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
            this.api.network.Guild.getInfosBoosts();
            break;
         case "TaxCollectors":
            this.attachMovie("TaxCollectorsViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
            this.api.datacenter.Player.guildInfos.taxCollectors.removeAll();
            this.api.network.Guild.getInfosTaxCollector();
            break;
         case "MountParks":
            this.attachMovie("GuildMountParkViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
            this.api.network.Guild.getInfosMountPark();
            break;
         case "GuildHouses":
            this.attachMovie("GuildHousesViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
            this.api.network.Guild.getInfosGuildHouses();
      }
   }
   function setCurrentTab(sNewTab)
   {
      if(this._sCurrentTab == "TaxCollectors")
      {
         this.api.network.Guild.leaveTaxInterface();
      }
      var _loc3_ = this["_btnTab" + this._sCurrentTab];
      var _loc4_ = this["_btnTab" + sNewTab];
      _loc3_.selected = true;
      _loc3_.enabled = true;
      _loc4_.selected = false;
      _loc4_.enabled = false;
      this._sCurrentTab = sNewTab;
      this.updateCurrentTabInformations();
   }
   function checkIfLocalPlayerIsDefender()
   {
      var _loc2_ = this.api.datacenter.Player.guildInfos;
      if(_loc2_.isLocalPlayerDefender)
      {
         this.api.network.Guild.leaveTaxCollector(_loc2_.defendedTaxCollectorID);
         this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("AUTO_DISJOIN_TAX"),"ERROR_BOX");
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnClose":
            this.callClose();
            break;
         case "_btnTabMembers":
            this.setCurrentTab("Members");
            break;
         case "_btnTabBoosts":
            if(this.api.datacenter.Player.guildInfos.isValid)
            {
               this.setCurrentTab("Boosts");
            }
            else
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
               oEvent.target.selected = true;
            }
            break;
         case "_btnTabTaxCollectors":
            if(this.api.datacenter.Player.guildInfos.isValid)
            {
               this.setCurrentTab("TaxCollectors");
            }
            else
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
               oEvent.target.selected = true;
            }
            break;
         case "_btnTabMountParks":
            if(this.api.datacenter.Player.guildInfos.isValid)
            {
               this.setCurrentTab("MountParks");
            }
            else
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
               oEvent.target.selected = true;
            }
            break;
         case "_btnTabGuildHouses":
            if(this.api.datacenter.Player.guildInfos.isValid)
            {
               this.setCurrentTab("GuildHouses");
            }
            else
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
               oEvent.target.selected = true;
            }
      }
   }
   function over(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "_pbXP")
      {
         this.gapi.showTooltip(new ank.utils.ExtendedString(this._pbXP.value).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3) + " / " + new ank.utils.ExtendedString(this._pbXP.maximum).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3),this._pbXP,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function modelChanged(oEvent)
   {
      switch(oEvent.eventName)
      {
         case "general":
            var _loc3_ = this.api.datacenter.Player.guildInfos;
            this._lblLevel.text = this.api.lang.getText("LEVEL") + " " + _loc3_.level;
            this._pbXP.minimum = _loc3_.xpmin;
            this._pbXP.maximum = _loc3_.xpmax;
            this._pbXP.value = _loc3_.xp;
            this._pbXP.onRollOver = function()
            {
               this._parent.gapi.showTooltip(this.value + " / " + this.maximum,this,-20);
            };
            this._pbXP.onRollOut = function()
            {
               this._parent.gapi.hideTooltip();
            };
            if(_loc3_.isValid)
            {
               this._y = 0;
               this._lblValid._visible = _loc0_ = false;
               this._mcCaution._visible = _loc0_;
            }
            else
            {
               this._y = -20;
               this._lblValid._visible = _loc0_ = true;
               this._mcCaution._visible = _loc0_;
               this._lblValid.text = this.api.lang.getText("GUILD_INVALID_INFOS");
            }
            break;
         case "members":
            if(this._sCurrentTab == "Members")
            {
               this._mcTabViewer.members = this.api.datacenter.Player.guildInfos.members;
            }
            break;
         case "boosts":
            if(this._sCurrentTab == "Boosts")
            {
               this._mcTabViewer.updateData();
            }
            break;
         case "taxcollectors":
            if(this._sCurrentTab == "TaxCollectors")
            {
               this._mcTabViewer.taxCollectors = this.api.datacenter.Player.guildInfos.taxCollectors;
            }
            break;
         case "noboosts":
         case "notaxcollectors":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_MEMBERS_IN_GUILD"),"ERROR_BOX");
            this.setCurrentTab("Members");
            break;
         case "mountParks":
            if(this._sCurrentTab == "MountParks")
            {
               this._mcTabViewer.mountParks = this.api.datacenter.Player.guildInfos.mountParks;
            }
            break;
         case "houses":
            if(this._sCurrentTab == "GuildHouses")
            {
               this._mcTabViewer.houses = this.api.datacenter.Player.guildInfos.houses;
            }
      }
   }
}
