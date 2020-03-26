class dofus.utils.consoleParsers.AbstractConsoleParser
{
   function AbstractConsoleParser()
   {
   }
   function __get__api()
   {
      return this._oAPI;
   }
   function __set__api(oApi)
   {
      this._oAPI = oApi;
      return this.__get__api();
   }
   function initialize(oAPI)
   {
      this._oAPI = oAPI;
      this._aConsoleHistory = new Array();
      this._nConsoleHistoryPointer = 0;
   }
   function process(sCmd, oParams)
   {
      this.pushHistory({value:sCmd,params:oParams});
   }
   function pushHistory(oCommand)
   {
      var _loc3_ = this._aConsoleHistory.slice(-1);
      if(_loc3_[0].value != oCommand.value)
      {
         var _loc4_ = this._aConsoleHistory.push(oCommand);
         if(_loc4_ > 50)
         {
            this._aConsoleHistory.shift();
         }
      }
      this.initializePointers();
   }
   function getHistoryUp()
   {
      if(this._nConsoleHistoryPointer > 0)
      {
         this._nConsoleHistoryPointer = this._nConsoleHistoryPointer - 1;
      }
      var _loc2_ = this._aConsoleHistory[this._nConsoleHistoryPointer];
      return _loc2_;
   }
   function getHistoryDown()
   {
      if(this._nConsoleHistoryPointer < this._aConsoleHistory.length)
      {
         this._nConsoleHistoryPointer = this._nConsoleHistoryPointer + 1;
      }
      var _loc2_ = this._aConsoleHistory[this._nConsoleHistoryPointer];
      return _loc2_;
   }
   function autoCompletion(aList, sCmd)
   {
      return ank.utils.ConsoleUtils.autoCompletion(aList,sCmd);
   }
   function initializePointers()
   {
      this._nConsoleHistoryPointer = this._aConsoleHistory.length;
   }
}
