class dofus.graphics.gapi.controls.DeathCounter extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DeathCounter";
	static var MAX_HEAD = 11;
	function DeathCounter()
	{
		super();
	}
	function __set__death(loc2)
	{
		this._nDeath = loc2;
		this.draw();
		return this.__get__death();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.DeathCounter.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.draw});
	}
	function draw()
	{
		if(this._nDeath == undefined || this._nDeath == 0)
		{
			return undefined;
		}
		var loc2 = this._nDeath <= dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD?this._nDeath:dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD;
		var loc3 = Math.PI / loc2;
		var loc4 = (- loc3) / 2;
		var loc5 = this._mcPlacer._width / 2;
		var loc6 = this._mcPlacer._height;
		var loc7 = this._mcPlacer._width / 2;
		var loc8 = this._mcPlacer._height;
		var loc9 = this.createEmptyMovieClip("_mcHeads",100);
		loc9._x = this._mcPlacer._x;
		loc9._y = this._mcPlacer._y;
		var loc10 = 0;
		while(loc10 < loc2)
		{
			var loc11 = loc4 - loc10 * loc3;
			var loc12 = Math.cos(loc11) * loc5 + loc7;
			var loc13 = Math.sin(loc11) * loc6 + loc8;
			if(loc10 == 0 && this._nDeath > dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD)
			{
				var loc14 = "_mcDeathCounterHeadMore";
			}
			else
			{
				loc14 = "_mcDeathCounterHead";
			}
			loc9.attachMovie(loc14,"head" + loc10,loc10,{_x:loc12,_y:loc13,_rotation:loc11 * 180 / Math.PI});
			loc10 = loc10 + 1;
		}
	}
}
