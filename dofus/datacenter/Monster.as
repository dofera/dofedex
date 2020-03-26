class dofus.datacenter.Monster extends dofus.datacenter.PlayableCharacter
{
   var _nSpeedModerator = 1;
   function Monster(sID, clipClass, sGfxFile, cellNum, dir, gfxID)
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
   function __get__kickable()
   {
      return this.api.lang.getMonstersText(this._nNameID).k;
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
   function __get__resistances()
   {
      var _loc2_ = this.api.lang.getMonstersText(this._nNameID)["g" + this._nPowerLevel].r;
      var _loc3_ = new Array();
      var _loc4_ = 0;
      while(_loc4_ < _loc2_.length)
      {
         _loc3_[_loc4_] = _loc2_[_loc4_];
         _loc4_ = _loc4_ + 1;
      }
      _loc3_[5] = _loc3_[5] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PA_LOST_PROBABILITY);
      _loc3_[6] = _loc3_[6] + this.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.DODGE_PM_LOST_PROBABILITY);
      return _loc3_;
   }
   function __get__alignment()
   {
      return new dofus.datacenter.Alignment(this.api.lang.getMonstersText(this._nNameID).a,0);
   }
   function alertChatText()
   {
      var _loc2_ = this.api.datacenter.Map;
      return this.name + " niveau " + this.Level + " en " + _loc2_.x + "," + _loc2_.y + ".";
   }
}
