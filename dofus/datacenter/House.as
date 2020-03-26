class dofus.datacenter.House extends Object
{
   static var GUILDSHARE_VISIBLE_GUILD_BRIEF = 1;
   static var GUILDSHARE_DOORSIGN_GUILD = 2;
   static var GUILDSHARE_DOORSIGN_OTHERS = 4;
   static var GUILDSHARE_ALLOWDOOR_GUILD = 8;
   static var GUILDSHARE_FORBIDDOOR_OTHERS = 16;
   static var GUILDSHARE_ALLOWCHESTS_GUILD = 32;
   static var GUILDSHARE_FORBIDCHESTS_OTHERS = 64;
   static var GUILDSHARE_TELEPORT = 128;
   static var GUILDSHARE_RESPAWN = 256;
   var _bLocalOwner = false;
   var _sOwnerName = new String();
   var _sGuildName = new String();
   var _bForSale = false;
   var _bLocked = false;
   var _bShared = false;
   function House(nID)
   {
      super();
      this.initialize(nID);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__name()
   {
      return this.api.lang.fetchString(this._sName);
   }
   function __get__description()
   {
      return this.api.lang.fetchString(this._sDescription);
   }
   function __set__price(nPrice)
   {
      this._nPrice = Number(nPrice);
      return this.__get__price();
   }
   function __get__price()
   {
      return this._nPrice;
   }
   function __set__localOwner(bLocalOwner)
   {
      this._bLocalOwner = bLocalOwner;
      return this.__get__localOwner();
   }
   function __get__localOwner()
   {
      return this._bLocalOwner;
   }
   function __set__ownerName(sOwnerName)
   {
      this._sOwnerName = sOwnerName;
      return this.__get__ownerName();
   }
   function __get__ownerName()
   {
      if(typeof this._sOwnerName == "string")
      {
         if(this._sOwnerName.length > 0)
         {
            return this._sOwnerName;
         }
      }
      return null;
   }
   function __set__guildName(sGuildName)
   {
      this._sGuildName = sGuildName;
      this.dispatchEvent({type:"guild",value:this});
      return this.__get__guildName();
   }
   function __get__guildName()
   {
      if(typeof this._sGuildName == "string")
      {
         if(this._sGuildName.length > 0)
         {
            return this._sGuildName;
         }
      }
      return null;
   }
   function __set__guildEmblem(oGuildEmblem)
   {
      this._oGuildEmblem = oGuildEmblem;
      this.dispatchEvent({type:"guild",value:this});
      return this.__get__guildEmblem();
   }
   function __get__guildEmblem()
   {
      return this._oGuildEmblem;
   }
   function __set__guildRights(nRights)
   {
      this._nGuildRights = Number(nRights);
      this.dispatchEvent({type:"guild",value:this});
      return this.__get__guildRights();
   }
   function __get__guildRights()
   {
      return this._nGuildRights;
   }
   function __set__isForSale(bForSale)
   {
      this._bForSale = bForSale;
      this.dispatchEvent({type:"forsale",value:bForSale});
      return this.__get__isForSale();
   }
   function __get__isForSale()
   {
      return this._bForSale;
   }
   function __set__isLocked(bLocked)
   {
      this._bLocked = bLocked;
      this.dispatchEvent({type:"locked",value:bLocked});
      return this.__get__isLocked();
   }
   function __get__isLocked()
   {
      return this._bLocked;
   }
   function __set__isShared(bShared)
   {
      this._bShared = bShared;
      this.dispatchEvent({type:"shared",value:bShared});
      return this.__get__isShared();
   }
   function __get__isShared()
   {
      return this._bShared;
   }
   function __set__coords(pCoords)
   {
      this._pCoords = pCoords;
      return this.__get__coords();
   }
   function __get__coords()
   {
      return this._pCoords;
   }
   function __set__skills(aSkillsIDs)
   {
      this._aSkills = aSkillsIDs;
      return this.__get__skills();
   }
   function __get__skills()
   {
      return this._aSkills;
   }
   function initialize(nID)
   {
      this.api = _global.API;
      mx.events.EventDispatcher.initialize(this);
      this._nID = nID;
      var _loc3_ = this.api.lang.getHouseText(nID);
      this._sName = _loc3_.n;
      this._sDescription = _loc3_.d;
   }
   function hasRight(nRight)
   {
      return (this._nGuildRights & nRight) == nRight;
   }
   function getHumanReadableRightsList()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = 1;
      while(_loc3_ < 8192)
      {
         if(this.hasRight(_loc3_))
         {
            _loc2_.push({id:_loc3_,label:this.api.lang.getText("GUILD_HOUSE_RIGHT_" + _loc3_)});
         }
         _loc3_ = _loc3_ * 2;
      }
      return _loc2_;
   }
}
