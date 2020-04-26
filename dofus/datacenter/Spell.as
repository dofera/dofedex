class dofus.datacenter.Spell extends Object
{
	function Spell(loc3, loc4, loc5)
	{
		super();
		this.initialize(loc3,loc4,loc5);
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
	function __set__level(loc2)
	{
		this._nLevel = loc2;
		return this.__get__level();
	}
	function __get__level()
	{
		return this._nLevel;
	}
	function __set__position(loc2)
	{
		this._nPosition = loc2;
		return this.__get__position();
	}
	function __get__position()
	{
		return this._nPosition;
	}
	function __set__animID(loc2)
	{
		this._nAnimID = loc2;
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
	function __set__inFrontOfSprite(loc2)
	{
		this._bInFrontOfSprite = loc2;
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
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_AP_COST,this._nID);
		var loc3 = this.getSpellLevelText(2);
		if(loc2 > -1)
		{
			return loc3 - loc2;
		}
		return loc3;
	}
	function __get__rangeMin()
	{
		return this.getSpellLevelText(3);
	}
	function __get__rangeMax()
	{
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGE,this._nID);
		var loc3 = this.getSpellLevelText(4);
		if(loc2 > -1)
		{
			return loc3 + loc2;
		}
		return loc3;
	}
	function __get__rangeStr()
	{
		return (this.rangeMin == 0?"":this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") + this.rangeMax;
	}
	function __get__criticalHit()
	{
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CC,this._nID);
		var loc3 = this.getSpellLevelText(5);
		if(loc2 > -1)
		{
			return loc3 <= 0?0:Math.max(loc3 - loc2,2);
		}
		return loc3;
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
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CASTOUTLINE,this._nID);
		var loc3 = this.getSpellLevelText(7);
		if(loc2 > 0)
		{
			return false;
		}
		return loc3;
	}
	function __get__lineOfSight()
	{
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_NOLINEOFSIGHT,this._nID);
		var loc3 = this.getSpellLevelText(8);
		if(loc2 > 0)
		{
			return false;
		}
		return loc3;
	}
	function __get__freeCell()
	{
		return this.getSpellLevelText(9);
	}
	function __get__canBoostRange()
	{
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_RANGEABLE,this._nID);
		var loc3 = this.getSpellLevelText(10);
		if(loc2 > 0)
		{
			return true;
		}
		return loc3;
	}
	function __get__classID()
	{
		return this.getSpellLevelText(11);
	}
	function __get__launchCountByTurn()
	{
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTURN,this._nID);
		var loc3 = this.getSpellLevelText(12);
		if(loc2 > -1)
		{
			return loc3 + loc2;
		}
		return loc3;
	}
	function __get__launchCountByPlayerTurn()
	{
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_MAXPERTARGET,this._nID);
		var loc3 = this.getSpellLevelText(13);
		if(loc2 > -1)
		{
			return loc3 + loc2;
		}
		return loc3;
	}
	function __get__delayBetweenLaunch()
	{
		var loc2 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_CAST_INTVL,this._nID);
		var loc3 = this.api.kernel.SpellsBoostsManager.getSpellModificator(dofus.managers.SpellsBoostsManager.ACTION_BOOST_SPELL_SET_INTVL,this._nID);
		var loc4 = loc3 <= -1?this.getSpellLevelText(14):loc3;
		if(loc2 > -1)
		{
			return loc4 - loc2;
		}
		return loc4;
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
		var loc2 = this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(0),this._nID);
		var loc3 = new ank.utils.();
		var loc4 = 0;
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = new Object();
			loc6.fx = loc2[loc5];
			loc6.at = this._aEffectZones[loc4 + loc5].shape;
			loc6.ar = this._aEffectZones[loc4 + loc5].size;
			loc3.push(loc6);
			loc5 = loc5 + 1;
		}
		return loc3;
	}
	function __get__effectsCriticalHitWithArea()
	{
		var loc2 = this.api.kernel.GameManager.getSpellEffects(this.getSpellLevelText(1),this._nID);
		var loc3 = new ank.utils.();
		var loc4 = this.effectsNormalHit.length;
		var loc5 = 0;
		while(loc5 < loc2.length)
		{
			var loc6 = new Object();
			loc6.fx = loc2[loc5];
			loc6.at = this._aEffectZones[loc4 + loc5].shape;
			loc6.ar = this._aEffectZones[loc4 + loc5].size;
			loc3.push(loc6);
			loc5 = loc5 + 1;
		}
		return loc3;
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
		var loc2 = {none:false,neutral:false,earth:false,fire:false,water:false,air:false};
		var loc3 = this.effectsNormalHit;
		for(var k in loc3)
		{
			var loc4 = loc3[k].element;
			switch(loc4)
			{
				case "N":
					loc2.neutral = true;
					break;
				case "E":
					loc2.earth = true;
					break;
				case "F":
					loc2.fire = true;
					break;
				case "W":
					loc2.water = true;
					break;
				case "A":
					loc2.air = true;
					break;
				default:
					loc2.none = true;
			}
		}
		return loc2;
	}
	function __get__effectZones()
	{
		return this._aEffectZones;
	}
	function initialize(loc2, loc3, loc4)
	{
		this.api = _global.API;
		this._nID = loc2;
		this._nLevel = loc3;
		this._nPosition = ank.utils.Compressor.decode64(loc4);
		if(this._nPosition > 24 || this._nPosition < 1)
		{
			this._nPosition = null;
		}
		this._oSpellText = this.api.lang.getSpellText(loc2);
		var loc5 = this.getSpellLevelText(15);
		var loc6 = loc5.split("");
		this._aEffectZones = new Array();
		var loc7 = 0;
		while(loc7 < loc6.length)
		{
			this._aEffectZones.push({shape:loc6[loc7],size:ank.utils.Compressor.decode64(loc6[loc7 + 1])});
			loc7 = loc7 + 2;
		}
		this._bSummonSpell = this.searchIfSummon(this.getSpellLevelText(0)) || this.searchIfSummon(this.getSpellLevelText(1));
		this._nMaxLevel = 1;
		var loc8 = 1;
		while(loc8 <= dofus.Constants.SPELL_BOOST_MAX_LEVEL)
		{
			if(this._oSpellText["l" + loc8] == undefined)
			{
				break;
			}
			this._nMaxLevel = loc8;
			loc8 = loc8 + 1;
		}
		this._aRequiredStates = this.getSpellLevelText(16);
		this._aForbiddenStates = this.getSpellLevelText(17);
		this._minPlayerLevel = this.normalMinPlayerLevel;
	}
	function getSpellLevelText(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			loc3 = this._nLevel;
		}
		return this._oSpellText["l" + loc3][loc2];
	}
	function searchIfSummon(loc2)
	{
		var loc3 = loc2.length;
		if(typeof loc2 == "object")
		{
			var loc4 = 0;
			while(loc4 < loc3)
			{
				var loc5 = loc2[loc4][0];
				if(loc5 == 180 || loc5 == 181)
				{
					return true;
				}
				loc4 = loc4 + 1;
			}
		}
		return false;
	}
	function searchIfGlyph(loc2)
	{
		var loc3 = loc2.length;
		if(typeof loc2 == "object")
		{
			var loc4 = 0;
			while(loc4 < loc3)
			{
				var loc5 = loc2[loc4][0];
				if(loc5 == 401)
				{
					return true;
				}
				loc4 = loc4 + 1;
			}
		}
		return false;
	}
	function searchIfTrap(loc2)
	{
		var loc3 = loc2.length;
		if(typeof loc2 == "object")
		{
			var loc4 = 0;
			while(loc4 < loc3)
			{
				var loc5 = loc2[loc4][0];
				if(loc5 == 400)
				{
					return true;
				}
				loc4 = loc4 + 1;
			}
		}
		return false;
	}
}
