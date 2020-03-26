class dofus.datacenter.ServerProblem extends Object
{
   function ServerProblem(nID, nDate, nType, nStatus, aServers, aHistory)
   {
      super();
      this._nID = nID;
      this._nDate = nDate;
      this._nType = nType;
      this._nStatus = nStatus;
      this._aServers = aServers;
      this._aHistory = aHistory;
      var _loc9_ = _global.API;
      this._sType = _loc9_.lang.getText("STATUS_PROBLEM_" + this._nType);
      this._sStatus = _loc9_.lang.getText("STATUS_STATE_" + this._nStatus);
      var _loc10_ = _loc9_.lang.getConfigText("LONG_DATE_FORMAT");
      var _loc11_ = _loc9_.config.language;
      var _loc12_ = String(this._nDate);
      var _loc13_ = new Date(Number(_loc12_.substr(0,4)),Number(_loc12_.substr(4,2)) - 1,Number(_loc12_.substr(6,2)));
      this._sDate = org.utils.SimpleDateFormatter.formatDate(_loc13_,_loc10_,_loc11_);
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__date()
   {
      return this._sDate;
   }
   function __get__type()
   {
      return this._sType;
   }
   function __get__status()
   {
      return this._sStatus;
   }
   function __get__servers()
   {
      return this._aServers;
   }
   function __get__history()
   {
      return this._aHistory;
   }
}
