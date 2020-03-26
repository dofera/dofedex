class ank.utils.Extensions
{
   static var bExtended = false;
   function Extensions()
   {
   }
   static function addExtensions()
   {
      if(ank.utils.Extensions.bExtended == true)
      {
         return true;
      }
      var _loc2_ = ank.utils.extensions.MovieClipExtensions.prototype;
      var _loc3_ = MovieClip.prototype;
      _loc3_.attachClassMovie = _loc2_.attachClassMovie;
      _loc3_.alignOnPixel = _loc2_.alignOnPixel;
      _loc3_.playFirstChildren = _loc2_.playFirstChildren;
      _loc3_.getFirstParentProperty = _loc2_.getFirstParentProperty;
      _loc3_.getActionClip = _loc2_.getActionClip;
      _loc3_.end = _loc2_.end;
      _loc3_.playAll = _loc2_.playAll;
      _loc3_.stopAll = _loc2_.stopAll;
      String.prototype.replace = function(searchStr, replaceStr)
      {
         return this.split(searchStr).join(replaceStr);
      };
      ank.utils.Extensions.bExtended = true;
      return true;
   }
}
