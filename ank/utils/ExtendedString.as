class ank.utils.ExtendedString extends String
{
   static var DEFAULT_SPACECHARS = " \n\r\t";
   function ExtendedString(o)
   {
      super();
      this._s = String(o);
   }
   function replace(pFrom, pTo)
   {
      if(arguments.length == 0)
      {
         return this._s;
      }
      if(arguments.length == 1)
      {
         if(pFrom instanceof Array)
         {
            pTo = new Array(pFrom.length);
         }
         else
         {
            return this._s.split(pFrom).join("");
         }
      }
      if(!(pFrom instanceof Array))
      {
         return this._s.split(pFrom).join(pTo);
      }
      var _loc4_ = pFrom.length;
      var _loc5_ = this._s;
      if(pTo instanceof Array)
      {
         var _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = _loc5_.split(pFrom[_loc6_]).join(pTo[_loc6_]);
            _loc6_ = _loc6_ + 1;
         }
      }
      else
      {
         var _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc5_ = _loc5_.split(pFrom[_loc7_]).join(pTo);
            _loc7_ = _loc7_ + 1;
         }
      }
      return _loc5_;
   }
   function addLeftChar(sChar, nMaxSize)
   {
      var _loc4_ = nMaxSize - this._s.length;
      var _loc5_ = new String();
      var _loc6_ = 0;
      while(_loc6_ < _loc4_)
      {
         _loc5_ = _loc5_ + sChar;
         _loc6_ = _loc6_ + 1;
      }
      _loc5_ = _loc5_ + this._s;
      return _loc5_;
   }
   function addMiddleChar(nChar, nCount)
   {
      if(_global.isNaN(nCount))
      {
         nCount = Number(nCount);
      }
      nCount = Math.abs(nCount);
      var _loc5_ = new Array();
      var _loc4_ = this._s.length;
      while(_loc4_ > 0)
      {
         if(Math.max(0,_loc4_ - nCount) == 0)
         {
            _loc5_.push(this._s.substr(0,_loc4_));
         }
         else
         {
            _loc5_.push(this._s.substr(_loc4_ - nCount,nCount));
         }
         _loc4_ = _loc4_ - nCount;
      }
      _loc5_.reverse();
      return _loc5_.join(nChar);
   }
   function lTrim($space)
   {
      this._clearOutOfRange();
      this._lTrim(this.spaceStringToObject($space));
      return this;
   }
   function rTrim($space)
   {
      this._clearOutOfRange();
      this._rTrim(this.spaceStringToObject($space));
      return this;
   }
   function trim($space)
   {
      var _loc3_ = this.spaceStringToObject($space);
      this._clearOutOfRange();
      this._rTrim(_loc3_);
      this._lTrim(_loc3_);
      return this;
   }
   function toString()
   {
      return this._s;
   }
   function spaceStringToObject($space)
   {
      var _loc3_ = new Object();
      if($space == undefined)
      {
         $space = ank.utils.ExtendedString.DEFAULT_SPACECHARS;
      }
      if(typeof $space == "string")
      {
         var _loc4_ = $space.length;
         while((_loc4_ = _loc4_ - 1) >= 0)
         {
            _loc3_[$space.charAt(_loc4_)] = true;
         }
      }
      else
      {
         _loc3_ = $space;
      }
      return _loc3_;
   }
   function _lTrim($space)
   {
      var _loc3_ = this._s.length;
      var _loc4_ = 0;
      while(_loc3_ > 0)
      {
         if(!$space[this._s.charAt(_loc4_)])
         {
            break;
         }
         _loc4_ = _loc4_ + 1;
         _loc3_ = _loc3_ - 1;
      }
      this._s = this._s.slice(_loc4_);
   }
   function _rTrim($space)
   {
      var _loc3_ = this._s.length;
      var _loc4_ = _loc3_ - 1;
      while(_loc3_ > 0)
      {
         if(!$space[this._s.charAt(_loc4_)])
         {
            break;
         }
         _loc4_ = _loc4_ - 1;
         _loc3_ = _loc3_ - 1;
      }
      this._s = this._s.slice(0,_loc4_ + 1);
   }
   function _clearOutOfRange()
   {
      var _loc2_ = "";
      var _loc3_ = 0;
      while(_loc3_ < this._s.length)
      {
         if(this._s.charCodeAt(_loc3_) > 32 && this._s.charCodeAt(_loc3_) <= 255)
         {
            _loc2_ = _loc2_ + this._s.charAt(_loc3_);
         }
         _loc3_ = _loc3_ + 1;
      }
      this._s = _loc2_;
   }
}
