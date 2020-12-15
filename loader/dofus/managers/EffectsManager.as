class dofus.managers.EffectsManager extends dofus.utils.ApiElement
{
	function EffectsManager(oSprite, oAPI)
	{
		super();
		var var5 = new flash.display.BitmapData();
		this.initialize(oSprite,oAPI);
	}
	function initialize(oSprite, oAPI)
	{
		super.initialize(oAPI);
		this._oSprite = oSprite;
		this._aEffects = new Array();
	}
	function getEffects()
	{
		return this._aEffects;
	}
	function addEffect(var2)
	{
		var var3 = 0;
		while(var3 < this._aEffects.length)
		{
			var var4 = this._aEffects[var3];
			if(var4.spellID == var2.spellID && (var4.type == var2.type && var4.remainingTurn == var2.remainingTurn))
			{
				var4.param1 = var4.param1 + var2.param1;
				return undefined;
			}
			var3 = var3 + 1;
		}
		this._aEffects.push(var2);
	}
	function terminateAllEffects()
	{
		var var2 = this._aEffects.length;
		while((var2 = var2 - 1) >= 0)
		{
			var var3 = this._aEffects[var2];
			this._aEffects.splice(var2,var2 + 1);
		}
	}
	function removeEffectsByCasterID(sCasterID)
	{
		if(sCasterID == undefined)
		{
			return undefined;
		}
		var var3 = this._aEffects.length;
		while((var3 = var3 - 1) >= 0)
		{
			var var4 = this._aEffects[var3];
			if(var4.sCasterID == sCasterID)
			{
				this._aEffects.splice(var3,1);
			}
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
				this._aEffects.splice(var2,1);
			}
		}
	}
}
