class dofus.graphics.battlefield.TextWithTitleOverHead extends dofus.graphics.battlefield.AbstractTextOverHead
{
   static var STARS_COUNT = 5;
   static var STARS_WIDTH = 10;
   static var STARS_MARGIN = 2;
   static var STARS_COLORS = [-1,16777011,16750848,39168,39372,6697728,2236962,16711680,65280,16777215,16711935];
   function TextWithTitleOverHead(sText, sFile, nColor, nFrame, sTitle, nColorTitle, nStarsValue)
   {
      super();
      this.initialize(nStarsValue);
      this.draw(sText,sFile,nColor,nFrame,sTitle,nColorTitle);
   }
   function initialize(starValue)
   {
      super.initialize();
      if(starValue == undefined || _global.isNaN(starValue))
      {
         starValue = -1;
      }
      this._nStarsValue = starValue;
      this.createTextField("_txtTitle",40,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER + 4,0,0);
      this.createTextField("_txtText",30,0,-3 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * (this._nStarsValue <= -1?1:2) + 20 + (this._nStarsValue <= -1?0:dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH),0,0);
      this._txtText.embedFonts = true;
      this._txtTitle.embedFonts = true;
      this._aStars = new Array();
   }
   function draw(sText, sFile, nColor, nFrame, sTitle, nColorTitle)
   {
      var _loc8_ = sFile != undefined && nFrame != undefined;
      this._txtText.autoSize = "center";
      this._txtText.text = sText;
      this._txtText.selectable = false;
      this._txtText.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
      if(nColor != undefined)
      {
         this._txtText.textColor = nColor;
      }
      this._txtTitle.autoSize = "center";
      this._txtTitle.text = sTitle;
      this._txtTitle.selectable = false;
      this._txtTitle.setTextFormat(dofus.graphics.battlefield.AbstractTextOverHead.TEXT_FORMAT);
      if(nColorTitle != undefined)
      {
         this._txtTitle.textColor = nColorTitle;
      }
      this._nFullWidth = dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT * dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH + (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT - 1) * dofus.graphics.battlefield.TextWithTitleOverHead.STARS_MARGIN;
      var _loc9_ = Math.ceil(this._txtText.textHeight + 20 + dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * (this._nStarsValue <= -1?3:4) + (this._nStarsValue <= -1?0:dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH));
      var _loc10_ = Math.ceil(Math.max(Math.max(this._txtText.textWidth,this._txtTitle.textWidth),this._nStarsValue <= -1?0:this._nFullWidth) + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER * 2);
      this.drawBackground(_loc10_,_loc9_,dofus.graphics.battlefield.AbstractTextOverHead.BACKGROUND_COLOR);
      if(this._nStarsValue > -1)
      {
         var _loc11_ = this.getStarsColor();
         var _loc12_ = 0;
         while(_loc12_ < dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)
         {
            var _loc13_ = new Object();
            _loc13_._x = _loc12_ * (dofus.graphics.battlefield.TextWithTitleOverHead.STARS_WIDTH + dofus.graphics.battlefield.TextWithTitleOverHead.STARS_MARGIN) - this._nFullWidth / 2 + dofus.graphics.battlefield.AbstractTextOverHead.WIDTH_SPACER;
            _loc13_._y = dofus.graphics.battlefield.AbstractTextOverHead.HEIGHT_SPACER * 4 + this._txtTitle.textHeight;
            this._aStars[_loc12_] = this.createEmptyMovieClip("star" + _loc12_,50 + _loc12_);
            this._aStars[_loc12_].attachMovie("StarBorder","star",1,_loc13_);
            var _loc14_ = this._aStars[_loc12_].star.fill;
            if(_loc11_[_loc12_] > -1)
            {
               var _loc15_ = new Color(_loc14_);
               _loc15_.setRGB(_loc11_[_loc12_]);
            }
            else
            {
               _loc14_._alpha = 0;
            }
            _loc12_ = _loc12_ + 1;
         }
      }
      if(_loc8_)
      {
         this.drawGfx(sFile,nFrame);
      }
   }
   function getStarsColor()
   {
      var _loc2_ = new Array();
      var _loc3_ = 0;
      while(_loc3_ < dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)
      {
         var _loc4_ = Math.floor(this._nStarsValue / 100) + (this._nStarsValue - Math.floor(this._nStarsValue / 100) * 100 <= _loc3_ * (100 / dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COUNT)?0:1);
         _loc2_[_loc3_] = dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COLORS[Math.min(_loc4_,dofus.graphics.battlefield.TextWithTitleOverHead.STARS_COLORS.length - 1)];
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
}
