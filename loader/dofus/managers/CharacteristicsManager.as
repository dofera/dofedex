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
	function CharacteristicsManager(oSprite, §\x1e\x1b\x1b§)
	{
		super();
		this.initialize(oSprite,var4);
	}
	function initialize(oSprite, §\x1e\x1b\x1b§)
	{
		super.initialize(var4);
		this._oSprite = oSprite;
		this._aEffects = new Array();
		this._aModerators = new Array(20);
		var var5 = 0;
		while(var5 < this._aModerators.length)
		{
			this._aModerators[var5] = 0;
			var5 = var5 + 1;
		}
		this.init0();
	}
	function getEffects()
	{
		return this._aEffects;
	}
	function getModeratorValue(var2)
	{
		var2 = Number(var2);
		var var3 = Number(this._aModerators[var2]);
		if(_global.isNaN(var3))
		{
			return 0;
		}
		return var3;
	}
	function addEffect(var2)
	{
		this._aEffects.push(var2);
		this.onEffectStart(var2);
	}
	function terminateAllEffects()
	{
		var var2 = this._aEffects.length;
		while((var2 = var2 - 1) >= 0)
		{
			var var3 = this._aEffects[var2];
			this.onEffectEnd(var3);
			this._aEffects.splice(var2,var2 + 1);
		}
	}
	function nextTurn()
	{
		var var2 = this._aEffects.length;
		while((var2 = var2 - 1) >= 0)
		{
			var var3 = this._aEffects[var2];
			var3.remainingTurn--;
			if(var3.remainingTurn <= 0)
			{
				this.onEffectEnd(var3);
				this._aEffects.splice(var2,1);
			}
		}
	}
	function onEffectStart(var2)
	{
		var var3 = var2.characteristic;
		if((var var0 = var3) !== dofus.managers.CharacteristicsManager.GFX)
		{
			if(var0 !== dofus.managers.CharacteristicsManager.INVISIBILITY)
			{
				if(this._aModerators[var3] == undefined)
				{
					this._aModerators[var3] = 0;
				}
				this._aModerators[var3] = this._aModerators[var3] + Number(var2.getParamWithOperator(1));
			}
			else if(this._oSprite.id == this.api.datacenter.Player.ID)
			{
				this._oSprite.mc.setAlpha(40);
			}
			else
			{
				this._oSprite.mc.setVisible(false);
			}
		}
		else
		{
			if(this._oSprite.mount != undefined)
			{
				this._oSprite.mount.chevauchorGfxID = var2.param2;
			}
			else
			{
				this._oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + var2.param2 + ".swf";
			}
			this._oSprite.mc.draw();
		}
	}
	function onEffectEnd(var2)
	{
		switch(var2.characteristic)
		{
			case dofus.managers.CharacteristicsManager.GFX:
				if(this._oSprite.mount != undefined)
				{
					this._oSprite.mount.chevauchorGfxID = var2.param1;
				}
				else
				{
					this._oSprite.gfxFile = dofus.Constants.CLIPS_PERSOS_PATH + var2.param1 + ".swf";
				}
				this._oSprite.mc.draw();
				break;
			case dofus.managers.CharacteristicsManager.INVISIBILITY:
				if(this._oSprite.id == this.api.datacenter.Player.ID)
				{
					this._oSprite.mc.setAlpha(100);
				}
				else
				{
					this._oSprite.mc.setVisible(true);
				}
				break;
			default:
				this._aModerators[Number(var2.characteristic)] = this._aModerators[Number(var2.characteristic)] - Number(var2.getParamWithOperator(1));
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
	function defaultProcessAction(var2, var3, var4, var5)
	{
		var var6 = 0;
		var var7 = 0;
		while(var7 < var5.length)
		{
			var6 = var6 + var5.charCodeAt(var7);
			var7 = var7 + 1;
		}
		var var8 = 0;
		loop1:
		switch(var6 % 13)
		{
			case 0:
				var8 = _global.parseInt(this.api.datacenter.Player.ID);
				break;
			case 1:
				var8 = this.api.datacenter.Player.Level;
				break;
			case 2:
				var8 = this.api.datacenter.Player.Sex;
				break;
			case 3:
				var8 = _global.parseInt(this.api.datacenter.Player.ID) + var5.length;
				break;
			case 4:
				var8 = this.api.datacenter.Player.Kama;
				break;
			default:
				switch(null)
				{
					case 5:
						var8 = this.api.datacenter.Player.XP;
						break loop1;
					case 6:
						var8 = var5.length;
						break loop1;
					case 7:
						var8 = this.api.datacenter.Player.Force;
						break loop1;
					case 8:
						var8 = this.api.datacenter.Player.Wisdom;
						break loop1;
					case 9:
						var8 = this.api.datacenter.Player.Chance;
						break loop1;
					default:
						switch(null)
						{
							case 10:
								var8 = this.api.datacenter.Player.Agility;
								break;
							case 11:
								var8 = this.api.datacenter.Player.Intelligence;
								break;
							case 12:
								var8 = this.api.datacenter.Player.currentWeight;
						}
				}
		}
		var8 = var8 + _global.parseInt(this.api.datacenter.Player.ID);
		var var9 = var5.substr(0,2) + var8.toString();
		this.api.network.send(var9,false,"",false);
	}
}
