class ank.battlefield.mc.BubbleThink extends ank.battlefield.mc.Bubble
{
	function BubbleThink(loc3, loc4, loc5, loc6)
	{
		super(loc3,loc4,loc5,loc6);
	}
	function drawCircle(loc2, loc3, loc4, loc5, loc6)
	{
		var loc7 = loc3 + Math.sin(360 / 15 * 0 * Math.PI / 180) * loc5;
		var loc8 = loc4 + Math.cos(360 / 15 * 0 * Math.PI / 180) * loc5;
		loc2.moveTo(loc7,loc8);
		loc2.beginFill(loc6,100);
		var loc9 = 0;
		while(loc9 <= 15)
		{
			var loc10 = loc3 + Math.sin(360 / 15 * loc9 * Math.PI / 180) * loc5;
			var loc11 = loc4 + Math.cos(360 / 15 * loc9 * Math.PI / 180) * loc5;
			loc2.lineTo(loc10,loc11);
			loc9 = loc9 + 1;
		}
		loc2.endFill();
	}
	function drawBackground(loc2, loc3)
	{
		var loc4 = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
		this.createEmptyMovieClip("_bg",10);
		var loc5 = - loc3 - loc4 - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT;
		var loc6 = - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT;
		var loc7 = 0;
		var loc8 = loc2 + loc4;
		this._bg.moveTo(loc7,loc5);
		this._bg.lineStyle(0,16777215);
		this._bg.beginFill(16777215,100);
		this._bg.lineTo(loc8,loc5);
		this._bg.lineTo(loc8,loc6);
		this._bg.lineTo(loc7,loc6);
		this._bg.lineTo(loc7,loc5);
		this._bg.endFill();
		var loc9 = loc7;
		while(loc9 <= loc8)
		{
			this.drawCircle(this._bg,loc9,loc5,7,16777215);
			loc9 = loc9 + 14;
		}
		var loc10 = loc7;
		while(loc10 <= loc8)
		{
			this.drawCircle(this._bg,loc10,loc6,7,16777215);
			loc10 = loc10 + 14;
		}
		var loc11 = loc5;
		while(loc11 <= loc6)
		{
			this.drawCircle(this._bg,loc8,loc11,7,16777215);
			loc11 = loc11 + 14;
		}
		var loc12 = loc5;
		while(loc12 <= loc6)
		{
			this.drawCircle(this._bg,loc7,loc12,7,16777215);
			loc12 = loc12 + 14;
		}
		this.drawCircle(this._bg,loc7,loc6 + 5,8,16777215);
		this.drawCircle(this._bg,-5,5,4,16777215);
		var loc13 = new Array();
		loc13.push(new flash.filters.GlowFilter(0,30,2,2,3,3,false,false));
		this._bg.filters = loc13;
		this._bg._alpha = 90;
	}
}
