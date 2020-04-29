class dofus.graphics.battlefield.EffectsOverHead extends MovieClip
{
	static var ICON_WIDTH = 20;
	function EffectsOverHead(var3)
	{
		super();
		this.initialize(var3);
		this.draw();
	}
	function __get__height()
	{
		return 20;
	}
	function initialize(var2)
	{
		this.createEmptyMovieClip("_mcEffects",10);
		this._aEffects = var2;
	}
	function draw()
	{
		var var2 = this._aEffects.length - 1;
		this._aEffectsQty = new Array();
		while(var2 >= 0)
		{
			var var3 = this._aEffects[var2];
			if(this._aEffectsQty[var3.type])
			{
				this._aEffectsQty[var3.type].qty++;
			}
			else
			{
				this._aEffectsQty[var3.type] = {effect:var3,qty:1};
			}
			var2 = var2 - 1;
		}
		var var5 = 0;
		var var6 = 0;
		for(var j in this._aEffectsQty)
		{
			var3 = this._aEffectsQty[j].effect;
			var var7 = new MovieClipLoader();
			var7.addListener(this);
			this._mcEffects.createEmptyMovieClip("_mcEffect" + j,Number(j));
			var var4 = this._mcEffects["_mcEffect" + j];
			var4._x = var5;
			var5 = var5 + dofus.graphics.battlefield.EffectsOverHead.ICON_WIDTH;
			var4.effect = var3;
			var7.loadClip(dofus.Constants.EFFECTSICON_FILE,var4);
		}
		this._x = (- var5) / 2;
	}
	function onLoadInit(var2)
	{
		var var3 = var2.getDepth();
		var var4 = this._aEffectsQty[var3].effect;
		var var5 = var2.attachMovie("Icon_" + var4.characteristic,"icon_mc",10);
		var5.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
		var var6 = (dofus.graphics.battlefield.EffectIcon)var5;
		var6.initialize(var4.operator,this._aEffectsQty[var3].qty);
		if(this._aEffectsQty[var3].qty > 1)
		{
			var5 = var2.attachMovie("Icon_" + var4.characteristic,"icon_mc_multiple",5,{_x:3,_y:3});
			var5.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
			var6 = (dofus.graphics.battlefield.EffectIcon)var5;
			var6.initialize(var4.operator,this._aEffectsQty[var3].qty);
		}
	}
}
