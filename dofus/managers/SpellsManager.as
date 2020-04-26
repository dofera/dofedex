class dofus.managers.SpellsManager
{
	function SpellsManager(loc3)
	{
		this.initialize(loc2);
	}
	function initialize(loc2)
	{
		this._localPlayerData = loc2;
		this.api = loc2.api;
		this.clear();
		this._oSpellsModificators = new Object();
		mx.events.EventDispatcher.initialize(this);
	}
	function clear()
	{
		this._aSpellsCountByTurn = new Array();
		this._oSpellsCountByTurn_Counter = new Object();
		this._aSpellsCountByPlayer = new Array();
		this._oSpellsCountByPlayer_Counter = new Object();
		this._aSpellsDelay = new Array();
	}
	function addLaunchedSpell(loc2)
	{
		var loc3 = loc2.spell;
		var loc4 = loc3.launchCountByTurn;
		var loc5 = loc3.launchCountByPlayerTurn;
		var loc6 = loc3.delayBetweenLaunch;
		if(loc6 != 0)
		{
			this._aSpellsDelay.push(loc2);
		}
		if(loc5 != 0)
		{
			if(loc2.spriteOnID != undefined)
			{
				this._aSpellsCountByPlayer.push(loc2);
				if(this._oSpellsCountByPlayer_Counter[loc2.spriteOnID + "|" + loc3.ID] == undefined)
				{
					this._oSpellsCountByPlayer_Counter[loc2.spriteOnID + "|" + loc3.ID] = 1;
				}
				else
				{
					this._oSpellsCountByPlayer_Counter[loc2.spriteOnID + "|" + loc3.ID]++;
				}
			}
		}
		if(loc4 != 0)
		{
			this._aSpellsCountByTurn.push(loc2);
			if(this._oSpellsCountByTurn_Counter[loc3.ID] == undefined)
			{
				this._oSpellsCountByTurn_Counter[loc3.ID] = 1;
			}
			else
			{
				this._oSpellsCountByTurn_Counter[loc3.ID]++;
			}
		}
		this.dispatchEvent({type:"spellLaunched",spell:loc3});
	}
	function nextTurn()
	{
		this._aSpellsCountByTurn = new Array();
		this._oSpellsCountByTurn_Counter = new Object();
		this._aSpellsCountByPlayer = new Array();
		this._oSpellsCountByPlayer_Counter = new Object();
		var loc3 = this._aSpellsDelay.length;
		while((loc3 = loc3 - 1) >= 0)
		{
			var loc2 = this._aSpellsDelay[loc3];
			loc2.remainingTurn--;
			if(loc2.remainingTurn <= 0)
			{
				this._aSpellsDelay.splice(loc3,1);
			}
		}
		this.dispatchEvent({type:"nextTurn"});
	}
	function checkCanLaunchSpell(loc2, loc3)
	{
		var loc4 = this.checkCanLaunchSpellReturnObject(loc2,loc3);
		if(loc4.can == false)
		{
			this.api.datacenter.Basics.spellManager_errorMsg = this.api.lang.getText(loc4.type,loc4.params);
			return false;
		}
		return true;
	}
	function checkCanLaunchSpellReturnObject(loc2, loc3)
	{
		if(!this.api.datacenter.Game.isRunning || this.api.datacenter.Game.isSpectator)
		{
			return {can:false,type:"NOT_IN_FIGHT"};
		}
		var loc9 = this.api.datacenter.Player.Spells.findFirstItem("ID",loc2).item;
		var loc10 = new Object();
		if(loc9.needStates)
		{
			var loc11 = loc9.requiredStates;
			var loc12 = loc9.forbiddenStates;
			var loc13 = 0;
			while(loc13 < loc11.length)
			{
				if(!this.api.datacenter.Player.data.isInState(loc11[loc13]))
				{
					loc10 = {can:false,type:"NOT_IN_REQUIRED_STATE",params:[this.api.lang.getStateText(loc11[loc13])]};
					break;
				}
				loc13 = loc13 + 1;
			}
			var loc14 = 0;
			while(loc14 < loc12.length)
			{
				if(this.api.datacenter.Player.data.isInState(loc12[loc14]))
				{
					loc10 = {can:false,type:"IN_FORBIDDEN_STATE",params:[this.api.lang.getStateText(loc12[loc14])]};
					break;
				}
				loc14 = loc14 + 1;
			}
		}
		var loc15 = this._aSpellsDelay.length;
		while((loc15 = loc15 - 1) >= 0)
		{
			var loc5 = this._aSpellsDelay[loc15];
			var loc6 = loc5.spell;
			if(loc6.ID == loc2)
			{
				if(loc5.remainingTurn >= 63)
				{
					if(loc10.type)
					{
						loc10.params[1] = loc5.remainingTurn;
						return loc10;
					}
					return {can:false,type:"CANT_RELAUNCH"};
				}
				if(loc10.type)
				{
					loc10.params[1] = loc5.remainingTurn;
					return loc10;
				}
				return {can:false,type:"CANT_LAUNCH_BEFORE",params:[loc5.remainingTurn]};
			}
		}
		if(loc10.type)
		{
			return loc10;
		}
		if(loc9.summonSpell)
		{
			var loc16 = this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.MAX_SUMMONED_CREATURES_BOOST) + this.api.datacenter.Player.MaxSummonedCreatures;
			if(this.api.datacenter.Player.SummonedCreatures >= loc16)
			{
				return {can:false,type:"CANT_SUMMON_MORE_CREATURE",params:[loc16]};
			}
		}
		loc15 = this._aSpellsCountByPlayer.length;
		while((loc15 = loc15 - 1) >= 0)
		{
			loc5 = this._aSpellsCountByPlayer[loc15];
			loc6 = loc5.spell;
			if(loc6.ID == loc2)
			{
				var loc8 = loc6.launchCountByPlayerTurn;
				if(loc5.spriteOnID == loc3 && this._oSpellsCountByPlayer_Counter[loc5.spriteOnID + "|" + loc2] >= loc8)
				{
					return {can:false,type:"CANT_ON_THIS_PLAYER"};
				}
			}
		}
		loc15 = this._aSpellsCountByTurn.length;
		while((loc15 = loc15 - 1) >= 0)
		{
			loc5 = this._aSpellsCountByTurn[loc15];
			loc6 = loc5.spell;
			if(loc6.ID == loc2)
			{
				var loc7 = loc6.launchCountByTurn;
				if(this._oSpellsCountByTurn_Counter[loc2] >= loc7)
				{
					return {can:false,type:"CANT_LAUNCH_MORE",params:[loc7]};
				}
			}
		}
		if(!this.api.datacenter.Player.hasEnoughAP(loc9.apCost))
		{
			return {can:false,type:"NOT_ENOUGH_AP"};
		}
		return {can:true};
	}
	function checkCanLaunchSpellOnCell(mapHandler, §\x1e\x19\f§, §\x14\x02§, §\x1e\x16\x1d§)
	{
		var loc6 = Number(this._localPlayerData.data.cellNum);
		var loc7 = Number(loc4.mc.num);
		if(loc6 == loc7 && loc3.rangeMin != 0)
		{
			return false;
		}
		if(!this.api.datacenter.Game.isFight)
		{
			return false;
		}
		if(ank.battlefield.utils.Pathfinding.checkRange(mapHandler,loc6,loc7,loc3.lineOnly,loc3.rangeMin,loc3.rangeMax,loc5))
		{
			if(loc3.freeCell)
			{
				if(loc4.movement > 1 && loc4.spriteOnID != undefined)
				{
					return false;
				}
				if(loc4.movement <= 1)
				{
					return false;
				}
			}
			if(loc3.lineOfSight)
			{
				if(ank.battlefield.utils.Pathfinding.checkView(mapHandler,loc6,loc7))
				{
					return this.checkCanLaunchSpell(loc3.ID,loc4.spriteOnID);
				}
				return false;
			}
			return this.checkCanLaunchSpell(loc3.ID,loc4.spriteOnID);
		}
		return false;
	}
}
