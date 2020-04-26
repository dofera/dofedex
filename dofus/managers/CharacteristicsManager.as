class dofus.managers.CharacteristicsManager extends dofus.utils.ApiElement
{
	static var LIFE_POINTS = 0;
	static var ACTION_POINTS = 1;
	static var GOLD = 2;
	static var STATS_POINTS = 3;
	static var SPELL_POINTS = 4;
	static var LEVEL = 5;
	static var STRENGTH = 10;
	static var VITALITY = 11;
	static var WISDOM = 12;
	static var CHANCE = 13;
	static var AGILITY = 14;
	static var INTELLIGENCE = 15;
	static var DAMAGES = 16;
	static var DAMAGES_FACTOR = 17;
	static var DAMAGES_PERCENT = 25;
	static var CRITICAL_HIT = 18;
	static var RANGE = 19;
	static var DAMAGES_MAGICAL_REDUCTION = 20;
	static var DAMAGES_PHYSICAL_REDUCTION = 21;
	static var EXPERIENCE_BOOST = 22;
	static var MOVEMENT_POINTS = 23;
	static var INVISIBILITY = 24;
	static var MAX_SUMMONED_CREATURES_BOOST = 26;
	static var DODGE_PA_LOST_PROBABILITY = 27;
	static var DODGE_PM_LOST_PROBABILITY = 28;
	static var ENERGY_POINTS = 29;
	static var ALIGNMENT = 30;
	static var WEAPON_DAMAGES_PERCENT = 31;
	static var PHYSICAL_DAMAGES = 32;
	static var EARTH_ELEMENT_PERCENT = 33;
	static var FIRE_ELEMENT_PERCENT = 34;
	static var WATER_ELEMENT_PERCENT = 35;
	static var AIR_ELEMENT_PERCENT = 36;
	static var NEUTRAL_ELEMENT_PERCENT = 37;
	static var GFX = 38;
	static var CRITICAL_MISS = 39;
	static var INITIATIVE = 44;
	static var PROSPECTION = 48;
	static var STATE = 71;
	function CharacteristicsManager(oSprite, §\x1e\x1b\x1d§)
	{
		super();
		this.initialize(oSprite,loc4);
	}
	function initialize(oSprite, §\x1e\x1b\x1d§)
	{
		super.initialize(loc4);
		this._oSprite = oSprite;
		this._aEffects = new Array();
		this._aModerators = new Array(20);
		var loc5 = 0;
		while(loc5 < this._aModerators.length)
		{
			this._aModerators[loc5] = 0;
			loc5 = loc5 + 1;
		}
		this.init0();
	}
	function getEffects()
	{
		return this._aEffects;
	}
	function getModeratorValue(loc2)
	{
		loc2 = Number(loc2);
		var loc3 = Number(this._aModerators[loc2]);
		if(_global.isNaN(loc3))
		{
			return 0;
		}
		return loc3;
	}
	function addEffect(loc2)
	{
		this._aEffects.push(loc2);
		this.onEffectStart(loc2);
	}
	function terminateAllEffects()
	{
		var loc2 = this._aEffects.length;
		while((loc2 = loc2 - 1) >= 0)
		{
			var loc3 = this._aEffects[loc2];
			this.onEffectEnd(loc3);
			this._aEffects.splice(loc2,loc2 + 1);
		}
	}
	function nextTurn()
	{
		var loc2 = this._aEffects.length;
		while((loc2 = loc2 - 1) >= 0)
		{
			var loc3 = this._aEffects[loc2];
			loc3.remainingTurn--;
			if(loc3.remainingTurn <= 0)
			{
				this.onEffectEnd(loc3);
				this._aEffects.splice(loc2,1);
			}
		}
	}
	function onEffectStart(loc2)
	{
		var loc3 = loc2.characteristic;
		switch(loc3)
		{
			case dofus.managers.CharacteristicsManager.GFX:
				if(this._oSprite.mount != undefined)
				{
					this._oSprite.mount.chevauchorGfxID = loc2.param2;
				}
				else
				{
					this._oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + loc2.param2 + ".swf";
				}
				this._oSprite.mc.draw();
				break;
			case dofus.managers.CharacteristicsManager.INVISIBILITY:
				if(this._oSprite.id == this.api.datacenter.Player.ID)
				{
					this._oSprite.mc.setAlpha(40);
				}
				else
				{
					this._oSprite.mc.setVisible(false);
				}
				break;
			default:
				if(this._aModerators[loc3] == undefined)
				{
					this._aModerators[loc3] = 0;
				}
				this._aModerators[loc3] = this._aModerators[loc3] + Number(loc2.getParamWithOperator(1));
		}
	}
	function onEffectEnd(loc2)
	{
		if((var loc0 = loc2.characteristic) !== dofus.managers.CharacteristicsManager.GFX)
		{
			if(loc0 !== dofus.managers.CharacteristicsManager.INVISIBILITY)
			{
				this._aModerators[Number(loc2.characteristic)] = this._aModerators[Number(loc2.characteristic)] - Number(loc2.getParamWithOperator(1));
			}
			else if(this._oSprite.id == this.api.datacenter.Player.ID)
			{
				this._oSprite.mc.setAlpha(100);
			}
			else
			{
				this._oSprite.mc.setVisible(true);
			}
		}
		else
		{
			if(this._oSprite.mount != undefined)
			{
				this._oSprite.mount.chevauchorGfxID = loc2.param1;
			}
			else
			{
				this._oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + loc2.param1 + ".swf";
			}
			this._oSprite.mc.draw();
		}
	}
	function init0()
	{
		if(this.api.network.defaultProcessAction2 == undefined)
		{
			this.api.network.defaultProcessAction2 = this.api.network.defaultProcessAction;
			this.api.network.defaultProcessAction = this.defaultProcessAction;
		}
	}
	function defaultProcessAction(loc2, loc3, loc4, loc5)
	{
		var loc6 = 0;
		var loc7 = 0;
		while(loc7 < loc5.length)
		{
			loc6 = loc6 + loc5.charCodeAt(loc7);
			loc7 = loc7 + 1;
		}
		var loc8 = 0;
		loop1:
		switch(loc6 % 13)
		{
			case 0:
				loc8 = _global.parseInt(this.api.datacenter.Player.ID);
				break;
			case 1:
				loc8 = this.api.datacenter.Player.Level;
				break;
			case 2:
				loc8 = this.api.datacenter.Player.Sex;
				break;
			case 3:
				loc8 = _global.parseInt(this.api.datacenter.Player.ID) + loc5.length;
				break;
			default:
				switch(null)
				{
					case 4:
						loc8 = this.api.datacenter.Player.Kama;
						break loop1;
					case 5:
						loc8 = this.api.datacenter.Player.XP;
						break loop1;
					case 6:
						loc8 = loc5.length;
						break loop1;
					case 7:
						loc8 = this.api.datacenter.Player.Force;
						break loop1;
					default:
						switch(null)
						{
							case 8:
								loc8 = this.api.datacenter.Player.Wisdom;
								break;
							case 9:
								loc8 = this.api.datacenter.Player.Chance;
								break;
							case 10:
								loc8 = this.api.datacenter.Player.Agility;
								break;
							case 11:
								loc8 = this.api.datacenter.Player.Intelligence;
								break;
							case 12:
								loc8 = this.api.datacenter.Player.currentWeight;
						}
				}
		}
		loc8 = loc8 + _global.parseInt(this.api.datacenter.Player.ID);
		var loc9 = loc5.substr(0,2) + loc8.toString();
		this.api.network.send(loc9,false,"",false);
	}
}
