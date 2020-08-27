class ank.battlefield.utils.Pathfinding
{
	function Pathfinding()
	{
	}
	static function pathFind(mapHandler, §\b\x1b§, §\b\x1a§, §\x1e\x19\x1b§)
	{
		if(var3 == undefined)
		{
			return null;
		}
		if(var4 == undefined)
		{
			return null;
		}
		var var6 = var5.bAllDirections != undefined?var5.bAllDirections:true;
		var var7 = var5.nMaxLength != undefined?var5.nMaxLength:500;
		var var8 = var5.bIgnoreSprites != undefined?var5.bIgnoreSprites:false;
		var var9 = var5.bCellNumOnly != undefined?var5.bCellNumOnly:false;
		var var10 = var5.bWithBeginCellNum != undefined?var5.bWithBeginCellNum:false;
		var var11 = mapHandler.getWidth();
		if(var6)
		{
			var var12 = 8;
			var var13 = [1,var11,var11 * 2 - 1,var11 - 1,-1,- var11,- var11 * 2 + 1,- var11 - 1];
			var var14 = [1.5,1,1.5,1,1.5,1,1.5,1];
		}
		else
		{
			var12 = 4;
			var13 = [var11,var11 - 1,- var11,- var11 - 1];
			var14 = [1,1,1,1];
		}
		var var15 = mapHandler.getCellsData();
		var var16 = new Object();
		var var17 = new Object();
		var var18 = false;
		var var19 = var16["oCell" + var3] = new Object();
		var16["oCell" + var3] = new Object().num = var3;
		var16["oCell" + var3] = new Object().g = 0;
		var16["oCell" + var3] = new Object().v = 0;
		var16["oCell" + var3] = new Object().h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,var3,var4);
		var16["oCell" + var3] = new Object().f = var16["oCell" + var3] = new Object().h;
		var16["oCell" + var3] = new Object().l = var15[var3].groundLevel;
		var16["oCell" + var3] = new Object().m = var15[var3].movement;
		var16["oCell" + var3] = new Object().parent = null;
		var var20 = new Array();
		var var21 = 0;
		while(var21 < var15.length - 1)
		{
			var20[var21] = var15[var21].isUnwalkableLayerObject;
			var21 = var21 + 1;
		}
		var var22 = new Array();
		if(!var8)
		{
			var var23 = 0;
			while(var23 < var15.length - 1)
			{
				var22[var23] = var15[var23].isTrigger;
				var23 = var23 + 1;
			}
		}
		while(!var18)
		{
			var var24 = null;
			var var25 = 500000;
			for(var k in var16)
			{
				if(var16[k].f < var25)
				{
					var25 = var16[k].f;
					var24 = k;
				}
			}
			var var26 = var16[var24];
			delete register16.register24;
			if(var26.num == var4)
			{
				var var27 = new Array();
				while(var26.num != var3)
				{
					if(var26.m == 0)
					{
						var27 = new Array();
					}
					else if(var9)
					{
						var27.splice(0,0,var26.num);
					}
					else
					{
						var27.splice(0,0,{num:var26.num,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,var26.parent.num,var26.num)});
					}
					var26 = var26.parent;
				}
				if(var10)
				{
					if(var9)
					{
						var27.splice(0,0,var3);
					}
					else
					{
						var27.splice(0,0,{num:var3,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,var26.parent.num,var3)});
					}
				}
				return var27;
			}
			var var28 = false;
			var var29 = 0;
			while(var29 < var12)
			{
				var var30 = var26.num + var13[var29];
				if(Math.abs(var15[var30].x - var15[var26.num].x) <= 53)
				{
					var var31 = var15[var30];
					var28 = !(var30 == var4 && var31.movement == 1)?false:true;
					var var32 = var31.groundLevel;
					var var33 = true;
					if(!var8)
					{
						var33 = var31.spriteOnID == undefined?true:false;
						if(var33 && (var30 != var4 && var22[var30] == true))
						{
							var33 = false;
						}
					}
					if(var33 && (var30 != var4 && var20[var30] == true))
					{
						var33 = false;
					}
					var var34 = var26.l == undefined || Math.abs(var32 - var26.l) < 2;
					if(var34 && (var31.active && var33))
					{
						var var35 = "oCell" + var30;
						var var36 = var26.v + var14[var29] + (!(var31.movement == 0 || var31.movement == 1)?0:1000 + (var29 % 2 != 0?0:3)) + (!(var31.movement == 1 && var28)?(var29 == var26.d?0:0.5) + (5 - var31.movement) / 3:-1000);
						var var37 = var26.g + var14[var29];
						var var38 = null;
						if(var16[var35])
						{
							var38 = var16[var35].v;
						}
						else if(var17[var35])
						{
							var38 = var17[var35].v;
						}
						if((var38 == null || var38 > var36) && var37 <= var7)
						{
							if(var17[var35])
							{
								delete register17.register35;
							}
							var var39 = new Object();
							var39.num = var30;
							var39.g = var37;
							var39.v = var36;
							var39.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,var30,var4);
							var39.f = var39.v + var39.h;
							var39.d = var29;
							var39.l = var32;
							var39.m = var31.movement;
							var39.parent = var26;
							var16[var35] = var39;
						}
					}
				}
				var29 = var29 + 1;
			}
			var17["oCell" + var26.num] = {v:var26.v};
			var18 = true;
			for(var k in var16)
			{
				var18 = false;
				break;
			}
		}
		return null;
	}
	static function goalDistEstimate(mapHandler, §\b\x1d§, §\b\x1c§)
	{
		var var5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var3);
		var var6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var4);
		var var7 = Math.abs(var5.x - var6.x);
		var var8 = Math.abs(var5.y - var6.y);
		return Math.sqrt(Math.pow(var7,2) + Math.pow(var8,2));
	}
	static function goalDistance(mapHandler, §\b\x1d§, §\b\x1c§)
	{
		var var5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var3);
		var var6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var4);
		var var7 = Math.abs(var5.x - var6.x);
		var var8 = Math.abs(var5.y - var6.y);
		return var7 + var8;
	}
	static function getCaseCoordonnee(mapHandler, §\x03\x13§)
	{
		var var4 = mapHandler.getWidth();
		var var5 = Math.floor(var3 / (var4 * 2 - 1));
		var var6 = var3 - var5 * (var4 * 2 - 1);
		var var7 = var6 % var4;
		var var8 = new Object();
		var8.y = var5 - var7;
		var8.x = (var3 - (var4 - 1) * var8.y) / var4;
		return var8;
	}
	static function getDirection(mapHandler, §\b\x1d§, §\b\x1c§)
	{
		var var5 = mapHandler.getWidth();
		var var6 = [1,var5,var5 * 2 - 1,var5 - 1,-1,- var5,- var5 * 2 + 1,- var5 - 1];
		var var7 = var4 - var3;
		var var8 = 7;
		while(var8 >= 0)
		{
			if(var6[var8] == var7)
			{
				return var8;
			}
			var8 = var8 - 1;
		}
		var var9 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var3);
		var var10 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var4);
		var var11 = var10.x - var9.x;
		var var12 = var10.y - var9.y;
		if(var11 == 0)
		{
			if(var12 > 0)
			{
				return 3;
			}
			return 7;
		}
		if(var11 > 0)
		{
			return 1;
		}
		return 5;
	}
	static function getDirectionFromCoordinates(var2, var3, var4, var5, var6)
	{
		var var7 = Math.atan2(var5 - var3,var4 - var2);
		if(var6)
		{
			if(var7 >= (- Math.PI) / 8 && var7 < Math.PI / 8)
			{
				return 0;
			}
			if(var7 >= Math.PI / 8 && var7 < Math.PI / 3)
			{
				return 1;
			}
			if(var7 >= Math.PI / 3 && var7 < 2 * Math.PI / 3)
			{
				return 2;
			}
			if(var7 >= 2 * Math.PI / 3 && var7 < 7 * Math.PI / 8)
			{
				return 3;
			}
			if(var7 >= 7 * Math.PI / 8 || var7 < -7 * Math.PI / 8)
			{
				return 4;
			}
			if(var7 >= -7 * Math.PI / 8 && var7 < -2 * Math.PI / 3)
			{
				return 5;
			}
			if(var7 >= -2 * Math.PI / 3 && var7 < (- Math.PI) / 3)
			{
				return 6;
			}
			if(var7 >= (- Math.PI) / 3 && var7 < (- Math.PI) / 8)
			{
				return 7;
			}
		}
		else
		{
			if(var7 >= 0 && var7 < Math.PI / 2)
			{
				return 1;
			}
			if(var7 >= Math.PI / 2 && var7 <= Math.PI)
			{
				return 3;
			}
			if(var7 >= - Math.PI && var7 < (- Math.PI) / 2)
			{
				return 5;
			}
			if(var7 >= (- Math.PI) / 2 && var7 < 0)
			{
				return 7;
			}
		}
		return 1;
	}
	static function getArroundCellNum(mapHandler, §\b\x18§, §\x07\x0e§, §\x05\x18§)
	{
		var var6 = mapHandler.getWidth();
		var var7 = [1,var6,var6 * 2 - 1,var6 - 1,-1,- var6,- var6 * 2 + 1,- var6 - 1];
		var var8 = 0;
		switch(var5 % 8)
		{
			case 0:
				var8 = 2;
				break;
			case 1:
				var8 = 6;
				break;
			case 2:
				var8 = 4;
				break;
			case 3:
				var8 = 0;
				break;
			default:
				switch(null)
				{
					case 4:
						var8 = 3;
						break;
					case 5:
						var8 = 5;
						break;
					case 6:
						var8 = 1;
						break;
					case 7:
						var8 = 7;
				}
		}
		var8 = (var8 + var4) % 8;
		var var9 = var3 + var7[var8];
		var var10 = mapHandler.getCellsData();
		var var11 = var10[var9];
		if(var11.active && (var10[var9] != undefined && Math.abs(var10[var9].x - var10[var3].x) <= 53))
		{
			return var9;
		}
		return var3;
	}
	static function convertHeightToFourDirection(var2)
	{
		return var2 | 1;
	}
	static function getSlopeOk(var2, var3, var4, var5, var6)
	{
		switch(var6)
		{
			case 0:
				if(((var2 - 1 & 2) >> 1) + var3 != (var4 - 1 & 1) + var5)
				{
					return false;
				}
				break;
			case 1:
				if(((var2 - 1 & 4) >> 2) + var3 != ((var4 - 1 & 2) >> 1) + var5)
				{
					return false;
				}
				if(((var2 - 1 & 8) >> 3) + var3 != (var4 - 1 & 1) + var5)
				{
					return false;
				}
				break;
			case 2:
				if(((var2 - 1 & 8) >> 3) + var3 != ((var4 - 1 & 2) >> 1) + var5)
				{
					return false;
				}
				break;
			default:
				switch(null)
				{
					case 3:
						if(((var2 - 1 & 8) >> 3) + var3 != ((var4 - 1 & 4) >> 2) + var5)
						{
							return false;
						}
						if((var2 - 1 & 1) + var3 != ((var4 - 1 & 2) >> 1) + var5)
						{
							return false;
						}
						break;
					case 4:
						if((var2 - 1 & 1) + var3 != ((var4 - 1 & 4) >> 2) + var5)
						{
							return false;
						}
						break;
					case 5:
						if((var2 - 1 & 1) + var3 != ((var4 - 1 & 8) >> 3) + var5)
						{
							return false;
						}
						if(((var2 - 1 & 2) >> 1) + var3 != ((var4 - 1 & 4) >> 2) + var5)
						{
							return false;
						}
						break;
					case 6:
						if(((var2 - 1 & 2) >> 1) + var3 != ((var4 - 1 & 8) >> 3) + var5)
						{
							return false;
						}
						break;
					case 7:
						if(((var2 - 1 & 2) >> 1) + var3 != (var4 - 1 & 1) + var5)
						{
							return false;
						}
						if(((var2 - 1 & 4) >> 2) + var3 != ((var4 - 1 & 8) >> 3) + var5)
						{
							return false;
						}
						break;
				}
		}
		return true;
	}
	static function checkView(mapHandler, §\x14\x03§, §\x14\x02§)
	{
		var var5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var3);
		var var6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var4);
		var var7 = mapHandler.getCellData(var3);
		var var8 = mapHandler.getCellData(var4);
		var var9 = !var7.spriteOnID?0:1.5;
		var var10 = !var8.spriteOnID?0:1.5;
		var9 = var9 + (!var7.carriedSpriteOnId?0:1.5);
		var10 = var10 + (!var8.carriedSpriteOnId?0:1.5);
		var5.z = mapHandler.getCellHeight(var3) + var9;
		var6.z = mapHandler.getCellHeight(var4) + var10;
		var var11 = var6.z - var5.z;
		var var12 = Math.max(Math.abs(var5.y - var6.y),Math.abs(var5.x - var6.x));
		var var13 = (var5.y - var6.y) / (var5.x - var6.x);
		var var14 = var5.y - var13 * var5.x;
		var var15 = var6.x - var5.x >= 0?1:-1;
		var var16 = var6.y - var5.y >= 0?1:-1;
		var var17 = var5.y;
		var var18 = var5.x;
		var var19 = var6.x * var15;
		var var20 = var6.y * var16;
		var var27 = var5.x + 0.5 * var15;
		while(var27 * var15 <= var19)
		{
			var var25 = var13 * var27 + var14;
			if(var16 > 0)
			{
				var var21 = Math.round(var25);
				var var22 = Math.ceil(var25 - 0.5);
			}
			else
			{
				var21 = Math.ceil(var25 - 0.5);
				var22 = Math.round(var25);
			}
			var var26 = var17;
			while(var26 * var16 <= var22 * var16)
			{
				if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,var27 - var15 / 2,var26,false,var5,var6,var11,var12))
				{
					return false;
				}
				var26 = var26 + var16;
			}
			var17 = var21;
			var27 = var27 + var15;
		}
		var26 = var17;
		while(var26 * var16 <= var6.y * var16)
		{
			if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,var27 - 0.5 * var15,var26,false,var5,var6,var11,var12))
			{
				return false;
			}
			var26 = var26 + var16;
		}
		if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,var27 - 0.5 * var15,var26 - var16,true,var5,var6,var11,var12))
		{
			return false;
		}
		return true;
	}
	static function checkCellView(mapHandler, §\x1e\x0b\x1b§, §\x1e\x0b\x12§, §\x17\n§, §\x1e\x18\x15§, §\x1e\x18\x14§, §\x1e\x0b\f§, §\x12\r§)
	{
		var var10 = ank.battlefield.utils.Pathfinding.getCaseNum(mapHandler,var3,var4);
		var var11 = mapHandler.getCellData(var10);
		var var12 = Math.max(Math.abs(var6.y - var4),Math.abs(var6.x - var3));
		var var13 = var12 / var9 * var8 + var6.z;
		var var14 = mapHandler.getCellHeight(var10);
		var var15 = !(var11.spriteOnID == undefined || (var12 == 0 || (var5 || var7.x == var3 && var7.y == var4)))?true:false;
		if(var11.lineOfSight && (var11.active && (var14 <= var13 && !var15)))
		{
			return true;
		}
		if(var5)
		{
			return true;
		}
		return false;
	}
	static function getCaseNum(mapHandler, §\x1e\x0b\x1b§, §\x1e\x0b\x12§)
	{
		var var5 = mapHandler.getWidth();
		return var3 * var5 + var4 * (var5 - 1);
	}
	static function checkAlign(mapHandler, §\x14\x03§, §\x14\x02§)
	{
		var var5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var3);
		var var6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var4);
		if(var5.x == var6.x)
		{
			return true;
		}
		if(var5.y == var6.y)
		{
			return true;
		}
		return false;
	}
	static function checkRange(mapHandler, §\b\x1d§, §\b\x1c§, §\x18\x0f§, §\x02\x04§, §\x02\x05§, §\x02\x03§)
	{
		var6 = Number(var6);
		var7 = Number(var7);
		var8 = Number(var8);
		if(var7 != 0)
		{
			var7 = var7 + var8;
			var7 = Math.max(var6,var7);
		}
		if(var5)
		{
			if(!ank.battlefield.utils.Pathfinding.checkAlign(mapHandler,var3,var4))
			{
				return false;
			}
		}
		if(ank.battlefield.utils.Pathfinding.goalDistance(mapHandler,var3,var4) > var7 || ank.battlefield.utils.Pathfinding.goalDistance(mapHandler,var3,var4) < var6)
		{
			return false;
		}
		return true;
	}
}
