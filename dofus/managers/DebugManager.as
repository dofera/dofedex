class dofus.managers.DebugManager extends dofus.utils.ApiElement
{
   static var _sSelf = null;
   function DebugManager(oAPI)
   {
      super();
      dofus.managers.DebugManager._sSelf = this;
      this.initialize(oAPI);
   }
   static function getInstance()
   {
      return dofus.managers.DebugManager._sSelf;
   }
   function initialize(oAPI)
   {
      super.initialize(oAPI);
      this.setDebug(dofus.Constants.DEBUG == true);
   }
   function setDebug(bOnOff)
   {
      this._bDebugEnabled = bOnOff;
      this.print("Debug mode " + (!bOnOff?"OFF":"ON"),5,true);
   }
   function toggleDebug()
   {
      this.setDebug(!this._bDebugEnabled);
   }
   function print(sMsg, nLevel, bEvenIfOff)
   {
      if(!bEvenIfOff && !this._bDebugEnabled)
      {
         return undefined;
      }
      var _loc5_ = this.getTimestamp() + " ";
      _loc5_ = _loc5_ + sMsg;
      var _loc6_ = "DEBUG_INFO";
      switch(nLevel)
      {
         case 5:
            _loc6_ = "ERROR_CHAT";
            break;
         case 4:
            _loc6_ = "MESSAGE_CHAT";
            break;
         case 3:
            _loc6_ = "DEBUG_ERROR";
            break;
         case 2:
            _loc6_ = "DEBUG_LOG";
            break;
         default:
            _loc6_ = "DEBUG_INFO";
      }
      this.api.kernel.showMessage(undefined,_loc5_,_loc6_);
   }
   function getTimestamp()
   {
      var _loc2_ = new Date();
      return "[" + new ank.utils.ExtendedString(_loc2_.getHours()).addLeftChar("0",2) + ":" + new ank.utils.ExtendedString(_loc2_.getMinutes()).addLeftChar("0",2) + ":" + new ank.utils.ExtendedString(_loc2_.getSeconds()).addLeftChar("0",2) + ":" + new ank.utils.ExtendedString(_loc2_.getMilliseconds()).addLeftChar("0",3) + "]";
   }
}
