class ank.battlefield.mc.Zone extends MovieClip
{
	static var ALPHA = 30;
	function Zone(var2)
	{
		super();
		this.initialize(var3);
	}
	function initialize(var2)
	{
		this._oMap = var2;
		this.clear();
	}
	function clear()
	{
		this.createEmptyMovieClip("_mcZone",10);
	}
	function remove()
	{
		this.removeMovieClip();
	}
	function drawCircle(var2, var3, var4)
	{
		var var5 = this._mcZone;
		var5.beginFill(var3,ank.battlefield.mc.Zone.ALPHA);
		this.drawCircleBorder(var2,var3,var4);
		var5.endFill();
	}
	function drawRing(var2, var3, var4, var5)
	{
		var var6 = this._mcZone;
		var6.beginFill(var4,ank.battlefield.mc.Zone.ALPHA);
		this.drawCircleBorder(var3,var4,var5);
		this.drawCircleBorder(var2,var4,var5);
		var6.endFill();
	}
	function drawRectangle(var2, var3, var4, var5)
	{
		var var6 = this._mcZone;
		var6.beginFill(var4,ank.battlefield.mc.Zone.ALPHA);
		this.drawRectangleBorder(var2,var3,var4,var5);
		var6.endFill();
	}
	function drawCross(var2, var3, var4)
	{
		var var5 = ank.battlefield.Constants.CELL_COORD;
		var var6 = this._oMap.getWidth();
		var var7 = var4;
		var var10 = this._mcZone;
		var10.beginFill(var3,ank.battlefield.mc.Zone.ALPHA);
		var10.lineStyle(1,var3,100);
		var var9 = this.getGroundData(var7);
		var10.moveTo(var5[var9.gf][0][0],var5[var9.gf][0][1] - var9.gl * 20);
		var var8 = 1;
		while(var8 <= var2)
		{
			var7 = var7 - var6;
			var9 = this.getGroundData(var7);
			var10.lineTo(var5[var9.gf][0][0] - var8 * ank.battlefield.Constants.CELL_HALF_WIDTH,var5[var9.gf][0][1] - var9.gl * 20 - var8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			var8 = var8 + 1;
		}
		var8 = var2;
		while(var8 >= 0)
		{
			if(var8 != var2)
			{
				var7 = var7 + var6;
			}
			var9 = this.getGroundData(var7);
			var10.lineTo(var5[var9.gf][1][0] - var8 * ank.battlefield.Constants.CELL_HALF_WIDTH,var5[var9.gf][1][1] - var9.gl * 20 - var8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			var8 = var8 - 1;
		}
		var8 = 1;
		while(var8 <= var2)
		{
			var7 = var7 - (var6 - 1);
			var9 = this.getGroundData(var7);
			var10.lineTo(var5[var9.gf][1][0] + var8 * ank.battlefield.Constants.CELL_HALF_WIDTH,var5[var9.gf][1][1] - var9.gl * 20 - var8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			var8 = var8 + 1;
		}
		var8 = var2;
		while(var8 >= 0)
		{
			if(var8 != var2)
			{
				var7 = var7 + (var6 - 1);
			}
			var9 = this.getGroundData(var7);
			var10.lineTo(var5[var9.gf][2][0] + var8 * ank.battlefield.Constants.CELL_HALF_WIDTH,var5[var9.gf][2][1] - var9.gl * 20 - var8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			var8 = var8 - 1;
		}
		var8 = 1;
		while(var8 <= var2)
		{
			var7 = var7 + var6;
			var9 = this.getGroundData(var7);
			var10.lineTo(var5[var9.gf][2][0] + var8 * ank.battlefield.Constants.CELL_HALF_WIDTH,var5[var9.gf][2][1] - var9.gl * 20 + var8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			var8 = var8 + 1;
		}
		var8 = var2;
		while(var8 >= 0)
		{
			if(var8 != var2)
			{
				var7 = var7 - var6;
			}
			var9 = this.getGroundData(var7);
			var10.lineTo(var5[var9.gf][3][0] + var8 * ank.battlefield.Constants.CELL_HALF_WIDTH,var5[var9.gf][3][1] - var9.gl * 20 + var8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			var8 = var8 - 1;
		}
		var8 = 1;
		while(var8 <= var2)
		{
			var7 = var7 + (var6 - 1);
			var9 = this.getGroundData(var7);
			var10.lineTo(var5[var9.gf][3][0] - var8 * ank.battlefield.Constants.CELL_HALF_WIDTH,var5[var9.gf][3][1] - var9.gl * 20 + var8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			var8 = var8 + 1;
		}
		var8 = var2;
		while(var8 > 0)
		{
			if(var8 != var2)
			{
				var7 = var7 - (var6 - 1);
			}
			var9 = this.getGroundData(var7);
			var10.lineTo(var5[var9.gf][0][0] - var8 * ank.battlefield.Constants.CELL_HALF_WIDTH,var5[var9.gf][0][1] - var9.gl * 20 + var8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			var8 = var8 - 1;
		}
		var10.endFill();
	}
	function drawLine(var2, var3, var4, var5, var6, var7)
	{
		var var8 = 0;
		var var9 = 0;
		if(var6 == true)
		{
			var var10 = this._oMap.getCellData(var4);
			var var11 = this._oMap.getCellData(var5);
			var8 = var10.x - var11.x;
			var9 = var10.rootY - var11.rootY;
		}
		var var12 = ank.battlefield.Constants.CELL_COORD;
		var var13 = this._oMap.getWidth();
		var var14 = var4;
		var var19 = [0,0,0,0,0,0,0,0];
		if(var5 != var4)
		{
			var var20 = ank.battlefield.utils.Pathfinding.getDirection(this._oMap,var5,var4);
			if(var7 == true)
			{
				var19[(var20 + 6) % 8] = var2;
				var19[(var20 + 10) % 8] = var2;
			}
			else
			{
				var19[var20] = var2;
			}
		}
		var var18 = this._mcZone;
		var18.beginFill(var3,ank.battlefield.mc.Zone.ALPHA);
		var18.lineStyle(1,var3,100);
		var var17 = this.getGroundData(var14);
		var18.moveTo(var12[var17.gf][0][0] + var8,var12[var17.gf][0][1] - var17.gl * 20 + var9);
		var var15 = 1;
		while(var15 <= var19[5])
		{
			var14 = var14 - var13;
			var17 = this.getGroundData(var14);
			var18.lineTo(var12[var17.gf][0][0] - var15 * ank.battlefield.Constants.CELL_HALF_WIDTH + var8,var12[var17.gf][0][1] - var17.gl * 20 - var15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + var9);
			var15 = var15 + 1;
		}
		var15 = var19[5];
		while(var15 >= 0)
		{
			if(var15 != var19[5])
			{
				var14 = var14 + var13;
			}
			var17 = this.getGroundData(var14);
			var18.lineTo(var12[var17.gf][1][0] - var15 * ank.battlefield.Constants.CELL_HALF_WIDTH + var8,var12[var17.gf][1][1] - var17.gl * 20 - var15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + var9);
			var15 = var15 - 1;
		}
		var15 = 1;
		while(var15 <= var19[7])
		{
			var14 = var14 - (var13 - 1);
			var17 = this.getGroundData(var14);
			var18.lineTo(var12[var17.gf][1][0] + var15 * ank.battlefield.Constants.CELL_HALF_WIDTH + var8,var12[var17.gf][1][1] - var17.gl * 20 - var15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + var9);
			var15 = var15 + 1;
		}
		var15 = var19[7];
		while(var15 >= 0)
		{
			if(var15 != var19[7])
			{
				var14 = var14 + (var13 - 1);
			}
			var17 = this.getGroundData(var14);
			var18.lineTo(var12[var17.gf][2][0] + var15 * ank.battlefield.Constants.CELL_HALF_WIDTH + var8,var12[var17.gf][2][1] - var17.gl * 20 - var15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + var9);
			var15 = var15 - 1;
		}
		var15 = 1;
		while(var15 <= var19[1])
		{
			var14 = var14 + var13;
			var17 = this.getGroundData(var14);
			var18.lineTo(var12[var17.gf][2][0] + var15 * ank.battlefield.Constants.CELL_HALF_WIDTH + var8,var12[var17.gf][2][1] - var17.gl * 20 + var15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + var9);
			var15 = var15 + 1;
		}
		var15 = var19[1];
		while(var15 >= 0)
		{
			if(var15 != var19[1])
			{
				var14 = var14 - var13;
			}
			var17 = this.getGroundData(var14);
			var18.lineTo(var12[var17.gf][3][0] + var15 * ank.battlefield.Constants.CELL_HALF_WIDTH + var8,var12[var17.gf][3][1] - var17.gl * 20 + var15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + var9);
			var15 = var15 - 1;
		}
		var15 = 1;
		while(var15 <= var19[3])
		{
			var14 = var14 + (var13 - 1);
			var17 = this.getGroundData(var14);
			var18.lineTo(var12[var17.gf][3][0] - var15 * ank.battlefield.Constants.CELL_HALF_WIDTH + var8,var12[var17.gf][3][1] - var17.gl * 20 + var15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + var9);
			var15 = var15 + 1;
		}
		var15 = var19[3];
		while(var15 > 0)
		{
			if(var15 != var19[3])
			{
				var14 = var14 - (var13 - 1);
			}
			var17 = this.getGroundData(var14);
			var18.lineTo(var12[var17.gf][0][0] - var15 * ank.battlefield.Constants.CELL_HALF_WIDTH + var8,var12[var17.gf][0][1] - var17.gl * 20 + var15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + var9);
			var15 = var15 - 1;
		}
		var18.endFill();
	}
	function getGroundData(var2)
	{
		var var3 = this._oMap.getCellData(var2);
		var var4 = var3.groundSlope != undefined?var3.groundSlope:1;
		var var5 = var3.groundLevel != undefined?var3.groundLevel - 7:0;
		return {gf:var4,gl:var5};
	}
	function drawCircleBorder(var2, var3, var4)
	{
		var var5 = ank.battlefield.Constants.CELL_COORD;
		var var6 = this._oMap.getWidth();
		var var7 = var6 * 2 - 1;
		var var8 = var4 - var2 * var6;
		var var13 = (- var2) * ank.battlefield.Constants.CELL_HALF_WIDTH;
		var var14 = (- var2) * ank.battlefield.Constants.CELL_HALF_HEIGHT;
		var var12 = this._mcZone;
		var12.lineStyle(1,var3,100);
		var var11 = this.getGroundData(var8);
		var12.moveTo(var13 + var5[var11.gf][0][0],var14 + var5[var11.gf][0][1] - var11.gl * 20);
		var var9 = 0;
		while(var9 < var2 + 1)
		{
			if(var9 != 0)
			{
				var8 = var8 + 1;
			}
			var11 = this.getGroundData(var8);
			var12.lineTo(var13 + var5[var11.gf][1][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var5[var11.gf][1][1] - var11.gl * 20);
			var12.lineTo(var13 + var5[var11.gf][2][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var5[var11.gf][2][1] - var11.gl * 20);
			var9 = var9 + 1;
		}
		var9 = var9 - 1;
		var var10 = 0;
		while(var10 < var2)
		{
			var8 = var8 + var7;
			var11 = this.getGroundData(var8);
			var12.lineTo(var13 + var5[var11.gf][1][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var5[var11.gf][1][1] + (var10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var12.lineTo(var13 + var5[var11.gf][2][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var5[var11.gf][2][1] + (var10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var10 = var10 + 1;
		}
		var9 = var2;
		while(var9 >= 0)
		{
			if(var9 != var2)
			{
				var8 = var8 - 1;
			}
			var11 = this.getGroundData(var8);
			var12.lineTo(var13 + var5[var11.gf][3][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var5[var11.gf][3][1] + var10 * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var12.lineTo(var13 + var5[var11.gf][0][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var5[var11.gf][0][1] + var10 * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var9 = var9 - 1;
		}
		var9 = var9 + 1;
		var10 = var2 - 1;
		while(var10 >= 0)
		{
			var8 = var8 - var7;
			var11 = this.getGroundData(var8);
			var12.lineTo(var13 + var5[var11.gf][3][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var5[var11.gf][3][1] + var10 * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var12.lineTo(var13 + var5[var11.gf][0][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var5[var11.gf][0][1] + var10 * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var10 = var10 - 1;
		}
	}
	function drawRectangleBorder(var2, var3, var4, var5)
	{
		var var6 = ank.battlefield.Constants.CELL_COORD;
		var var7 = this._oMap.getWidth() * 2 - 1;
		var var8 = Number(var5);
		var var13 = 0;
		var var14 = 0;
		var var12 = this._mcZone;
		var12.lineStyle(1,var4,100);
		var var11 = this.getGroundData(var8);
		var12.moveTo(var13 + var6[var11.gf][0][0],var14 + var6[var11.gf][0][1] - var11.gl * 20);
		var var9 = 0;
		while(var9 < var2)
		{
			if(var9 != 0)
			{
				var8 = var8 + 1;
			}
			var11 = this.getGroundData(var8);
			var12.lineTo(var13 + var6[var11.gf][1][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var6[var11.gf][1][1] - var11.gl * 20);
			var12.lineTo(var13 + var6[var11.gf][2][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var6[var11.gf][2][1] - var11.gl * 20);
			var9 = var9 + 1;
		}
		var9 = var9 - 1;
		var var10 = 0;
		while(var10 < var3 - 1)
		{
			var8 = var8 + var7;
			var11 = this.getGroundData(var8);
			var12.lineTo(var13 + var6[var11.gf][1][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var6[var11.gf][1][1] + (var10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var12.lineTo(var13 + var6[var11.gf][2][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var6[var11.gf][2][1] + (var10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var10 = var10 + 1;
		}
		var9 = var2 - 1;
		while(var9 >= 0)
		{
			if(var9 != var2 - 1)
			{
				var8 = var8 - 1;
			}
			var11 = this.getGroundData(var8);
			var12.lineTo(var13 + var6[var11.gf][3][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var6[var11.gf][3][1] + var10 * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var12.lineTo(var13 + var6[var11.gf][0][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var6[var11.gf][0][1] + var10 * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var9 = var9 - 1;
		}
		var9 = var9 + 1;
		var10 = var3 - 2;
		while(var10 >= 0)
		{
			var8 = var8 - var7;
			var11 = this.getGroundData(var8);
			var12.lineTo(var13 + var6[var11.gf][3][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var6[var11.gf][3][1] + var10 * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var12.lineTo(var13 + var6[var11.gf][0][0] + var9 * ank.battlefield.Constants.CELL_WIDTH,var14 + var6[var11.gf][0][1] + var10 * ank.battlefield.Constants.CELL_HEIGHT - var11.gl * 20);
			var10 = var10 - 1;
		}
	}
}
