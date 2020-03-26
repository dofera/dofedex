class dofus.graphics.gapi.ui.party.PartyItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   function PartyItem()
   {
      super();
   }
   function __set__data(oSprite)
   {
      this._oSprite = oSprite;
      if(this.initialized)
      {
         this.updateData();
      }
      return this.__get__data();
   }
   function __set__isFollowing(bIsFollowing)
   {
      this._bIsFollowing = bIsFollowing;
      this._mcFollow._visible = bIsFollowing;
      return this.__get__isFollowing();
   }
   function __get__isInGroup(bIsInGroup)
   {
      return this._bIsInGroup;
   }
   function setHealth(oSprite)
   {
      if(oSprite.life == undefined)
      {
         return undefined;
      }
      var _loc3_ = oSprite.life.split(",");
      this._mcHealth._yscale = _loc3_[0] / _loc3_[1] * 100;
      this._oSprite.life = oSprite.life;
   }
   function setData(oSprite)
   {
      if(this.doReload(oSprite))
      {
         this._oSprite = oSprite;
         if(this.initialized)
         {
            this.updateData();
         }
      }
      else
      {
         this.setHealth(oSprite);
      }
   }
   function doReload(oSprite)
   {
      var _loc3_ = true;
      if(this._oSprite.accessories && (oSprite.accessories.length == this._oSprite.accessories.length && oSprite.id == this._oSprite.id))
      {
         var _loc4_ = this._oSprite.accessories;
         var _loc5_ = oSprite.accessories;
         var _loc6_ = new Array();
         var _loc7_ = new Array();
         for(var i in _loc4_)
         {
            _loc6_.push(_loc4_[i].unicID);
         }
         for(var i in _loc5_)
         {
            _loc7_.push(_loc5_[i].unicID);
         }
         _loc6_.sort();
         _loc7_.sort();
         _loc3_ = !_loc6_ || _loc6_.join(",") != _loc7_.join(",");
      }
      return _loc3_;
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this._mcBack._visible = false;
      this._mcFollow._visible = false;
      this._mcHealth._visible = false;
      this._btn._visible = false;
   }
   function addListeners()
   {
      this._ldrSprite.addEventListener("initialization",this);
      this._btn.addEventListener("over",this);
      this._btn.addEventListener("out",this);
      this._btn.addEventListener("click",this);
   }
   function updateData()
   {
      if(this._oSprite != undefined)
      {
         this._ldrSprite.contentPath = this._oSprite.gfxFile != undefined?this._oSprite.gfxFile:"";
         this.api.colors.addSprite(this._ldrSprite,this._oSprite);
         this._mcBack._visible = true;
         this._btn.enabled = true;
         this._btn._visible = true;
         this._mcHealth._visible = true;
         this.setHealth(this._oSprite.life);
         this._bIsInGroup = true;
         this._visible = true;
      }
      else
      {
         this._ldrSprite.contentPath = "";
         this._mcBack._visible = false;
         this._mcFollow._visible = false;
         this._btn.enabled = false;
         this._btn._visible = false;
         this._mcHealth._visible = false;
         this._bIsInGroup = false;
         this._visible = false;
      }
   }
   function isLocalPlayerLeader()
   {
      return this._parent.leaderID == this.api.datacenter.Player.ID;
   }
   function isLocalPlayer()
   {
      return this._oSprite.id == this.api.datacenter.Player.ID;
   }
   function partyWhere()
   {
      this.api.network.Party.where();
      this.api.ui.loadUIAutoHideComponent("MapExplorer","MapExplorer");
   }
   function initialization(oEvent)
   {
      var _loc3_ = oEvent.target.content;
      _loc3_.attachMovie("staticR","anim",10);
      _loc3_._xscale = -65;
      _loc3_._yscale = 65;
   }
   function over(oEvent)
   {
      var _loc3_ = this._oSprite.life.split(",");
      this._mcHealth._yscale = _loc3_[0] / _loc3_[1] * 100;
      this.gapi.showTooltip(this._oSprite.name + "\n" + this.api.lang.getText("LEVEL") + " : " + this._oSprite.level + "\n" + this.api.lang.getText("LIFEPOINTS") + " : " + _loc3_[0] + " / " + _loc3_[1],oEvent.target,30);
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
   function click(oEvent)
   {
      this.api.kernel.GameManager.showPlayerPopupMenu(undefined,this._oSprite.name,this);
   }
   function addPartyMenuItems(pm)
   {
      pm.addStaticItem(this.api.lang.getText("PARTY"));
      pm.addItem(this.api.lang.getText("PARTY_WHERE"),this,this.partyWhere,[]);
      if(this._oSprite.id == this.api.datacenter.Player.ID)
      {
         pm.addItem(this.api.lang.getText("LEAVE_PARTY"),this.api.network.Party,this.api.network.Party.leave,[]);
         if(this.isLocalPlayerLeader())
         {
            if(this._bIsFollowing)
            {
               pm.addItem(this.api.lang.getText("PARTY_STOP_FOLLOW_ME_ALL"),this.api.network.Party,this.api.network.Party.followAll,[true,this._oSprite.id]);
            }
            else
            {
               pm.addItem(this.api.lang.getText("PARTY_FOLLOW_ME_ALL"),this.api.network.Party,this.api.network.Party.followAll,[false,this._oSprite.id]);
            }
         }
      }
      else
      {
         if(this.isLocalPlayer)
         {
            if(this._bIsFollowing)
            {
               pm.addItem(this.api.lang.getText("STOP_FOLLOW"),this.api.network.Party,this.api.network.Party.follow,[true,this._oSprite.id]);
            }
            else
            {
               pm.addItem(this.api.lang.getText("FOLLOW"),this.api.network.Party,this.api.network.Party.follow,[false,this._oSprite.id]);
            }
         }
         if(this.isLocalPlayerLeader())
         {
            if(this._bIsFollowing)
            {
               pm.addItem(this.api.lang.getText("PARTY_STOP_FOLLOW_HIM_ALL"),this.api.network.Party,this.api.network.Party.followAll,[true,this._oSprite.id]);
            }
            else
            {
               pm.addItem(this.api.lang.getText("PARTY_FOLLOW_HIM_ALL"),this.api.network.Party,this.api.network.Party.followAll,[false,this._oSprite.id]);
            }
            pm.addItem(this.api.lang.getText("KICK_FROM_PARTY"),this.api.network.Party,this.api.network.Party.leave,[this._oSprite.id]);
         }
      }
   }
}
