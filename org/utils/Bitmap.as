class org.utils.Bitmap
{
   function Bitmap()
   {
   }
   static function loadBitmapSmoothed(url, target)
   {
      var _loc4_ = target.createEmptyMovieClip("bmc",target.getNextHighestDepth());
      var _loc5_ = new Object();
      _loc5_.tmc = target;
      _loc5_.onLoadInit = function(mc)
      {
         mc._visible = false;
         mc.forceSmoothing = true;
         var _loc3_ = new flash.display.BitmapData(mc._width,mc._height,true);
         this.tmc.attachBitmap(_loc3_,this.tmc.getNextHighestDepth(),"auto",true);
         _loc3_.draw(mc);
      };
      var _loc6_ = new MovieClipLoader();
      _loc6_.addListener(_loc5_);
      _loc6_.loadClip(url,_loc4_);
   }
}
