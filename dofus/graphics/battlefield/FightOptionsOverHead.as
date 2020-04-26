class dofus.graphics.battlefield.FightOptionsOverHead extends MovieClip
{
	static var ICON_WIDTH = 20;
	function FightOptionsOverHead(loc3)
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
		this._mc.removeMovieClip();
		this.createEmptyMovieClip("_mc",10);
		this._tTeam = loc2;
	}
	function draw()
	{
		§§enumerate(this._mc);
		while((var loc0 = §§enumeration()) != null)
		{
			this._mc[a].removeMovieClip();
		}
		var loc2 = 0;
		for(var a in this._tTeam.options)
		{
			var loc3 = this._tTeam.options[a];
			if(loc3 == true)
			{
				var loc4 = this._mc.attachMovie("UI_FightOption" + a + "Up","mcOption" + loc2,loc2);
				loc4._x = loc2 * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH;
				loc4.onEnterFrame = function()
				{
					this.play();
					delete this.onEnterFrame;
				};
				loc2 = loc2 + 1;
			}
		}
		this._x = (- loc2 * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH) / 2;
	}
}
