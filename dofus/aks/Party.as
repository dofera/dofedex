class dofus.aks.Party extends dofus.aks.Handler
{
   function Party(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function invite(sSpriteName)
   {
      this.aks.send("PI" + sSpriteName);
   }
   function refuseInvitation()
   {
      this.aks.send("PR",false);
   }
   function acceptInvitation()
   {
      this.aks.send("PA");
   }
   function leave(sSpriteID)
   {
      this.aks.send("PV" + (sSpriteID == undefined?"":sSpriteID));
      this.api.ui.getUIComponent("Banner").illustration.updateFlags();
   }
   function follow(bStop, sSpriteID)
   {
      this.aks.send("PF" + (!bStop?"+":"-") + sSpriteID);
   }
   function where()
   {
      this.aks.send("PW");
   }
   function followAll(bStop, sSpriteID)
   {
      this.aks.send("PG" + (!bStop?"+":"-") + sSpriteID);
   }
   function onInvite(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = sExtraData.split("|");
         var _loc5_ = _loc4_[0];
         var _loc6_ = _loc4_[1];
         if(_loc5_ == undefined || _loc6_ == undefined)
         {
            this.refuseInvitation();
            return undefined;
         }
         if(_loc5_ == this.api.datacenter.Player.Name)
         {
            this.api.kernel.showMessage(this.api.lang.getText("PARTY"),this.api.lang.getText("YOU_INVITE_B_IN_PARTY",[_loc6_]),"INFO_CANCEL",{name:"Party",listener:this});
         }
         if(_loc6_ == this.api.datacenter.Player.Name)
         {
            if(this.api.kernel.ChatManager.isBlacklisted(_loc5_))
            {
               this.refuseInvitation();
               return undefined;
            }
            this.api.electron.makeNotification(this.api.lang.getText("A_INVITE_YOU_IN_PARTY",[_loc5_]));
            this.api.kernel.showMessage(undefined,this.api.lang.getText("CHAT_A_INVITE_YOU_IN_PARTY",[this.api.kernel.ChatManager.getLinkName(_loc5_)]),"INFO_CHAT");
            this.api.kernel.showMessage(this.api.lang.getText("PARTY"),this.api.lang.getText("A_INVITE_YOU_IN_PARTY",[_loc5_]),"CAUTION_YESNOIGNORE",{name:"Party",player:_loc5_,listener:this,params:{player:_loc5_}});
            this.api.sounds.events.onGameInvitation();
         }
      }
      else
      {
         var _loc7_ = sExtraData.charAt(0);
         switch(_loc7_)
         {
            case "a":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_ALREADY_IN_GROUP"),"ERROR_CHAT",{name:"PartyError"});
               break;
            case "f":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_FULL"),"ERROR_CHAT",{name:"PartyError"});
               break;
            case "n":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_FIND_ACCOUNT_OR_CHARACTER",[sExtraData.substr(1)]),"ERROR_CHAT",{name:"PartyError"});
         }
      }
   }
   function onLeader(sExtraData)
   {
      var _loc3_ = sExtraData;
      var _loc4_ = this.api.ui.getUIComponent("Party");
      _loc4_.setLeader(_loc3_);
      var _loc5_ = _loc4_.getMember(_loc3_).name;
      if(_loc5_ != undefined)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("NEW_GROUP_LEADER",[_loc5_]),"INFO_CHAT");
      }
   }
   function onRefuse(sExtraData)
   {
      this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
      this.api.ui.unloadUIComponent("AskCancelParty");
   }
   function onAccept(sExtraData)
   {
      this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
      this.api.ui.unloadUIComponent("AskCancelParty");
   }
   function onCreate(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = sExtraData;
         if(_loc4_ != this.api.datacenter.Player.Name)
         {
            this.api.kernel.showMessage(undefined,this.api.lang.getText("U_ARE_IN_GROUP",[_loc4_]),"INFO_CHAT");
         }
         this.api.datacenter.Player.inParty = true;
         this.api.ui.loadUIComponent("Party","Party",undefined,{bStrayIfPresent:true});
      }
      else
      {
         var _loc5_ = sExtraData.charAt(0);
         switch(_loc5_)
         {
            case "a":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_ALREADY_IN_GROUP"),"ERROR_CHAT",{name:"PartyError"});
               break;
            case "f":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_FULL"),"ERROR_CHAT",{name:"PartyError"});
         }
      }
   }
   function onLeave(sExtraData)
   {
      var _loc3_ = this.api.ui.getUIComponent("Party");
      if(_loc3_.followID != undefined)
      {
         this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1]);
      }
      var _loc4_ = _loc3_.getMember(sExtraData).name;
      if(_loc4_ != undefined)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("A_KICK_FROM_PARTY",[_loc4_]),"INFO_CHAT");
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("LEAVE_GROUP"),"INFO_CHAT");
      }
      this.api.ui.unloadUIComponent("Party");
      this.api.ui.unloadUIComponent("AskYesNoIgnoreParty");
      this.api.ui.unloadUIComponent("AskCancelParty");
      this.api.datacenter.Player.inParty = false;
      this.api.datacenter.Basics.aks_infos_highlightCoords_clear(2);
   }
   function onFollow(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = this.api.ui.getUIComponent("Party");
         var _loc5_ = sExtraData;
         _loc4_.setFollow(_loc5_);
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("PARTY_NOT_IN_IN_GROUP"),"ERROR_BOX",{name:"PartyError"});
      }
   }
   function onMovement(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = this.api.ui.getUIComponent("Party");
      var _loc5_ = sExtraData.substr(1).split("|");
      var _loc6_ = 0;
      while(_loc6_ < _loc5_.length)
      {
         var _loc7_ = String(_loc5_[_loc6_]).split(";");
         var _loc8_ = _loc7_[0];
         switch(sExtraData.charAt(0))
         {
            case "+":
               var _loc9_ = _loc7_[1];
               var _loc10_ = _loc7_[2];
               var _loc11_ = Number(_loc7_[3]);
               var _loc12_ = Number(_loc7_[4]);
               var _loc13_ = Number(_loc7_[5]);
               var _loc14_ = _loc7_[6];
               var _loc15_ = _loc7_[7];
               var _loc16_ = Number(_loc7_[8]);
               var _loc17_ = Number(_loc7_[9]);
               var _loc18_ = Number(_loc7_[10]);
               var _loc19_ = Number(_loc7_[11]);
               var _loc20_ = new Object();
               _loc20_.id = _loc8_;
               _loc20_.name = _loc9_;
               _loc20_.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc10_ + ".swf";
               _loc20_.color1 = _loc11_;
               _loc20_.color2 = _loc12_;
               _loc20_.color3 = _loc13_;
               _loc20_.life = _loc15_;
               _loc20_.level = _loc16_;
               _loc20_.initiative = _loc17_;
               _loc20_.prospection = _loc18_;
               _loc20_.side = _loc19_;
               this.api.kernel.CharactersManager.setSpriteAccessories(_loc20_,_loc14_);
               _loc4_.addMember(_loc20_);
               break;
            case "-":
               _loc4_.removeMember(_loc8_,true);
               break;
            case "~":
               var _loc21_ = _loc7_[1];
               var _loc22_ = _loc7_[2];
               var _loc23_ = Number(_loc7_[3]);
               var _loc24_ = Number(_loc7_[4]);
               var _loc25_ = Number(_loc7_[5]);
               var _loc26_ = _loc7_[6];
               var _loc27_ = _loc7_[7];
               var _loc28_ = Number(_loc7_[8]);
               var _loc29_ = Number(_loc7_[9]);
               var _loc30_ = Number(_loc7_[10]);
               var _loc31_ = Number(_loc7_[11]);
               var _loc32_ = new Object();
               _loc32_.id = _loc8_;
               _loc32_.name = _loc21_;
               _loc32_.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc22_ + ".swf";
               _loc32_.color1 = _loc23_;
               _loc32_.color2 = _loc24_;
               _loc32_.color3 = _loc25_;
               _loc32_.life = _loc27_;
               _loc32_.level = _loc28_;
               _loc32_.initiative = _loc29_;
               _loc32_.prospection = _loc30_;
               _loc32_.side = _loc31_;
               this.api.kernel.CharactersManager.setSpriteAccessories(_loc32_,_loc26_);
               _loc4_.updateData(_loc32_);
         }
         _loc6_ = _loc6_ + 1;
      }
      _loc4_.refresh();
   }
   function cancel(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskCancelParty")
      {
         this.refuseInvitation();
      }
   }
   function yes(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskYesNoIgnoreParty")
      {
         this.acceptInvitation();
      }
   }
   function no(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskYesNoIgnoreParty")
      {
         this.refuseInvitation();
      }
   }
   function ignore(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskYesNoIgnoreParty")
      {
         this.api.kernel.ChatManager.addToBlacklist(oEvent.params.player);
         this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[oEvent.params.player]),"INFO_CHAT");
         this.refuseInvitation(oEvent.params.spriteID);
      }
   }
}
