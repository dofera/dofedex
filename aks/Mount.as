class dofus.aks.Mount extends dofus.aks.Handler
{
   function Mount(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function rename(sName)
   {
      this.aks.send("Rn" + sName,true);
   }
   function kill()
   {
      this.aks.send("Rf");
   }
   function setXP(nValue)
   {
      this.aks.send("Rx" + nValue,true);
   }
   function ride()
   {
      this.aks.send("Rr",false);
   }
   function data(nMountID, sTime)
   {
      this.aks.send("Rd" + nMountID + "|" + sTime,true);
   }
   function parkMountData(nSpriteID)
   {
      this.aks.send("Rp" + nSpriteID,true);
   }
   function removeObjectInPark(nCellNum)
   {
      this.aks.send("Ro" + nCellNum,true);
   }
   function mountParkSell(nPrice)
   {
      this.aks.send("Rs" + nPrice,true);
   }
   function mountParkBuy(nPrice)
   {
      this.aks.send("Rb" + nPrice,true);
   }
   function leave()
   {
      this.aks.send("Rv");
   }
   function castrate()
   {
      this.aks.send("Rc");
   }
   function onEquip(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0);
      switch(_loc3_)
      {
         case "+":
            this.api.datacenter.Player.mount = this.createMount(sExtraData.substr(1));
            break;
         case "-":
            this.unequipMount();
            break;
         case "E":
            this.equipError(sExtraData.charAt(1));
      }
   }
   function onXP(sExtraData)
   {
      var _loc3_ = Number(sExtraData);
      if(!_global.isNaN(_loc3_))
      {
         this.api.datacenter.Player.mountXPPercent = _loc3_;
      }
   }
   function onName(sExtraData)
   {
      this.api.datacenter.Player.mount.name = sExtraData;
   }
   function onData(sExtraData)
   {
      var _loc3_ = this.createMount(sExtraData);
      this.api.ui.loadUIComponent("MountViewer","MountViewer",{mount:_loc3_});
   }
   function onMountPark(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = Number(_loc3_[2]);
      var _loc7_ = Number(_loc3_[3]);
      var _loc8_ = _loc3_[4];
      var _loc9_ = _loc3_[5];
      var _loc10_ = this.api.kernel.CharactersManager.createGuildEmblem(_loc9_);
      this.api.datacenter.Map.mountPark = new dofus.datacenter.MountPark(_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc10_);
   }
   function onRidingState(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0);
      switch(_loc3_)
      {
         case "+":
            this.api.datacenter.Player.isRiding = true;
            break;
         case "-":
            this.api.datacenter.Player.isRiding = false;
      }
   }
   function onMountParkBuy(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      this.api.ui.loadUIComponent("MountParkSale","MountParkSale",{defaultPrice:Number(_loc3_[1])});
   }
   function onLeave()
   {
      this.api.ui.unloadUIComponent("MountParkSale");
   }
   function equipError(errorType)
   {
      switch(errorType)
      {
         case "-":
            var _loc3_ = this.api.lang.getText("MOUNT_ERROR_INVENTORY_NOT_EMPTY");
            break;
         case "+":
            _loc3_ = this.api.lang.getText("MOUNT_ERROR_ALREADY_HAVE_ONE");
            break;
         case "r":
            _loc3_ = this.api.lang.getText("MOUNT_ERROR_RIDE");
      }
      this.api.kernel.showMessage(undefined,_loc3_,"ERROR_CHAT");
   }
   function unequipMount()
   {
      this.api.datacenter.Player.mount = undefined;
   }
   function createMount(sParams, newBorn)
   {
      var _loc4_ = sParams.split(":");
      var _loc5_ = Number(_loc4_[1]);
      var _loc6_ = new dofus.datacenter.Mount(_loc5_,undefined,newBorn);
      _loc6_.ID = _loc4_[0];
      _loc6_.ancestors = _loc4_[2].split(",");
      var _loc7_ = _loc4_[3].split(",");
      _loc6_.capacities = new ank.utils.ExtendedArray();
      var _loc8_ = 0;
      while(_loc8_ < _loc7_.length)
      {
         var _loc9_ = Number(_loc7_[_loc8_]);
         if(_loc9_ != 0 && !_global.isNaN(_loc9_))
         {
            _loc6_.capacities.push({label:this.api.lang.getMountCapacity(_loc9_).n,data:_loc9_});
         }
         _loc8_ = _loc8_ + 1;
      }
      _loc6_.name = _loc4_[4] != ""?_loc4_[4]:this.api.lang.getText("NO_NAME");
      _loc6_.sex = Number(_loc4_[5]);
      var _loc10_ = _loc4_[6].split(",");
      _loc6_.xp = Number(_loc10_[0]);
      _loc6_.xpMin = Number(_loc10_[1]);
      _loc6_.xpMax = Number(_loc10_[2]);
      _loc6_.level = Number(_loc4_[7]);
      _loc6_.mountable = !!Number(_loc4_[8]);
      _loc6_.podsMax = Number(_loc4_[9]);
      _loc6_.wild = !!Number(_loc4_[10]);
      var _loc11_ = _loc4_[11].split(",");
      _loc6_.stamina = Number(_loc11_[0]);
      _loc6_.staminaMax = Number(_loc11_[1]);
      var _loc12_ = _loc4_[12].split(",");
      _loc6_.maturity = Number(_loc12_[0]);
      _loc6_.maturityMax = Number(_loc12_[1]);
      var _loc13_ = _loc4_[13].split(",");
      _loc6_.energy = Number(_loc13_[0]);
      _loc6_.energyMax = Number(_loc13_[1]);
      var _loc14_ = _loc4_[14].split(",");
      _loc6_.serenity = Number(_loc14_[0]);
      _loc6_.serenityMin = Number(_loc14_[1]);
      _loc6_.serenityMax = Number(_loc14_[2]);
      var _loc15_ = _loc4_[15].split(",");
      _loc6_.love = Number(_loc15_[0]);
      _loc6_.loveMax = Number(_loc15_[1]);
      _loc6_.fecondation = Number(_loc4_[16]);
      _loc6_.fecondable = !!Number(_loc4_[17]);
      _loc6_.setEffects(_loc4_[18]);
      var _loc16_ = _loc4_[19].split(",");
      _loc6_.tired = Number(_loc16_[0]);
      _loc6_.tiredMax = Number(_loc16_[1]);
      var _loc17_ = _loc4_[20].split(",");
      _loc6_.reprod = Number(_loc17_[0]);
      _loc6_.reprodMax = Number(_loc17_[1]);
      return _loc6_;
   }
}
