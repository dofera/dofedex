class dofus.managers.GameActionsManager extends dofus.utils.ApiElement
{
	static var STATE_TRANSMITTING = 2;
	static var STATE_IN_PROGRESS = 1;
	static var STATE_READY = 0;
	function GameActionsManager(§\x11\x17§, §\x1e\x1a\x16§)
	{
		super();
		this.initialize(var3,var4);
	}
	function initialize(§\x11\x17§, §\x1e\x1a\x16§)
	{
		super.initialize(var4);
		this._data = var3;
		this.clear();
	}
	function clear(§\x1e\n\f§)
	{
		this._id = undefined;
		this._bNextAction = false;
		this._state = dofus.managers.GameActionsManager.STATE_READY;
		this._currentType = null;
	}
	function transmittingMove(§\x1e\n\x1b§, §\x1e\x17\f§)
	{
		if(!this.isWaiting())
		{
			this.api.network.GameActions.sendActions(var2,var3);
			this._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
			this._currentType = var2;
		}
		else if(this.canCancel(var2))
		{
			this.cancel(this._data.cellNum);
			this.transmittingMove(var2,var3);
		}
		else
		{
			ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci");
		}
	}
	function isOnUncancelableAction(§\x1e\n\x1b§)
	{
		return this.isWaiting() && !this.canCancel(var2);
	}
	function transmittingOther(§\x1e\n\x1b§, §\x1e\x17\f§)
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
	function onServerResponse(§\r\b§)
	{
		this._id = var2;
		this._state = dofus.managers.GameActionsManager.STATE_IN_PROGRESS;
	}
	function cancel(§\x1e\x17\f§, §\x19\x14§)
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
	function end(§\x19\b§)
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
	function ack(§\r\x07§)
	{
		this.api.network.GameActions.actionAck(var2);
		this.end(true);
	}
	function isWaiting(§\x1e\n\f§)
	{
		if((var var0 = this._state) !== dofus.managers.GameActionsManager.STATE_READY)
		{
			switch(null)
			{
				case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
				case dofus.managers.GameActionsManager.STATE_IN_PROGRESS:
					return true;
				default:
					return false;
			}
		}
		else
		{
			return false;
		}
	}
	function canCancel(§\x1e\n\x1b§)
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
