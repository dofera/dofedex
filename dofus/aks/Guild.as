class dofus.aks.Guild extends dofus.aks.Handler
{
   function Guild(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function create(nBackID, nBackColor, nSymbolID, nSymbolColor, sName)
   {
      this.aks.send("gC" + nBackID + "|" + nBackColor + "|" + nSymbolID + "|" + nSymbolColor + "|" + sName);
   }
   function leave()
   {
      this.aks.send("gV");
   }
   function leaveTaxInterface()
   {
      this.aks.send("gITV",false);
   }
   function invite(sPlayerName)
   {
      this.aks.send("gJR" + sPlayerName);
   }
   function acceptInvitation(nPlayerID)
   {
      this.aks.send("gJK" + nPlayerID);
   }
   function refuseInvitation(nPlayerID)
   {
      this.aks.send("gJE" + nPlayerID,false);
   }
   function getInfosGeneral()
   {
      this.aks.send("gIG",true);
   }
   function getInfosMembers()
   {
      this.aks.send("gIM",true);
   }
   function getInfosBoosts()
   {
      this.aks.send("gIB",true);
   }
   function getInfosTaxCollector()
   {
      this.aks.send("gIT",false);
   }
   function getInfosMountPark()
   {
      this.aks.send("gIF",false);
   }
   function getInfosGuildHouses()
   {
      this.aks.send("gIH",false);
   }
   function bann(sPlayerName)
   {
      this.aks.send("gK" + sPlayerName);
   }
   function changeMemberProfil(oMember)
   {
      this.aks.send("gP" + oMember.id + "|" + oMember.rank + "|" + oMember.percentxp + "|" + oMember.rights.value,true);
   }
   function boostCharacteristic(sCharacteristic)
   {
      var _loc3_ = sCharacteristic;
      switch(_loc3_)
      {
         case "c":
            _loc3_ = "k";
            break;
         case "w":
            _loc3_ = "o";
      }
      this.aks.send("gB" + _loc3_,true);
   }
   function boostSpell(nSpellID)
   {
      this.aks.send("gb" + nSpellID,true);
   }
   function hireTaxCollector()
   {
      this.aks.send("gH");
   }
   function joinTaxCollector(nTaxID)
   {
      this.aks.send("gTJ" + nTaxID,false);
   }
   function leaveTaxCollector(nTaxID, nID)
   {
      this.aks.send("gTV" + nTaxID + (nID == undefined?"":"|" + nID),false);
   }
   function removeTaxCollector(nID)
   {
      this.aks.send("gF" + nID,false);
   }
   function teleportToGuildHouse(nHouseID)
   {
      this.aks.send("gh" + nHouseID,false);
   }
   function teleportToGuildFarm(nID)
   {
      this.aks.send("gf" + nID,false);
   }
   function onNew()
   {
      this.api.ui.loadUIComponent("CreateGuild","CreateGuild");
   }
   function onCreate(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATED"),"INFO_CHAT");
         this.api.ui.loadUIAutoHideComponent("Guild","Guild",{currentTab:"Members"},{bStayIfPresent:true});
      }
      else
      {
         switch(sExtraData)
         {
            case "an":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATE_ALLREADY_USE_NAME"),"ERROR_BOX");
               break;
            case "ae":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATE_ALLREADY_USE_EMBLEM"),"ERROR_BOX");
               break;
            case "a":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_CREATE_ALLREADY_IN_GUILD"),"ERROR_BOX");
         }
         this.api.ui.getUIComponent("CreateGuild").enabled = true;
      }
   }
   function onStats(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _global.parseInt(_loc3_[1],36);
      var _loc6_ = _global.parseInt(_loc3_[2],36);
      var _loc7_ = _global.parseInt(_loc3_[3],36);
      var _loc8_ = _global.parseInt(_loc3_[4],36);
      var _loc9_ = _global.parseInt(_loc3_[5],36);
      if(this.api.datacenter.Player.guildInfos == undefined)
      {
         this.api.datacenter.Player.guildInfos = new dofus.datacenter.GuildInfos(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
      }
      else
      {
         this.api.datacenter.Player.guildInfos.initialize(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
      }
   }
   function onInfosGeneral(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0] == "1";
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = Number(_loc3_[2]);
      var _loc7_ = Number(_loc3_[3]);
      var _loc8_ = Number(_loc3_[4]);
      this.api.datacenter.Player.guildInfos.setGeneralInfos(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
   }
   function onInfosMembers(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = this.api.datacenter.Player.guildInfos;
      var _loc6_ = 0;
      while(_loc6_ < _loc4_.length)
      {
         var _loc7_ = _loc4_[_loc6_].split(";");
         var _loc8_ = new Object();
         _loc8_.id = Number(_loc7_[0]);
         if(_loc3_)
         {
            var _loc9_ = _loc5_.members.length == 0;
            _loc8_.name = _loc7_[1];
            _loc8_.level = Number(_loc7_[2]);
            _loc8_.gfx = Number(_loc7_[3]);
            _loc8_.rank = Number(_loc7_[4]);
            _loc8_.rankOrder = this.api.lang.getRankInfos(_loc8_.rank).o;
            _loc8_.winxp = Number(_loc7_[5]);
            _loc8_.percentxp = Number(_loc7_[6]);
            _loc8_.rights = new dofus.datacenter.GuildRights(Number(_loc7_[7]));
            _loc8_.state = Number(_loc7_[8]);
            _loc8_.alignement = Number(_loc7_[9]);
            _loc8_.lastConnection = Number(_loc7_[10]);
            _loc8_.isLocalPlayer = _loc8_.id == this.api.datacenter.Player.ID;
            if(_loc9_)
            {
               _loc5_.members.push(_loc8_);
            }
            else
            {
               var _loc10_ = _loc5_.members.findFirstItem("id",_loc8_.id);
               if(_loc10_.index != -1)
               {
                  _loc5_.members.updateItem(_loc10_.index,_loc8_);
               }
               else
               {
                  _loc5_.members.push(_loc8_);
               }
            }
            _loc5_.members.sortOn("rankOrder",Array.NUMERIC);
         }
         else
         {
            var _loc11_ = _loc5_.members.findFirstItem("id",_loc8_.id);
            if(_loc11_.index != -1)
            {
               _loc5_.members.removeItems(_loc11_.index,1);
            }
         }
         _loc6_ = _loc6_ + 1;
      }
      _loc5_.setMembers();
   }
   function onInfosBoosts(sExtraData)
   {
      if(sExtraData.length == 0)
      {
         this.api.datacenter.Player.guildInfos.setNoBoosts();
      }
      else
      {
         var _loc3_ = sExtraData.split("|");
         var _loc4_ = Number(_loc3_[0]);
         var _loc5_ = Number(_loc3_[1]);
         var _loc6_ = Number(_loc3_[2]);
         var _loc7_ = Number(_loc3_[3]);
         var _loc8_ = Number(_loc3_[4]);
         var _loc9_ = Number(_loc3_[5]);
         var _loc10_ = Number(_loc3_[6]);
         var _loc11_ = Number(_loc3_[7]);
         var _loc12_ = Number(_loc3_[8]);
         var _loc13_ = Number(_loc3_[9]);
         _loc3_.splice(0,10);
         var _loc14_ = 0;
         while(_loc14_ < _loc3_.length)
         {
            _loc3_[_loc14_] = _loc3_[_loc14_].split(";");
            _loc14_ = _loc14_ + 1;
         }
         _loc3_.sortOn("0");
         var _loc15_ = new ank.utils.ExtendedArray();
         var _loc16_ = 0;
         while(_loc16_ < _loc3_.length)
         {
            var _loc17_ = Number(_loc3_[_loc16_][0]);
            var _loc18_ = Number(_loc3_[_loc16_][1]);
            _loc15_.push(new dofus.datacenter.Spell(_loc17_,_loc18_));
            _loc16_ = _loc16_ + 1;
         }
         this.api.datacenter.Player.guildInfos.setBoosts(_loc5_,_loc4_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc15_);
      }
   }
   function onInfosMountPark(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = new ank.utils.ExtendedArray();
      var _loc6_ = 1;
      while(_loc6_ < _loc3_.length)
      {
         var _loc7_ = _loc3_[_loc6_].split(";");
         var _loc8_ = Number(_loc7_[0]);
         var _loc9_ = Number(_loc7_[1]);
         var _loc10_ = Number(_loc7_[2]);
         var _loc11_ = new dofus.datacenter.MountPark(0,-1,_loc9_,_loc10_,this.api.datacenter.Player.guildInfos.name);
         _loc11_.map = _loc8_;
         _loc11_.mounts = new ank.utils.ExtendedArray();
         if(_loc7_[3] != "")
         {
            var _loc12_ = _loc7_[3].split(",");
            var _loc13_ = 0;
            while(_loc13_ < _loc12_.length)
            {
               var _loc14_ = new dofus.datacenter.Mount(Number(_loc12_[_loc13_]));
               _loc14_.name = _loc12_[_loc13_ + 1] != ""?_loc12_[_loc13_ + 1]:this.api.lang.getText("NO_NAME");
               _loc14_.ownerName = _loc12_[_loc13_ + 2];
               _loc11_.mounts.push(_loc14_);
               _loc13_ = _loc13_ + 3;
            }
         }
         _loc5_.push(_loc11_);
         _loc6_ = _loc6_ + 1;
      }
      this.api.datacenter.Player.guildInfos.setMountParks(_loc4_,_loc5_);
   }
   function onInfosTaxCollectorsMovement(sExtraData)
   {
      if(sExtraData.length == 0)
      {
         this.api.datacenter.Player.guildInfos.setNoTaxCollectors();
      }
      else
      {
         var _loc3_ = sExtraData.charAt(0) == "+";
         var _loc4_ = sExtraData.substr(1).split("|");
         var _loc5_ = this.api.datacenter.Player.guildInfos;
         var _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            var _loc7_ = _loc4_[_loc6_].split(";");
            var _loc8_ = new Object();
            _loc8_.id = _global.parseInt(_loc7_[0],36);
            if(_loc3_)
            {
               var _loc9_ = _loc5_.taxCollectors.length == 0;
               var _loc10_ = _global.parseInt(_loc7_[2],36);
               var _loc11_ = this.api.lang.getMapText(_loc10_).x;
               var _loc12_ = this.api.lang.getMapText(_loc10_).y;
               _loc8_.name = this.api.lang.getFullNameText(_loc7_[1].split(","));
               _loc8_.position = this.api.kernel.MapsServersManager.getMapName(_loc10_) + " (" + _loc11_ + ", " + _loc12_ + ")";
               _loc8_.state = Number(_loc7_[3]);
               _loc8_.timer = Number(_loc7_[4]);
               _loc8_.maxTimer = Number(_loc7_[5]);
               _loc8_.timerReference = getTimer();
               _loc8_.maxPlayerCount = Number(_loc7_[6]);
               var _loc13_ = _loc7_[1].split(",");
               if(_loc13_.length != 2)
               {
                  _loc8_.showMoreInfo = true;
                  _loc8_.callerName = _loc13_[2] != ""?_loc13_[2]:"?";
                  _loc8_.startDate = _global.parseInt(_loc13_[3],10);
                  _loc8_.lastHarvesterName = _loc13_[4] != ""?_loc13_[4]:"?";
                  _loc8_.lastHarvestDate = _global.parseInt(_loc13_[5],10);
                  _loc8_.nextHarvestDate = _global.parseInt(_loc13_[6],10);
               }
               else
               {
                  _loc8_.showMoreInfo = false;
                  _loc8_.callerName = "?";
                  _loc8_.startDate = -1;
                  _loc8_.lastHarvesterName = "?";
                  _loc8_.lastHarvestDate = -1;
                  _loc8_.nextHarvestDate = -1;
               }
               _loc8_.players = new ank.utils.ExtendedArray();
               _loc8_.attackers = new ank.utils.ExtendedArray();
               if(_loc9_)
               {
                  _loc5_.taxCollectors.push(_loc8_);
               }
               else
               {
                  var _loc14_ = _loc5_.taxCollectors.findFirstItem("id",_loc8_.id);
                  if(_loc14_.index != -1)
                  {
                     _loc5_.taxCollectors.updateItem(_loc14_.index,_loc8_);
                  }
                  else
                  {
                     _loc5_.taxCollectors.push(_loc8_);
                  }
               }
            }
            else
            {
               var _loc15_ = _loc5_.taxCollectors.findFirstItem("id",_loc8_.id);
               if(_loc15_.index != -1)
               {
                  _loc5_.taxCollectors.removeItems(_loc15_.index,1);
               }
            }
            _loc6_ = _loc6_ + 1;
         }
         _loc5_.setTaxCollectors();
      }
   }
   function onInfosTaxCollectorsPlayers(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = _global.parseInt(_loc4_[0],36);
      var _loc6_ = this.api.datacenter.Player.guildInfos.taxCollectors;
      var _loc7_ = _loc6_.findFirstItem("id",_loc5_);
      if(_loc7_.index != -1)
      {
         var _loc8_ = _loc7_.item;
         var _loc9_ = 1;
         while(_loc9_ < _loc4_.length)
         {
            var _loc10_ = _loc4_[_loc9_].split(";");
            if(_loc3_)
            {
               var _loc11_ = new Object();
               _loc11_.id = _global.parseInt(_loc10_[0],36);
               _loc11_.name = _loc10_[1];
               _loc11_.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc10_[2] + ".swf";
               _loc11_.level = Number(_loc10_[3]);
               _loc11_.color1 = _global.parseInt(_loc10_[4],36);
               _loc11_.color2 = _global.parseInt(_loc10_[5],36);
               _loc11_.color3 = _global.parseInt(_loc10_[6],36);
               var _loc12_ = _loc8_.players.findFirstItem("id",_loc11_.id);
               if(_loc12_.index != -1)
               {
                  _loc8_.players.updateItem(_loc12_.index,_loc11_);
               }
               else
               {
                  _loc8_.players.push(_loc11_);
               }
               if(_loc11_.id == this.api.datacenter.Player.ID)
               {
                  this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = _loc5_;
               }
            }
            else
            {
               var _loc13_ = _global.parseInt(_loc10_[0],36);
               var _loc14_ = _loc8_.players.findFirstItem("id",_loc13_);
               if(_loc14_.index != -1)
               {
                  _loc8_.players.removeItems(_loc14_.index,1);
               }
               if(_loc13_ == this.api.datacenter.Player.ID)
               {
                  this.api.datacenter.Player.guildInfos.defendedTaxCollectorID = undefined;
               }
            }
            _loc9_ = _loc9_ + 1;
         }
      }
      else
      {
         ank.utils.Logger.err("[gITP] impossible de trouver le percepteur");
      }
   }
   function onInfosTaxCollectorsAttackers(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = _global.parseInt(_loc4_[0],36);
      var _loc6_ = this.api.datacenter.Player.guildInfos.taxCollectors;
      var _loc7_ = _loc6_.findFirstItem("id",_loc5_);
      if(_loc7_.index != -1)
      {
         var _loc8_ = _loc7_.item;
         var _loc9_ = 1;
         while(_loc9_ < _loc4_.length)
         {
            var _loc10_ = _loc4_[_loc9_].split(";");
            if(_loc3_)
            {
               var _loc11_ = new Object();
               _loc11_.id = _global.parseInt(_loc10_[0],36);
               _loc11_.name = _loc10_[1];
               _loc11_.level = Number(_loc10_[2]);
               var _loc12_ = _loc8_.attackers.findFirstItem("id",_loc11_.id);
               if(_loc12_.index != -1)
               {
                  _loc8_.attackers.updateItem(_loc12_.index,_loc11_);
               }
               else
               {
                  _loc8_.attackers.push(_loc11_);
               }
            }
            else
            {
               var _loc13_ = _global.parseInt(_loc10_[0],36);
               var _loc14_ = _loc8_.attackers.findFirstItem("id",_loc13_);
               if(_loc14_.index != -1)
               {
                  _loc8_.attackers.removeItems(_loc14_.index,1);
               }
            }
            _loc9_ = _loc9_ + 1;
         }
      }
      else
      {
         ank.utils.Logger.err("[gITp] impossible de trouver le percepteur");
      }
   }
   function onInfosHouses(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      if(sExtraData.length <= 1)
      {
         this.api.datacenter.Player.guildInfos.setNoHouses();
      }
      else
      {
         var _loc4_ = sExtraData.substr(1).split("|");
         var _loc5_ = new ank.utils.ExtendedArray();
         var _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            var _loc7_ = _loc4_[_loc6_].split(";");
            var _loc8_ = Number(_loc7_[0]);
            var _loc9_ = _loc7_[1];
            var _loc10_ = _loc7_[2].split(",");
            var _loc11_ = new com.ankamagames.types.Point(Number(_loc10_[0]),Number(_loc10_[1]));
            var _loc12_ = new Array();
            var _loc13_ = _loc7_[3].split(",");
            var _loc14_ = 0;
            while(_loc14_ < _loc13_.length)
            {
               _loc12_.push(Number(_loc13_[_loc14_]));
               _loc14_ = _loc14_ + 1;
            }
            var _loc15_ = _loc7_[4];
            var _loc16_ = new dofus.datacenter.House(_loc8_);
            _loc16_.ownerName = _loc9_;
            _loc16_.coords = _loc11_;
            _loc16_.skills = _loc12_;
            _loc16_.guildRights = _loc15_;
            _loc5_.push(_loc16_);
            _loc6_ = _loc6_ + 1;
         }
         this.api.datacenter.Player.guildInfos.setHouses(_loc5_);
      }
   }
   function onRequestLocal(sExtraData)
   {
      this.api.kernel.showMessage(this.api.lang.getText("GUILD"),this.api.lang.getText("YOU_INVIT_B_IN_GUILD",[sExtraData]),"INFO_CANCEL",{name:"Guild",listener:this,params:{spriteID:this.api.datacenter.Player.ID}});
   }
   function onRequestDistant(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0];
      var _loc5_ = _loc3_[1];
      var _loc6_ = _loc3_[2];
      if(this.api.kernel.ChatManager.isBlacklisted(_loc5_))
      {
         this.refuseInvitation(Number(_loc4_));
         return undefined;
      }
      this.api.electron.makeNotification(this.api.lang.getText("A_INVIT_YOU_IN_GUILD",[_loc5_,_loc6_]));
      this.api.kernel.showMessage(undefined,this.api.lang.getText("CHAT_A_INVIT_YOU_IN_GUILD",[this.api.kernel.ChatManager.getLinkName(_loc5_),_loc6_]),"INFO_CHAT");
      this.api.kernel.showMessage(this.api.lang.getText("GUILD"),this.api.lang.getText("A_INVIT_YOU_IN_GUILD",[_loc5_,_loc6_]),"CAUTION_YESNOIGNORE",{name:"Guild",player:_loc5_,listener:this,params:{spriteID:_loc4_,player:_loc5_}});
   }
   function onJoinError(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0);
      switch(_loc3_)
      {
         case "a":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_ALREADY_IN_GUILD"),"ERROR_CHAT");
            break;
         case "d":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_NO_RIGHTS"),"ERROR_CHAT");
            break;
         case "u":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_UNKNOW"),"ERROR_CHAT");
            break;
         case "o":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_OCCUPED"),"ERROR_CHAT");
            break;
         case "r":
            var _loc4_ = sExtraData.substr(1);
            this.api.kernel.showMessage(undefined,this.api.lang.getText("GUILD_JOIN_REFUSED",[_loc4_]),"ERROR_CHAT");
            this.api.ui.unloadUIComponent("AskCancelGuild");
            break;
         case "c":
            this.api.ui.unloadUIComponent("AskCancelGuild");
            this.api.ui.unloadUIComponent("AskYesNoIgnoreGuild");
      }
   }
   function onJoinOk(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0);
      switch(_loc3_)
      {
         case "a":
            this.api.ui.unloadUIComponent("AskCancelGuild");
            this.api.kernel.showMessage(undefined,this.api.lang.getText("A_JOIN_YOUR_GUILD",[sExtraData.substr(1)]),"INFO_CHAT");
            break;
         case "j":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("YOUR_R_NEW_IN_GUILD",[this.api.datacenter.Player.guildInfos.name]),"INFO_CHAT");
      }
   }
   function onJoinDistantOk()
   {
      this.api.ui.unloadUIComponent("AskYesNoIgnoreGuild");
   }
   function onLeave()
   {
      this.api.ui.unloadUIComponent("CreateGuild");
   }
   function onBann(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = sExtraData.split("|");
         var _loc5_ = _loc4_[0];
         var _loc6_ = _loc4_[1];
         var _loc7_ = _loc5_ == this.api.datacenter.Player.Name;
         if(_loc7_)
         {
            if(_loc5_ != _loc6_)
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_BANN_A_FROM_GUILD",[_loc6_]),"INFO_CHAT");
            }
            else
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_BANN_YOU_FROM_GUILD"),"INFO_CHAT");
               this.api.ui.unloadUIComponent("Guild");
               this.api.datacenter.Player.guildInfos = undefined;
            }
         }
         else
         {
            this.api.kernel.showMessage(undefined,this.api.lang.getText("YOU_ARE_BANN_BY_A_FROM_GUILD",[_loc5_]),"INFO_CHAT");
            this.api.ui.unloadUIComponent("Guild");
            delete this.api.datacenter.Player.guildInfos;
         }
      }
      else
      {
         var _loc8_ = sExtraData.charAt(0);
         switch(_loc8_)
         {
            case "d":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"),"ERROR_CHAT");
               break;
            case "a":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BANN_FROM_GUILD_NOT_MEMBER"),"ERROR_CHAT");
         }
      }
   }
   function onHireTaxCollector(bSuccess, sExtraData)
   {
      if(!bSuccess)
      {
         var _loc4_ = sExtraData.charAt(0);
         switch(_loc4_)
         {
            case "d":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGHT_RIGHTS_FROM_GUILD"),"ERROR_CHAT");
               break;
            case "a":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_TAXCOLLECTOR_ON_MAP"),"ERROR_CHAT");
               break;
            case "k":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_ENOUGTH_RICH_TO_HIRE_TAX"),"ERROR_CHAT");
               break;
            case "m":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_HIRE_MAX_TAXCOLLECTORS"),"ERROR_CHAT");
               break;
            case "b":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("NOT_YOUR_TAXCOLLECTORS"),"ERROR_CHAT");
               break;
            case "y":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_HIRE_TAXCOLLECTORS_TOO_TIRED"),"ERROR_CHAT");
               break;
            case "h":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_HIRE_TAXCOLLECTORS_HERE"),"ERROR_CHAT");
         }
      }
   }
   function onTaxCollectorAttacked(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0].charAt(0);
      var _loc5_ = this.api.lang.getFullNameText(_loc3_[0].substr(1).split(","));
      var _loc6_ = Number(_loc3_[1]);
      var _loc7_ = _loc3_[2];
      var _loc8_ = _loc3_[3];
      var _loc9_ = "(" + _loc7_ + ", " + _loc8_ + ")";
      switch(_loc4_)
      {
         case "A":
            this.api.electron.makeNotification(this.api.lang.getText("TAX_ATTACKED",[_loc5_,_loc9_]));
            this.api.kernel.showMessage(undefined,"<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\' /><a href=\'asfunction:onHref,OpenGuildTaxCollectors\'>" + this.api.lang.getText("TAX_ATTACKED",[_loc5_,_loc9_]) + "</a>","GUILD_CHAT");
            this.api.sounds.events.onTaxcollectorAttack();
            break;
         case "S":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("TAX_ATTACKED_SUVIVED",[_loc5_,_loc9_]),"GUILD_CHAT");
            break;
         case "D":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("TAX_ATTACKED_DIED",[_loc5_,_loc9_]),"GUILD_CHAT");
      }
   }
   function onTaxCollectorInfo(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = _loc3_[0].charAt(0);
      var _loc5_ = this.api.lang.getFullNameText(_loc3_[0].substr(1).split(","));
      var _loc6_ = Number(_loc3_[1]);
      var _loc7_ = _loc3_[2];
      var _loc8_ = _loc3_[3];
      var _loc9_ = "(" + _loc7_ + ", " + _loc8_ + ")";
      var _loc10_ = _loc3_[4];
      switch(_loc4_)
      {
         case "S":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_ADDED",[_loc5_,_loc9_,_loc10_]),"GUILD_CHAT");
            break;
         case "R":
            this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_REMOVED",[_loc5_,_loc9_,_loc10_]),"GUILD_CHAT");
            break;
         case "G":
            var _loc11_ = _loc3_[5].split(";");
            var _loc12_ = Number(_loc11_[0]);
            var _loc13_ = _loc12_ + " " + this.api.lang.getText("EXPERIENCE_POINT");
            var _loc14_ = 1;
            while(_loc14_ < _loc11_.length)
            {
               var _loc15_ = _loc11_[_loc14_].split(",");
               var _loc16_ = _loc15_[0];
               var _loc17_ = _loc15_[1];
               _loc13_ = _loc13_ + (",<br/>" + _loc17_ + " x " + this.api.lang.getItemUnicText(_loc16_).n);
               _loc14_ = _loc14_ + 1;
            }
            _loc13_ = _loc13_ + ".";
            this.api.kernel.showMessage(undefined,this.api.lang.getText("TAXCOLLECTOR_RECOLTED",[_loc5_,_loc9_,_loc10_,_loc13_]),"GUILD_CHAT");
      }
   }
   function onUserInterfaceOpen(sExtraData)
   {
      switch(sExtraData)
      {
         case "T":
            if(this.api.datacenter.Player.guildInfos.name != undefined)
            {
               this.api.ui.loadUIAutoHideComponent("Guild","Guild",{currentTab:"GuildHouses"});
            }
            else
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("ITEM_NEED_GUILD"),"ERROR_CHAT");
            }
            break;
         case "F":
            if(this.api.datacenter.Player.guildInfos.name != undefined)
            {
               this.api.ui.loadUIAutoHideComponent("Guild","Guild",{currentTab:"MountParks"});
            }
            else
            {
               this.api.kernel.showMessage(undefined,this.api.lang.getText("ITEM_NEED_GUILD"),"ERROR_CHAT");
            }
      }
   }
   function cancel(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskCancelGuild")
      {
         this.refuseInvitation(oEvent.params.spriteID);
      }
   }
   function yes(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskYesNoIgnoreGuild")
      {
         this.acceptInvitation(oEvent.params.spriteID);
      }
   }
   function no(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskYesNoIgnoreGuild")
      {
         this.refuseInvitation(oEvent.params.spriteID);
      }
   }
   function ignore(oEvent)
   {
      if((var _loc0_ = oEvent.target._name) === "AskYesNoIgnoreGuild")
      {
         this.api.kernel.ChatManager.addToBlacklist(oEvent.params.player);
         this.api.kernel.showMessage(undefined,this.api.lang.getText("TEMPORARY_BLACKLISTED",[oEvent.params.player]),"INFO_CHAT");
         this.refuseInvitation(oEvent.params.spriteID);
      }
   }
}
