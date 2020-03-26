class dofus.datacenter.PrismSprite extends dofus.datacenter.PlayableCharacter
{
   function PrismSprite(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
   {
      super();
      this.initialize(sID,clipClass,sGfxFile,cellNum,dir,gfxID);
   }
   function __get__name()
   {
      return this.api.lang.getMonstersText(this._nLinkedMonsterId).n;
   }
   function __set__linkedMonster(value)
   {
      this._nLinkedMonsterId = value;
      return this.__get__linkedMonster();
   }
   function __get__linkedMonster()
   {
      return this._nLinkedMonsterId;
   }
   function __set__alignment(value)
   {
      this._aAlignment = value;
      return this.__get__alignment();
   }
   function __get__alignment()
   {
      return this._aAlignment;
   }
}
