class ank.utils.CustomDate
{
   static var MS_PER_DAY = 86400000;
   function CustomDate(nRefTime, aMonths, nYearOffset)
   {
      this._nRefTime = nRefTime;
      this._aMonths = aMonths;
      this._nYearOffset = nYearOffset;
      this._aMonths.sortOn("0",Array.NUMERIC | Array.DESCENDING);
      this._nSaveTime = getTimer();
   }
   function getCurrentTime()
   {
      var _loc2_ = this.getCurrentRealDate();
      var _loc3_ = _loc2_.getUTCHours();
      var _loc4_ = _loc2_.getUTCMinutes();
      return [_loc3_,_loc4_];
   }
   function getCurrentDate()
   {
      var _loc2_ = this.getCurrentRealDate();
      var _loc3_ = this.getYearDayNumber();
      var _loc4_ = 1;
      var _loc5_ = 0;
      while(_loc5_ < this._aMonths.length)
      {
         if(this._aMonths[_loc5_][0] < _loc3_)
         {
            _loc4_ = _loc5_;
            break;
         }
         _loc5_ = _loc5_ + 1;
      }
      return [_loc2_.getUTCFullYear(),this._aMonths[_loc4_][1],_loc3_ - this._aMonths[_loc4_][0]];
   }
   function getCurrentMillisInDay()
   {
      var _loc2_ = new Date();
      _loc2_.setTime(this._nRefTime);
      var _loc3_ = new Date(Date.UTC(1970,0,1,_loc2_.getUTCHours(),_loc2_.getUTCMinutes(),_loc2_.getUTCSeconds(),_loc2_.getUTCMilliseconds()));
      return _loc3_.getTime();
   }
   function getDiffDate(nTime)
   {
      var _loc3_ = this.getCurrentRealDate();
      var _loc4_ = new Date();
      _loc4_.setTime(nTime);
      _loc4_ = new Date(Date.UTC(_loc4_.getUTCFullYear() - this._nYearOffset,_loc4_.getUTCMonth(),_loc4_.getUTCDate(),_loc4_.getUTCHours(),_loc4_.getUTCMinutes(),_loc4_.getUTCSeconds(),_loc4_.getUTCMilliseconds()));
      return _loc3_ - _loc4_;
   }
   function getCurrentRealDate()
   {
      var _loc2_ = getTimer() - this._nSaveTime;
      var _loc3_ = new Date();
      _loc3_.setTime(this._nRefTime + _loc2_);
      _loc3_ = new Date(Date.UTC(_loc3_.getUTCFullYear() - this._nYearOffset,_loc3_.getUTCMonth(),_loc3_.getUTCDate(),_loc3_.getUTCHours(),_loc3_.getUTCMinutes(),_loc3_.getUTCSeconds(),_loc3_.getUTCMilliseconds()));
      return _loc3_;
   }
   function getYearDayNumber()
   {
      var _loc2_ = this.getCurrentRealDate();
      var _loc3_ = new Date(Date.UTC(_loc2_.getUTCFullYear(),0,1));
      return Math.floor((_loc2_ - _loc3_) / ank.utils.CustomDate.MS_PER_DAY) + 1;
   }
}
