class dofus.graphics.gapi.controls.taxcollectorsviewer.TaxCollectorsViewerItem extends ank.gapi.core.UIBasicComponent
{
   function TaxCollectorsViewerItem()
   {
      super();
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      this._oItem.players.removeEventListener("modelChanged",this);
      this._oItem.attackers.removeEventListener("modelChanged",this);
      this._oItem = oItem;
      if(bUsed)
      {
         this._lblName.text = oItem.name;
         this._lblPosition.text = oItem.position;
         this.showStateIcon();
         if(!_global.isNaN(oItem.timer))
         {
            var _loc5_ = oItem.timer - (getTimer() - oItem.timerReference);
            var _loc6_ = oItem.maxTimer / 1000;
            if(_loc5_ > 0)
            {
               this._vcTimer.startTimer(_loc5_ / 1000,_loc6_);
               this.showButtonsJoin(!_global.isNaN(oItem.maxPlayerCount)?oItem.maxPlayerCount:0);
            }
            else
            {
               this._vcTimer.stopTimer();
               this.showButtonsJoin(0);
            }
         }
         else
         {
            this._vcTimer.stopTimer();
            this.showButtonsJoin(0);
         }
         oItem.players.addEventListener("modelChanged",this);
         oItem.attackers.addEventListener("modelChanged",this);
         this._btnAttackers.enabled = true;
         this.updateAttackers();
         this.updatePlayers();
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblPosition.text = "";
         this._mcFight._visible = false;
         this._mcEnterFight._visible = false;
         this._mcCollect._visible = false;
         this._btnState._visible = false;
         this.hideButtonsJoin();
         this._vcTimer.stopTimer();
         this._btnAttackers.enabled = false;
         this._lblAttackersCount._visible = false;
      }
      else
      {
         this.hideButtonsJoin();
         this._vcTimer.stopTimer();
      }
   }
   function init()
   {
      super.init(false);
      this._mcFight._visible = false;
      this._mcEnterFight._visible = false;
      this._mcCollect._visible = false;
      this._btnState._visible = false;
      this._btnAttackers.enabled = false;
      this._lblAttackersCount._visible = false;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this._btnPlayer0._visible = this._btnPlayer1._visible = this._btnPlayer2._visible = this._btnPlayer3._visible = this._btnPlayer4._visible = this._btnPlayer5._visible = this._btnPlayer6._visible = false;
   }
   function addListeners()
   {
      this._btnPlayer0.addEventListener("click",this);
      this._btnPlayer1.addEventListener("click",this);
      this._btnPlayer2.addEventListener("click",this);
      this._btnPlayer3.addEventListener("click",this);
      this._btnPlayer4.addEventListener("click",this);
      this._btnPlayer5.addEventListener("click",this);
      this._btnPlayer6.addEventListener("click",this);
      this._btnPlayer0.addEventListener("over",this);
      this._btnPlayer1.addEventListener("over",this);
      this._btnPlayer2.addEventListener("over",this);
      this._btnPlayer3.addEventListener("over",this);
      this._btnPlayer4.addEventListener("over",this);
      this._btnPlayer5.addEventListener("over",this);
      this._btnPlayer6.addEventListener("over",this);
      this._btnAttackers.addEventListener("over",this);
      this._btnState.addEventListener("over",this);
      this._btnPlayer0.addEventListener("out",this);
      this._btnPlayer1.addEventListener("out",this);
      this._btnPlayer2.addEventListener("out",this);
      this._btnPlayer3.addEventListener("out",this);
      this._btnPlayer4.addEventListener("out",this);
      this._btnPlayer5.addEventListener("out",this);
      this._btnPlayer6.addEventListener("out",this);
      this._btnAttackers.addEventListener("out",this);
      this._btnState.addEventListener("out",this);
      this._vcTimer.addEventListener("endTimer",this);
   }
   function showButtonsJoin(nPlayerCount)
   {
      this._mcBackButtons._visible = true;
      var _loc3_ = 0;
      while(_loc3_ < nPlayerCount)
      {
         this["_btnPlayer" + _loc3_]._visible = true;
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = _loc3_;
      while(_loc4_ < 7)
      {
         this["_btnPlayer" + _loc4_]._visible = false;
         _loc4_ = _loc4_ + 1;
      }
   }
   function hideButtonsJoin()
   {
      this._mcBackButtons._visible = false;
      var _loc2_ = 0;
      while(_loc2_ < 7)
      {
         this["_btnPlayer" + _loc2_]._visible = false;
         _loc2_ = _loc2_ + 1;
      }
   }
   function updatePlayers()
   {
      var _loc2_ = this._oItem.players;
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         var _loc4_ = this["_btnPlayer" + _loc3_];
         var _loc5_ = _loc2_[_loc3_];
         _loc4_.iconClip.data = _loc5_;
         _loc4_.params = {player:_loc5_};
         _loc3_ = _loc3_ + 1;
      }
      var _loc6_ = _loc3_;
      while(_loc6_ < 7)
      {
         var _loc7_ = this["_btnPlayer" + _loc6_];
         _loc7_.iconClip.data = null;
         _loc7_.params = new Object();
         _loc6_ = _loc6_ + 1;
      }
   }
   function updateAttackers()
   {
      this._lblAttackersCount._visible = true;
      if(this._oItem.state == 1)
      {
         var _loc2_ = this._oItem.attackers.length;
         this._lblAttackersCount.text = String(_loc2_);
         this._btnAttackers._visible = _loc2_ > 0;
      }
      else
      {
         this._lblAttackersCount.text = "-";
      }
   }
   function showStateIcon()
   {
      this._btnState._visible = true;
      this._mcFight._visible = this._oItem.state == 2;
      this._mcEnterFight._visible = this._oItem.state == 1;
      this._mcCollect._visible = this._oItem.state == 0;
   }
   function click(oEvent)
   {
      var _loc3_ = this._mcList.gapi.api;
      if(_loc3_.datacenter.Player.cantInteractWithTaxCollector)
      {
         return undefined;
      }
      var _loc4_ = oEvent.target.params.player;
      if(_loc4_ != undefined)
      {
         if(_loc4_.id == _loc3_.datacenter.Player.ID)
         {
            _loc3_.network.Guild.leaveTaxCollector(this._oItem.id);
         }
      }
      else
      {
         var _loc5_ = _loc3_.datacenter.Player.guildInfos;
         if(_loc5_.isLocalPlayerDefender)
         {
            if(_loc5_.defendedTaxCollectorID != this._oItem.id)
            {
               _loc3_.network.Guild.leaveTaxCollector(_loc5_.defendedTaxCollectorID);
               _loc3_.network.Guild.joinTaxCollector(this._oItem.id);
            }
         }
         else
         {
            _loc3_.network.Guild.joinTaxCollector(this._oItem.id);
         }
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnAttackers":
            if(!this._lblAttackersCount._visible)
            {
               return undefined;
            }
            var _loc3_ = this._oItem.attackers.length;
            if(_loc3_ == 0)
            {
               return undefined;
            }
            var _loc4_ = new String();
            var _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               var _loc6_ = this._oItem.attackers[_loc5_];
               _loc4_ = _loc4_ + ("\n" + _loc6_.name + " (" + _loc6_.level + ")");
               _loc5_ = _loc5_ + 1;
            }
            this._mcList.gapi.showTooltip(this._mcList.gapi.api.lang.getText("ATTACKERS") + " : " + _loc4_,oEvent.target,40);
            break;
         case "_btnState":
            var _loc7_ = new String();
            switch(this._oItem.state)
            {
               case 0:
                  _loc7_ = this._mcList.gapi.api.lang.getText("TAX_IN_COLLECT");
                  break;
               case 1:
                  _loc7_ = this._mcList.gapi.api.lang.getText("TAX_IN_ENTERFIGHT");
                  break;
               case 2:
                  _loc7_ = this._mcList.gapi.api.lang.getText("TAX_IN_FIGHT");
            }
            if(this._oItem.showMoreInfo)
            {
               if(this._oItem.callerName != "?")
               {
                  _loc7_ = _loc7_ + ("\n" + this._mcList.gapi.api.lang.getText("OWNER_WORD") + " : " + this._oItem.callerName);
               }
               var _loc8_ = new Date(this._oItem.startDate);
               if(_loc8_.getFullYear() != 1970)
               {
                  _loc7_ = _loc7_ + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_START_DATE",[_loc8_.getDay(),_loc8_.getMonth() + 1,_loc8_.getFullYear() + this._mcList.gapi.api.lang.getTimeZoneText().z,_loc8_.getHours(),_loc8_.getMinutes()]));
               }
               if(this._oItem.lastHarvesterName != "?")
               {
                  _loc7_ = _loc7_ + ("\n" + this._mcList.gapi.api.lang.getText("LAST_HARVESTER_NAME") + " : " + this._oItem.lastHarvesterName);
               }
               _loc8_ = new Date(this._oItem.lastHarvestDate);
               if(_loc8_.getFullYear() != 1970)
               {
                  _loc7_ = _loc7_ + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_LAST_DATE",[_loc8_.getDay(),_loc8_.getMonth() + 1,_loc8_.getFullYear() + this._mcList.gapi.api.lang.getTimeZoneText().z,_loc8_.getHours(),_loc8_.getMinutes()]));
               }
               var _loc9_ = new Date();
               var _loc10_ = this._oItem.nextHarvestDate - _loc9_.valueOf();
               if(_loc10_ <= 0)
               {
                  _loc7_ = _loc7_ + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST"));
               }
               else
               {
                  var _loc11_ = Math.floor(_loc10_ / 1000 / 60 / 60);
                  var _loc12_ = Math.floor(_loc10_ / 1000 / 60 - _loc11_ * 60);
                  var _loc13_ = _loc11_ + " " + ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("HOURS"),"m",_loc11_ == 1);
                  if(_loc12_ == 0)
                  {
                     _loc7_ = _loc7_ + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST_IN",[_loc13_,""]));
                  }
                  else
                  {
                     var _loc14_ = this._mcList.gapi.api.lang.getText("AND") + " ";
                     var _loc15_ = _loc12_ + " " + ank.utils.PatternDecoder.combine(this._mcList.gapi.api.lang.getText("MINUTES"),"m",_loc12_ == 1);
                     _loc7_ = _loc7_ + ("\n" + this._mcList.gapi.api.lang.getText("TAX_COLLECTOR_CAN_BE_HARVEST_IN",[_loc13_,_loc14_ + _loc15_]));
                  }
               }
            }
            this._mcList.gapi.showTooltip(_loc7_,oEvent.target,40);
            break;
         default:
            var _loc16_ = oEvent.target.params.player;
            if(_loc16_ != undefined)
            {
               this._mcList.gapi.showTooltip(_loc16_.name + " (" + _loc16_.level + ")",oEvent.target,-20);
            }
      }
   }
   function out(oEvent)
   {
      this._mcList.gapi.hideTooltip();
   }
   function endTimer(oEvent)
   {
      this._vcTimer.stopTimer();
      this.showButtonsJoin(0);
      this._oItem.state = 2;
      this.showStateIcon();
      this.updateAttackers();
      this._mcList.gapi.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
   }
   function modelChanged(oEvent)
   {
      this._mcList.gapi.hideTooltip();
      this.updateAttackers();
      this.updatePlayers();
   }
}
