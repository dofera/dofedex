class dofus.graphics.gapi.ui.Party extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Party";
   var _sLeaderID = "0";
   var _sFollowID = "0";
   function Party()
   {
      super();
   }
   function __get__leaderID()
   {
      return this._sLeaderID;
   }
   function __get__followID()
   {
      return this._sFollowID;
   }
   function addMember(oMember, bRefresh)
   {
      this._aMembers.push(oMember);
      if(bRefresh)
      {
         this.updateData();
      }
   }
   function getMember(sMemberID)
   {
      var _loc3_ = this._aMembers.findFirstItem("id",sMemberID);
      if(_loc3_.index != -1)
      {
         return _loc3_.item;
      }
      return null;
   }
   function getMemberById(nMemberID)
   {
      var _loc3_ = 0;
      while(_loc3_ < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
      {
         if(this._aMembers[_loc3_].id == nMemberID)
         {
            return this._aMembers[_loc3_];
         }
         _loc3_ = _loc3_ + 1;
      }
      return null;
   }
   function removeMember(sMemberID, bRefresh)
   {
      var _loc4_ = this._aMembers.findFirstItem("id",sMemberID);
      if(this._sFollowID == sMemberID)
      {
         this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1]);
         delete this._sFollowID;
      }
      if(_loc4_.index != -1)
      {
         this._aMembers.removeItems(_loc4_.index,1);
      }
      if(bRefresh)
      {
         this.updateData();
      }
   }
   function refresh()
   {
      this.addToQueue({object:this,method:this.updateData});
   }
   function setLeader(sLeaderID)
   {
      this._sLeaderID = sLeaderID;
      this.updateData();
      if(sLeaderID == undefined)
      {
         this.api.kernel.GameManager.updateCompass(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[0]);
      }
   }
   function setFollow(sFollowID)
   {
      this._sFollowID = sFollowID;
      this.updateData();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Party.CLASS_NAME);
      this._aMembers = new ank.utils.ExtendedArray();
   }
   function destroy()
   {
      this.gapi.hideTooltip();
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
      this.addToQueue({object:this,method:this.initOption});
   }
   function addListeners()
   {
      this._btnOpenClose.addEventListener("click",this);
      this._btnOpenClose.addEventListener("over",this);
      this._btnOpenClose.addEventListener("out",this);
      this._btnBlockJoinerExceptParty.addEventListener("click",this);
      this._btnBlockJoinerExceptParty.addEventListener("over",this);
      this._btnBlockJoinerExceptParty.addEventListener("out",this);
   }
   function initOption()
   {
      this._btnBlockJoinerExceptParty.selected = this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
   }
   function updateData(oMemberTarget)
   {
      var _loc3_ = 0;
      this._nLvlTotal = 0;
      this._nProspectionTotal = 0;
      var _loc5_ = false;
      if(this._aMembers.length != 0)
      {
         var _loc6_ = 0;
         while(_loc6_ < dofus.Constants.MEMBERS_COUNT_IN_PARTY)
         {
            var _loc7_ = this._aMembers[_loc6_];
            _loc3_;
            var _loc8_ = this["_piMember" + _loc3_++];
            if(oMemberTarget && oMemberTarget.id == _loc7_.id)
            {
               _loc7_ = oMemberTarget;
               this._aMembers[_loc6_] = oMemberTarget;
            }
            _loc8_.setData(_loc7_);
            _loc8_.isFollowing = _loc7_.id == this._sFollowID;
            if(_loc8_.isInGroup)
            {
               this._nLvlTotal = this._nLvlTotal + _loc7_.level;
               this._nProspectionTotal = this._nProspectionTotal + _loc7_.prospection;
            }
            _loc6_ = _loc6_ + 1;
         }
         var _loc9_ = true;
         while(_loc9_)
         {
            _loc9_ = false;
            var _loc10_ = 0;
            while(_loc10_ < dofus.Constants.MEMBERS_COUNT_IN_PARTY - 1)
            {
               if(this._aMembers[_loc10_].initiative < this._aMembers[_loc10_ + 1].initiative)
               {
                  var _loc11_ = this._aMembers[_loc10_];
                  this._aMembers[_loc10_] = this._aMembers[_loc10_ + 1];
                  this._aMembers[_loc10_ + 1] = _loc11_;
                  _loc9_ = true;
               }
               var _loc12_ = this["_piMember" + _loc10_];
               _loc12_._visible = !this._btnOpenClose.selected;
               _loc12_.setData(this._aMembers[_loc10_]);
               _loc12_.isFollowing = this._aMembers[_loc10_].id == this._sFollowID;
               if(_loc12_.isInGroup)
               {
                  var _loc4_ = _loc12_;
               }
               _loc10_ = _loc10_ + 1;
            }
         }
      }
      var ref = this;
      this._mcInfo.onRollOver = function()
      {
         ref.over({target:this});
      };
      this._mcInfo.onRollOut = function()
      {
         ref.out({target:this});
      };
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target) !== this._btnBlockJoinerExceptParty)
      {
         this._piMember0._visible = !this._btnOpenClose.selected;
         this._piMember1._visible = !this._btnOpenClose.selected;
         this._piMember2._visible = !this._btnOpenClose.selected;
         this._piMember3._visible = !this._btnOpenClose.selected;
         this._piMember4._visible = !this._btnOpenClose.selected;
         this._piMember5._visible = !this._btnOpenClose.selected;
         this._piMember6._visible = !this._btnOpenClose.selected;
         this._piMember7._visible = !this._btnOpenClose.selected;
         this._mcInfo._visible = !this._btnOpenClose.selected;
      }
      else
      {
         var _loc3_ = !this.api.kernel.OptionsManager.getOption("FightGroupAutoLock");
         this.api.kernel.OptionsManager.setOption("FightGroupAutoLock",_loc3_);
      }
   }
   function over(oEvent)
   {
      switch(oEvent.target)
      {
         case this._btnOpenClose:
            this.gapi.showTooltip(this.api.lang.getText("PARTY_OPEN_CLOSE"),oEvent.target,20);
            break;
         case this._mcInfo:
            this.gapi.showTooltip("<b>" + this.api.lang.getText("INFORMATIONS") + "</b>\n" + this.api.lang.getText("TOTAL_LEVEL") + " : " + this._nLvlTotal + "\n" + this.api.lang.getText("TOTAL_DISCERNMENT") + " : " + this._nProspectionTotal,oEvent.target,20);
            break;
         case this._btnBlockJoinerExceptParty:
            this.gapi.showTooltip(this.api.lang.getText("FIGHT_OPTION_BLOCKJOINEREXCEPTPARTY"),oEvent.target,20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
