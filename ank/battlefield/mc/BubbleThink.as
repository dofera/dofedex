class ank.battlefield.mc.BubbleThink extends ank.battlefield.mc.Bubble
{
   function BubbleThink(text, x, y, maxW)
   {
      super(text,x,y,maxW);
   }
   function drawCircle(mc, x, y, ray, color)
   {
      var _loc7_ = x + Math.sin(360 / 15 * 0 * Math.PI / 180) * ray;
      var _loc8_ = y + Math.cos(360 / 15 * 0 * Math.PI / 180) * ray;
      mc.moveTo(_loc7_,_loc8_);
      mc.beginFill(color,100);
      var _loc9_ = 0;
      while(_loc9_ <= 15)
      {
         var _loc10_ = x + Math.sin(360 / 15 * _loc9_ * Math.PI / 180) * ray;
         var _loc11_ = y + Math.cos(360 / 15 * _loc9_ * Math.PI / 180) * ray;
         mc.lineTo(_loc10_,_loc11_);
         _loc9_ = _loc9_ + 1;
      }
      mc.endFill();
   }
   function drawBackground(w, h)
   {
      var _loc4_ = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
      this.createEmptyMovieClip("_bg",10);
      var _loc5_ = - h - _loc4_ - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT;
      var _loc6_ = - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT;
      var _loc7_ = 0;
      var _loc8_ = w + _loc4_;
      this._bg.moveTo(_loc7_,_loc5_);
      this._bg.lineStyle(0,16777215);
      this._bg.beginFill(16777215,100);
      this._bg.lineTo(_loc8_,_loc5_);
      this._bg.lineTo(_loc8_,_loc6_);
      this._bg.lineTo(_loc7_,_loc6_);
      this._bg.lineTo(_loc7_,_loc5_);
      this._bg.endFill();
      var _loc9_ = _loc7_;
      while(_loc9_ <= _loc8_)
      {
         this.drawCircle(this._bg,_loc9_,_loc5_,7,16777215);
         _loc9_ = _loc9_ + 14;
      }
      var _loc10_ = _loc7_;
      while(_loc10_ <= _loc8_)
      {
         this.drawCircle(this._bg,_loc10_,_loc6_,7,16777215);
         _loc10_ = _loc10_ + 14;
      }
      var _loc11_ = _loc5_;
      while(_loc11_ <= _loc6_)
      {
         this.drawCircle(this._bg,_loc8_,_loc11_,7,16777215);
         _loc11_ = _loc11_ + 14;
      }
      var _loc12_ = _loc5_;
      while(_loc12_ <= _loc6_)
      {
         this.drawCircle(this._bg,_loc7_,_loc12_,7,16777215);
         _loc12_ = _loc12_ + 14;
      }
      this.drawCircle(this._bg,_loc7_,_loc6_ + 5,8,16777215);
      this.drawCircle(this._bg,-5,5,4,16777215);
      var _loc13_ = new Array();
      _loc13_.push(new flash.filters.GlowFilter(0,30,2,2,3,3,false,false));
      this._bg.filters = _loc13_;
      this._bg._alpha = 90;
   }
}
