class dofus.datacenter.QuestObjective
{
   function QuestObjective(nID, bFinished)
   {
      this.initialize(nID,bFinished);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__description()
   {
      var _loc2_ = this.api.lang.getQuestObjectiveText(this._nID);
      var _loc3_ = _loc2_.t;
      var _loc4_ = _loc2_.p;
      var _loc5_ = new Array();
      var _loc6_ = this.api.lang.getQuestObjectiveTypeText(_loc3_);
      switch(_loc3_)
      {
         case 0:
         case 4:
            _loc5_ = [_loc4_[0]];
            break;
         case 1:
         case 9:
         case 10:
            _loc5_ = [this.api.lang.getNonPlayableCharactersText(_loc4_[0]).n];
            break;
         case 2:
         case 3:
            _loc5_[0] = this.api.lang.getNonPlayableCharactersText(_loc4_[0]).n;
            _loc5_[1] = this.api.lang.getItemUnicText(_loc4_[1]).n;
            _loc5_[2] = _loc4_[2];
            break;
         case 5:
            _loc5_[0] = this.api.lang.getMapSubAreaText(_loc4_[0]).n;
            break;
         case 6:
         case 7:
            _loc5_[0] = this.api.lang.getMonstersText(_loc4_[0]).n;
            _loc5_[1] = _loc4_[1];
            break;
         case 8:
            _loc5_[0] = this.api.lang.getItemUnicText(_loc4_[0]).n;
            break;
         case 12:
            _loc5_[0] = this.api.lang.getNonPlayableCharactersText(_loc4_[0]).n;
            _loc5_[1] = this.api.lang.getMonstersText(_loc4_[1]).n;
            _loc5_[2] = _loc4_[2];
      }
      return ank.utils.PatternDecoder.getDescription(_loc6_,_loc5_);
   }
   function __get__isFinished()
   {
      return this._bFinished;
   }
   function __get__x()
   {
      return this.api.lang.getQuestObjectiveText(this._nID).x;
   }
   function __get__y()
   {
      return this.api.lang.getQuestObjectiveText(this._nID).y;
   }
   function initialize(nID, bFinished)
   {
      this.api = _global.API;
      this._nID = nID;
      this._bFinished = bFinished;
   }
}
