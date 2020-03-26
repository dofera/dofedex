class dofus.datacenter.Game extends Object
{
   static var _bTacticMode = false;
   static var _bLogMapDisconnections = false;
   var _bRunning = false;
   function Game()
   {
      super();
      this.initialize();
   }
   function __get__isLoggingMapDisconnections()
   {
      return dofus.datacenter.Game._bLogMapDisconnections;
   }
   function __set__isLoggingMapDisconnections(bLogMapDisconnections)
   {
      dofus.datacenter.Game._bLogMapDisconnections = bLogMapDisconnections;
      return this.__get__isLoggingMapDisconnections();
   }
   function __get__isTacticMode()
   {
      return dofus.datacenter.Game._bTacticMode;
   }
   function __set__isTacticMode(bTacticMode)
   {
      dofus.datacenter.Game._bTacticMode = bTacticMode;
      this.api.gfx.activateTacticMode(bTacticMode);
      return this.__get__isTacticMode();
   }
   function __set__playerCount(nPlayerCount)
   {
      this._nPlayerCount = Number(nPlayerCount);
      return this.__get__playerCount();
   }
   function __get__playerCount()
   {
      return this._nPlayerCount;
   }
   function __set__currentPlayerID(sCurrentPlayerID)
   {
      this._sCurrentPlayerID = sCurrentPlayerID;
      return this.__get__currentPlayerID();
   }
   function __get__currentPlayerID()
   {
      return this._sCurrentPlayerID;
   }
   function __set__lastPlayerID(sLastPlayerID)
   {
      this._sLastPlayerID = sLastPlayerID;
      return this.__get__lastPlayerID();
   }
   function __get__lastPlayerID()
   {
      return this._sLastPlayerID;
   }
   function __set__state(nState)
   {
      this._nState = Number(nState);
      this.dispatchEvent({type:"stateChanged",value:this._nState});
      return this.__get__state();
   }
   function __get__state()
   {
      return this._nState;
   }
   function __set__fightType(nFightType)
   {
      this._nFightType = nFightType;
      return this.__get__fightType();
   }
   function __get__fightType()
   {
      return this._nFightType;
   }
   function __set__isSpectator(bSpectator)
   {
      this._bSpectator = bSpectator;
      return this.__get__isSpectator();
   }
   function __get__isSpectator()
   {
      return this._bSpectator;
   }
   function __set__turnSequence(aTurnSequence)
   {
      this._aTurnSequence = aTurnSequence;
      return this.__get__turnSequence();
   }
   function __get__turnSequence()
   {
      return this._aTurnSequence;
   }
   function __set__results(oResults)
   {
      this._oResults = oResults;
      return this.__get__results();
   }
   function __get__results()
   {
      return this._oResults;
   }
   function __set__isInCreaturesMode(bInCreaturesMode)
   {
      this._bInCreaturesMode = bInCreaturesMode;
      return this.__get__isInCreaturesMode();
   }
   function __get__isInCreaturesMode()
   {
      return this._bInCreaturesMode;
   }
   function __set__isRunning(bRunning)
   {
      this._bRunning = bRunning;
      return this.__get__isRunning();
   }
   function __get__isRunning()
   {
      return this._bRunning;
   }
   function __get__isFight()
   {
      return this._nState > 1 && this._nState != undefined;
   }
   function __get__interactionType()
   {
      return this._nInteractionType;
   }
   function initialize()
   {
      mx.events.EventDispatcher.initialize(this);
      this.api = _global.API;
      this._bRunning = false;
      this._nPlayerCount = 0;
      this._sCurrentPlayerID = null;
      this._sLastPlayerID = null;
      this._nState = 0;
      this._aTurnSequence = new Array();
      this._oResults = new Object();
      this._nInteractionType = 0;
      this._bInCreaturesMode = false;
   }
   function setInteractionType(sType)
   {
      switch(sType)
      {
         case "move":
            this._nInteractionType = 1;
            break;
         case "spell":
            this._nInteractionType = 2;
            break;
         case "cc":
            this._nInteractionType = 3;
            break;
         case "place":
            this._nInteractionType = 4;
            break;
         case "target":
            this._nInteractionType = 5;
            break;
         case "flag":
            this._nInteractionType = 6;
      }
   }
}
