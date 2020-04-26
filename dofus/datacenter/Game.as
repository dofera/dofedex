class dofus.datacenter.Game extends Object
{
	static var _bTacticMode = false;
	static var _bLogMapDisconnections = false;
	var _bRunning = false;
	var _bFirstTurn = true;
	function Game()
	{
		super();
		this.initialize();
	}
	function __get__isLoggingMapDisconnections()
	{
		return dofus.datacenter.Game._bLogMapDisconnections;
	}
	function __set__isLoggingMapDisconnections(loc2)
	{
		dofus.datacenter.Game._bLogMapDisconnections = loc2;
		return this.__get__isLoggingMapDisconnections();
	}
	function __get__isFirstTurn()
	{
		return this._bFirstTurn;
	}
	function __set__isFirstTurn(loc2)
	{
		this._bFirstTurn = loc2;
		return this.__get__isFirstTurn();
	}
	function __get__isTacticMode()
	{
		return dofus.datacenter.Game._bTacticMode;
	}
	function __set__isTacticMode(loc2)
	{
		dofus.datacenter.Game._bTacticMode = loc2;
		this.api.gfx.activateTacticMode(loc2);
		return this.__get__isTacticMode();
	}
	function __set__playerCount(loc2)
	{
		this._nPlayerCount = Number(loc2);
		return this.__get__playerCount();
	}
	function __get__playerCount()
	{
		return this._nPlayerCount;
	}
	function __set__currentPlayerID(loc2)
	{
		this._sCurrentPlayerID = loc2;
		return this.__get__currentPlayerID();
	}
	function __get__currentPlayerID()
	{
		return this._sCurrentPlayerID;
	}
	function __set__lastPlayerID(loc2)
	{
		this._sLastPlayerID = loc2;
		return this.__get__lastPlayerID();
	}
	function __get__lastPlayerID()
	{
		return this._sLastPlayerID;
	}
	function __set__state(loc2)
	{
		this._nState = Number(loc2);
		this.dispatchEvent({type:"stateChanged",value:this._nState});
		return this.__get__state();
	}
	function __get__state()
	{
		return this._nState;
	}
	function __set__fightType(loc2)
	{
		this._nFightType = loc2;
		return this.__get__fightType();
	}
	function __get__fightType()
	{
		return this._nFightType;
	}
	function __set__isSpectator(loc2)
	{
		this._bSpectator = loc2;
		return this.__get__isSpectator();
	}
	function __get__isSpectator()
	{
		return this._bSpectator;
	}
	function __set__turnSequence(loc2)
	{
		this._aTurnSequence = loc2;
		return this.__get__turnSequence();
	}
	function __get__turnSequence()
	{
		return this._aTurnSequence;
	}
	function __set__results(loc2)
	{
		this._oResults = loc2;
		return this.__get__results();
	}
	function __get__results()
	{
		return this._oResults;
	}
	function __set__isRunning(loc2)
	{
		this._bRunning = loc2;
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
	}
	function setInteractionType(loc2)
	{
		switch(loc2)
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
