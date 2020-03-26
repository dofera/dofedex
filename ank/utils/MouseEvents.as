class ank.utils.MouseEvents
{
   function MouseEvents()
   {
   }
   static function addListener(oListener)
   {
      Mouse.addListener(oListener);
      ank.utils.MouseEvents.garbageCollector();
   }
   static function garbageCollector()
   {
      var _loc2_ = Mouse._listeners;
      var _loc3_ = _loc2_.length;
      while(_loc3_ >= 0)
      {
         var _loc4_ = _loc2_[_loc3_];
         if(_loc4_ == undefined || _loc4_._target == undefined)
         {
            _loc2_.splice(_loc3_,1);
         }
         _loc3_ = _loc3_ - 1;
      }
   }
}
