class dofus.graphics.battlefield.EffectsOverHead extends MovieClip
{
	static var ICON_WIDTH = 20;
	function EffectsOverHead(loc3)
	{
		super();
		this.initialize(loc3);
		this.draw();
	}
	function __get__height()
	{
		return 20;
	}
	function initialize(loc2)
	{
		this.createEmptyMovieClip("_mcEffects",10);
		this._aEffects = loc2;
	}
	function draw()
	{
		var loc2 = this._aEffects.length - 1;
		this._aEffectsQty = new Array();
		while(loc2 >= 0)
		{
			var loc3 = this._aEffects[loc2];
			if(this._aEffectsQty[loc3.type])
			{
				this._aEffectsQty[loc3.type].qty++;
			}
			else
			{
				this._aEffectsQty[loc3.type] = {effect:loc3,qty:1};
			}
			loc2 = loc2 - 1;
		}
		var loc5 = 0;
		var loc6 = 0;
		for(var j in this._aEffectsQty)
		{
			loc3 = this._aEffectsQty[j].effect;
			var loc7 = new MovieClipLoader();
			loc7.addListener(this);
			this._mcEffects.createEmptyMovieClip("_mcEffect" + j,Number(j));
			var loc4 = this._mcEffects["_mcEffect" + j];
			loc4._x = loc5;
			loc5 = loc5 + dofus.graphics.battlefield.EffectsOverHead.ICON_WIDTH;
			loc4.effect = loc3;
			loc7.loadClip(dofus.Constants.EFFECTSICON_FILE,loc4);
		}
		this._x = (- loc5) / 2;
	}
	function onLoadInit(loc2)
	{
		var loc3 = loc2.getDepth();
		var loc4 = this._aEffectsQty[loc3].effect;
		var loc5 = loc2.attachMovie("Icon_" + loc4.characteristic,"icon_mc",10);
		loc5.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
		var loc6 = (dofus.graphics.battlefield.EffectIcon)loc5;
		loc6.initialize(loc4.operator,this._aEffectsQty[loc3].qty);
		if(this._aEffectsQty[loc3].qty > 1)
		{
			loc5 = loc2.attachMovie("Icon_" + loc4.characteristic,"icon_mc_multiple",5,{_x:3,_y:3});
			loc5.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
			loc6 = (dofus.graphics.battlefield.EffectIcon)loc5;
			loc6.initialize(loc4.operator,this._aEffectsQty[loc3].qty);
		}
	}
}
