class ank.battlefield.mc.BubbleThink extends ank.battlefield.mc.Bubble
{
	function BubbleThink(var3, var4, var5, var6)
	{
		super(var3,var4,var5,var6);
	}
	function drawCircle(var2, var3, var4, var5, var6)
	{
		var var7 = var3 + Math.sin(360 / 15 * 0 * Math.PI / 180) * var5;
		var var8 = var4 + Math.cos(360 / 15 * 0 * Math.PI / 180) * var5;
		var2.moveTo(var7,var8);
		var2.beginFill(var6,100);
		var var9 = 0;
		while(var9 <= 15)
		{
			var var10 = var3 + Math.sin(360 / 15 * var9 * Math.PI / 180) * var5;
			var var11 = var4 + Math.cos(360 / 15 * var9 * Math.PI / 180) * var5;
			var2.lineTo(var10,var11);
			var9 = var9 + 1;
		}
		var2.endFill();
	}
	function drawBackground(var2, var3)
	{
		var var4 = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
		this.createEmptyMovieClip("_bg",10);
		var var5 = - var3 - var4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT;
		var var6 = - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT;
		var var7 = 0;
		var var8 = var2 + var4;
		this._bg.moveTo(var7,var5);
		this._bg.lineStyle(0,16777215);
		this._bg.beginFill(16777215,100);
		this._bg.lineTo(var8,var5);
		this._bg.lineTo(var8,var6);
		this._bg.lineTo(var7,var6);
		this._bg.lineTo(var7,var5);
		this._bg.endFill();
		var var9 = var7;
		while(var9 <= var8)
		{
			this.drawCircle(this._bg,var9,var5,7,16777215);
			var9 = var9 + 14;
		}
		var var10 = var7;
		while(var10 <= var8)
		{
			this.drawCircle(this._bg,var10,var6,7,16777215);
			var10 = var10 + 14;
		}
		var var11 = var5;
		while(var11 <= var6)
		{
			this.drawCircle(this._bg,var8,var11,7,16777215);
			var11 = var11 + 14;
		}
		var var12 = var5;
		while(var12 <= var6)
		{
			this.drawCircle(this._bg,var7,var12,7,16777215);
			var12 = var12 + 14;
		}
		this.drawCircle(this._bg,var7,var6 + 5,8,16777215);
		this.drawCircle(this._bg,-5,5,4,16777215);
		var var13 = new Array();
		var13.push(new flash.filters.GlowFilter(0,30,2,2,3,3,false,false));
		this._bg.filters = var13;
		this._bg._alpha = 90;
	}
}
