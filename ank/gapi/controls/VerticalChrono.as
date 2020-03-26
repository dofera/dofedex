class ank.gapi.controls.VerticalChrono extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "VerticalChrono";
   function VerticalChrono()
   {
      super();
   }
   function startTimer(nDuration, nMaxValue)
   {
      this._nTimerValue = Math.ceil(nDuration);
      this._nMaxTime = nMaxValue != undefined?nMaxValue:this._nTimerValue;
      this.addToQueue({object:this,method:this.updateTimer});
      _global.clearInterval(this._nIntervalID);
      this._nIntervalID = _global.setInterval(this,"updateTimer",1000);
   }
   function stopTimer()
   {
      _global.clearInterval(this._nIntervalID);
      this._mcRectangle._height = 0;
   }
   function init()
   {
      super.init(false,ank.gapi.controls.VerticalChrono.CLASS_NAME);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("_mcRectangle",10);
   }
   function arrange()
   {
      this._mcRectangle._width = this.__width;
      this._mcRectangle._height = 0;
      this._mcRectangle._x = 0;
      this._mcRectangle._y = this.__height;
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      var _loc3_ = _loc2_ == undefined?0:_loc2_.bgcolor;
      var _loc4_ = _loc2_ == undefined?100:_loc2_.bgalpha;
      this._mcRectangle.clear();
      this.drawRoundRect(this._mcRectangle,0,0,100,100,0,_loc3_,_loc4_);
   }
   function updateTimer()
   {
      var _loc2_ = this._nTimerValue / this._nMaxTime;
      var _loc3_ = (this._nMaxTime - this._nTimerValue) / this._nMaxTime * this.__height;
      var _loc4_ = _loc2_ * this.__height;
      this._mcRectangle._y = _loc4_;
      this._mcRectangle._height = _loc3_;
      if(this._nTimerValue < 0)
      {
         this.stopTimer();
         this.dispatchEvent({type:"endTimer"});
      }
      this._nTimerValue = this._nTimerValue - 1;
   }
}
