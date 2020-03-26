class ank.battlefield.mc.Bubble extends MovieClip
{
   function Bubble(text, x, y, maxW)
   {
      super();
      this.initialize(text,x,y,maxW);
   }
   function initialize(text, x, y, maxW)
   {
      this._maxW = maxW;
      this.createTextField("_txtf",20,0,0,150,100);
      this._txtf.autoSize = "left";
      this._txtf.wordWrap = true;
      this._txtf.embedFonts = true;
      this._txtf.multiline = true;
      this._txtf.selectable = false;
      this._txtf.html = true;
      this.draw(text,x,y);
   }
   function draw(text, x, y)
   {
      this._txtf.htmlText = text;
      this._txtf.setTextFormat(ank.battlefield.Constants.BUBBLE_TXTFORMAT);
      var _loc5_ = this._txtf.textHeight > 10?this._txtf.textHeight:11;
      var _loc6_ = this._txtf.textWidth > 10?this._txtf.textWidth + 4:11;
      this.drawBackground(_loc6_,_loc5_);
      this.adjust(_loc6_ + ank.battlefield.Constants.BUBBLE_MARGIN * 2,_loc5_ + ank.battlefield.Constants.BUBBLE_MARGIN * 2 + ank.battlefield.Constants.BUBBLE_PIC_HEIGHT,x,y);
      var _loc7_ = ank.battlefield.Constants.BUBBLE_REMOVE_TIMER + text.length * ank.battlefield.Constants.BUBBLE_REMOVE_CHAR_TIMER;
      ank.utils.Timer.setTimer(this,"battlefield",this,this.remove,_loc7_);
   }
   function remove()
   {
      this.swapDepths(1);
      this.removeMovieClip();
   }
   function drawBackground(w, h)
   {
      var _loc4_ = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
      this.createEmptyMovieClip("_bg",10);
      this._bg.lineStyle(1,ank.battlefield.Constants.BUBBLE_BORDERCOLOR,100);
      this._bg.beginFill(ank.battlefield.Constants.BUBBLE_BGCOLOR,100);
      this._bg.moveTo(0,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      this._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH / 2,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      this._bg.lineTo(0,0);
      this._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      this._bg.lineTo(w + _loc4_,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      this._bg.lineTo(w + _loc4_,- h - _loc4_ - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      this._bg.lineTo(0,- h - _loc4_ - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      this._bg.endFill();
   }
   function adjust(w, h, x, y)
   {
      var _loc6_ = this._maxW - w;
      var _loc7_ = h + ank.battlefield.Constants.BUBBLE_Y_OFFSET;
      if(x > _loc6_)
      {
         this._txtf._x = - w + ank.battlefield.Constants.BUBBLE_MARGIN;
         this._bg._xscale = -100;
      }
      else
      {
         this._txtf._x = ank.battlefield.Constants.BUBBLE_MARGIN;
      }
      if(y < _loc7_)
      {
         this._txtf._y = ank.battlefield.Constants.BUBBLE_PIC_HEIGHT + ank.battlefield.Constants.BUBBLE_MARGIN - 3;
         this._bg._yscale = -100;
      }
      else
      {
         this._txtf._y = - h + ank.battlefield.Constants.BUBBLE_MARGIN - 3 - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
         this._bg._y = - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
      }
      this._x = x;
      this._y = y;
   }
}
