class ank.gapi.controls.button.ButtonBackground extends ank.gapi.core.UIBasicComponent
{
	function ButtonBackground()
	{
		super();
	}
	function setSize(var2, var3, var4)
	{
		this.left_mc._x = this.left_mc._y = this.middle_mc._y = this.right_mc._y = 0;
		this.left_mc._height = this.middle_mc._height = this.right_mc._height = var3;
		if(var4)
		{
			this.left_mc._xscale = this.left_mc._yscale;
			this.right_mc._xscale = this.right_mc._yscale;
		}
		this.middle_mc._x = this.left_mc != undefined?this.left_mc._width:0;
		this.middle_mc._width = var2 - (this.left_mc != undefined?this.left_mc._width:0) - (this.right_mc != undefined?this.right_mc._width:0);
		this.right_mc._x = var2 - this.right_mc._width;
	}
	function setStyleColor(var2, var3)
	{
		var var4 = this.left_mc;
		for(var var5 in var4)
		{
			var var6 = var2[var5 + var3];
			if(var6 != undefined)
			{
				this.setMovieClipColor(var4[k],var6);
			}
		}
		var4 = this.middle_mc;
		for(var var7 in var4)
		{
			var var8 = var2[var7 + var3];
			if(var8 != undefined)
			{
				this.setMovieClipColor(var4[k],var8);
			}
		}
		var4 = this.right_mc;
		for(var k in var4)
		{
			var var9 = k.split("_")[0];
			var var10 = var2[var9 + var3];
			if(var10 != undefined)
			{
				this.setMovieClipColor(var4[k],var10);
			}
		}
	}
}
