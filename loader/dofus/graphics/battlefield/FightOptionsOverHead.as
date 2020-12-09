class dofus.graphics.battlefield.FightOptionsOverHead extends MovieClip
{
	static var ICON_WIDTH = 20;
	function FightOptionsOverHead(§\x1e\x0b\x07§)
	{
		super();
		this.initialize(var3);
		this.draw();
	}
	function __get__height()
	{
		return 20;
	}
	function initialize(§\x1e\x0b\x07§)
	{
		this._mc.removeMovieClip();
		this.createEmptyMovieClip("_mc",10);
		this._tTeam = var2;
	}
	function draw()
	{
		§§enumerate(this._mc);
		while((var var0 = §§enumeration()) != null)
		{
			this._mc[a].removeMovieClip();
		}
		var var2 = 0;
		for(var var3 in this._tTeam.options)
		{
			if(var3 == true)
			{
				var var4 = "UI_FightOption" + a + "Up";
				if(dofus.Constants.DOUBLEFRAMERATE && a == dofus.datacenter.Team.OPT_NEED_HELP)
				{
					var4 = var4 + "_DoubleFramerate";
				}
				var var5 = this._mc.attachMovie(var4,"mcOption" + var2,var2);
				var5._x = var2 * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH;
				var5.onEnterFrame = function()
				{
					this.play();
					delete this.onEnterFrame;
				};
				var2 = var2 + 1;
			}
		}
		this._x = (- var2 * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH) / 2;
	}
}
