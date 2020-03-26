class dofus.datacenter.TaxCollector extends dofus.datacenter.PlayableCharacter
{
   function TaxCollector(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
   {
      super();
      this.initialize(sID,clipClass,sGfxFile,cellNum,dir,gfxID);
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
   function __set__resistances(aResistances)
   {
      this._aResistances = aResistances;
      return this.__get__resistances();
   }
   function __get__resistances()
   {
      return this._aResistances;
   }
}
