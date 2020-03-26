class dofus.datacenter.OfflineCharacter extends ank.battlefield.datacenter.Sprite
{
   var xtraClipTopAnimations = {staticL:true,staticF:true,staticR:true};
   function OfflineCharacter(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
   {
      super();
      if(this.__proto__ == dofus.datacenter.OfflineCharacter.prototype)
      {
         this.initialize(sID,clipClass,sGfxFile,cellNum,dir,gfxID);
      }
   }
   function __set__name(sName)
   {
      this._sName = sName;
      return this.__get__name();
   }
   function __get__name()
   {
      return this._sName;
   }
   function __get__gfxID()
   {
      return this._gfxID;
   }
   function __set__gfxID(value)
   {
      this._gfxID = value;
      return this.__get__gfxID();
   }
   function initialize(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
   {
      super.initialize(sID,clipClass,sGfxFile,cellNum,dir);
      this._gfxID = gfxID;
   }
   function __set__guildName(sGuildName)
   {
      this._sGuildName = sGuildName;
      return this.__get__guildName();
   }
   function __get__guildName()
   {
      return this._sGuildName;
   }
   function __set__emblem(oEmblem)
   {
      this._oEmblem = oEmblem;
      return this.__get__emblem();
   }
   function __get__emblem()
   {
      return this._oEmblem;
   }
   function __set__offlineType(sOfflineType)
   {
      this._sOfflineType = sOfflineType;
      return this.__get__offlineType();
   }
   function __get__offlineType()
   {
      return this._sOfflineType;
   }
}
