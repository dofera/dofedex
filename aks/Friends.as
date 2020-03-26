class dofus.aks.Friends extends dofus.aks.Handler
{
   function Friends(oAKS, oAPI)
   {
      super.initialize(oAKS,oAPI);
   }
   function getFriendsList()
   {
      this.aks.send("FL",true);
   }
   function addFriend(sName)
   {
      if(sName == undefined || (sName.length == 0 || sName == "*"))
      {
         return undefined;
      }
      this.aks.send("FA" + sName);
   }
   function removeFriend(sName)
   {
      if(sName == undefined || (sName.length == 0 || sName == "*"))
      {
         return undefined;
      }
      this.aks.send("FD" + sName);
   }
   function join(sType)
   {
      this.aks.send("FJ" + sType);
   }
   function joinFriend(sName)
   {
      this.aks.send("FJF" + sName);
   }
   function compass(bStop)
   {
      this.aks.send("FJC" + (!bStop?"+":"-"));
   }
   function setNotifyWhenConnect(bActivity)
   {
      this.aks.send("FO" + (!bActivity?"-":"+"));
   }
   function onAddFriend(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         var _loc4_ = this.getFriendObjectFromData(sExtraData);
         if(_loc4_ != undefined)
         {
            this.api.datacenter.Player.Friends.push(_loc4_);
         }
         this.api.kernel.showMessage(undefined,this.api.lang.getText("ADD_TO_FRIEND_LIST",[_loc4_.name]),"INFO_CHAT");
      }
      else
      {
         switch(sExtraData)
         {
            case "f":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
               break;
            case "y":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_YOU"),"ERROR_CHAT");
               break;
            case "a":
               this.api.kernel.showMessage(undefined,this.api.lang.getText("ALREADY_YOUR_FRIEND"),"ERROR_CHAT");
               break;
            case "m":
               this.api.kernel.showMessage(this.api.lang.getText("FRIENDS"),this.api.lang.getText("FRIENDS_LIST_FULL"),"ERROR_BOX",{name:"FriendsListFull"});
         }
      }
   }
   function onRemoveFriend(bSuccess, sExtraData)
   {
      if(bSuccess)
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("REMOVE_FRIEND_OK"),"INFO_CHAT");
         this.getFriendsList();
      }
      else if((var _loc0_ = sExtraData) === "f")
      {
         this.api.kernel.showMessage(undefined,this.api.lang.getText("CANT_ADD_FRIEND_NOT_FOUND"),"ERROR_CHAT");
      }
   }
   function onFriendsList(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      this.api.datacenter.Player.Friends = new Array();
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = this.getFriendObjectFromData(_loc3_[_loc4_]);
         if(_loc5_ != undefined)
         {
            this.api.datacenter.Player.Friends.push(_loc5_);
         }
         _loc4_ = _loc4_ + 1;
      }
      var _loc6_ = this.api.ui.getUIComponent("Friends");
      var _loc7_ = this.api.datacenter.Player.Friends;
      if(_loc6_ != undefined)
      {
         _loc6_.friendsList = _loc7_;
      }
      else
      {
         var _loc8_ = new String();
         if(_loc7_.length != 0)
         {
            this.api.kernel.showMessage(undefined,"<b>" + this.api.lang.getText("YOUR_FRIEND_LIST") + " :</b>","INFO_CHAT");
            var _loc9_ = 0;
            while(_loc9_ < _loc7_.length)
            {
               _loc8_ = " - " + _loc7_[_loc9_].account;
               if(_loc7_[_loc9_].state != "DISCONNECT")
               {
                  _loc8_ = _loc8_ + (" (" + _loc7_[_loc9_].name + ") " + this.api.lang.getText("LEVEL") + ":" + _loc7_[_loc9_].level + ", " + this.api.lang.getText(_loc7_[_loc9_].state));
               }
               this.api.kernel.showMessage(undefined,_loc8_,"INFO_CHAT");
               _loc9_ = _loc9_ + 1;
            }
         }
         else
         {
            this.api.kernel.showMessage(undefined,this.api.lang.getText("EMPTY_FRIEND_LIST"),"INFO_CHAT");
         }
      }
   }
   function onSpouse(sExtraData)
   {
      var _loc3_ = sExtraData.split("|");
      var _loc4_ = new Object();
      _loc4_.name = _loc3_[0];
      _loc4_.gfx = _loc3_[1];
      _loc4_.color1 = Number(_loc3_[2]);
      _loc4_.color2 = Number(_loc3_[3]);
      _loc4_.color3 = Number(_loc3_[4]);
      _loc4_.mapID = Number(_loc3_[5]);
      _loc4_.isConnected = !_global.isNaN(_loc4_.mapID);
      _loc4_.level = Number(_loc3_[6]);
      _loc4_.isInFight = _loc3_[7] != "1"?false:true;
      _loc4_.sex = this.api.datacenter.Player.Sex != 0?"m":"f";
      _loc4_.isFollow = _loc3_[8] != "1"?false:true;
      var _loc5_ = this.api.ui.getUIComponent("Friends");
      _loc5_.spouse = _loc4_;
   }
   function onNotifyChange(sExtraData)
   {
      this.api.datacenter.Basics.aks_notify_on_friend_connexion = sExtraData == "+";
      var _loc3_ = (dofus.graphics.gapi.ui.Friends)this.api.ui.getUIComponent("Friends");
      if(_loc3_ != null)
      {
         _loc3_.notifyStateChanged(sExtraData == "+");
      }
   }
   function getFriendObjectFromData(sData)
   {
      var _loc3_ = sData.split(";");
      var _loc4_ = new Object();
      _loc4_.account = String(_loc3_[0]);
      if(_loc3_[1] != undefined)
      {
         switch(_loc3_[1])
         {
            case "1":
               _loc4_.state = "IN_SOLO";
               break;
            case "2":
               _loc4_.state = "IN_MULTI";
               break;
            case "?":
               _loc4_.state = "IN_UNKNOW";
         }
         _loc4_.name = _loc3_[2];
         _loc4_.level = _loc3_[3];
         _loc4_.sortLevel = _loc4_.level != "?"?Number(_loc4_.level):-1;
         _loc4_.alignement = Number(_loc3_[4]);
         _loc4_.guild = _loc3_[5];
         _loc4_.sex = _loc3_[6];
         _loc4_.gfxID = _loc3_[7];
      }
      else
      {
         _loc4_.name = _loc4_.account;
         _loc4_.state = "DISCONNECT";
      }
      return _loc4_.account.length == 0?undefined:_loc4_;
   }
   function setNotify(bNotify)
   {
      this.aks.send("FO" + (!bNotify?"-":"+"),false);
   }
}
