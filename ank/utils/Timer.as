class ank.utils.Timer extends Object
{
   static var _nTimerIndex = 0;
   static var _oIDs = new Object();
   static var _tTimer = new ank.utils.Timer();
   function Timer()
   {
      super();
   }
   static function setTimer(mRefObject, sLayer, mFuncObject, fFunction, nInterval, aParams, bRepeat)
   {
      ank.utils.Timer.garbageCollector();
      var _loc9_ = ank.utils.Timer.getNextTimerIndex();
      var _loc10_ = _global.setInterval(ank.utils.Timer.getInstance(),"onTimer",nInterval,_loc9_,mRefObject,sLayer,mFuncObject,fFunction,aParams);
      mRefObject.__ANKTIMERID__ = _loc10_;
      mRefObject.__ANKTIMERREPEAT__ = bRepeat;
      if(ank.utils.Timer._oIDs[sLayer] == undefined)
      {
         ank.utils.Timer._oIDs[sLayer] = new Object();
      }
      ank.utils.Timer._oIDs[sLayer][_loc9_] = new Array(mRefObject,_loc10_,sLayer);
   }
   static function clear(sLayer)
   {
      if(sLayer != undefined)
      {
         var _loc3_ = ank.utils.Timer._oIDs[sLayer];
         for(var k in _loc3_)
         {
            ank.utils.Timer.removeTimer(_loc3_[k][0],sLayer,_loc3_[k][1]);
         }
      }
      else
      {
         for(var k in ank.utils.Timer._oIDs)
         {
            var _loc4_ = ank.utils.Timer._oIDs[k];
            for(var kk in _loc4_)
            {
               ank.utils.Timer.removeTimer(_loc4_[kk][0],_loc4_[kk][2],_loc4_[kk][1]);
            }
         }
      }
      ank.utils.Timer.garbageCollector();
   }
   static function clean()
   {
      ank.utils.Timer.garbageCollector();
   }
   static function removeTimer(mRefObject, sLayer, nTimerIndex)
   {
      if(nTimerIndex == undefined)
      {
         if(mRefObject == undefined)
         {
            return undefined;
         }
         if(mRefObject.__ANKTIMERID__ == undefined)
         {
            return undefined;
         }
         var _loc5_ = mRefObject.__ANKTIMERID__;
      }
      else
      {
         _loc5_ = ank.utils.Timer._oIDs[sLayer][nTimerIndex][1];
      }
      _global.clearInterval(_loc5_);
      delete mRefObject.__ANKTIMERID__;
      delete ank.utils.Timer._oIDs[sLayer].nTimerIndex;
   }
   static function getInstance()
   {
      return ank.utils.Timer._tTimer;
   }
   static function garbageCollector()
   {
      for(var k in ank.utils.Timer._oIDs)
      {
         var _loc2_ = ank.utils.Timer._oIDs[k];
         for(var kk in _loc2_)
         {
            var _loc3_ = _loc2_[kk];
            if(_loc3_[0] == undefined || (typeof _loc3_[0] == "movieclip" && _loc3_[0]._name == undefined || _loc3_[0].__ANKTIMERID__ != _loc3_[1]))
            {
               _global.clearInterval(_loc3_[1]);
               delete register2.kk;
            }
         }
      }
   }
   static function getTimersCount()
   {
      var _loc2_ = 0;
      for(var k in ank.utils.Timer._oIDs)
      {
         var _loc3_ = ank.utils.Timer._oIDs[k];
         for(var kk in _loc3_)
         {
            _loc2_ = _loc2_ + 1;
         }
      }
      return _loc2_;
   }
   static function getNextTimerIndex()
   {
      ank.utils.Timer._nTimerIndex = ank.utils.Timer._nTimerIndex + 1;
      return ank.utils.Timer._nTimerIndex;
   }
   function onTimer(nTimerIndex, mRefObject, sLayer, mFuncObject, fFunction, aParams)
   {
      if(mRefObject == undefined)
      {
         ank.utils.Timer.removeTimer(undefined,sLayer,nTimerIndex);
         return undefined;
      }
      if(mRefObject.__ANKTIMERID__ == undefined)
      {
         ank.utils.Timer.removeTimer(undefined,sLayer,nTimerIndex);
         return undefined;
      }
      if(!mRefObject.__ANKTIMERREPEAT__)
      {
         ank.utils.Timer.removeTimer(mRefObject,sLayer,nTimerIndex);
         delete mRefObject.__ANKTIMERID__;
      }
      fFunction.apply(mFuncObject,aParams);
      ank.utils.Timer.garbageCollector();
   }
}
