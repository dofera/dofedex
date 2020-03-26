class ank.utils.PatternDecoder
{
   function PatternDecoder()
   {
   }
   static function getDescription(sText, aParams)
   {
      ank.utils.Extensions.addExtensions();
      var _loc4_ = sText.split("");
      var _loc5_ = ank.utils.PatternDecoder.decodeDescription(_loc4_,aParams).join("");
      return _loc5_;
   }
   static function combine(str, gender, singular)
   {
      ank.utils.Extensions.addExtensions();
      var _loc5_ = str.split("");
      var _loc6_ = new Object();
      _loc6_.m = gender == "m";
      _loc6_.f = gender == "f";
      _loc6_.n = gender == "n";
      _loc6_.p = !singular;
      _loc6_.s = singular;
      var _loc7_ = ank.utils.PatternDecoder.decodeCombine(_loc5_,_loc6_).join("");
      return _loc7_;
   }
   static function replace(sSrc, sPattern)
   {
      var _loc4_ = sSrc.split("##");
      var _loc5_ = 1;
      while(_loc5_ < _loc4_.length)
      {
         var _loc6_ = _loc4_[_loc5_].split(",");
         _loc4_[_loc5_] = ank.utils.PatternDecoder.getDescription(sPattern,_loc6_);
         _loc5_ = _loc5_ + 2;
      }
      return _loc4_.join("");
   }
   static function replaceStr(sSrc, sSearchPattern, sReplaceStr)
   {
      var _loc5_ = sSrc.split(sSearchPattern);
      return _loc5_.join(sReplaceStr);
   }
   static function decodeDescription(aStr, aParams)
   {
      var _loc4_ = 0;
      var _loc5_ = new String();
      var _loc6_ = aStr.length;
      while(_loc4_ < _loc6_)
      {
         _loc5_ = aStr[_loc4_];
         switch(_loc5_)
         {
            case "#":
               var _loc7_ = aStr[_loc4_ + 1];
               if(!_global.isNaN(_loc7_))
               {
                  if(aParams[_loc7_ - 1] != undefined)
                  {
                     aStr.splice(_loc4_,2,aParams[_loc7_ - 1]);
                     _loc4_ = _loc4_ - 1;
                  }
                  else
                  {
                     aStr.splice(_loc4_,2);
                     _loc4_ = _loc4_ - 2;
                  }
               }
               break;
            case "~":
               var _loc8_ = aStr[_loc4_ + 1];
               if(!_global.isNaN(_loc8_))
               {
                  if(aParams[_loc8_ - 1] != undefined)
                  {
                     aStr.splice(_loc4_,2);
                     _loc4_ = _loc4_ - 2;
                  }
                  else
                  {
                     return aStr.slice(0,_loc4_);
                  }
               }
               break;
            case "{":
               var _loc9_ = ank.utils.PatternDecoder.find(aStr.slice(_loc4_),"}");
               var _loc10_ = ank.utils.PatternDecoder.decodeDescription(aStr.slice(_loc4_ + 1,_loc4_ + _loc9_),aParams).join("");
               aStr.splice(_loc4_,_loc9_ + 1,_loc10_);
               break;
            case "[":
               var _loc11_ = ank.utils.PatternDecoder.find(aStr.slice(_loc4_),"]");
               var _loc12_ = Number(aStr.slice(_loc4_ + 1,_loc4_ + _loc11_).join(""));
               if(!_global.isNaN(_loc12_))
               {
                  aStr.splice(_loc4_,_loc11_ + 1,aParams[_loc12_] + " ");
                  _loc4_ = _loc4_ - _loc11_;
               }
         }
         _loc4_ = _loc4_ + 1;
      }
      return aStr;
   }
   static function decodeCombine(aStr, oParams)
   {
      var _loc4_ = 0;
      var _loc5_ = new String();
      var _loc6_ = aStr.length;
      while(_loc4_ < _loc6_)
      {
         _loc5_ = aStr[_loc4_];
         switch(_loc5_)
         {
            case "~":
               var _loc7_ = aStr[_loc4_ + 1];
               if(oParams[_loc7_])
               {
                  aStr.splice(_loc4_,2);
                  _loc4_ = _loc4_ - 2;
                  break;
               }
               return aStr.slice(0,_loc4_);
               break;
            case "{":
               var _loc8_ = ank.utils.PatternDecoder.find(aStr.slice(_loc4_),"}");
               var _loc9_ = ank.utils.PatternDecoder.decodeCombine(aStr.slice(_loc4_ + 1,_loc4_ + _loc8_),oParams).join("");
               aStr.splice(_loc4_,_loc8_ + 1,_loc9_);
         }
         _loc4_ = _loc4_ + 1;
      }
      return aStr;
   }
   static function find(a, f)
   {
      var _loc4_ = a.length;
      var _loc5_ = 0;
      while(_loc5_ < _loc4_)
      {
         if(a[_loc5_] == f)
         {
            return _loc5_;
         }
         _loc5_ = _loc5_ + 1;
      }
      return -1;
   }
}
