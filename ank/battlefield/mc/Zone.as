class ank.battlefield.mc.Zone extends MovieClip
{
	static var ALPHA = 30;
	function Zone(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function initialize(loc2)
	{
		this._oMap = loc2;
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
	function drawCircle(loc2, loc3, loc4)
	{
		var loc5 = this._mcZone;
		loc5.beginFill(loc3,ank.battlefield.mc.Zone.ALPHA);
		this.drawCircleBorder(loc2,loc3,loc4);
		loc5.endFill();
	}
	function drawRing(loc2, loc3, loc4, loc5)
	{
		var loc6 = this._mcZone;
		loc6.beginFill(loc4,ank.battlefield.mc.Zone.ALPHA);
		this.drawCircleBorder(loc3,loc4,loc5);
		this.drawCircleBorder(loc2,loc4,loc5);
		loc6.endFill();
	}
	function drawRectangle(loc2, loc3, loc4, loc5)
	{
		var loc6 = this._mcZone;
		loc6.beginFill(loc4,ank.battlefield.mc.Zone.ALPHA);
		this.drawRectangleBorder(loc2,loc3,loc4,loc5);
		loc6.endFill();
	}
	function drawCross(loc2, loc3, loc4)
	{
		var loc5 = ank.battlefield.Constants.CELL_COORD;
		var loc6 = this._oMap.getWidth();
		var loc7 = loc4;
		var loc10 = this._mcZone;
		loc10.beginFill(loc3,ank.battlefield.mc.Zone.ALPHA);
		loc10.lineStyle(1,loc3,100);
		var loc9 = this.getGroundData(loc7);
		loc10.moveTo(loc5[loc9.gf][0][0],loc5[loc9.gf][0][1] - loc9.gl * 20);
		var loc8 = 1;
		while(loc8 <= loc2)
		{
			loc7 = loc7 - loc6;
			loc9 = this.getGroundData(loc7);
			loc10.lineTo(loc5[loc9.gf][0][0] - loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH,loc5[loc9.gf][0][1] - loc9.gl * 20 - loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			loc8 = loc8 + 1;
		}
		loc8 = loc2;
		while(loc8 >= 0)
		{
			if(loc8 != loc2)
			{
				loc7 = loc7 + loc6;
			}
			loc9 = this.getGroundData(loc7);
			loc10.lineTo(loc5[loc9.gf][1][0] - loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH,loc5[loc9.gf][1][1] - loc9.gl * 20 - loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			loc8 = loc8 - 1;
		}
		loc8 = 1;
		while(loc8 <= loc2)
		{
			loc7 = loc7 - (loc6 - 1);
			loc9 = this.getGroundData(loc7);
			loc10.lineTo(loc5[loc9.gf][1][0] + loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH,loc5[loc9.gf][1][1] - loc9.gl * 20 - loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			loc8 = loc8 + 1;
		}
		loc8 = loc2;
		while(loc8 >= 0)
		{
			if(loc8 != loc2)
			{
				loc7 = loc7 + (loc6 - 1);
			}
			loc9 = this.getGroundData(loc7);
			loc10.lineTo(loc5[loc9.gf][2][0] + loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH,loc5[loc9.gf][2][1] - loc9.gl * 20 - loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			loc8 = loc8 - 1;
		}
		loc8 = 1;
		while(loc8 <= loc2)
		{
			loc7 = loc7 + loc6;
			loc9 = this.getGroundData(loc7);
			loc10.lineTo(loc5[loc9.gf][2][0] + loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH,loc5[loc9.gf][2][1] - loc9.gl * 20 + loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			loc8 = loc8 + 1;
		}
		loc8 = loc2;
		while(loc8 >= 0)
		{
			if(loc8 != loc2)
			{
				loc7 = loc7 - loc6;
			}
			loc9 = this.getGroundData(loc7);
			loc10.lineTo(loc5[loc9.gf][3][0] + loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH,loc5[loc9.gf][3][1] - loc9.gl * 20 + loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			loc8 = loc8 - 1;
		}
		loc8 = 1;
		while(loc8 <= loc2)
		{
			loc7 = loc7 + (loc6 - 1);
			loc9 = this.getGroundData(loc7);
			loc10.lineTo(loc5[loc9.gf][3][0] - loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH,loc5[loc9.gf][3][1] - loc9.gl * 20 + loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			loc8 = loc8 + 1;
		}
		loc8 = loc2;
		while(loc8 > 0)
		{
			if(loc8 != loc2)
			{
				loc7 = loc7 - (loc6 - 1);
			}
			loc9 = this.getGroundData(loc7);
			loc10.lineTo(loc5[loc9.gf][0][0] - loc8 * ank.battlefield.Constants.CELL_HALF_WIDTH,loc5[loc9.gf][0][1] - loc9.gl * 20 + loc8 * ank.battlefield.Constants.CELL_HALF_HEIGHT);
			loc8 = loc8 - 1;
		}
		loc10.endFill();
	}
	function drawLine(loc2, loc3, loc4, loc5, loc6, loc7)
	{
		var loc8 = 0;
		var loc9 = 0;
		if(loc6 == true)
		{
			var loc10 = this._oMap.getCellData(loc4);
			var loc11 = this._oMap.getCellData(loc5);
			loc8 = loc10.x - loc11.x;
			loc9 = loc10.rootY - loc11.rootY;
		}
		var loc12 = ank.battlefield.Constants.CELL_COORD;
		var loc13 = this._oMap.getWidth();
		var loc14 = loc4;
		var loc19 = [0,0,0,0,0,0,0,0];
		if(loc5 != loc4)
		{
			var loc20 = ank.battlefield.utils.Pathfinding.getDirection(this._oMap,loc5,loc4);
			if(loc7 == true)
			{
				loc19[(loc20 + 6) % 8] = loc2;
				loc19[(loc20 + 10) % 8] = loc2;
			}
			else
			{
				loc19[loc20] = loc2;
			}
		}
		var loc18 = this._mcZone;
		loc18.beginFill(loc3,ank.battlefield.mc.Zone.ALPHA);
		loc18.lineStyle(1,loc3,100);
		var loc17 = this.getGroundData(loc14);
		loc18.moveTo(loc12[loc17.gf][0][0] + loc8,loc12[loc17.gf][0][1] - loc17.gl * 20 + loc9);
		var loc15 = 1;
		while(loc15 <= loc19[5])
		{
			loc14 = loc14 - loc13;
			loc17 = this.getGroundData(loc14);
			loc18.lineTo(loc12[loc17.gf][0][0] - loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + loc8,loc12[loc17.gf][0][1] - loc17.gl * 20 - loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + loc9);
			loc15 = loc15 + 1;
		}
		loc15 = loc19[5];
		while(loc15 >= 0)
		{
			if(loc15 != loc19[5])
			{
				loc14 = loc14 + loc13;
			}
			loc17 = this.getGroundData(loc14);
			loc18.lineTo(loc12[loc17.gf][1][0] - loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + loc8,loc12[loc17.gf][1][1] - loc17.gl * 20 - loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + loc9);
			loc15 = loc15 - 1;
		}
		loc15 = 1;
		while(loc15 <= loc19[7])
		{
			loc14 = loc14 - (loc13 - 1);
			loc17 = this.getGroundData(loc14);
			loc18.lineTo(loc12[loc17.gf][1][0] + loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + loc8,loc12[loc17.gf][1][1] - loc17.gl * 20 - loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + loc9);
			loc15 = loc15 + 1;
		}
		loc15 = loc19[7];
		while(loc15 >= 0)
		{
			if(loc15 != loc19[7])
			{
				loc14 = loc14 + (loc13 - 1);
			}
			loc17 = this.getGroundData(loc14);
			loc18.lineTo(loc12[loc17.gf][2][0] + loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + loc8,loc12[loc17.gf][2][1] - loc17.gl * 20 - loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + loc9);
			loc15 = loc15 - 1;
		}
		loc15 = 1;
		while(loc15 <= loc19[1])
		{
			loc14 = loc14 + loc13;
			loc17 = this.getGroundData(loc14);
			loc18.lineTo(loc12[loc17.gf][2][0] + loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + loc8,loc12[loc17.gf][2][1] - loc17.gl * 20 + loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + loc9);
			loc15 = loc15 + 1;
		}
		loc15 = loc19[1];
		while(loc15 >= 0)
		{
			if(loc15 != loc19[1])
			{
				loc14 = loc14 - loc13;
			}
			loc17 = this.getGroundData(loc14);
			loc18.lineTo(loc12[loc17.gf][3][0] + loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + loc8,loc12[loc17.gf][3][1] - loc17.gl * 20 + loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + loc9);
			loc15 = loc15 - 1;
		}
		loc15 = 1;
		while(loc15 <= loc19[3])
		{
			loc14 = loc14 + (loc13 - 1);
			loc17 = this.getGroundData(loc14);
			loc18.lineTo(loc12[loc17.gf][3][0] - loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + loc8,loc12[loc17.gf][3][1] - loc17.gl * 20 + loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + loc9);
			loc15 = loc15 + 1;
		}
		loc15 = loc19[3];
		while(loc15 > 0)
		{
			if(loc15 != loc19[3])
			{
				loc14 = loc14 - (loc13 - 1);
			}
			loc17 = this.getGroundData(loc14);
			loc18.lineTo(loc12[loc17.gf][0][0] - loc15 * ank.battlefield.Constants.CELL_HALF_WIDTH + loc8,loc12[loc17.gf][0][1] - loc17.gl * 20 + loc15 * ank.battlefield.Constants.CELL_HALF_HEIGHT + loc9);
			loc15 = loc15 - 1;
		}
		loc18.endFill();
	}
	function getGroundData(loc2)
	{
		var loc3 = this._oMap.getCellData(loc2);
		var loc4 = loc3.groundSlope != undefined?loc3.groundSlope:1;
		var loc5 = loc3.groundLevel != undefined?loc3.groundLevel - 7:0;
		return {gf:loc4,gl:loc5};
	}
	function drawCircleBorder(loc2, loc3, loc4)
	{
		var loc5 = ank.battlefield.Constants.CELL_COORD;
		var loc6 = this._oMap.getWidth();
		var loc7 = loc6 * 2 - 1;
		var loc8 = loc4 - loc2 * loc6;
		var loc13 = (- loc2) * ank.battlefield.Constants.CELL_HALF_WIDTH;
		var loc14 = (- loc2) * ank.battlefield.Constants.CELL_HALF_HEIGHT;
		var loc12 = this._mcZone;
		loc12.lineStyle(1,loc3,100);
		var loc11 = this.getGroundData(loc8);
		loc12.moveTo(loc13 + loc5[loc11.gf][0][0],loc14 + loc5[loc11.gf][0][1] - loc11.gl * 20);
		var loc9 = 0;
		while(loc9 < loc2 + 1)
		{
			if(loc9 != 0)
			{
				loc8 = loc8 + 1;
			}
			loc11 = this.getGroundData(loc8);
			loc12.lineTo(loc13 + loc5[loc11.gf][1][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc5[loc11.gf][1][1] - loc11.gl * 20);
			loc12.lineTo(loc13 + loc5[loc11.gf][2][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc5[loc11.gf][2][1] - loc11.gl * 20);
			loc9 = loc9 + 1;
		}
		loc9 = loc9 - 1;
		var loc10 = 0;
		while(loc10 < loc2)
		{
			loc8 = loc8 + loc7;
			loc11 = this.getGroundData(loc8);
			loc12.lineTo(loc13 + loc5[loc11.gf][1][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc5[loc11.gf][1][1] + (loc10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc12.lineTo(loc13 + loc5[loc11.gf][2][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc5[loc11.gf][2][1] + (loc10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc10 = loc10 + 1;
		}
		loc9 = loc2;
		while(loc9 >= 0)
		{
			if(loc9 != loc2)
			{
				loc8 = loc8 - 1;
			}
			loc11 = this.getGroundData(loc8);
			loc12.lineTo(loc13 + loc5[loc11.gf][3][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc5[loc11.gf][3][1] + loc10 * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc12.lineTo(loc13 + loc5[loc11.gf][0][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc5[loc11.gf][0][1] + loc10 * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc9 = loc9 - 1;
		}
		loc9 = loc9 + 1;
		loc10 = loc2 - 1;
		while(loc10 >= 0)
		{
			loc8 = loc8 - loc7;
			loc11 = this.getGroundData(loc8);
			loc12.lineTo(loc13 + loc5[loc11.gf][3][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc5[loc11.gf][3][1] + loc10 * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc12.lineTo(loc13 + loc5[loc11.gf][0][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc5[loc11.gf][0][1] + loc10 * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc10 = loc10 - 1;
		}
	}
	function drawRectangleBorder(loc2, loc3, loc4, loc5)
	{
		var loc6 = ank.battlefield.Constants.CELL_COORD;
		var loc7 = this._oMap.getWidth() * 2 - 1;
		var loc8 = Number(loc5);
		var loc13 = 0;
		var loc14 = 0;
		var loc12 = this._mcZone;
		loc12.lineStyle(1,loc4,100);
		var loc11 = this.getGroundData(loc8);
		loc12.moveTo(loc13 + loc6[loc11.gf][0][0],loc14 + loc6[loc11.gf][0][1] - loc11.gl * 20);
		var loc9 = 0;
		while(loc9 < loc2)
		{
			if(loc9 != 0)
			{
				loc8 = loc8 + 1;
			}
			loc11 = this.getGroundData(loc8);
			loc12.lineTo(loc13 + loc6[loc11.gf][1][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc6[loc11.gf][1][1] - loc11.gl * 20);
			loc12.lineTo(loc13 + loc6[loc11.gf][2][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc6[loc11.gf][2][1] - loc11.gl * 20);
			loc9 = loc9 + 1;
		}
		loc9 = loc9 - 1;
		var loc10 = 0;
		while(loc10 < loc3 - 1)
		{
			loc8 = loc8 + loc7;
			loc11 = this.getGroundData(loc8);
			loc12.lineTo(loc13 + loc6[loc11.gf][1][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc6[loc11.gf][1][1] + (loc10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc12.lineTo(loc13 + loc6[loc11.gf][2][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc6[loc11.gf][2][1] + (loc10 + 1) * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc10 = loc10 + 1;
		}
		loc9 = loc2 - 1;
		while(loc9 >= 0)
		{
			if(loc9 != loc2 - 1)
			{
				loc8 = loc8 - 1;
			}
			loc11 = this.getGroundData(loc8);
			loc12.lineTo(loc13 + loc6[loc11.gf][3][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc6[loc11.gf][3][1] + loc10 * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc12.lineTo(loc13 + loc6[loc11.gf][0][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc6[loc11.gf][0][1] + loc10 * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc9 = loc9 - 1;
		}
		loc9 = loc9 + 1;
		loc10 = loc3 - 2;
		while(loc10 >= 0)
		{
			loc8 = loc8 - loc7;
			loc11 = this.getGroundData(loc8);
			loc12.lineTo(loc13 + loc6[loc11.gf][3][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc6[loc11.gf][3][1] + loc10 * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc12.lineTo(loc13 + loc6[loc11.gf][0][0] + loc9 * ank.battlefield.Constants.CELL_WIDTH,loc14 + loc6[loc11.gf][0][1] + loc10 * ank.battlefield.Constants.CELL_HEIGHT - loc11.gl * 20);
			loc10 = loc10 - 1;
		}
	}
}
