class dofus.managers.SpellsBoostsManager extends dofus.utils.ApiElement
{
	static var ACTION_BOOST_SPELL_RANGE = 281;
	static var ACTION_BOOST_SPELL_RANGEABLE = 282;
	static var ACTION_BOOST_SPELL_DMG = 283;
	static var ACTION_BOOST_SPELL_HEAL = 284;
	static var ACTION_BOOST_SPELL_AP_COST = 285;
	static var ACTION_BOOST_SPELL_CAST_INTVL = 286;
	static var ACTION_BOOST_SPELL_CC = 287;
	static var ACTION_BOOST_SPELL_CASTOUTLINE = 288;
	static var ACTION_BOOST_SPELL_NOLINEOFSIGHT = 289;
	static var ACTION_BOOST_SPELL_MAXPERTURN = 290;
	static var ACTION_BOOST_SPELL_MAXPERTARGET = 291;
	static var ACTION_BOOST_SPELL_SET_INTVL = 292;
	static var _sSelf = null;
	function SpellsBoostsManager(loc3)
	{
		super();
		dofus.managers.SpellsBoostsManager._sSelf = this;
		this.initialize(loc3);
	}
	static function getInstance()
	{
		return dofus.managers.SpellsBoostsManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		this.clear();
	}
	function clear()
	{
		this._oSpellsModificators = new Object();
		delete dofus.managers.SpellsBoostsManager._aBoostedEffects;
		delete dofus.managers.SpellsBoostsManager._aDamagingEffects;
		delete dofus.managers.SpellsBoostsManager._aHealingEffects;
	}
	function getSpellModificator(loc2, loc3)
	{
		if(_global.isNaN(this._oSpellsModificators[loc2][loc3]) || this._oSpellsModificators[loc2][loc3] == undefined)
		{
			return -1;
		}
		return Number(this._oSpellsModificators[loc2][loc3]);
	}
	function setSpellModificator(loc2, loc3, loc4)
	{
		if(typeof this._oSpellsModificators[loc2] != "object" && this._oSpellsModificators[loc2] == undefined)
		{
			this._oSpellsModificators[loc2] = new Object();
		}
		this._oSpellsModificators[loc2][loc3] = loc4;
	}
	function isBoostedDamagingEffect(loc2)
	{
		if(dofus.managers.SpellsBoostsManager._aDamagingEffects == undefined)
		{
			this.computeBoostedEffectsLists();
		}
		var loc3 = 0;
		while(loc3 < dofus.managers.SpellsBoostsManager._aDamagingEffects.length)
		{
			if(dofus.managers.SpellsBoostsManager._aDamagingEffects[loc3] == loc2)
			{
				return true;
			}
			loc3 = loc3 + 1;
		}
		return false;
	}
	function isBoostedHealingEffect(loc2)
	{
		if(dofus.managers.SpellsBoostsManager._aHealingEffects == undefined)
		{
			this.computeBoostedEffectsLists();
		}
		var loc3 = 0;
		while(loc3 < dofus.managers.SpellsBoostsManager._aHealingEffects.length)
		{
			if(dofus.managers.SpellsBoostsManager._aHealingEffects[loc3] == loc2)
			{
				return true;
			}
			loc3 = loc3 + 1;
		}
		return false;
	}
	function isBoostedHealingOrDamagingEffect(loc2)
	{
		if(dofus.managers.SpellsBoostsManager._aBoostedEffects == undefined)
		{
			this.computeBoostedEffectsLists();
		}
		var loc3 = 0;
		while(loc3 < dofus.managers.SpellsBoostsManager._aBoostedEffects.length)
		{
			if(dofus.managers.SpellsBoostsManager._aBoostedEffects[loc3] == loc2)
			{
				return true;
			}
			loc3 = loc3 + 1;
		}
		return false;
	}
	function computeBoostedEffectsLists()
	{
		dofus.managers.SpellsBoostsManager._aBoostedEffects = new Array();
		dofus.managers.SpellsBoostsManager._aDamagingEffects = this.api.lang.getBoostedDamagingEffects();
		dofus.managers.SpellsBoostsManager._aHealingEffects = this.api.lang.getBoostedHealingEffects();
		var loc2 = 0;
		while(loc2 < dofus.managers.SpellsBoostsManager._aDamagingEffects.length)
		{
			dofus.managers.SpellsBoostsManager._aBoostedEffects.push(dofus.managers.SpellsBoostsManager._aDamagingEffects[loc2]);
			loc2 = loc2 + 1;
		}
		var loc3 = 0;
		while(loc3 < dofus.managers.SpellsBoostsManager._aHealingEffects.length)
		{
			dofus.managers.SpellsBoostsManager._aBoostedEffects.push(dofus.managers.SpellsBoostsManager._aHealingEffects[loc3]);
			loc3 = loc3 + 1;
		}
	}
}
