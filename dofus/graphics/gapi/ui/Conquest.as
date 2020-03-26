class dofus.graphics.gapi.ui.Conquest extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Conquest";
   var _sCurrentTab = "Stats";
   function Conquest()
   {
      super();
   }
   function __set__currentTab(sTab)
   {
      this._sCurrentTab = sTab;
      return this.__get__currentTab();
   }
   function sharePropertiesWithTab(properties)
   {
      for(var i in properties)
      {
         this._mcTabViewer[i] = properties[i];
      }
   }
   function setBalance(worldBalance, areaBalance)
   {
      this._nWorldBalance = worldBalance;
      this._nAreaBalance = areaBalance;
      this.addToQueue({object:this,method:this.updateBalance});
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Conquest.CLASS_NAME);
   }
   function callClose()
   {
      switch(this._sCurrentTab)
      {
         case "Zones":
            this.api.network.Conquest.worldInfosLeave();
            break;
         case "Join":
            if(!(dofus.graphics.gapi.controls.ConquestJoinViewer)this._mcTabViewer.noUnsubscribe)
            {
               this.api.network.Conquest.prismInfosLeave();
            }
      }
      this.unloadThis();
      return true;
   }
   function createChildren()
   {
      this._mcPlacer._visible = false;
      this._mcPvpActive._visible = false;
      this._mcPvpInactive._visible = false;
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.initData});
      this.addToQueue({object:this,method:this.setCurrentTab,params:[this._sCurrentTab]});
   }
   function addListeners()
   {
      this.api.datacenter.Player.addEventListener("rankChanged",this);
      this.api.datacenter.Player.addEventListener("alignmentChanged",this);
      this._btnClose.addEventListener("click",this);
      this._btnTabJoin.addEventListener("click",this);
      this._btnTabStats.addEventListener("click",this);
      this._btnTabZones.addEventListener("click",this);
      this._ctrAlignment.addEventListener("over",this);
      this._ctrAlignment.addEventListener("out",this);
      var ref = this;
      this._mcBalanceInteractivity.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcBalanceInteractivity.onRollOut = function()
      {
         ref.out({target:this});
      };
   }
   function initTexts()
   {
      this._lblTitle.text = this.api.lang.getText("CONQUEST_WORD");
      this._lblGrade.text = this.api.lang.getText("RANK");
      this._lblBalance.text = this.api.lang.getText("BALANCE_WORD");
      this._btnTabStats.label = this.api.lang.getText("STATS");
      this._btnTabZones.label = this.api.lang.getText("ZONES_WORD");
      this._btnTabJoin.label = this.api.lang.getText("DEFEND");
   }
   function initData()
   {
      this.rankChanged({rank:this.api.datacenter.Player.rank});
      this.alignmentChanged({alignment:this.api.datacenter.Player.alignment});
      this.api.network.Conquest.requestBalance();
   }
   function setCurrentTab(sNewTab)
   {
      this._mcComboBoxPopup.removeMovieClip();
      var _loc3_ = this["_btnTab" + this._sCurrentTab];
      var _loc4_ = this["_btnTab" + sNewTab];
      _loc3_.selected = true;
      _loc3_.enabled = true;
      _loc4_.selected = false;
      _loc4_.enabled = false;
      switch(this._sCurrentTab)
      {
         case "Zones":
            this.api.network.Conquest.worldInfosLeave();
            break;
         case "Join":
            if(!(dofus.graphics.gapi.controls.ConquestJoinViewer)this._mcTabViewer.noUnsubscribe)
            {
               this.api.network.Conquest.prismInfosLeave();
            }
      }
      this._sCurrentTab = sNewTab;
      this.updateCurrentTabInformations();
   }
   function updateCurrentTabInformations()
   {
      this._mcTabViewer.removeMovieClip();
      switch(this._sCurrentTab)
      {
         case "Stats":
            this.attachMovie("ConquestStatsViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
            break;
         case "Zones":
            this.attachMovie("ConquestZonesViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
            this.api.network.Conquest.worldInfosJoin();
            break;
         case "Join":
            this.attachMovie("ConquestJoinViewer","_mcTabViewer",this.getNextHighestDepth(),{_x:this._mcPlacer._x,_y:this._mcPlacer._y});
            this.api.network.Conquest.prismInfosJoin();
      }
   }
   function updateBalance()
   {
      var _loc2_ = this.api.lang.getAlignmentBalance();
      var _loc3_ = new String();
      for(var i in _loc2_)
      {
         if(this._nWorldBalance >= _loc2_[i].s && this._nWorldBalance <= _loc2_[i].e)
         {
            _loc3_ = String(_loc2_[i].n);
            this._sBalanceDescription = String(_loc2_[i].d);
         }
      }
      this._lblBalanceValue.text = this._nWorldBalance + "%" + (_loc3_.length <= 0?"":" (" + _loc3_ + ")");
   }
   function destroy()
   {
      switch(this._sCurrentTab)
      {
         case "Zones":
            this.api.network.Conquest.worldInfosLeave();
            break;
         case "Join":
            this.api.network.Conquest.prismInfosLeave();
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._ctrAlignment:
            this.gapi.showTooltip(this.api.datacenter.Player.alignment.name,oEvent.target,oEvent.target.height + 5);
            break;
         case this._mcBalanceInteractivity:
            var _loc3_ = new String();
            if(this._sBalanceDescription.length > 0)
            {
               _loc3_ = _loc3_ + this._sBalanceDescription;
            }
            if(this._nAreaBalance != undefined && (!_global.isNaN(this._nAreaBalance) && this._nAreaBalance > 0))
            {
               _loc3_ = _loc3_ + ("\n\n" + this.api.lang.getText("CONQUEST_ZONE_BALANCE") + ": " + this._nAreaBalance + "%");
            }
            this.gapi.showTooltip(_loc3_,oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function click(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnClose:
            this.callClose();
            break;
         case this._btnTabJoin:
         case this._btnTabStats:
         case this._btnTabZones:
            this.setCurrentTab(oEvent.target._name.substr(7));
      }
   }
   function rankChanged(oEvent)
   {
      this._rRank = (dofus.datacenter.Rank)oEvent.rank;
      if(this._rRank.enable && this._lblStats.text != undefined)
      {
         var _loc3_ = this.api.datacenter.Player.alignment.index;
         if(_loc3_ == 0)
         {
            this._lblGradeValue.text = this.api.lang.getRankLongName(0,0);
         }
         else
         {
            this._lblGradeValue.text = oEvent.rank.value + " (" + this.api.lang.getRankLongName(_loc3_,this._rRank.value) + ")";
         }
         this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("ACTIVE") + ")";
         this._mcPvpActive._visible = true;
         this._mcPvpInactive._visible = false;
      }
      else if(this._lblStats.text != undefined)
      {
         this._lblGradeValue.text = "-";
         this._lblStats.text = this.api.lang.getText("PVP_MODE") + " (" + this.api.lang.getText("INACTIVE") + ")";
         this._mcPvpActive._visible = false;
         this._mcPvpInactive._visible = true;
      }
   }
   function alignmentChanged(oEvent)
   {
      this._ctrAlignment.contentPath = oEvent.alignment.iconFile;
   }
}
