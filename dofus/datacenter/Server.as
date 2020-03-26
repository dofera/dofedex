class dofus.datacenter.Server
{
   static var SERVER_OFFLINE = 0;
   static var SERVER_ONLINE = 1;
   static var SERVER_STARTING = 2;
   static var SERVER_CLASSIC = 0;
   static var SERVER_HARDCORE = 1;
   function Server(nID, nState, nCompletion, bCanLog)
   {
      this.initialize(nID,nState,nCompletion,bCanLog);
      this._nCharactersCount = 0;
   }
   function __set__id(nID)
   {
      this._nID = nID;
      return this.__get__id();
   }
   function __get__id()
   {
      return this._nID;
   }
   function __set__charactersCount(nCount)
   {
      this._nCharactersCount = nCount;
      return this.__get__charactersCount();
   }
   function __get__charactersCount()
   {
      return this._nCharactersCount;
   }
   function __set__state(nState)
   {
      this._nState = nState;
      return this.__get__state();
   }
   function __get__state()
   {
      return this._nState;
   }
   function __get__stateStr()
   {
      switch(this._nState)
      {
         case dofus.datacenter.Server.SERVER_OFFLINE:
            return this.api.lang.getText("SERVER_OFFLINE");
         case dofus.datacenter.Server.SERVER_ONLINE:
            return this.api.lang.getText("SERVER_ONLINE");
         case dofus.datacenter.Server.SERVER_STARTING:
            return this.api.lang.getText("SERVER_STARTING");
         default:
            return "";
      }
   }
   function __get__stateStrShort()
   {
      switch(this._nState)
      {
         case dofus.datacenter.Server.SERVER_OFFLINE:
            return this.api.lang.getText("SERVER_OFFLINE_SHORT");
         case dofus.datacenter.Server.SERVER_ONLINE:
            return this.api.lang.getText("SERVER_ONLINE_SHORT");
         case dofus.datacenter.Server.SERVER_STARTING:
            return this.api.lang.getText("SERVER_STARTING_SHORT");
         default:
            return "";
      }
   }
   function __set__canLog(bCanLog)
   {
      this._bCanLog = bCanLog;
      return this.__get__canLog();
   }
   function __get__canLog()
   {
      return this._bCanLog;
   }
   function __get__label()
   {
      return this.api.lang.getServerInfos(this._nID).n;
   }
   function __get__description()
   {
      return this.api.lang.getServerInfos(this._nID).d;
   }
   function __get__language()
   {
      return this.api.lang.getServerInfos(this._nID).l;
   }
   function __get__population()
   {
      return Number(this.api.lang.getServerInfos(this._nID).p);
   }
   function __get__populationStr()
   {
      return this.api.lang.getServerPopulation(this.population);
   }
   function __get__community()
   {
      return Number(this.api.lang.getServerInfos(this._nID).c);
   }
   function __get__communityStr()
   {
      return this.api.lang.getServerCommunity(this.community);
   }
   function __get__date()
   {
      var _loc2_ = new Date(Number(this.api.lang.getServerInfos(this._nID).date));
      return _loc2_;
   }
   function __get__dateStr()
   {
      var _loc2_ = new Date(Number(this.api.lang.getServerInfos(this._nID).date));
      return org.utils.SimpleDateFormatter.formatDate(_loc2_,this.api.lang.getConfigText("LONG_DATE_FORMAT"),this.api.config.language);
   }
   function __get__type()
   {
      return this.api.lang.getText("SERVER_GAME_TYPE_" + this.api.lang.getServerInfos(this._nID).t);
   }
   function __get__typeNum()
   {
      return this.api.lang.getServerInfos(this._nID).t;
   }
   function isHardcore()
   {
      return this.typeNum == dofus.datacenter.Server.SERVER_HARDCORE;
   }
   function initialize(nID, nState, nCompletion, bCanLog)
   {
      this.api = _global.API;
      this._nID = nID;
      this._nState = nState;
      this._bCanLog = bCanLog;
      this.completion = nCompletion;
      this.populationWeight = Number(this.api.lang.getServerPopulationWeight(this.population));
   }
   function isAllowed()
   {
      if(this.api.datacenter.Player.isAuthorized)
      {
         return true;
      }
      var _loc2_ = this.api.lang.getServerInfos(this._nID).rlng;
      if(_loc2_ == undefined || (_loc2_.length == undefined || (_loc2_.length == 0 || this.api.config.skipLanguageVerification)))
      {
         return true;
      }
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         if(_loc2_[_loc3_].toUpperCase() == this.api.config.language.toUpperCase())
         {
            return true;
         }
         _loc3_ = _loc3_ + 1;
      }
      return false;
   }
}
