class dofus.managers.SpellsManager
{
	function SpellsManager(var3)
	{
		this.initialize(var2);
	}
	function initialize(var2)
	{
		this._localPlayerData = var2;
		this.api = var2.api;
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
	function addLaunchedSpell(var2)
	{
		var var3 = var2.spell;
		var var4 = var3.launchCountByTurn;
		var var5 = var3.launchCountByPlayerTurn;
		var var6 = var3.delayBetweenLaunch;
		if(var6 != 0)
		{
			this._aSpellsDelay.push(var2);
		}
		if(var5 != 0)
		{
			if(var2.spriteOnID != undefined)
			{
				this._aSpellsCountByPlayer.push(var2);
				if(this._oSpellsCountByPlayer_Counter[var2.spriteOnID + "|" + var3.ID] == undefined)
				{
					this._oSpellsCountByPlayer_Counter[var2.spriteOnID + "|" + var3.ID] = 1;
				}
				else
				{
					this._oSpellsCountByPlayer_Counter[var2.spriteOnID + "|" + var3.ID]++;
				}
			}
		}
		if(var4 != 0)
		{
			this._aSpellsCountByTurn.push(var2);
			if(this._oSpellsCountByTurn_Counter[var3.ID] == undefined)
			{
				this._oSpellsCountByTurn_Counter[var3.ID] = 1;
			}
			else
			{
				this._oSpellsCountByTurn_Counter[var3.ID]++;
			}
		}
		this.dispatchEvent({type:"spellLaunched",spell:var3});
	}
	function nextTurn()
	{
		this._aSpellsCountByTurn = new Array();
		this._oSpellsCountByTurn_Counter = new Object();
		this._aSpellsCountByPlayer = new Array();
		this._oSpellsCountByPlayer_Counter = new Object();
		var var3 = this._aSpellsDelay.length;
		while((var3 = var3 - 1) >= 0)
		{
			var var2 = this._aSpellsDelay[var3];
			var2.remainingTurn--;
			if(var2.remainingTurn <= 0)
			{
				this._aSpellsDelay.splice(var3,1);
			}
		}
		this.dispatchEvent({type:"nextTurn"});
	}
	function checkCanLaunchSpell(var2, var3)
	{
		var var4 = this.checkCanLaunchSpellReturnObject(var2,var3);
		if(var4.can == false)
		{
			this.api.datacenter.Basics.spellManager_errorMsg = this.api.lang.getText(var4.type,var4.params);
			return false;
		}
		return true;
	}
	function checkCanLaunchSpellReturnObject(var2, var3)
	{
		if(!this.api.datacenter.Game.isRunning || this.api.datacenter.Game.isSpectator)
		{
			return {can:false,type:"NOT_IN_FIGHT"};
		}
		var var9 = this.api.datacenter.Player.Spells.findFirstItem("ID",var2).item;
		var var10 = new Object();
		if(var9.needStates)
		{
			var var11 = var9.requiredStates;
			var var12 = var9.forbiddenStates;
			var var13 = 0;
			while(var13 < var11.length)
			{
				if(!this.api.datacenter.Player.data.isInState(var11[var13]))
				{
					var10 = {can:false,type:"NOT_IN_REQUIRED_STATE",params:[this.api.lang.getStateText(var11[var13])]};
					break;
				}
				var13 = var13 + 1;
			}
			var var14 = 0;
			while(var14 < var12.length)
			{
				if(this.api.datacenter.Player.data.isInState(var12[var14]))
				{
					var10 = {can:false,type:"IN_FORBIDDEN_STATE",params:[this.api.lang.getStateText(var12[var14])]};
					break;
				}
				var14 = var14 + 1;
			}
		}
		var var15 = this._aSpellsDelay.length;
		while((var15 = var15 - 1) >= 0)
		{
			var var5 = this._aSpellsDelay[var15];
			var var6 = var5.spell;
			if(var6.ID == var2)
			{
				if(var5.remainingTurn >= 63)
				{
					if(var10.type)
					{
						var10.params[1] = var5.remainingTurn;
						return var10;
					}
					return {can:false,type:"CANT_RELAUNCH"};
				}
				if(var10.type)
				{
					var10.params[1] = var5.remainingTurn;
					return var10;
				}
				return {can:false,type:"CANT_LAUNCH_BEFORE",params:[var5.remainingTurn]};
			}
		}
		if(var10.type)
		{
			return var10;
		}
		if(var9.summonSpell)
		{
			var var16 = this.api.datacenter.Player.data.CharacteristicsManager.getModeratorValue(dofus.managers.CharacteristicsManager.MAX_SUMMONED_CREATURES_BOOST) + this.api.datacenter.Player.MaxSummonedCreatures;
			if(this.api.datacenter.Player.SummonedCreatures >= var16)
			{
				return {can:false,type:"CANT_SUMMON_MORE_CREATURE",params:[var16]};
			}
		}
		var15 = this._aSpellsCountByPlayer.length;
		while((var15 = var15 - 1) >= 0)
		{
			var5 = this._aSpellsCountByPlayer[var15];
			var6 = var5.spell;
			if(var6.ID == var2)
			{
				var var8 = var6.launchCountByPlayerTurn;
				if(var5.spriteOnID == var3 && this._oSpellsCountByPlayer_Counter[var5.spriteOnID + "|" + var2] >= var8)
				{
					return {can:false,type:"CANT_ON_THIS_PLAYER"};
				}
			}
		}
		var15 = this._aSpellsCountByTurn.length;
		while((var15 = var15 - 1) >= 0)
		{
			var5 = this._aSpellsCountByTurn[var15];
			var6 = var5.spell;
			if(var6.ID == var2)
			{
				var var7 = var6.launchCountByTurn;
				if(this._oSpellsCountByTurn_Counter[var2] >= var7)
				{
					return {can:false,type:"CANT_LAUNCH_MORE",params:[var7]};
				}
			}
		}
		if(!this.api.datacenter.Player.hasEnoughAP(var9.apCost))
		{
			return {can:false,type:"NOT_ENOUGH_AP"};
		}
		return {can:true};
	}
	function checkCanLaunchSpellOnCell(mapHandler, §\x1e\x19\n§, §\x13\x1d§, §\x1e\x16\x1b§)
	{
		var var6 = Number(this._localPlayerData.data.cellNum);
		var var7 = Number(var4.mc.num);
		if(var6 == var7 && var3.rangeMin != 0)
		{
			return false;
		}
		if(!this.api.datacenter.Game.isFight)
		{
			return false;
		}
		if(ank.battlefield.utils.Pathfinding.checkRange(mapHandler,var6,var7,var3.lineOnly,var3.rangeMin,var3.rangeMax,var5))
		{
			if(var3.freeCell)
			{
				if(var4.movement > 1 && var4.spriteOnID != undefined)
				{
					return false;
				}
				if(var4.movement <= 1)
				{
					return false;
				}
			}
			if(var3.lineOfSight)
			{
				if(ank.battlefield.utils.Pathfinding.checkView(mapHandler,var6,var7))
				{
					return this.checkCanLaunchSpell(var3.ID,var4.spriteOnID);
				}
				return false;
			}
			return this.checkCanLaunchSpell(var3.ID,var4.spriteOnID);
		}
		return false;
	}
}
