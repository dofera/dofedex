class ank.battlefield.utils.Pathfinding
{
	function Pathfinding()
	{
	}
	static function pathFind(var2, var3, var4, var5, var6)
	{
		var var7 = var2.datacenter.Game.isFight;
		if(var4 == undefined)
		{
			return null;
		}
		if(var5 == undefined)
		{
			return null;
		}
		if(var7 == undefined)
		{
			var7 = false;
		}
		var var8 = var6.bAllDirections != undefined?var6.bAllDirections:true;
		var var9 = var6.nMaxLength != undefined?var6.nMaxLength:500;
		var var10 = var6.bIgnoreSprites != undefined?var6.bIgnoreSprites:false;
		var var11 = var6.bCellNumOnly != undefined?var6.bCellNumOnly:false;
		var var12 = var6.bWithBeginCellNum != undefined?var6.bWithBeginCellNum:false;
		var var13 = mapHandler.getWidth();
		if(var8)
		{
			var var14 = 8;
			var var15 = [1,var13,var13 * 2 - 1,var13 - 1,-1,- var13,- var13 * 2 + 1,- var13 - 1];
			var var16 = [1.5,1,1.5,1,1.5,1,1.5,1];
		}
		else
		{
			var14 = 4;
			var15 = [var13,var13 - 1,- var13,- var13 - 1];
			var16 = [1,1,1,1];
		}
		var var17 = mapHandler.getCellsData();
		var var18 = new Object();
		var var19 = new Object();
		var var20 = false;
		var var21 = var18["oCell" + var4] = new Object();
		var18["oCell" + var4] = new Object().num = var4;
		var18["oCell" + var4] = new Object().g = 0;
		var18["oCell" + var4] = new Object().v = 0;
		var18["oCell" + var4] = new Object().h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,var4,var5);
		var18["oCell" + var4] = new Object().f = var18["oCell" + var4] = new Object().h;
		var18["oCell" + var4] = new Object().l = var17[var4].groundLevel;
		var18["oCell" + var4] = new Object().m = var17[var4].movement;
		var18["oCell" + var4] = new Object().parent = null;
		var var22 = new Array();
		var var23 = 0;
		while(var23 < var17.length - 1)
		{
			var22[var23] = var17[var23].isUnwalkableLayerObject;
			var23 = var23 + 1;
		}
		var var24 = new Array();
		if(!var10 && !var7)
		{
			var var25 = 0;
			while(var25 < var17.length - 1)
			{
				var24[var25] = var17[var25].isTrigger;
				var25 = var25 + 1;
			}
		}
		while(!var20)
		{
			var var26 = null;
			var var27 = 500000;
			for(var k in var18)
			{
				if(var18[k].f < var27)
				{
					var27 = var18[k].f;
					var26 = k;
				}
			}
			var var28 = var18[var26];
			delete register18.register26;
			if(var28.num == var5)
			{
				var var29 = new Array();
				while(var28.num != var4)
				{
					if(var28.m == 0)
					{
						var29 = new Array();
					}
					else if(var11)
					{
						var29.splice(0,0,var28.num);
					}
					else
					{
						var29.splice(0,0,{num:var28.num,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,var28.parent.num,var28.num)});
					}
					var28 = var28.parent;
				}
				if(var12)
				{
					if(var11)
					{
						var29.splice(0,0,var4);
					}
					else
					{
						var29.splice(0,0,{num:var4,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,var28.parent.num,var4)});
					}
				}
				return var29;
			}
			var var30 = false;
			var var31 = 0;
			while(var31 < var14)
			{
				var var32 = var28.num + var15[var31];
				if(Math.abs(var17[var32].x - var17[var28.num].x) <= 53)
				{
					var var33 = var17[var32];
					var30 = !(var32 == var5 && var33.movement == 1)?false:true;
					var var34 = var33.groundLevel;
					var var35 = true;
					if(!var10)
					{
						var var36 = var33.spriteOnID;
						if(var7)
						{
							var35 = var36 == undefined?true:false;
						}
						else
						{
							var var37 = var2.gfx.spriteHandler.getSprite(var36);
							var35 = !(var37 != undefined && (var37 instanceof dofus.datacenter.Character && var32 != var5))?true:false;
						}
						if(var35 && (var32 != var5 && var24[var32] == true))
						{
							var35 = false;
						}
					}
					if(var35 && (var32 != var5 && var22[var32] == true))
					{
						var35 = false;
					}
					var var38 = var28.l == undefined || Math.abs(var34 - var28.l) < 2;
					if(var38 && (var33.active && var35))
					{
						var var39 = "oCell" + var32;
						var var40 = var28.v + var16[var31] + (!(var33.movement == 0 || var33.movement == 1)?0:1000 + (var31 % 2 != 0?0:3)) + (!(var33.movement == 1 && var30)?(var31 == var28.d?0:0.5) + (5 - var33.movement) / 3:-1000);
						var var41 = var28.g + var16[var31];
						var var42 = null;
						if(var18[var39])
						{
							var42 = var18[var39].v;
						}
						else if(var19[var39])
						{
							var42 = var19[var39].v;
						}
						if((var42 == null || var42 > var40) && var41 <= var9)
						{
							if(var19[var39])
							{
								delete register19.register39;
							}
							var var43 = new Object();
							var43.num = var32;
							var43.g = var41;
							var43.v = var40;
							var43.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,var32,var5);
							var43.f = var43.v + var43.h;
							var43.d = var31;
							var43.l = var34;
							var43.m = var33.movement;
							var43.parent = var28;
							var18[var39] = var43;
						}
					}
				}
				var31 = var31 + 1;
			}
			var19["oCell" + var28.num] = {v:var28.v};
			var20 = true;
			for(var k in var18)
			{
				var20 = false;
				while(§§enumeration() != null)
				{
				}
				break;
			}
		}
		return null;
	}
	static function goalDistEstimate(mapHandler, §\x07\x19§, §\x07\x18§)
	{
		var var5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var3);
		var var6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var4);
		var var7 = Math.abs(var5.x - var6.x);
		var var8 = Math.abs(var5.y - var6.y);
		return Math.sqrt(Math.pow(var7,2) + Math.pow(var8,2));
	}
	static function goalDistance(mapHandler, §\x07\x19§, §\x07\x18§)
	{
		var var5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var3);
		var var6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,var4);
		var var7 = Math.abs(var5.x - var6.x);
		var var8 = Math.abs(var5.y - var6.y);
		return var7 + var8;
	}
	static function getCaseCoordonnee(mapHandler, §\x02\b§)
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
	static function getDirection(mapHandler, §\x07\x19§, §\x07\x18§)
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
	static function getArroundCellNum(mapHandler, §\x07\x14§, §\x06\b§, §\x04\r§)
	{
		var var6 = mapHandler.getWidth();
		var var7 = [1,var6,var6 * 2 - 1,var6 - 1,-1,- var6,- var6 * 2 + 1,- var6 - 1];
		var var8 = 0;
		loop0:
		switch(var5 % 8)
		{
			case 0:
				var8 = 2;
				break;
			case 1:
				var8 = 6;
				break;
			default:
				switch(null)
				{
					case 2:
						var8 = 4;
						break loop0;
					case 3:
						var8 = 0;
						break loop0;
					case 4:
						var8 = 3;
						break loop0;
					case 5:
						var8 = 5;
						break loop0;
					case 6:
						var8 = 1;
						break loop0;
					default:
						if(var0 !== 7)
						{
							break loop0;
						}
						var8 = 7;
						break loop0;
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
			default:
				switch(null)
				{
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
	static function checkView(mapHandler, §\x13\b§, §\x13\x07§)
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
	static function checkCellView(mapHandler, §\x1e\t\x16§, §\x1e\t\r§, §\x16\x19§, §\x1e\x17\x06§, §\x1e\x17\x05§, §\x1e\t\x07§, §\x11\x0f§)
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
	static function getCaseNum(mapHandler, §\x1e\t\x16§, §\x1e\t\r§)
	{
		var var5 = mapHandler.getWidth();
		return var3 * var5 + var4 * (var5 - 1);
	}
	static function checkAlign(mapHandler, §\x13\b§, §\x13\x07§)
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
	static function checkRange(mapHandler, §\x07\x19§, §\x07\x18§, §\x18\x03§, §\x1e\x1e\x15§, §\x1e\x1e\x16§, §\x1e\x1e\x14§)
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
