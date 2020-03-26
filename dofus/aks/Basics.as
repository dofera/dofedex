class dofus.aks.Basics extends dofus.aks.Handler
{
   function Basics(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function autorisedCommand(sCommand)
   {
      this.aks.send("BA" + sCommand,false,undefined,true);
   }
   function autorisedMoveCommand(nX, nY)
   {
      this.aks.send("BaM" + nX + "," + nY,false);
   }
   function autorisedKickCommand(sPlayerName, nTempo, sMessage)
   {
      this.aks.send("BaK" + sPlayerName + "|" + nTempo + "|" + sMessage,false);
   }
   function whoAmI()
   {
      this.whoIs("");
   }
   function whoIs(sName)
   {
      this.aks.send("BW" + sName);
   }
   function kick(nCellNum)
   {
      this.aks.send("BQ" + nCellNum,false);
   }
   function away()
   {
      this.aks.send("BYA",false);
   }
   function invisible()
   {
      this.aks.send("BYI",false);
   }
   function getDate()
   {
      this.aks.send("BD",false);
   }
   function fileCheckAnswer(nCheckID, nFileSize)
   {
      this.aks.send("BC" + nCheckID + ";" + nFileSize,false);
   }
   function sanctionMe(nSanctionID, nWordID)
   {
      this.aks.send("BK" + nSanctionID + "|" + nWordID,false);
   }
   function averagePing()
   {
      this.aks.send("Bp" + this.api.network.getAveragePing() + "|" + this.api.network.getAveragePingPacketsCount() + "|" + this.api.network.getAveragePingBufferSize(),false);
   }
   function onAuthorizedInterfaceOpen(sExtraData)
   {
      this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("A_GIVE_U_RIGHTS",[sExtraData]),"ERROR_BOX");
      this.api.datacenter.Player.isAuthorized = true;
   }
   function onAuthorizedInterfaceClose(sExtraData)
   {
      this.api.ui.unloadUIComponent("Debug");
      this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("A_REMOVE_U_RIGHTS",[sExtraData]),"ERROR_BOX");
      this.api.datacenter.Player.isAuthorized = false;
   }
   function onAuthorizedCommand(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = Number(sExtraData.charAt(0));
         var _loc5_ = "DEBUG_LOG";
         switch(_loc4_)
         {
            case 1:
               _loc5_ = "DEBUG_ERROR";
               break;
            case 2:
               _loc5_ = "DEBUG_INFO";
         }
         if(this.api.ui.getUIComponent("Debug") == undefined)
         {
            this.api.ui.loadUIComponent("Debug","Debug",undefined,{bStayIfPresent:true});
         }
         var _loc6_ = sExtraData.substr(1);
         this.api.kernel.showMessage(undefined,_loc6_,_loc5_);
         if(dofus.Constants.SAVING_THE_WORLD)
         {
            if(_loc6_.indexOf("BotKick inactif") == 0)
            {
               dofus.SaveTheWorld.getInstance().nextAction();
            }
         }
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("UNKNOW_COMMAND",["/a"]),"ERROR_CHAT");
      }
   }
   function onAuthorizedCommandPrompt(sExtraData)
   {
      this.api.datacenter.Basics.aks_a_prompt = sExtraData;
      this.api.ui.getUIComponent("Debug").setPrompt(sExtraData);
   }
   function onAuthorizedCommandClear()
   {
      this.api.ui.getUIComponent("Debug").clear();
   }
   function onAuthorizedLine(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = _loc3_[2];
      var _loc7_ = this.api.datacenter.Basics.aks_a_logs.split("<br/>");
      var _loc8_ = "<font color=\"#FFFFFF\">" + _loc6_ + "</font>";
      switch(_loc5_)
      {
         case 1:
            _loc8_ = "<font color=\"#FF0000\">" + _loc6_ + "</font>";
            break;
         case 2:
            _loc8_ = "<font color=\"#00FF00\">" + _loc6_ + "</font>";
      }
      if(!_global.isNaN(_loc4_) && _loc4_ < _loc7_.length)
      {
         _loc7_[_loc7_.length - _loc4_] = _loc8_;
         this.api.datacenter.Basics.aks_a_logs = _loc7_.join("<br/>");
         this.api.ui.getUIComponent("Debug").refresh();
      }
   }
   function onReferenceTime(sExtraData)
   {
      var _loc3_ = Number(sExtraData);
      this.api.kernel.NightManager.setReferenceTime(_loc3_);
   }
   function onDate(sExtraData)
   {
      this.api.datacenter.Basics.lastDateUpdate = getTimer();
      var _loc3_ = sExtraData.split("|");
      this.api.kernel.NightManager.setReferenceDate(Number(_loc3_[0]),Number(_loc3_[1]),Number(_loc3_[2]));
   }
   function onWhoIs(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = sExtraData.split("|");
         if(_loc4_.length != 4)
         {
            return undefined;
         }
         var _loc5_ = _loc4_[0];
         var _loc6_ = _loc4_[1];
         var _loc7_ = _loc4_[2];
         var _loc8_ = Number(_loc4_[3]) == -1?this.api.lang.getText("UNKNOWN_AREA"):this.api.lang.getMapAreaText(Number(_loc4_[3])).n;
         if(_loc5_.toLowerCase() == this.api.datacenter.Basics.login)
         {
            switch(_loc6_)
            {
               case "1":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("I_AM_IN_SINGLE_GAME",[_loc7_,_loc5_,_loc8_]),"INFO_CHAT");
                  break;
               case "2":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("I_AM_IN_GAME",[_loc7_,_loc5_,_loc8_]),"INFO_CHAT");
            }
         }
         else
         {
            switch(_loc6_)
            {
               case "1":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("IS_IN_SINGLE_GAME",[_loc7_,_loc5_,_loc8_]),"INFO_CHAT");
                  break;
               case "2":
                  this.api.kernel.showMessage(undefined,this.api.lang.getText("IS_IN_GAME",[_loc7_,_loc5_,_loc8_]),"INFO_CHAT");
            }
         }
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER",[sExtraData]),"ERROR_CHAT");
      }
   }
   function onFileCheck(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1];
      if(_loc5_.indexOf("bright.swf") == 0)
      {
         this.api.network.send("BC" + _loc4_ + ";-1",false);
         sExtraData = _loc5_.substr(10);
         this.onBrightCell(sExtraData);
      }
      else
      {
         dofus.utils.Api.getInstance().checkFileSize(_loc5_,_loc4_);
      }
   }
   function onBrightCell(sExtraData)
   {
      var _loc3_ = sExtraData.split("/");
      var _loc4_ = Number(_loc3_[0]);
      if(_loc4_ == 0)
      {
         this.api.gfx.unSelect(true);
      }
      else if(sExtraData.charAt(0) == "-")
      {
         var _loc5_ = _loc3_[0].substr(1).split(".");
         this.api.gfx.unSelect(false,_loc5_,"brightedPosition");
      }
      else
      {
         var _loc6_ = _loc3_[0].split(".");
         var _loc7_ = _global.parseInt(_loc3_[1],16);
         this.api.gfx.select(_loc6_,_loc7_,"brightedPosition");
      }
   }
   function onAveragePing(sExtraData)
   {
      this.averagePing();
   }
   function onSubscriberRestriction(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      if(_loc3_)
      {
         var _loc4_ = Number(sExtraData.substr(1));
         if(_loc4_ != 10)
         {
            this.api.ui.loadUIComponent("PayZoneDialog2","PayZoneDialog2",{dialogID:_loc4_,name:"El Pemy",gfx:"9059"});
         }
         else
         {
            this.api.ui.loadUIComponent("PayZone","PayZone",{dialogID:_loc4_},{bForceLoad:true});
            this.api.datacenter.Basics.payzone_isFirst = false;
         }
      }
      else
      {
         this.api.ui.unloadUIComponent("PayZone");
      }
   }
}
