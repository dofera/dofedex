class dofus.datacenter.Spell extends Object
{
	function Spell(var3, var4, var5)
	{
		super();
		this.initialize(var3,var4,var5);
	}
	function __get__ID()
	{
		return this._nID;
	}
	function __get__isValid()
	{
		return this._oSpellText["l" + this._nLevel] != undefined;
	}
	function __get__maxLevel()
	{
		return this._nMaxLevel;
	}
	function __set__level(var2)
	{
		this._nLevel = var2;
		return this.__get__level();
	}
	function __get__level()
	{
		return this._nLevel;
	}
	function __set__position(var2)
	{
		this._nPosition = var2;
		return this.__get__position();
	}
	function __get__position()
	{
		return this._nPosition;
	}
	function __set__animID(var2)
	{
		this._nAnimID = var2;
		return this.__get__animID();
	}
	function __get__animID()
	{
		return this._nAnimID;
	}
	function __get__summonSpell()
	{
		return this._bSummonSpell;
	}
	function __get__glyphSpell()
	{
		return this.searchIfGlyph(this.getSpellLevelText(0));
	}
	function __get__trapSpell()
	{
		return this.searchIfTrap(this.getSpellLevelText(0));
	}
	function __set__inFrontOfSprite(var2)
	{
		this._bInFrontOfSprite = var2;
		return this.__get__inFrontOfSprite();
	}
	function __get__inFrontOfSprite()
	{
		return this._bInFrontOfSprite;
	}
	function __get__iconFile()
	{
		return dofus.Constants.SPELLS_ICONS_PATH + this._nID + ".swf";
	}
	function __get__file()
	{
		return dofus.Constants.SPELLS_PATH + this._nAnimID + ".swf";
	}
	function __get__name()
	{
		return this._oSpellText.n;
	}
	function __get__description()
	{
		return this._oSpellText.d;
	}
	function __get__apCost()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST,this._nID);
		var var3 = this.getSpellLevelText(2);
		if(var2 > -1)
		{
			return var3 - var2;
		}
		return var3;
	}
	function __get__rangeMin()
	{
		return this.getSpellLevelText(3);
	}
	function __get__rangeMax()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGE,this._nID);
		var var3 = this.getSpellLevelText(4);
		if(var2 > -1)
		{
			return var3 + var2;
		}
		return var3;
	}
	function __get__rangeStr()
	{
		return (this.rangeMin == 0?"":this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") + this.rangeMax;
	}
	function __get__criticalHit()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CC,this._nID);
		var var3 = this.getSpellLevelText(5);
		if(var2 > -1)
		{
			return var3 <= 0?0:Math.max(var3 - var2,2);
		}
		return var3;
	}
	function __get__actualCriticalHit()
	{
		return this.api.kernel.GameManager.getCriticalHitChance(this.criticalHit);
	}
	function __get__criticalFailure()
	{
		return this.getSpellLevelText(6);
	}
	function __get__lineOnly()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CASTOUTLINE,this._nID);
		var var3 = this.getSpellLevelText(7);
		if(var2 > 0)
		{
			return false;
		}
		return var3;
	}
	function __get__lineOfSight()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_NOLINEOFSIGHT,this._nID);
		var var3 = this.getSpellLevelText(8);
		if(var2 > 0)
		{
			return false;
		}
		return var3;
	}
	function __get__freeCell()
	{
		return this.getSpellLevelText(9);
	}
	function __get__canBoostRange()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGEABLE,this._nID);
		var var3 = this.getSpellLevelText(10);
		if(var2 > 0)
		{
			return true;
		}
		return var3;
	}
	function __get__classID()
	{
		return this.getSpellLevelText(11);
	}
	function __get__launchCountByTurn()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTURN,this._nID);
		var var3 = this.getSpellLevelText(12);
		if(var2 > -1)
		{
			return var3 + var2;
		}
		return var3;
	}
	function __get__launchCountByPlayerTurn()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTARGET,this._nID);
		var var3 = this.getSpellLevelText(13);
		if(var2 > -1)
		{
			return var3 + var2;
		}
		return var3;
	}
	function __get__delayBetweenLaunch()
	{
		var var2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CAST_INTVL,this._nID);
		var var3 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_SET_INTVL,this._nID);
		var var4 = var3 <= -1?this.getSpellLevelText(14):var3;
		if(var2 > -1)
		{
			return var4 - var2;
		}
		return var4;
	}
	function __get__descriptionNormalHit()
	{
		return this.api.kernel.GameManager.getSpellDescriptionWithEffects(this.getSpellLevelText(0),false,this._nID);
	}
	function __get__descriptionCriticalHit()
	{
		return this.api.kernel.GameManager.getSpellDescriptionWithEffects(this.getSpellLevelText(1),false,this._nID);
	}
	function __get__effectsNormalHit()
	{
		return this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(0),this._nID);
	}
	function __get__effectsCriticalHit()
	{
		return this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(1),this._nID);
	}
	function __get__effectsNormalHitWithArea()
	{
		var var2 = this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(0),this._nID);
		var var3 = new ank.utils.();
		var var4 = 0;
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = new Object();
			var6.fx = var2[var5];
			var6.at = this._aEffectZones[var4 + var5].shape;
			var6.ar = this._aEffectZones[var4 + var5].size;
			var3.push(var6);
			var5 = var5 + 1;
		}
		return var3;
	}
	function __get__effectsCriticalHitWithArea()
	{
		var var2 = this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(1),this._nID);
		var var3 = new ank.utils.();
		var var4 = this.effectsNormalHit.length;
		var var5 = 0;
		while(var5 < var2.length)
		{
			var var6 = new Object();
			var6.fx = var2[var5];
			var6.at = this._aEffectZones[var4 + var5].shape;
			var6.ar = this._aEffectZones[var4 + var5].size;
			var3.push(var6);
			var5 = var5 + 1;
		}
		return var3;
	}
	function __get__requiredStates()
	{
		return this._aRequiredStates;
	}
	function __get__forbiddenStates()
	{
		return this._aForbiddenStates;
	}
	function __get__needStates()
	{
		return this._aRequiredStates.length > 0 || this._aForbiddenStates.length > 0;
	}
	function __get__minPlayerLevel()
	{
		return Number(this.getSpellLevelText(18));
	}
	function __get__normalMinPlayerLevel()
	{
		return Number(this.getSpellLevelText(18,1));
	}
	function __get__criticalFailureEndsTheTurn()
	{
		return this.getSpellLevelText(19);
	}
	function __get__elements()
	{
		var var2 = {none:false,neutral:false,earth:false,fire:false,water:false,air:false};
		var var3 = this.effectsNormalHit;
		for(var k in var3)
		{
			var var4 = var3[k].element;
			switch(var4)
			{
				case "N":
					var2.neutral = true;
					break;
				case "E":
					var2.earth = true;
					break;
				case "F":
					var2.fire = true;
					break;
				case "W":
					var2.water = true;
					break;
				case "A":
					var2.air = true;
					break;
				default:
					var2.none = true;
			}
		}
		return var2;
	}
	function __get__effectZones()
	{
		return this._aEffectZones;
	}
	function initialize(var2, var3, var4)
	{
		this.api = _global.API;
		this._nID = var2;
		this._nLevel = var3;
		this._nPosition = ank.utils.Compressor.decode64(var4);
		if(this._nPosition > 29 || this._nPosition < 1)
		{
			this._nPosition = null;
		}
		this._oSpellText = this.api.lang.getSpellText(var2);
		var var5 = this.getSpellLevelText(15);
		var var6 = var5.split("");
		this._aEffectZones = new Array();
		var var7 = 0;
		while(var7 < var6.length)
		{
			this._aEffectZones.push({shape:var6[var7],size:ank.utils.Compressor.decode64(var6[var7 + 1])});
			var7 = var7 + 2;
		}
		this._bSummonSpell = this.searchIfSummon(this.getSpellLevelText(0)) || this.searchIfSummon(this.getSpellLevelText(1));
		this._nMaxLevel = 1;
		var var8 = 1;
		while(var8 <= dofus.Constants.SPELL_BOOST_MAX_LEVEL)
		{
			if(this._oSpellText["l" + var8] == undefined)
			{
				break;
			}
			this._nMaxLevel = var8;
			var8 = var8 + 1;
		}
		this._aRequiredStates = this.getSpellLevelText(16);
		this._aForbiddenStates = this.getSpellLevelText(17);
		this._minPlayerLevel = this.normalMinPlayerLevel;
	}
	function getSpellLevelText(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = this._nLevel;
		}
		return this._oSpellText["l" + var3][var2];
	}
	function searchIfSummon(var2)
	{
		var var3 = var2.length;
		if(typeof var2 == "object")
		{
			var var4 = 0;
			while(var4 < var3)
			{
				var var5 = var2[var4][0];
				if(var5 == 180 || var5 == 181)
				{
					return true;
				}
				var4 = var4 + 1;
			}
		}
		return false;
	}
	function searchIfGlyph(var2)
	{
		var var3 = var2.length;
		if(typeof var2 == "object")
		{
			var var4 = 0;
			while(var4 < var3)
			{
				var var5 = var2[var4][0];
				if(var5 == 401)
				{
					return true;
				}
				var4 = var4 + 1;
			}
		}
		return false;
	}
	function searchIfTrap(var2)
	{
		var var3 = var2.length;
		if(typeof var2 == "object")
		{
			var var4 = 0;
			while(var4 < var3)
			{
				var var5 = var2[var4][0];
				if(var5 == 400)
				{
					return true;
				}
				var4 = var4 + 1;
			}
		}
		return false;
	}
}
