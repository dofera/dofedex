class dofus.managers.GameActionsManager extends dofus.utils.ApiElement
{
	static var STATE_TRANSMITTING = 2;
	static var STATE_IN_PROGRESS = 1;
	static var STATE_READY = 0;
	function GameActionsManager(loc3, loc4)
	{
		super();
		this.initialize(loc3,loc4);
	}
	function initialize(loc2, loc3)
	{
		super.initialize(loc4);
		this._data = loc3;
		this.clear();
	}
	function clear(loc2)
	{
		this._id = undefined;
		this._bNextAction = false;
		this._state = dofus.managers.GameActionsManager.STATE_READY;
		this._currentType = null;
	}
	function transmittingMove(loc2, loc3)
	{
		if(!this.isWaiting())
		{
			this.api.network.GameActions.sendActions(loc2,loc3);
			this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
			this._currentType = loc2;
		}
		else if(this.canCancel(loc2))
		{
			this.cancel(this._data.lastCellNum);
			this.transmittingMove(loc2,loc3);
		}
		else
		{
			ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci");
		}
	}
	function transmittingOther(loc2, loc3)
	{
		if(!this.isWaiting())
		{
			this.api.network.GameActions.sendActions(loc2,loc3);
			this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
			this._currentType = loc2;
		}
		else
		{
			ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci " + loc2 + " " + loc3);
		}
	}
	function onServerResponse(loc2)
	{
		this._id = loc2;
		this._state = dofus.managers.GameActionsManager.STATE_IN_PROGRESS;
	}
	function cancel(loc2, loc3)
	{
		this._currentType = null;
		if(this.canCancel())
		{
			this.api.network.GameActions.actionCancel(this._id,loc2);
			var loc4 = this._data.sequencer;
			var loc5 = this._data.mc;
			loc4.clearAllNextActions();
			if(loc3 == true)
			{
				loc4.addAction(false,loc5,loc5.setAnim,["Static"]);
			}
			this.clear();
		}
	}
	function end(loc2)
	{
		if(this._bNextAction == false || !loc2)
		{
			this.clear();
		}
		else
		{
			this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
			this._id = undefined;
		}
	}
	function ack(loc2)
	{
		this.api.network.GameActions.actionAck(loc2);
		this.end(true);
	}
	function isWaiting(loc2)
	{
		switch(this._state)
		{
			case dofus.managers.GameActionsManager.STATE_READY:
				return false;
			default:
				if(loc0 !== dofus.managers.GameActionsManager.STATE_IN_PROGRESS)
				{
					return false;
				}
			case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
				return true;
		}
	}
	function canCancel(loc2)
	{
		if(loc2 != this._currentType)
		{
			return false;
		}
		if(this._id == undefined)
		{
			return false;
		}
		switch(this._state)
		{
			case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
				return false;
			default:
				if(loc0 !== dofus.managers.GameActionsManager.STATE_IN_PROGRESS)
				{
					return false;
				}
			case dofus.managers.GameActionsManager.STATE_READY:
				return true;
		}
	}
}
