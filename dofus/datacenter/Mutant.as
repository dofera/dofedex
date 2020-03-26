class dofus.datacenter.Mutant extends dofus.datacenter.Character
{
   function Mutant(sID, clipClass, sGfxFile, cellNum, dir, gfxID, bShowIsPlayer)
   {
      super();
      this._bShowIsPlayer = bShowIsPlayer == undefined?false:bShowIsPlayer;
      this.initialize(sID,clipClass,sGfxFile,cellNum,dir,gfxID);
   }
   function __get__name()
   {
      if(!this._bShowIsPlayer)
      {
         return this.monsterName;
      }
      return this._sPlayerName;
   }
   function __set__monsterID(n)
   {
      this._nMonsterID = n;
      return this.__get__monsterID();
   }
   function __get__monsterID()
   {
      return this._nMonsterID;
   }
   function __set__playerName(n)
   {
      this._sPlayerName = n;
      return this.__get__playerName();
   }
   function __get__playerName()
   {
      return this._sPlayerName;
   }
   function __get__monsterName()
   {
      return this.api.lang.getMonstersText(this._nMonsterID).n;
   }
   function __get__alignment()
   {
      return new dofus.datacenter.Alignment();
   }
   function __set__powerLevel(nPowerLevel)
   {
      this._nPowerLevel = Number(nPowerLevel);
      return this.__get__powerLevel();
   }
   function __get__powerLevel()
   {
      return this._nPowerLevel;
   }
   function __get__Level()
   {
      return this.api.lang.getMonstersText(this._nMonsterID)["g" + this._nPowerLevel].l;
   }
   function __get__resistances()
   {
      return this.api.lang.getMonstersText(this._nMonsterID)["g" + this._nPowerLevel].r;
   }
   function __set__showIsPlayer(b)
   {
      this._bShowIsPlayer = b;
      return this.__get__showIsPlayer();
   }
   function __get__showIsPlayer()
   {
      return this._bShowIsPlayer;
   }
}
