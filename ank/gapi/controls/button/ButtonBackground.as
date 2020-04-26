class ank.gapi.controls.button.ButtonBackground extends ank.gapi.core.UIBasicComponent
{
	function ButtonBackground()
	{
		super();
	}
	function setSize(loc2, loc3, loc4)
	{
		this.left_mc._x = this.left_mc._y = this.middle_mc._y = this.right_mc._y = 0;
		this.left_mc._height = this.middle_mc._height = this.right_mc._height = loc3;
		if(loc4)
		{
			this.left_mc._xscale = this.left_mc._yscale;
			this.right_mc._xscale = this.right_mc._yscale;
		}
		this.middle_mc._x = this.left_mc != undefined?this.left_mc._width:0;
		this.middle_mc._width = loc2 - (this.left_mc != undefined?this.left_mc._width:0) - (this.right_mc != undefined?this.right_mc._width:0);
		this.right_mc._x = loc2 - this.right_mc._width;
	}
	function setStyleColor(loc2, loc3)
	{
		var loc4 = this.left_mc;
		for(var k in loc4)
		{
			var loc5 = k.split("_")[0];
			var loc6 = loc2[loc5 + loc3];
			if(loc6 != undefined)
			{
				this.setMovieClipColor(loc4[k],loc6);
			}
		}
		loc4 = this.middle_mc;
		for(var loc7 in loc4)
		{
			var loc8 = loc2[loc7 + loc3];
			if(loc8 != undefined)
			{
				this.setMovieClipColor(loc4[k],loc8);
			}
		}
		loc4 = this.right_mc;
		for(var loc9 in loc4)
		{
			var loc10 = loc2[loc9 + loc3];
			if(loc10 != undefined)
			{
				this.setMovieClipColor(loc4[k],loc10);
			}
		}
	}
}
