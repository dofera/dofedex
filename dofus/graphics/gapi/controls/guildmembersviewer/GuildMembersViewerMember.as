class dofus.graphics.gapi.controls.guildmembersviewer.GuildMembersViewerMember extends ank.gapi.core.UIBasicComponent
{
   var ftgt = 150;
   function GuildMembersViewerMember()
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
      if(bUsed)
      {
         this._oItem = oItem;
         var _loc5_ = this._mcList.gapi.api.datacenter.Player.guildInfos.playerRights;
         this._lblName.text = oItem.name;
         this._lblRank.text = this._mcList.gapi.api.lang.getRankInfos(oItem.rank).n;
         this._lblLevel.text = oItem.level;
         this._lblPercentXP.text = oItem.percentxp + "%";
         this._lblWinXP.text = oItem.winxp;
         this._btnBann._visible = oItem.isLocalPlayer || _loc5_.canBann;
         this._btnProfil._visible = oItem.isLocalPlayer || (_loc5_.canManageRights || (_loc5_.canManageXPContitribution || _loc5_.canManageRanks));
         this._ldrGuild.contentPath = dofus.Constants.GUILDS_MINI_PATH + oItem.gfx + ".swf";
         this._mcFight._visible = oItem.state == 2;
         this._mcOffline._visible = oItem.state == 0;
         this._mcOver.hint = oItem.lastConnection;
         this._ldrAlignement.contentPath = dofus.Constants.ALIGNMENTS_MINI_PATH + oItem.alignement + ".swf";
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblRank.text = "";
         this._lblLevel.text = "";
         this._lblPercentXP.text = "";
         this._lblWinXP.text = "";
         this._btnBann._visible = false;
         this._btnProfil._visible = false;
         this._ldrGuild.contentPath = "";
         this._ldrAlignement.contentPath = "";
         this._mcFight._visible = false;
         this._mcOffline._visible = false;
         delete this._mcOver.onRollOver;
         delete this._mcOver.onRollOut;
      }
   }
   function init()
   {
      super.init(false);
      this._btnBann._visible = false;
      this._btnProfil._visible = false;
      this._mcFight._visible = false;
      this._mcOffline._visible = false;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnBann.addEventListener("click",this);
      this._btnProfil.addEventListener("click",this);
   }
   function click(oEvent)
   {
      switch(oEvent.target._name)
      {
         case "_btnBann":
            var _loc3_ = this._mcList.gapi.api;
            var _loc4_ = _loc3_.datacenter.Player.guildInfos.members.length;
            if(this._oItem.rights.isBoss && _loc4_ > 1)
            {
               this._mcList.gapi.api.kernel.showMessage(undefined,_loc3_.lang.getText("GUILD_BOSS_CANT_BE_BANN"),"ERROR_BOX");
            }
            else if(this._oItem.isLocalPlayer)
            {
               this._mcList.gapi.api.kernel.showMessage(undefined,_loc3_.lang.getText("DO_U_DELETE_YOU") + (_loc4_ <= 1?"\n" + _loc3_.lang.getText("DELETE_GUILD_CAUTION"):""),"CAUTION_YESNO",{name:"DeleteMember",listener:this,params:{name:this._oItem.name}});
            }
            else
            {
               this._mcList.gapi.api.kernel.showMessage(undefined,_loc3_.lang.getText("DO_U_DELETE_MEMBER",[this._oItem.name]),"CAUTION_YESNO",{name:"DeleteMember",listener:this,params:{name:this._oItem.name}});
            }
            break;
         case "_btnProfil":
            this._mcList.gapi.loadUIComponent("GuildMemberInfos","GuildMemberInfos",{member:this._oItem});
      }
   }
   function yes(oEvent)
   {
      this._mcList.gapi.api.network.Guild.bann(oEvent.params.name);
   }
   function over(oEvent)
   {
      if(this._oItem.state != 0)
      {
         return undefined;
      }
      var _loc3_ = this._mcList.gapi.api;
      var _loc4_ = this._oItem.lastConnection;
      var _loc5_ = Math.floor(_loc4_ / (24 * 31));
      _loc4_ = _loc4_ - _loc5_ * 24 * 31;
      var _loc6_ = Math.floor(_loc4_ / 24);
      _loc4_ = _loc4_ - _loc6_ * 24;
      var _loc7_ = _loc4_;
      if(_loc5_ < 0)
      {
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 0;
      }
      var _loc8_ = " " + _loc3_.lang.getText("AND") + " ";
      var _loc9_ = "";
      if(_loc5_ > 0 && _loc6_ != 0)
      {
         var _loc10_ = ank.utils.PatternDecoder.combine(_loc3_.lang.getText("MONTHS"),"m",_loc5_ == 1);
         var _loc11_ = ank.utils.PatternDecoder.combine(_loc3_.lang.getText("DAYS"),"m",_loc6_ == 1);
         _loc9_ = _loc9_ + (_loc5_ + " " + _loc10_ + _loc8_ + _loc6_ + " " + _loc11_);
      }
      else if(_loc6_ != 0)
      {
         var _loc12_ = ank.utils.PatternDecoder.combine(_loc3_.lang.getText("DAYS"),"m",_loc6_ == 1);
         _loc9_ = _loc9_ + (_loc6_ + " " + _loc12_);
      }
      else
      {
         _loc9_ = _loc9_ + _loc3_.lang.getText("A_CONNECTED_TODAY");
      }
      _loc3_.ui.showTooltip(_loc3_.lang.getText("GUILD_LAST_CONNECTION",[_loc9_]),this._mcOver,-20);
   }
   function out(oEvent)
   {
      this._mcList.gapi.api.ui.hideTooltip();
   }
}
