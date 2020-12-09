class dofus.graphics.gapi.controls.DeathCounter extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DeathCounter";
	static var MAX_HEAD = 11;
	function DeathCounter()
	{
		super();
	}
	function __set__death(§\x06\x1b§)
	{
		this._nDeath = var2;
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
		var var2 = this._nDeath <= dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD?this._nDeath:dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD;
		var var3 = Math.PI / var2;
		var var4 = (- var3) / 2;
		var var5 = this._mcPlacer._width / 2;
		var var6 = this._mcPlacer._height;
		var var7 = this._mcPlacer._width / 2;
		var var8 = this._mcPlacer._height;
		var var9 = this.createEmptyMovieClip("_mcHeads",100);
		var9._x = this._mcPlacer._x;
		var9._y = this._mcPlacer._y;
		var var10 = 0;
		while(var10 < var2)
		{
			var var11 = var4 - var10 * var3;
			var var12 = Math.cos(var11) * var5 + var7;
			var var13 = Math.sin(var11) * var6 + var8;
			if(var10 == 0 && this._nDeath > dofus.graphics.gapi.controls.DeathCounter.MAX_HEAD)
			{
				var var14 = "_mcDeathCounterHeadMore";
			}
			else
			{
				var14 = "_mcDeathCounterHead";
			}
			var9.attachMovie(var14,"head" + var10,var10,{_x:var12,_y:var13,_rotation:var11 * 180 / Math.PI});
			var10 = var10 + 1;
		}
	}
}
