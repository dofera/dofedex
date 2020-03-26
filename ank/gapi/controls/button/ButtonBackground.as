class ank.gapi.controls.button.ButtonBackground extends ank.gapi.core.UIBasicComponent
{
   function ButtonBackground()
   {
      super();
   }
   function setSize(nWidth, nHeight, bBorderAspectRatio)
   {
      this.left_mc._x = this.left_mc._y = this.middle_mc._y = this.right_mc._y = 0;
      this.left_mc._height = this.middle_mc._height = this.right_mc._height = nHeight;
      if(bBorderAspectRatio)
      {
         this.left_mc._xscale = this.left_mc._yscale;
         this.right_mc._xscale = this.right_mc._yscale;
      }
      this.middle_mc._x = this.left_mc != undefined?this.left_mc._width:0;
      this.middle_mc._width = nWidth - (this.left_mc != undefined?this.left_mc._width:0) - (this.right_mc != undefined?this.right_mc._width:0);
      this.right_mc._x = nWidth - this.right_mc._width;
   }
   function setStyleColor(oStyle, sSuffixe)
   {
      var _loc4_ = this.left_mc;
      for(var k in _loc4_)
      {
         var _loc5_ = k.split("_")[0];
         var _loc6_ = oStyle[_loc5_ + sSuffixe];
         if(_loc6_ != undefined)
         {
            this.setMovieClipColor(_loc4_[k],_loc6_);
         }
      }
      _loc4_ = this.middle_mc;
      for(var k in _loc4_)
      {
         var _loc7_ = k.split("_")[0];
         var _loc8_ = oStyle[_loc7_ + sSuffixe];
         if(_loc8_ != undefined)
         {
            this.setMovieClipColor(_loc4_[k],_loc8_);
         }
      }
      _loc4_ = this.right_mc;
      for(var k in _loc4_)
      {
         var _loc9_ = k.split("_")[0];
         var _loc10_ = oStyle[_loc9_ + sSuffixe];
         if(_loc10_ != undefined)
         {
            this.setMovieClipColor(_loc4_[k],_loc10_);
         }
      }
   }
}
