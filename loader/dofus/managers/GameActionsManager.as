class dofus.managers.GameActionsManager extends dofus.utils.ApiElement
{
	static var STATE_TRANSMITTING = 2;
	static var STATE_IN_PROGRESS = 1;
	static var STATE_READY = 0;
	function GameActionsManager(var2, var3)
	{
		super();
		this.initialize(var3,var4);
	}
	function initialize(var2, var3)
	{
		super.initialize(var4);
		this._data = var3;
		this.clear();
	}
	function clear(var2)
	{
		this._id = undefined;
		this._bNextAction = false;
		this._state = dofus.managers.GameActionsManager.STATE_READY;
		this._currentType = null;
	}
	function transmittingMove(var2, var3)
	{
		if(!this.isWaiting())
		{
			this.api.network.GameActions.sendActions(var2,var3);
			this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
			this._currentType = var2;
		}
		else if(this.canCancel(var2))
		{
			this.cancel(this._data.lastCellNum);
			this.transmittingMove(var2,var3);
		}
		else
		{
			ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci");
		}
	}
	function transmittingOther(var2, var3)
	{
		if(!this.isWaiting())
		{
			this.api.network.GameActions.sendActions(var2,var3);
			this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
			this._currentType = var2;
		}
		else
		{
			ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci " + var2 + " " + var3);
		}
	}
	function onServerResponse(var2)
	{
		this._id = var2;
		this._state = dofus.managers.GameActionsManager.STATE_IN_PROGRESS;
	}
	function cancel(var2, var3)
	{
		this._currentType = null;
		if(this.canCancel())
		{
			this.api.network.GameActions.actionCancel(this._id,var2);
			var var4 = this._data.sequencer;
			var var5 = this._data.mc;
			var4.clearAllNextActions();
			if(var3 == true)
			{
				var4.addAction(125,false,var5,var5.setAnim,["Static"]);
			}
			this.clear();
		}
	}
	function end(var2)
	{
		if(this._bNextAction == false || !var2)
		{
			this.clear();
		}
		else
		{
			this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
			this._id = undefined;
		}
	}
	function ack(var2)
	{
		this.api.network.GameActions.actionAck(var2);
		this.end(true);
	}
	function isWaiting(var2)
	{
		if((var var0 = this._state) !== dofus.managers.GameActionsManager.STATE_READY)
		{
			if(var0 !== dofus.managers.GameActionsManager.STATE_TRANSMITTING)
			{
				if(var0 !== dofus.managers.GameActionsManager.STATE_IN_PROGRESS)
				{
					return false;
				}
			}
			return true;
		}
		return false;
	}
	function canCancel(var2)
	{
		if(var2 != this._currentType)
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
				if(var0 !== dofus.managers.GameActionsManager.STATE_IN_PROGRESS)
				{
					return false;
				}
			case dofus.managers.GameActionsManager.STATE_READY:
				return true;
		}
	}
}
