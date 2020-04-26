class dofus.managers.EffectsManager extends dofus.utils.ApiElement
{
	function EffectsManager(oSprite, §\x1e\x1b\x1d§)
	{
		super();
		var loc5 = new flash.display.BitmapData();
		this.initialize(oSprite,loc4);
	}
	function initialize(oSprite, §\x1e\x1b\x1d§)
	{
		super.initialize(loc4);
		this._oSprite = oSprite;
		this._aEffects = new Array();
	}
	function getEffects()
	{
		return this._aEffects;
	}
	function addEffect(loc2)
	{
		var loc3 = 0;
		while(loc3 < this._aEffects.length)
		{
			var loc4 = this._aEffects[loc3];
			if(loc4.spellID == loc2.spellID && (loc4.type == loc2.type && loc4.remainingTurn == loc2.remainingTurn))
			{
				loc4.param1 = loc4.param1 + loc2.param1;
				return undefined;
			}
			loc3 = loc3 + 1;
		}
		this._aEffects.push(loc2);
	}
	function terminateAllEffects()
	{
		var loc2 = this._aEffects.length;
		while((loc2 = loc2 - 1) >= 0)
		{
			var loc3 = this._aEffects[loc2];
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
				this._aEffects.splice(loc2,1);
			}
		}
	}
}
