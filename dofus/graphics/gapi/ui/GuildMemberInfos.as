class dofus.graphics.gapi.ui.GuildMemberInfos extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "GuildMemberInfos";
   function GuildMemberInfos()
   {
      super();
   }
   function __set__member(oMember)
   {
      this._oMember = oMember;
      this._oMemberClone = new Object();
      this._oMemberClone.rank = this._oMember.rank;
      this._oMemberClone.percentxp = this._oMember.percentxp;
      this._oMemberClone.rights = new dofus.datacenter.GuildRights(this._oMember.rights.value);
      return this.__get__member();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.GuildMemberInfos.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.initTexts});
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
      this._cbRanks._visible = false;
      this._btnPercentXP._visible = false;
   }
   function initTexts()
   {
      this._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
      this._btnModify.label = this.api.lang.getText("MODIFY");
      this._lblRank.text = this.api.lang.getText("GUILD_RANK");
      this._lblPercentXP.text = this.api.lang.getText("PERCENT_XP_FULL");
      this._lblRights.text = this.api.lang.getText("RIGHTS");
      this._lblRBoost.text = this.api.lang.getText("GUILD_RIGHTS_BOOST");
      this._lblRRights.text = this.api.lang.getText("GUILD_RIGHTS_RIGHTS");
      this._lblRInvit.text = this.api.lang.getText("GUILD_RIGHTS_INVIT");
      this._lblRBann.text = this.api.lang.getText("GUILD_RIGHTS_BANN");
      this._lblRPercentXP.text = this.api.lang.getText("GUILD_RIGHTS_PERCENTXP");
      this._lblROwnPercentXP.text = this.api.lang.getText("GUILD_RIGHT_MANAGE_OWN_XP");
      this._lblRRank.text = this.api.lang.getText("GUILD_RIGHTS_RANK");
      this._lblRHireTax.text = this.api.lang.getText("GUILD_RIGHTS_HIRETAX");
      this._lblRDefendTax.text = this.api.lang.getText("GUILD_RIGHTS_DEFENDTAX");
      this._lblRCollect.text = this.api.lang.getText("GUILD_RIGHTS_COLLECT");
      this._lblRCanUseMountPark.text = this.api.lang.getText("GUILD_RIGHTS_MOUNT_PARK_USE");
      this._lblRCanArrangeMountPark.text = this.api.lang.getText("GUILD_RIGHTS_MOUNT_PARK_ARRANGE");
      this._lblRCanManageOtherMount.text = this.api.lang.getText("GUILD_RIGHTS_MANAGE_OTHER_MOUNT");
   }
   function addListeners()
   {
      this._btnClose.addEventListener("click",this);
      this._btnCancel.addEventListener("click",this);
      this._btnModify.addEventListener("click",this);
      this._btnPercentXP.addEventListener("click",this);
      this._cbRanks.addEventListener("itemSelected",this);
      this._btnRBoost.addEventListener("click",this);
      this._btnRRights.addEventListener("click",this);
      this._btnRInvit.addEventListener("click",this);
      this._btnRBann.addEventListener("click",this);
      this._btnRPercentXP.addEventListener("click",this);
      this._btnROwnPercentXP.addEventListener("click",this);
      this._btnRRank.addEventListener("click",this);
      this._btnRHireTax.addEventListener("click",this);
      this._btnRDefendTax.addEventListener("click",this);
      this._btnRCollect.addEventListener("click",this);
      this._bntRCanUseMountPark.addEventListener("click",this);
      this._btnRCanArrangeMountPark.addEventListener("click",this);
      this._btnRCanManageOtherMount.addEventListener("click",this);
   }
   function updateData()
   {
      this._winBg.title = this._oMember.name + " (" + this.api.lang.getText("LEVEL_SMALL") + " " + this._oMember.level + ")";
      this._lblPercentXPValue.text = this._oMemberClone.percentxp + "%";
      var _loc2_ = this.api.datacenter.Player.guildInfos.playerRights;
      this._cbRanks.enabled = _loc2_.canManageRanks;
      this._btnPercentXP._visible = _loc2_.canManageXPContitribution || _loc2_.canManageOwnXPContitribution;
      var _loc3_ = this._oMemberClone.rights;
      this._btnRBoost.selected = _loc3_.canManageBoost;
      this._btnRRights.selected = _loc3_.canManageRights;
      this._btnRInvit.selected = _loc3_.canInvite;
      this._btnRBann.selected = _loc3_.canBann;
      this._btnRPercentXP.selected = _loc3_.canManageXPContitribution;
      this._btnRRank.selected = _loc3_.canManageRanks;
      this._btnRHireTax.selected = _loc3_.canHireTaxCollector;
      this._btnROwnPercentXP.selected = _loc3_.canManageOwnXPContitribution;
      this._btnRCollect.selected = _loc3_.canCollect;
      this._bntRCanUseMountPark.selected = _loc3_.canUseMountPark;
      this._btnRCanArrangeMountPark.selected = _loc3_.canArrangeMountPark;
      this._btnRCanManageOtherMount.selected = _loc3_.canManageOtherMount;
      var _loc4_ = _loc2_.canManageRights && !_loc3_.isBoss;
      this._btnRBoost.enabled = _loc4_;
      this._btnRRights.enabled = _loc4_;
      this._btnRInvit.enabled = _loc4_;
      this._btnRBann.enabled = _loc4_;
      this._btnRPercentXP.enabled = _loc4_;
      this._btnRRank.enabled = _loc4_;
      this._btnRHireTax.enabled = _loc4_;
      this._btnROwnPercentXP.enabled = _loc4_;
      this._btnRCollect.enabled = _loc4_;
      this._bntRCanUseMountPark.enabled = _loc4_;
      this._btnRCanArrangeMountPark.enabled = _loc4_;
      this._btnRCanManageOtherMount.enabled = _loc4_;
      this._btnModify.enabled = _loc2_.isBoss || (_loc2_.canManageRights || (_loc2_.canManageRanks || (_loc2_.canManageXPContitribution || _loc3_.canManageOwnXPContitribution)));
      if(_loc2_.canManageRanks)
      {
         this._cbRanks._visible = true;
         var _loc5_ = this.api.lang.getRanks().slice();
         var _loc6_ = new ank.utils.ExtendedArray();
         _loc5_.sortOn("o",Array.NUMERIC);
         if(this.api.datacenter.Player.guildInfos.playerRights.isBoss)
         {
            _loc6_.push({label:_loc5_[0].n,id:_loc5_[0].i});
            if(this._oMemberClone.rank == _loc5_[0].i)
            {
               this._cbRanks.selectedIndex = 0;
            }
         }
         var _loc7_ = 1;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_.push({label:_loc5_[_loc7_].n,id:_loc5_[_loc7_].i});
            if(this._oMemberClone.rank == _loc5_[_loc7_].i)
            {
               this._cbRanks.selectedIndex = _loc6_.length - 1;
            }
            _loc7_ = _loc7_ + 1;
         }
         this._cbRanks.dataProvider = _loc6_;
      }
      else
      {
         this._lblRankValue.text = this.api.lang.getRankInfos(this._oMemberClone.rank).n;
      }
   }
   function setRank(nRank)
   {
      this._oMemberClone.rank = nRank;
      this._oMemberClone.rankOrder = this.api.lang.getRankInfos(nRank).o;
      this.updateData();
   }
   function setBoss()
   {
      this.api.kernel.showMessage(undefined,this.api.lang.getText("DO_U_GIVERIGHTS",[this._oMember.name]),"CAUTION_YESNO",{name:"GuildSetBoss",listener:this});
   }
   function itemSelected(oEvent)
   {
      if(this._cbRanks.selectedItem.id == 1)
      {
         this.setBoss();
      }
      else
      {
         this.setRank(this._cbRanks.selectedItem.id);
      }
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnCancel":
         case "_btnClose":
            this.unloadThis();
            break;
         case "_btnModify":
            if(this._oMember.rank == this._oMemberClone.rank && (this._oMember.percentxp == this._oMemberClone.percentxp && this._oMember.rights.value == this._oMemberClone.rights.value))
            {
               return undefined;
            }
            this._oMember.rank = this._oMemberClone.rank;
            this._oMember.rankOrder = this._oMemberClone.rankOrder;
            this._oMember.percentxp = this._oMemberClone.percentxp;
            this._oMember.rights.value = this._oMemberClone.rights.value;
            this.api.network.Guild.changeMemberProfil(this._oMember);
            this.api.datacenter.Player.guildInfos.setMembers();
            this.unloadThis();
            break;
         case "_btnPercentXP":
            var _loc3_ = this.gapi.loadUIComponent("PopupQuantity","PopupQuantity",{value:this._oMember.percentxp,max:90,min:0});
            _loc3_.addEventListener("validate",this);
            break;
         case "_btnRBoost":
            if(this._btnRBoost.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 2;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 2;
            }
            break;
         case "_btnRRights":
            if(this._btnRRights.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 4;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 4;
            }
            break;
         case "_btnRInvit":
            if(this._btnRInvit.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 8;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 8;
            }
            break;
         case "_btnRBann":
            if(this._btnRBann.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 16;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 16;
            }
            break;
         case "_btnRPercentXP":
            if(this._btnRPercentXP.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 32;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 32;
            }
            break;
         case "_btnRRank":
            if(this._btnRRank.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 64;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 64;
            }
            break;
         case "_btnRHireTax":
            if(this._btnRHireTax.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 128;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 128;
            }
            break;
         case "_btnROwnPercentXP":
            if(this._btnROwnPercentXP.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 256;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 256;
            }
            break;
         case "_btnRCollect":
            if(this._btnRCollect.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 512;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 512;
            }
            break;
         case "_bntRCanUseMountPark":
            if(this._bntRCanUseMountPark.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 4096;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 4096;
            }
            break;
         case "_btnRCanArrangeMountPark":
            if(this._btnRCanArrangeMountPark.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 8192;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 8192;
            }
            break;
         case "_btnRCanManageOtherMount":
            if(this._btnRCanManageOtherMount.selected)
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value | 16384;
            }
            else
            {
               this._oMemberClone.rights.value = this._oMemberClone.rights.value ^ 16384;
            }
      }
   }
   function validate(oEvent)
   {
      var _loc3_ = oEvent.value;
      if(_global.isNaN(_loc3_))
      {
         return undefined;
      }
      if(_loc3_ > 90)
      {
         return undefined;
      }
      if(_loc3_ < 0)
      {
         return undefined;
      }
      this._oMemberClone.percentxp = _loc3_;
      this.updateData();
   }
   function yes(oEvent)
   {
      this.setRank(1);
   }
}
