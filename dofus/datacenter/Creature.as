class dofus.datacenter.Creature extends dofus.datacenter.PlayableCharacter
{
   var _sStartAnimation = "appear";
   function Creature(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
   {
      super();
      this.initialize(sID,clipClass,sGfxFile,cellNum,dir,gfxID);
   }
   function __set__name(nNameID)
   {
      this._nNameID = Number(nNameID);
      return this.__get__name();
   }
   function __get__name()
   {
      return this.api.lang.getMonstersText(this._nNameID).n;
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
      return this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].l;
   }
   function __set__resistances(a)
   {
      this._resistances = a;
      return this.__get__resistances();
   }
   function __get__resistances()
   {
      if(this._resistances)
      {
         return this._resistances;
      }
      var _loc2_ = this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].r;
      _loc2_[5] = _loc2_[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
      _loc2_[6] = _loc2_[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
      return _loc2_;
   }
   function __get__alignment()
   {
      return new dofus.datacenter.Alignment(this.api.lang.getMonstersText(this._nNameID).a,0);
   }
}
