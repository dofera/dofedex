class ank.utils.Sequencer extends Object
{
	var _nTimeModerator = 1;
	function Sequencer(timeout)
	{
		super();
		this.initialize(timeout);
	}
	function initialize(loc2)
	{
		this._nTimeout = loc2 != undefined?loc2:10000;
		this._unicID = String(getTimer()) + random(10000);
		this._nActionIndex = 0;
		this.clear();
	}
	function clear(loc2)
	{
		this._aActions = new Array();
		this._bPlaying = false;
		this._nTimeModerator = 1;
		ank.utils.Timer.removeTimer(this,"sequencer");
	}
	function setTimeModerator(loc2)
	{
		this._nTimeModerator = loc2;
	}
	function addAction(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		var loc8 = new Object();
		loc8.id = this.getActionIndex();
		loc8.waitEnd = loc2;
		loc8.object = loc3;
		loc8.fn = loc4;
		loc8.parameters = loc5;
		loc8.duration = loc6;
		loc8.forceTimeout = loc2 && (loc7 != undefined && loc7);
		this._aActions.push(loc8);
	}
	function execute(loc2)
	{
		if(this._bPlaying && loc2 == undefined)
		{
			return undefined;
		}
		this._bPlaying = true;
		var loc3 = true;
		while(loc3)
		{
			if(this._aActions.length > 0)
			{
				var loc4 = this._aActions[0];
				if(loc4.waitEnd)
				{
					loc4.object[this._unicID] = loc4.id;
				}
				loc4.fn.apply(loc4.object,loc4.parameters);
				if(!loc4.waitEnd)
				{
					this.onActionEnd(true);
				}
				else
				{
					loc3 = false;
					ank.utils.Timer.setTimer(loc4.object,"sequencer",this,this.onActionTimeOut,loc4.duration == undefined?this._nTimeout:loc4.duration * this._nTimeModerator,[loc4.id]);
				}
			}
			else
			{
				loc3 = false;
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
	function clearAllNextActions(loc2)
	{
		this._aActions.splice(1);
		ank.utils.Timer.removeTimer(this,"sequencer");
	}
	function onActionTimeOut(loc2)
	{
		if(loc2 != undefined && this._aActions[0].id != loc2)
		{
			return undefined;
		}
		this.onActionEnd(false,true);
	}
	function onActionEnd(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			loc3 = false;
		}
		if(this._aActions.length == 0)
		{
			return undefined;
		}
		if(this._aActions[0].forceTimeout && !loc3)
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
		else if(loc2 != true)
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
	function getActionIndex(loc2)
	{
		this._nActionIndex++;
		if(this._nActionIndex > 10000)
		{
			this._nActionIndex = 0;
		}
		return this._nActionIndex;
	}
}
