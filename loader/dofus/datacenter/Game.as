class dofus.datacenter.Game extends Object
{
	static var INTERACTION_TYPE_MOVE = 1;
	static var INTERACTION_TYPE_SPELL = 2;
	static var INTERACTION_TYPE_CC = 3;
	static var INTERACTION_TYPE_PLACE = 4;
	static var INTERACTION_TYPE_TARGET = 5;
	static var INTERACTION_TYPE_FLAG = 6;
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
	function __set__isLoggingMapDisconnections(§\x18\x02§)
	{
		dofus.datacenter.Game._bLogMapDisconnections = var2;
		return this.__get__isLoggingMapDisconnections();
	}
	function __get__isFirstTurn()
	{
		return this._bFirstTurn;
	}
	function __set__isFirstTurn(§\x1a\x05§)
	{
		this._bFirstTurn = var2;
		return this.__get__isFirstTurn();
	}
	function __get__isTacticMode()
	{
		return dofus.datacenter.Game._bTacticMode;
	}
	function __set__isTacticMode(§\x14\x19§)
	{
		dofus.datacenter.Game._bTacticMode = var2;
		this.api.gfx.activateTacticMode(var2);
		return this.__get__isTacticMode();
	}
	function __set__playerCount(§\x01\x1c§)
	{
		this._nPlayerCount = Number(var2);
		return this.__get__playerCount();
	}
	function __get__playerCount()
	{
		return this._nPlayerCount;
	}
	function __set__currentTableTurn(§\x07\x03§)
	{
		this._nCurrentTableTurn = Number(var2);
		return this.__get__currentTableTurn();
	}
	function __get__currentTableTurn()
	{
		return this._nCurrentTableTurn;
	}
	function __set__currentPlayerID(§\x1e\x13\x13§)
	{
		this._sCurrentPlayerID = var2;
		return this.__get__currentPlayerID();
	}
	function __get__currentPlayerID()
	{
		return this._sCurrentPlayerID;
	}
	function __set__lastPlayerID(§\x1e\x11\x05§)
	{
		this._sLastPlayerID = var2;
		return this.__get__lastPlayerID();
	}
	function __get__lastPlayerID()
	{
		return this._sLastPlayerID;
	}
	function __set__state(§\x1e\x1d\x07§)
	{
		this._nState = Number(var2);
		this.dispatchEvent({type:"stateChanged",value:this._nState});
		return this.__get__state();
	}
	function __get__state()
	{
		return this._nState;
	}
	function __set__fightType(§\x05\x14§)
	{
		this._nFightType = var2;
		return this.__get__fightType();
	}
	function __get__fightType()
	{
		return this._nFightType;
	}
	function __set__isSpectator(§\x15\x06§)
	{
		this._bSpectator = var2;
		return this.__get__isSpectator();
	}
	function __get__isSpectator()
	{
		return this._bSpectator;
	}
	function __set__turnSequence(§\x1d\x07§)
	{
		this._aTurnSequence = var2;
		return this.__get__turnSequence();
	}
	function __get__turnSequence()
	{
		return this._aTurnSequence;
	}
	function __set__results(§\x1e\x18\f§)
	{
		this._oResults = var2;
		return this.__get__results();
	}
	function __get__results()
	{
		return this._oResults;
	}
	function __set__isRunning(§\x16\x05§)
	{
		this._bRunning = var2;
		return this.__get__isRunning();
	}
	function __get__isRunning()
	{
		return this._bRunning;
	}
	function __get__isFight()
	{
		return this._nState != undefined && this._nState > 1;
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
		this._nCurrentTableTurn = 0;
	}
	function setInteractionType(§\x1e\f\x14§)
	{
		switch(var2)
		{
			case "move":
				this._nInteractionType = dofus.datacenter.Game.INTERACTION_TYPE_MOVE;
				break;
			case "spell":
				this._nInteractionType = dofus.datacenter.Game.INTERACTION_TYPE_SPELL;
				break;
			case "cc":
				this._nInteractionType = dofus.datacenter.Game.INTERACTION_TYPE_CC;
				break;
			case "place":
				this._nInteractionType = dofus.datacenter.Game.INTERACTION_TYPE_PLACE;
				break;
			default:
				switch(null)
				{
					case "target":
						this._nInteractionType = dofus.datacenter.Game.INTERACTION_TYPE_TARGET;
						break;
					case "flag":
						this._nInteractionType = dofus.datacenter.Game.INTERACTION_TYPE_FLAG;
				}
		}
	}
}
