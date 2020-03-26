class dofus.datacenter.GuildRights extends Object
{
   function GuildRights(nRights)
   {
      super();
      this._nRights = nRights;
   }
   function __get__value()
   {
      return this._nRights;
   }
   function __set__value(nValue)
   {
      this._nRights = nValue;
      return this.__get__value();
   }
   function __get__isBoss()
   {
      return (this._nRights & 1) == 1;
   }
   function __get__canManageBoost()
   {
      return this.isBoss || (this._nRights & 2) == 2;
   }
   function __get__canManageRights()
   {
      return this.isBoss || (this._nRights & 4) == 4;
   }
   function __get__canInvite()
   {
      return this.isBoss || (this._nRights & 8) == 8;
   }
   function __get__canBann()
   {
      return this.isBoss || (this._nRights & 16) == 16;
   }
   function __get__canManageXPContitribution()
   {
      return this.isBoss || (this._nRights & 32) == 32;
   }
   function __get__canManageRanks()
   {
      return this.isBoss || (this._nRights & 64) == 64;
   }
   function __get__canHireTaxCollector()
   {
      return this.isBoss || (this._nRights & 128) == 128;
   }
   function __get__canManageOwnXPContitribution()
   {
      return this.isBoss || (this._nRights & 256) == 256;
   }
   function __get__canCollect()
   {
      return this.isBoss || (this._nRights & 512) == 512;
   }
   function __get__canUseMountPark()
   {
      return this.isBoss || (this._nRights & 4096) == 4096;
   }
   function __get__canArrangeMountPark()
   {
      return this.isBoss || (this._nRights & 8192) == 8192;
   }
   function __get__canManageOtherMount()
   {
      return this.isBoss || (this._nRights & 16384) == 16384;
   }
}
