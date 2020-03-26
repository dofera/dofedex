class ank.utils.CyclicTimer extends Object
{
   static var _aFunctions = new Array();
   static var _nInterval = 40;
   static var _bPlaying = false;
   static var _oCyclicTimer = new ank.utils.CyclicTimer();
   function CyclicTimer()
   {
      super();
   }
   static function __get__interval()
   {
      return ank.utils.CyclicTimer._nInterval;
   }
   static function addFunction(oRef, oObjFn, fFunction, aParams, oObjFnEnd, fFunctionEnd, aParamsEnd)
   {
      var _loc9_ = new Object();
      _loc9_.objRef = oRef;
      _loc9_.objFn = oObjFn;
      _loc9_.fn = fFunction;
      _loc9_.params = aParams;
      _loc9_.objFnEnd = oObjFnEnd;
      _loc9_.fnEnd = fFunctionEnd;
      _loc9_.paramsEnd = aParamsEnd;
      ank.utils.CyclicTimer._aFunctions.push(_loc9_);
      ank.utils.CyclicTimer.play();
   }
   static function removeFunction(oRef)
   {
      var _loc3_ = ank.utils.CyclicTimer._aFunctions.length - 1;
      while(_loc3_ >= 0)
      {
         var _loc4_ = ank.utils.CyclicTimer._aFunctions[_loc3_];
         if(oRef == _loc4_.objRef)
         {
            ank.utils.CyclicTimer._aFunctions.splice(_loc3_,1);
         }
         _loc3_ = _loc3_ - 1;
      }
   }
   static function clear()
   {
      ank.utils.CyclicTimer.stop();
      ank.utils.CyclicTimer._aFunctions = new Array();
   }
   static function play()
   {
      if(ank.utils.CyclicTimer._bPlaying)
      {
         return undefined;
      }
      ank.utils.CyclicTimer._bPlaying = true;
      ank.utils.CyclicTimer.doCycle();
   }
   static function stop()
   {
      ank.utils.CyclicTimer._bPlaying = false;
   }
   static function getInstance()
   {
      return ank.utils.CyclicTimer._oCyclicTimer;
   }
   static function doCycle()
   {
      var _loc2_ = ank.utils.CyclicTimer._aFunctions.length - 1;
      while(_loc2_ >= 0)
      {
         var _loc3_ = ank.utils.CyclicTimer._aFunctions[_loc2_];
         if(!_loc3_.fn.apply(_loc3_.objFn,_loc3_.params))
         {
            ank.utils.CyclicTimer.onFunctionEnd(_loc2_,_loc3_);
         }
         _loc2_ = _loc2_ - 1;
      }
      if(ank.utils.CyclicTimer._aFunctions.length != 0)
      {
         var _loc4_ = ank.utils.CyclicTimer._nInterval;
         if(_global.doubleFramerate)
         {
            _loc4_ = _loc4_ / 2;
         }
         ank.utils.Timer.setTimer(ank.utils.CyclicTimer._oCyclicTimer,"cyclicTimer",ank.utils.CyclicTimer,ank.utils.CyclicTimer.doCycle,_loc4_);
      }
      else
      {
         ank.utils.CyclicTimer.stop();
      }
   }
   static function onFunctionEnd(nIndex, oFunction)
   {
      oFunction.fnEnd.apply(oFunction.objFnEnd,oFunction.paramsEnd);
      ank.utils.CyclicTimer._aFunctions.splice(nIndex,1);
   }
}
