class dofus.datacenter.MonsterGroup extends ank.battlefield.datacenter.Sprite
{
   var _sDefaultAnimation = "static";
   var _bAllDirections = false;
   var _bForceWalk = true;
   var _nAlignmentIndex = -1;
   function MonsterGroup(sID, clipClass, sGfxFile, cellNum, dir, bonus)
   {
      super();
      this.api = _global.API;
      this._nBonusValue = bonus;
      this.initialize(sID,clipClass,sGfxFile,cellNum,dir,null);
   }
   function __set__name(value)
   {
      this._aNamesList = new Array();
      var _loc3_ = value.split(",");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = this.api.lang.getMonstersText(_loc3_[_loc4_]);
         this._aNamesList.push(_loc5_.n);
         if(_loc5_.a != -1)
         {
            this._nAlignmentIndex = _loc5_.a;
         }
         _loc4_ = _loc4_ + 1;
      }
      return this.__get__name();
   }
   function __get__name()
   {
      return this.getName();
   }
   function getName(sEndChar)
   {
      sEndChar = sEndChar != undefined?sEndChar:"\n";
      var _loc3_ = new Array();
      var _loc4_ = 0;
      while(_loc4_ < this._aLevelsList.length)
      {
         _loc3_.push({level:Number(this._aLevelsList[_loc4_]),name:this._aNamesList[_loc4_]});
         _loc4_ = _loc4_ + 1;
      }
      _loc3_.sortOn(["level"],Array.DESCENDING | Array.NUMERIC);
      var _loc5_ = new String();
      var _loc6_ = 0;
      while(_loc6_ < _loc3_.length)
      {
         var _loc7_ = _loc3_[_loc6_];
         _loc5_ = _loc5_ + (_loc7_.name + " (" + _loc7_.level + ")" + sEndChar);
         _loc6_ = _loc6_ + 1;
      }
      return _loc5_;
   }
   function alertChatText()
   {
      var _loc2_ = this.api.datacenter.Map;
      return "Groupe niveau " + this.totalLevel + " en " + _loc2_.x + "," + _loc2_.y + " : <br/>" + this.getName("<br/>");
   }
   function __set__Level(value)
   {
      this._aLevelsList = value.split(",");
      return this.__get__Level();
   }
   function __get__totalLevel()
   {
      var _loc2_ = 0;
      var _loc3_ = 0;
      while(_loc3_ < this._aLevelsList.length)
      {
         _loc2_ = _loc2_ + Number(this._aLevelsList[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
   function __get__bonusValue()
   {
      return this._nBonusValue;
   }
   function __get__alignment()
   {
      return new dofus.datacenter.Alignment(this._nAlignmentIndex,0);
   }
}
