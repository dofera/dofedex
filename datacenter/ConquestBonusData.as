class dofus.datacenter.ConquestBonusData extends Object
{
   function ConquestBonusData(xp, drop, recolte)
   {
      super();
      this._nXp = xp;
      this._nDrop = drop;
      this._nRecolte = recolte;
   }
   function __get__xp()
   {
      return this._nXp;
   }
   function __set__xp(value)
   {
      this._nXp = value;
      return this.__get__xp();
   }
   function __get__drop()
   {
      return this._nDrop;
   }
   function __set__drop(value)
   {
      this._nDrop = value;
      return this.__get__drop();
   }
   function __get__recolte()
   {
      return this._nRecolte;
   }
   function __set__recolte(value)
   {
      this._nRecolte = value;
      return this.__get__recolte();
   }
}
