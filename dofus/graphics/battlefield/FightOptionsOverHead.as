class dofus.graphics.battlefield.FightOptionsOverHead extends MovieClip
{
	static var ICON_WIDTH = 20;
	function FightOptionsOverHead(var3)
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
		this._mc.removeMovieClip();
		this.createEmptyMovieClip("_mc",10);
		this._tTeam = var2;
	}
	function draw()
	{
		for(var a in this._mc)
		{
			this._mc[a].removeMovieClip();
		}
		var var2 = 0;
		for(var a in this._tTeam.options)
		{
			var var3 = this._tTeam.options[a];
			if(var3 == true)
			{
				var var4 = this._mc.attachMovie("UI_FightOption" + a + "Up","mcOption" + var2,var2);
				var4._x = var2 * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH;
				var4.onEnterFrame = function()
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
