class ank.gapi.controls.CircleChrono extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "CircleChrono";
   var _sBackgroundLink = "CircleChronoHalfDefault";
   var _nFinalCountDownTrigger = 5;
   function CircleChrono()
   {
      super();
   }
   function __set__background(sBackground)
   {
      this._sBackgroundLink = sBackground;
      return this.__get__background();
   }
   function __set__finalCountDownTrigger(nFinalCountDownTrigger)
   {
      nFinalCountDownTrigger = Number(nFinalCountDownTrigger);
      if(_global.isNaN(nFinalCountDownTrigger))
      {
         return undefined;
      }
      if(nFinalCountDownTrigger < 0)
      {
         return undefined;
      }
      this._nFinalCountDownTrigger = nFinalCountDownTrigger;
      return this.__get__finalCountDownTrigger();
   }
   function startTimer(nDuration)
   {
      _global.clearInterval(this._nIntervalID);
      nDuration = Number(nDuration);
      if(_global.isNaN(nDuration))
      {
         return undefined;
      }
      if(nDuration < 0)
      {
         return undefined;
      }
      this._nMaxTime = nDuration;
      this._nTimerValue = nDuration;
      this.updateTimer();
      this._nIntervalID = _global.setInterval(this,"updateTimer",1000);
   }
   function stopTimer()
   {
      _global.clearInterval(this._nIntervalID);
      this.dispatchEvent({type:"finish"});
      this.addToQueue({object:this,method:this.initialize});
   }
   function init()
   {
      super.init(false,ank.gapi.controls.CircleChrono.CLASS_NAME);
   }
   function createChildren()
   {
      this.attachMovie(this._sBackgroundLink,"_mcLeft",10);
      this.attachMovie(this._sBackgroundLink,"_mcRight",20);
   }
   function arrange()
   {
      this._mcLeft._width = this._mcRight._width = this.__width;
      this._mcLeft._height = this._mcRight._height = this.__height;
      this._mcLeft._xscale = this._mcLeft._xscale * -1;
      this._mcLeft._yscale = this._mcLeft._yscale * -1;
      this._mcLeft._x = this._mcRight._x = this.__width / 2;
      this._mcLeft._y = this._mcRight._y = this.__height / 2;
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      if(_loc2_.bgcolor != undefined)
      {
         this.setMovieClipColor(this._mcLeft.bg_mc,_loc2_.bgcolor);
         this.setMovieClipColor(this._mcRight.bg_mc,_loc2_.bgcolor);
      }
   }
   function updateTimer()
   {
      this.dispatchEvent({type:"tictac"});
      var _loc2_ = this._nTimerValue / this._nMaxTime;
      var _loc3_ = 360 * (1 - this._nTimerValue / this._nMaxTime);
      if(_loc3_ < 180)
      {
         this.setRtation(this._mcRight,_loc3_);
         this.setRtation(this._mcLeft,0);
      }
      else
      {
         this.setRtation(this._mcRight,180);
         this.setRtation(this._mcLeft,_loc3_ - 180);
      }
      if(this._nTimerValue - 5 <= this._nFinalCountDownTrigger)
      {
         this.dispatchEvent({type:"beforeFinalCountDown",value:Math.ceil(this._nTimerValue)});
      }
      if(this._nTimerValue <= this._nFinalCountDownTrigger)
      {
         this.dispatchEvent({type:"finalCountDown",value:Math.ceil(this._nTimerValue)});
      }
      this._nTimerValue = this._nTimerValue - 1;
      if(this._nTimerValue < 0)
      {
         this.stopTimer();
      }
   }
   function initialize()
   {
      this.setRtation(this._mcLeft,0);
      this.setRtation(this._mcRight,0);
   }
   function setRtation(mc, nAngle)
   {
      mc._mcMask._rotation = nAngle;
   }
}
