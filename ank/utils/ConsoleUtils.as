class ank.utils.ConsoleUtils
{
   function ConsoleUtils()
   {
   }
   static function autoCompletion(aList, sCmd)
   {
      var _loc4_ = ank.utils.ConsoleUtils.removeAndGetLastWord(sCmd);
      var _loc5_ = _loc4_.lastWord;
      sCmd = _loc4_.leftCmd;
      _loc5_ = _loc5_.toLowerCase();
      var _loc6_ = ank.utils.ConsoleUtils.getStringsStartWith(aList,_loc5_);
      if(_loc6_.length > 1)
      {
         var _loc7_ = "";
         var _loc8_ = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc7_ = String(_loc6_[_loc8_]).charAt(_loc5_.length);
            if(_loc7_ != "")
            {
               break;
            }
            _loc8_ = _loc8_ + 1;
         }
         if(_loc7_ == "")
         {
            return {result:sCmd + _loc5_,full:false};
         }
         return ank.utils.ConsoleUtils.autoCompletionRecurcive(_loc6_,sCmd,_loc5_ + _loc7_);
      }
      if(_loc6_.length != 0)
      {
         return {result:sCmd + _loc6_[0],isFull:true};
      }
      return {result:sCmd + _loc5_,list:_loc6_,isFull:false};
   }
   static function removeAndGetLastWord(sCmd)
   {
      var _loc3_ = sCmd.split(" ");
      if(_loc3_.length == 0)
      {
         return {leftCmd:"",lastWord:""};
      }
      var _loc4_ = String(_loc3_.pop());
      return {leftCmd:(_loc3_.length != 0?_loc3_.join(" ") + " ":""),lastWord:_loc4_};
   }
   static function autoCompletionRecurcive(aList, sLeftCmd, sPattern)
   {
      sPattern = sPattern.toLowerCase();
      var _loc5_ = ank.utils.ConsoleUtils.getStringsStartWith(aList,sPattern);
      if(_loc5_.length > 1 && _loc5_.length == aList.length)
      {
         var _loc6_ = "";
         var _loc7_ = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ = String(_loc5_[_loc7_]).charAt(sPattern.length);
            if(_loc6_ != "")
            {
               break;
            }
            _loc7_ = _loc7_ + 1;
         }
         if(_loc6_ == "")
         {
            return {result:sLeftCmd + sPattern,isFull:false};
         }
         return ank.utils.ConsoleUtils.autoCompletionRecurcive(_loc5_,sLeftCmd,sPattern + _loc6_);
      }
      if(_loc5_.length != 0)
      {
         return {result:sLeftCmd + sPattern.substr(0,sPattern.length - 1),list:aList,isFull:false};
      }
      return {result:sLeftCmd + sPattern,list:aList,isFull:false};
   }
   static function getStringsStartWith(aList, sPattern)
   {
      var _loc4_ = new Array();
      var _loc5_ = 0;
      while(_loc5_ < aList.length)
      {
         var _loc6_ = String(aList[_loc5_]).toLowerCase().split(sPattern);
         if(_loc6_[0] == "" && (_loc6_.length != 0 && String(aList[_loc5_]).length >= sPattern.length))
         {
            _loc4_.push(aList[_loc5_]);
         }
         _loc5_ = _loc5_ + 1;
      }
      return _loc4_;
   }
}
