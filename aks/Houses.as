class dofus.aks.Houses extends dofus.aks.Handler
{
   function Houses(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function kick(nID)
   {
      this.aks.send("hQ" + nID);
   }
   function leave()
   {
      this.aks.send("hV");
   }
   function sell(nPrice)
   {
      this.aks.send("hS" + nPrice,true);
   }
   function buy(nPrice)
   {
      this.aks.send("hB" + nPrice,true);
   }
   function state()
   {
      this.aks.send("hG",true);
   }
   function share()
   {
      this.aks.send("hG+",true);
   }
   function unshare()
   {
      this.aks.send("hG-",true);
   }
   function rights(nRights)
   {
      this.aks.send("hG" + nRights,true);
   }
   function onList(sExtraData)
   {
      var _loc3_ = sExtraData.charAt(0) == "+";
      var _loc4_ = sExtraData.substr(1).split("|");
      var _loc5_ = 0;
      while(_loc5_ < _loc4_.length)
      {
         var _loc6_ = _loc4_[_loc5_].split(";");
         var _loc7_ = _loc6_[0];
         var _loc8_ = _loc6_[1] == "1";
         var _loc9_ = _loc6_[2] == "1";
         var _loc10_ = _loc4_[3] == "1";
         var _loc11_ = this.api.datacenter.Houses;
         if(_loc3_)
         {
            var _loc12_ = _loc11_.getItemAt(_loc7_);
            if(_loc12_ == undefined)
            {
               _loc12_ = new dofus.datacenter.House(_loc7_);
            }
            _loc12_.localOwner = _loc3_;
            _loc12_.isLocked = _loc8_;
            _loc12_.isForSale = _loc9_;
            _loc12_.isShared = _loc10_;
            _loc11_.addItemAt(_loc7_,_loc12_);
         }
         else
         {
            var _loc13_ = _loc11_.getItemAt(_loc7_);
            _loc13_.localOwner = false;
            var _loc14_ = this.api.lang.getHousesMapText(this.api.datacenter.Map.id);
            if(_loc14_ == _loc7_)
            {
               this.api.ui.unloadUIComponent("HouseIndoor");
            }
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function onProperties(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1].split(";");
      var _loc6_ = _loc5_[0];
      var _loc7_ = _loc5_[1] == "1";
      var _loc8_ = _loc5_[2];
      var _loc9_ = this.api.kernel.CharactersManager.createGuildEmblem(_loc5_[3]);
      var _loc10_ = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(_loc4_);
      if(_loc10_ == undefined)
      {
         _loc10_ = new dofus.datacenter.House(_loc4_);
         this.api.datacenter.Houses.addItemAt(_loc4_,_loc10_);
      }
      _loc10_.ownerName = _loc6_;
      _loc10_.isForSale = _loc7_;
      _loc10_.guildName = _loc8_;
      _loc10_.guildEmblem = _loc9_;
   }
   function onLockedProperty(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = _loc3_[1] == "1";
      var _loc6_ = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(_loc4_);
      if(_loc6_ == undefined)
      {
         _loc6_ = new dofus.datacenter.House(_loc4_);
         this.api.datacenter.Houses.addItemAt(_loc4_,_loc6_);
      }
      _loc6_.isLocked = _loc5_;
   }
   function onCreate(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = Number(_loc3_[1]);
      var _loc6_ = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(_loc4_);
      if(_loc6_ == undefined)
      {
         _loc6_ = new dofus.datacenter.House(_loc4_);
      }
      _loc6_.price = _loc5_;
      this.api.ui.loadUIComponent("HouseSale","HouseSale",{house:_loc6_});
   }
   function onSell(bSuccess, sExtraData)
   {
      var _loc4_ = sExtraData.split("|");
      var _loc5_ = Number(_loc4_[0]);
      var _loc6_ = Number(_loc4_[1]);
      var _loc7_ = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(_loc5_);
      if(_loc7_ == undefined)
      {
         _loc7_ = new dofus.datacenter.House(_loc5_);
      }
      _loc7_.isForSale = _loc6_ > 0;
      _loc7_.price = _loc6_;
      if(_loc6_ > 0)
      {
         if(bSuccess)
         {
            this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_SELL",[_loc7_.name,_loc7_.price]),"ERROR_BOX",{name:"SellHouse"});
         }
         else
         {
            this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_SELL_HOUSE"),"ERROR_BOX",{name:"SellHouse"});
         }
      }
      else
      {
         this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_NOSELL",[_loc7_.name]),"ERROR_BOX",{name:"NoSellHouse"});
      }
   }
   function onBuy(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = sExtraData.split("|");
         var _loc5_ = Number(_loc4_[0]);
         var _loc6_ = Number(_loc4_[1]);
         var _loc7_ = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(_loc5_);
         if(_loc7_ == undefined)
         {
            _loc7_ = new dofus.datacenter.House(_loc5_);
         }
         _loc7_.price = _loc6_;
         this.api.kernel.showMessage(this.api.lang.getText("INFORMATIONS"),this.api.lang.getText("HOUSE_BUY",[_loc7_.name,_loc7_.price]),"ERROR_BOX",{name:"BuyHouse"});
         _loc7_.isForSale = false;
         _loc7_.price = 0;
      }
      else if((var _loc0_ = sExtraData.charAt(0)) === "C")
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_BUY_HOUSE",[sExtraData.substr(1)]),"ERROR_BOX",{name:"BuyHouse"});
      }
   }
   function onLeave()
   {
      this.api.ui.unloadUIComponent("HouseSale");
   }
   function onGuildInfos(sExtraData)
   {
      var _loc3_ = sExtraData.split(";");
      var _loc4_ = Number(_loc3_[0]);
      var _loc5_ = true;
      var _loc6_ = new String();
      var _loc7_ = new Object();
      var _loc8_ = 0;
      if(_loc3_.length < 4)
      {
         _loc5_ = false;
      }
      else
      {
         _loc5_ = true;
         _loc6_ = _loc3_[1];
         _loc7_ = this.api.kernel.CharactersManager.createGuildEmblem(_loc3_[2]);
         _loc8_ = Number(_loc3_[3]);
      }
      var _loc9_ = (dofus.datacenter.House)this.api.datacenter.Houses.getItemAt(_loc4_);
      if(_loc9_ == undefined)
      {
         _loc9_ = new dofus.datacenter.House(_loc4_);
         this.api.datacenter.Houses.addItemAt(_loc4_,_loc9_);
      }
      _loc9_.isShared = _loc5_;
      _loc9_.guildName = _loc6_;
      _loc9_.guildEmblem = _loc7_;
      _loc9_.guildRights = _loc8_;
   }
}
