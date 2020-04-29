class ank.utils.Sequencer extends Object
{
	var _nTimeModerator = 1;
	function Sequencer(timeout)
	{
		super();
		this.initialize(timeout);
	}
	function initialize(var2)
	{
		this._nTimeout = var2 != undefined?var2:10000;
		this._unicID = String(getTimer()) + random(10000);
		this._nActionIndex = 0;
		this.clear();
	}
	function clear(var2)
	{
		this._aActions = new Array();
		this._bPlaying = false;
		this._nTimeModerator = 1;
		ank.utils.Timer.removeTimer(this,"sequencer");
	}
	function setTimeModerator(var2)
	{
		this._nTimeModerator = var2;
	}
	function addAction(var2, var3, var4, var5, var6, var7)
	{
		var var8 = new Object();
		var8.id = this.getActionIndex();
		var8.waitEnd = var2;
		var8.object = var3;
		var8.fn = var4;
		var8.parameters = var5;
		var8.duration = var6;
		var8.forceTimeout = var2 && (var7 != undefined && var7);
		this._aActions.push(var8);
	}
	function execute(var2)
	{
		if(this._bPlaying && var2 == undefined)
		{
			return undefined;
		}
		this._bPlaying = true;
		var var3 = true;
		while(var3)
		{
			if(this._aActions.length > 0)
			{
				var var4 = this._aActions[0];
				if(var4.waitEnd)
				{
					var4.object[this._unicID] = var4.id;
				}
				var4.fn.apply(var4.object,var4.parameters);
				if(!var4.waitEnd)
				{
					this.onActionEnd(true);
				}
				else
				{
					var3 = false;
					ank.utils.Timer.setTimer(var4.object,"sequencer",this,this.onActionTimeOut,var4.duration == undefined?this._nTimeout:var4.duration * this._nTimeModerator,[var4.id]);
				}
			}
			else
			{
				var3 = false;
				this.stop();
			}
		}
	}
	function stop()
	{
		this._bPlaying = false;
	}
	function isPlaying()
	{
		return this._bPlaying;
	}
	function clearAllNextActions(var2)
	{
		this._aActions.splice(1);
		ank.utils.Timer.removeTimer(this,"sequencer");
	}
	function onActionTimeOut(var2)
	{
		if(var2 != undefined && this._aActions[0].id != var2)
		{
			return undefined;
		}
		this.onActionEnd(false,true);
	}
	function onActionEnd(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		if(this._aActions.length == 0)
		{
			return undefined;
		}
		if(this._aActions[0].forceTimeout && !var3)
		{
			return undefined;
		}
		if(this._aActions[0].waitEnd)
		{
			ank.utils.Timer.removeTimer(this._aActions[0].object,"sequencer");
		}
		this._aActions.shift();
		if(this._aActions.length == 0)
		{
			this.clear();
			this.onSequenceEnd();
		}
		else if(var2 != true)
		{
			if(this._bPlaying)
			{
				this.execute(true);
			}
		}
	}
	function toString()
	{
		return "Sequencer unicID:" + this._unicID + " playing:" + this._bPlaying + " actionsCount:" + this._aActions.length + " currentActionID:" + this._aActions[0].id + " currentActionObject:" + this._aActions[0].object + " currentActionParam:" + this._aActions[0].parameters.toString() + " currentActionBlocking:" + this._aActions[0].waitEnd + " currentActionForceTimeout:" + this._aActions[0].forceTimeout;
	}
	function getActionIndex(var2)
	{
		this._nActionIndex++;
		if(this._nActionIndex > 10000)
		{
			this._nActionIndex = 0;
		}
		return this._nActionIndex;
	}
}
