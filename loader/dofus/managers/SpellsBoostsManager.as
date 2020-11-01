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
	function SpellsBoostsManager(var2)
	{
		super();
		dofus.managers.SpellsBoostsManager._sSelf = this;
		this.initialize(var3);
	}
	static function getInstance()
	{
		return dofus.managers.SpellsBoostsManager._sSelf;
	}
	function initialize(var2)
	{
		super.initialize(var3);
		this.clear();
	}
	function clear()
	{
		this._oSpellsModificators = new Object();
		delete dofus.managers.SpellsBoostsManager._aBoostedEffects;
		delete dofus.managers.SpellsBoostsManager._aDamagingEffects;
		delete dofus.managers.SpellsBoostsManager._aHealingEffects;
	}
	function getSpellModificator(var2, var3)
	{
		if(_global.isNaN(this._oSpellsModificators[var2][var3]) || this._oSpellsModificators[var2][var3] == undefined)
		{
			return -1;
		}
		return Number(this._oSpellsModificators[var2][var3]);
	}
	function setSpellModificator(var2, var3, var4)
	{
		if(typeof this._oSpellsModificators[var2] != "object" && this._oSpellsModificators[var2] == undefined)
		{
			this._oSpellsModificators[var2] = new Object();
		}
		this._oSpellsModificators[var2][var3] = var4;
	}
	function isBoostedDamagingEffect(var2)
	{
		if(dofus.managers.SpellsBoostsManager._aDamagingEffects == undefined)
		{
			this.computeBoostedEffectsLists();
		}
		var var3 = 0;
		while(var3 < dofus.managers.SpellsBoostsManager._aDamagingEffects.length)
		{
			if(dofus.managers.SpellsBoostsManager._aDamagingEffects[var3] == var2)
			{
				return true;
			}
			var3 = var3 + 1;
		}
		return false;
	}
	function isBoostedHealingEffect(var2)
	{
		if(dofus.managers.SpellsBoostsManager._aHealingEffects == undefined)
		{
			this.computeBoostedEffectsLists();
		}
		var var3 = 0;
		while(var3 < dofus.managers.SpellsBoostsManager._aHealingEffects.length)
		{
			if(dofus.managers.SpellsBoostsManager._aHealingEffects[var3] == var2)
			{
				return true;
			}
			var3 = var3 + 1;
		}
		return false;
	}
	function isBoostedHealingOrDamagingEffect(var2)
	{
		if(dofus.managers.SpellsBoostsManager._aBoostedEffects == undefined)
		{
			this.computeBoostedEffectsLists();
		}
		var var3 = 0;
		while(var3 < dofus.managers.SpellsBoostsManager._aBoostedEffects.length)
		{
			if(dofus.managers.SpellsBoostsManager._aBoostedEffects[var3] == var2)
			{
				return true;
			}
			var3 = var3 + 1;
		}
		return false;
	}
	function computeBoostedEffectsLists()
	{
		dofus.managers.SpellsBoostsManager._aBoostedEffects = new Array();
		dofus.managers.SpellsBoostsManager._aDamagingEffects = this.api.lang.getBoostedDamagingEffects();
		dofus.managers.SpellsBoostsManager._aHealingEffects = this.api.lang.getBoostedHealingEffects();
		var var2 = 0;
		while(var2 < dofus.managers.SpellsBoostsManager._aDamagingEffects.length)
		{
			dofus.managers.SpellsBoostsManager._aBoostedEffects.push(dofus.managers.SpellsBoostsManager._aDamagingEffects[var2]);
			var2 = var2 + 1;
		}
		var var3 = 0;
		while(var3 < dofus.managers.SpellsBoostsManager._aHealingEffects.length)
		{
			dofus.managers.SpellsBoostsManager._aBoostedEffects.push(dofus.managers.SpellsBoostsManager._aHealingEffects[var3]);
			var3 = var3 + 1;
		}
	}
}
