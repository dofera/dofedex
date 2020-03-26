class ank.utils.Crypt
{
   static var HASH = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9","-","_");
   function Crypt()
   {
   }
   static function cryptPassword(pwd, key)
   {
      var _loc4_ = "#1";
      var _loc5_ = 0;
      while(_loc5_ < pwd.length)
      {
         var _loc6_ = pwd.charCodeAt(_loc5_);
         var _loc7_ = key.charCodeAt(_loc5_);
         var _loc8_ = Math.floor(_loc6_ / 16);
         var _loc9_ = _loc6_ % 16;
         _loc4_ = _loc4_ + (ank.utils.Crypt.HASH[(_loc8_ + _loc7_ % ank.utils.Crypt.HASH.length) % ank.utils.Crypt.HASH.length] + ank.utils.Crypt.HASH[(_loc9_ + _loc7_ % ank.utils.Crypt.HASH.length) % ank.utils.Crypt.HASH.length]);
         _loc5_ = _loc5_ + 1;
      }
      return _loc4_;
   }
}
