class dofus.aks.Conquest extends dofus.aks.Handler
{
   function Conquest(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function getAlignedBonus()
   {
      this.aks.send("CB",true);
   }
   function prismInfosJoin()
   {
      this.api.datacenter.Conquest.clear();
      this.aks.send("CIJ",true);
   }
   function prismInfosLeave()
   {
      this.aks.send("CIV",false);
   }
   function prismFightJoin()
   {
      this.aks.send("CFJ",true);
   }
   function prismFightLeave()
   {
      this.aks.send("CFV",false);
   }
   function worldInfosJoin()
   {
      this.aks.send("CWJ",false);
   }
   function worldInfosLeave()
   {
      this.aks.send("CWV",false);
   }
   function switchPlaces(id)
   {
      this.aks.send("CFS" + id,true);
   }
   function requestBalance()
   {
      this.aks.send("Cb",true);
   }
   function onAreaAlignmentChanged(sExtraData)
   {
      var _loc3_ = String(sExtraData).split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = this.api.lang.getMapAreaText(_loc4_).n;
      var _loc7_ = this.api.lang.getAlignment(_loc5_).n;
      if(_loc5_ == -1)
      {
         this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("AREA_ALIGNMENT_PRISM_REMOVED",[_loc6_]) + "</b>","PVP_CHAT");
      }
      else
      {
         this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("AREA_ALIGNMENT_IS",[_loc6_,_loc7_]) + "</b>","PVP_CHAT");
      }
   }
   function onConquestBonus(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      var _loc4_ = String(_loc3_[0]).split(",");
      var _loc5_ = new dofus.datacenter.ConquestBonusData();
      _loc5_.xp = Number(_loc4_[0]);
      _loc5_.drop = Number(_loc4_[1]);
      _loc5_.recolte = Number(_loc4_[2]);
      _loc4_ = String(_loc3_[1]).split(",");
      var _loc6_ = new dofus.datacenter.ConquestBonusData();
      _loc6_.xp = Number(_loc4_[0]);
      _loc6_.drop = Number(_loc4_[1]);
      _loc6_.recolte = Number(_loc4_[2]);
      _loc4_ = String(_loc3_[2]).split(",");
      var _loc7_ = new dofus.datacenter.ConquestBonusData();
      _loc7_.xp = Number(_loc4_[0]);
      _loc7_.drop = Number(_loc4_[1]);
      _loc7_.recolte = Number(_loc4_[2]);
      this.api.datacenter.Conquest.alignBonus = _loc5_;
      this.api.datacenter.Conquest.rankMultiplicator = _loc6_;
      this.api.datacenter.Conquest.alignMalus = _loc7_;
   }
   function onConquestBalance(sExtraData)
   {
      var _loc3_ = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
      var _loc4_ = sExtraData.split(";");
      _loc3_.setBalance(Number(_loc4_[0]),Number(_loc4_[1]));
   }
   function onWorldData(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = new dofus.datacenter.ConquestWorldData();
      _loc4_.ownedAreas = Number(_loc3_[0]);
      _loc4_.totalAreas = Number(_loc3_[1]);
      _loc4_.possibleAreas = Number(_loc3_[2]);
      var _loc5_ = _loc3_[3];
      var _loc6_ = _loc5_.split(";");
      _loc4_.areas = new ank.utils.ExtendedArray();
      for(var i in _loc6_)
      {
         var _loc7_ = String(_loc6_[i]).split(",");
         if(_loc7_.length >= 5)
         {
            var _loc8_ = new dofus.datacenter.ConquestZoneData(Number(_loc7_[0]),Number(_loc7_[1]),Number(_loc7_[2]) == 1,Number(_loc7_[3]),Number(_loc7_[4]) == 1);
            _loc4_.areas.push(_loc8_);
         }
      }
      _loc4_.areas.sortOn("areaName");
      _loc4_.ownedVillages = Number(_loc3_[4]);
      _loc4_.totalVillages = Number(_loc3_[5]);
      var _loc9_ = _loc3_[6];
      var _loc10_ = _loc9_.split(";");
      _loc4_.villages = new ank.utils.ExtendedArray();
      for(var i in _loc10_)
      {
         var _loc11_ = String(_loc10_[i]).split(",");
         if(_loc11_.length == 4)
         {
            var _loc12_ = new dofus.datacenter.ConquestVillageData(Number(_loc11_[0]),Number(_loc11_[1]),Number(_loc11_[2]) == 1,Number(_loc11_[3]) == 1);
            _loc4_.villages.push(_loc12_);
         }
      }
      _loc4_.villages.sortOn("areaName");
      this.api.datacenter.Conquest.worldDatas = _loc4_;
   }
   function onPrismInfosJoined(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
      if(_loc4_ == 0)
      {
         var _loc6_ = Number(_loc3_[1]);
         var _loc7_ = Number(_loc3_[2]);
         var _loc8_ = Number(_loc3_[3]);
         var _loc9_ = new Object();
         _loc9_.error = 0;
         _loc9_.timer = _loc6_;
         _loc9_.maxTimer = _loc7_;
         _loc9_.timerReference = getTimer();
         _loc9_.maxTeamPositions = _loc8_;
         _loc5_.sharePropertiesWithTab(_loc9_);
      }
      else
      {
         var _loc10_ = new Object();
         switch(_loc4_)
         {
            case -1:
            case -2:
            case -3:
               _loc10_.error = _loc4_;
         }
         _loc5_.sharePropertiesWithTab(_loc10_);
      }
   }
   function onPrismInfosClosing(sExtraData)
   {
      var _loc3_ = (dofus.graphics.gapi.ui.Conquest)this.api.ui.getUIComponent("Conquest");
      _loc3_.sharePropertiesWithTab({noUnsubscribe:true});
      this.api.ui.unloadUIComponent("Conquest");
   }
   function onPrismAttacked(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1];
      var _loc6_ = _loc3_[2];
      var _loc7_ = "[" + _loc5_ + ", " + _loc6_ + "]";
      var _loc8_ = Number(this.api.lang.getMapText(_loc4_).sa);
      var _loc9_ = String(this.api.lang.getMapSubAreaText(_loc8_).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(_loc8_).n:String(this.api.lang.getMapSubAreaText(_loc8_).n).substr(2);
      if(_loc8_ == this.api.datacenter.Basics.gfx_lastSubarea)
      {
         this.api.kernel.showMessage(undefined,"<img src=\"CautionIcon\" hspace=\'0\' vspace=\'0\' width=\'13\' height=\'13\' />" + this.api.lang.getText("PRISM_ATTACKED",[_loc9_,_loc7_]),"PVP_CHAT");
         this.api.sounds.events.onTaxcollectorAttack();
      }
      else
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED",[_loc9_,_loc7_]),"PVP_CHAT");
      }
   }
   function onPrismSurvived(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1];
      var _loc6_ = _loc3_[2];
      var _loc7_ = "[" + _loc5_ + ", " + _loc6_ + "]";
      var _loc8_ = Number(this.api.lang.getMapText(_loc4_).sa);
      var _loc9_ = String(this.api.lang.getMapSubAreaText(_loc8_).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(_loc8_).n:String(this.api.lang.getMapSubAreaText(_loc8_).n).substr(2);
      this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED_SUVIVED",[_loc9_,_loc7_]),"PVP_CHAT");
   }
   function onPrismDead(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1];
      var _loc6_ = _loc3_[2];
      var _loc7_ = "[" + _loc5_ + ", " + _loc6_ + "]";
      var _loc8_ = Number(this.api.lang.getMapText(_loc4_).sa);
      var _loc9_ = String(this.api.lang.getMapSubAreaText(_loc8_).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(_loc8_).n:String(this.api.lang.getMapSubAreaText(_loc8_).n).substr(2);
      this.api.kernel.showMessage(undefined,this.api.lang.getText("PRISM_ATTACKED_DIED",[_loc9_,_loc7_]),"PVP_CHAT");
   }
   function onPrismFightAddPlayer(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = _global.parseInt(_loc4_[0],36);
      var _loc6_ = 1;
      while(_loc6_ < _loc4_.length)
      {
         var _loc7_ = _loc4_[_loc6_].split(";");
         if(_loc3_)
         {
            var _loc8_ = new Object();
            _loc8_.id = _global.parseInt(_loc7_[0],36);
            _loc8_.name = _loc7_[1];
            _loc8_.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + _loc7_[2] + ".swf";
            _loc8_.level = Number(_loc7_[3]);
            _loc8_.color1 = _global.parseInt(_loc7_[4],36);
            _loc8_.color2 = _global.parseInt(_loc7_[5],36);
            _loc8_.color3 = _global.parseInt(_loc7_[6],36);
            _loc8_.reservist = _loc7_[7] == "1";
            var _loc9_ = this.api.datacenter.Conquest.players.findFirstItem("id",_loc8_.id);
            if(_loc9_.index != -1)
            {
               this.api.datacenter.Conquest.players.updateItem(_loc9_.index,_loc8_);
            }
            else
            {
               this.api.datacenter.Conquest.players.push(_loc8_);
            }
         }
         else
         {
            var _loc10_ = _global.parseInt(_loc7_[0],36);
            var _loc11_ = this.api.datacenter.Conquest.players.findFirstItem("id",_loc10_);
            if(_loc11_.index != -1)
            {
               this.api.datacenter.Conquest.players.removeItems(_loc11_.index,1);
            }
         }
         _loc6_ = _loc6_ + 1;
      }
   }
   function onPrismFightAddEnemy(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = _global.parseInt(_loc4_[0],36);
      var _loc6_ = this.api.datacenter.Conquest.attackers;
      var _loc7_ = 1;
      while(_loc7_ < _loc4_.length)
      {
         var _loc8_ = _loc4_[_loc7_].split(";");
         if(_loc3_)
         {
            var _loc9_ = new Object();
            _loc9_.id = _global.parseInt(_loc8_[0],36);
            _loc9_.name = _loc8_[1];
            _loc9_.level = Number(_loc8_[2]);
            var _loc10_ = _loc6_.findFirstItem("id",_loc9_.id);
            if(_loc10_.index != -1)
            {
               _loc6_.updateItem(_loc10_.index,_loc9_);
            }
            else
            {
               _loc6_.push(_loc9_);
            }
         }
         else
         {
            var _loc11_ = _global.parseInt(_loc8_[0],36);
            var _loc12_ = _loc6_.findFirstItem("id",_loc11_);
            if(_loc12_.index != -1)
            {
               _loc6_.removeItems(_loc12_.index,1);
            }
         }
         _loc7_ = _loc7_ + 1;
      }
   }
}
