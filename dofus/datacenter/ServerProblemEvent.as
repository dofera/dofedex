class dofus.datacenter.ServerProblemEvent extends Object
{
   function ServerProblemEvent(nTimestamp, nEventID, bTranslated, sContent)
   {
      super();
      this._nTimestamp = nTimestamp;
      this._nID = nEventID;
      this._bTranslated = bTranslated;
      this._sContent = sContent;
      var _loc7_ = _global.API;
      this._sTitle = _loc7_.lang.getText("STATUS_EVENT_" + this._nID);
      var _loc8_ = _loc7_.lang.getConfigText("HOUR_FORMAT");
      var _loc9_ = _loc7_.config.language;
      var _loc10_ = new Date(this._nTimestamp);
      this._sHour = org.utils.SimpleDateFormatter.formatDate(_loc10_,_loc8_,_loc9_);
   }
   function __get__timestamp()
   {
      return this._nTimestamp;
   }
   function __get__hour()
   {
      return this._sHour;
   }
   function __get__id()
   {
      return this._nID;
   }
   function __get__title()
   {
      return this._sTitle;
   }
   function __get__translated()
   {
      return this._bTranslated;
   }
   function __get__content()
   {
      return this._sContent;
   }
}
