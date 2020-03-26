class dofus.utils.criterions.CriterionManager
{
   static var MAIN_TYPE_AREA = "A";
   static var TYPE_AREA_ALIGNMENT = "A";
   static var MAIN_TYPE_BASIC = "B";
   static var TYPE_BASIC_EPISOD = "E";
   function CriterionManager()
   {
   }
   static function fillingCriterions(sCriterions)
   {
      var _loc3_ = sCriterions.split("|");
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         var _loc5_ = String(_loc3_[_loc4_]).split("&");
         if(_loc5_.length != 0)
         {
            var _loc6_ = 0;
            var _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               var _loc8_ = dofus.utils.criterions.CriterionManager.parseCriterion(_loc5_[_loc7_]);
               if(_loc8_.isFilled())
               {
                  _loc6_ = _loc6_ + 1;
               }
               _loc7_ = _loc7_ + 1;
            }
            if(_loc6_ == _loc5_.length)
            {
               return true;
            }
         }
         _loc4_ = _loc4_ + 1;
      }
      return false;
   }
   static function parseCriterion(sCriterion)
   {
      var _loc3_ = sCriterion.charAt(0);
      var _loc4_ = sCriterion.charAt(1);
      var _loc5_ = sCriterion.charAt(2);
      var _loc6_ = sCriterion.substring(3);
      switch(_loc3_)
      {
         case dofus.utils.criterions.CriterionManager.MAIN_TYPE_AREA:
            if((_loc0_ = _loc4_) === dofus.utils.criterions.CriterionManager.TYPE_AREA_ALIGNMENT)
            {
               var _loc7_ = new dofus.utils.criterions.subareaCriterion.SubareaCriterionAlignment(_loc5_,Number(_loc6_));
            }
            break;
         case dofus.utils.criterions.CriterionManager.MAIN_TYPE_BASIC:
            if((_loc0_ = _loc4_) === dofus.utils.criterions.CriterionManager.TYPE_BASIC_EPISOD)
            {
               _loc7_ = new dofus.utils.criterions.basicCriterion.BasicCriterionEpisod(_loc5_,Number(_loc6_));
            }
      }
      if(_loc7_ == null || !_loc7_.check())
      {
         return null;
      }
      return _loc7_;
   }
}
