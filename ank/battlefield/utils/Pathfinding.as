class ank.battlefield.utils.Pathfinding
{
	function Pathfinding()
	{
	}
	static function pathFind(mapHandler, §\b\x1d§, §\b\x1c§, §\x1e\x19\x1d§)
	{
		if(loc3 == undefined)
		{
			return null;
		}
		if(loc4 == undefined)
		{
			return null;
		}
		var loc6 = loc5.bAllDirections != undefined?loc5.bAllDirections:true;
		var loc7 = loc5.nMaxLength != undefined?loc5.nMaxLength:500;
		var loc8 = loc5.bIgnoreSprites != undefined?loc5.bIgnoreSprites:false;
		var loc9 = loc5.bCellNumOnly != undefined?loc5.bCellNumOnly:false;
		var loc10 = loc5.bWithBeginCellNum != undefined?loc5.bWithBeginCellNum:false;
		var loc11 = mapHandler.getWidth();
		if(loc6)
		{
			var loc12 = 8;
			var loc13 = [1,loc11,loc11 * 2 - 1,loc11 - 1,-1,- loc11,- loc11 * 2 + 1,- loc11 - 1];
			var loc14 = [1.5,1,1.5,1,1.5,1,1.5,1];
		}
		else
		{
			loc12 = 4;
			loc13 = [loc11,loc11 - 1,- loc11,- loc11 - 1];
			loc14 = [1,1,1,1];
		}
		var loc15 = mapHandler.getCellsData();
		var loc16 = new Object();
		var loc17 = new Object();
		var loc18 = false;
		var loc19 = loc16["oCell" + loc3] = new Object();
		loc16["oCell" + loc3] = new Object().num = loc3;
		loc16["oCell" + loc3] = new Object().g = 0;
		loc16["oCell" + loc3] = new Object().v = 0;
		loc16["oCell" + loc3] = new Object().h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,loc3,loc4);
		loc16["oCell" + loc3] = new Object().f = loc16["oCell" + loc3] = new Object().h;
		loc16["oCell" + loc3] = new Object().l = loc15[loc3].groundLevel;
		loc16["oCell" + loc3] = new Object().m = loc15[loc3].movement;
		loc16["oCell" + loc3] = new Object().parent = null;
		var loc20 = new Array();
		var loc21 = 0;
		while(loc21 < loc15.length - 1)
		{
			loc20[loc21] = loc15[loc21].isUnwalkableLayerObject;
			loc21 = loc21 + 1;
		}
		var loc22 = new Array();
		if(!loc8)
		{
			var loc23 = 0;
			while(loc23 < loc15.length - 1)
			{
				loc22[loc23] = loc15[loc23].isTrigger;
				loc23 = loc23 + 1;
			}
		}
		while(!loc18)
		{
			var loc24 = null;
			var loc25 = 500000;
			§§enumerate(loc16);
			while((var loc0 = §§enumeration()) != null)
			{
				if(loc16[k].f < loc25)
				{
					loc25 = loc16[k].f;
					loc24 = k;
				}
			}
			var loc26 = loc16[loc24];
			delete register16.register24;
			if(loc26.num == loc4)
			{
				var loc27 = new Array();
				while(loc26.num != loc3)
				{
					if(loc26.m == 0)
					{
						loc27 = new Array();
					}
					else if(loc9)
					{
						loc27.splice(0,0,loc26.num);
					}
					else
					{
						loc27.splice(0,0,{num:loc26.num,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,loc26.parent.num,loc26.num)});
					}
					loc26 = loc26.parent;
				}
				if(loc10)
				{
					if(loc9)
					{
						loc27.splice(0,0,loc3);
					}
					else
					{
						loc27.splice(0,0,{num:loc3,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,loc26.parent.num,loc3)});
					}
				}
				return loc27;
			}
			var loc28 = false;
			var loc29 = 0;
			while(loc29 < loc12)
			{
				var loc30 = loc26.num + loc13[loc29];
				if(Math.abs(loc15[loc30].x - loc15[loc26.num].x) <= 53)
				{
					var loc31 = loc15[loc30];
					loc28 = !(loc30 == loc4 && loc31.movement == 1)?false:true;
					var loc32 = loc31.groundLevel;
					var loc33 = true;
					if(!loc8)
					{
						loc33 = loc31.spriteOnID == undefined?true:false;
						if(loc33 && (loc30 != loc4 && loc22[loc30] == true))
						{
							loc33 = false;
						}
					}
					if(loc33 && (loc30 != loc4 && loc20[loc30] == true))
					{
						loc33 = false;
					}
					var loc34 = loc26.l == undefined || Math.abs(loc32 - loc26.l) < 2;
					if(loc34 && (loc31.active && loc33))
					{
						var loc35 = "oCell" + loc30;
						var loc36 = loc26.v + loc14[loc29] + (!(loc31.movement == 0 || loc31.movement == 1)?0:1000 + (loc29 % 2 != 0?0:3)) + (!(loc31.movement == 1 && loc28)?(loc29 == loc26.d?0:0.5) + (5 - loc31.movement) / 3:-1000);
						var loc37 = loc26.g + loc14[loc29];
						var loc38 = null;
						if(loc16[loc35])
						{
							loc38 = loc16[loc35].v;
						}
						else if(loc17[loc35])
						{
							loc38 = loc17[loc35].v;
						}
						if((loc38 == null || loc38 > loc36) && loc37 <= loc7)
						{
							if(loc17[loc35])
							{
								delete register17.register35;
							}
							var loc39 = new Object();
							loc39.num = loc30;
							loc39.g = loc37;
							loc39.v = loc36;
							loc39.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,loc30,loc4);
							loc39.f = loc39.v + loc39.h;
							loc39.d = loc29;
							loc39.l = loc32;
							loc39.m = loc31.movement;
							loc39.parent = loc26;
							loc16[loc35] = loc39;
						}
					}
				}
				loc29 = loc29 + 1;
			}
			loc17["oCell" + loc26.num] = {v:loc26.v};
			loc18 = true;
			for(var loc18 in loc16)
			{
				break;
			}
		}
		return null;
	}
	static function goalDistEstimate(mapHandler, §\t\x02§, §\t\x01§)
	{
		var loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc3);
		var loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc4);
		var loc7 = Math.abs(loc5.x - loc6.x);
		var loc8 = Math.abs(loc5.y - loc6.y);
		return Math.sqrt(Math.pow(loc7,2) + Math.pow(loc8,2));
	}
	static function goalDistance(mapHandler, §\t\x02§, §\t\x01§)
	{
		var loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc3);
		var loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc4);
		var loc7 = Math.abs(loc5.x - loc6.x);
		var loc8 = Math.abs(loc5.y - loc6.y);
		return loc7 + loc8;
	}
	static function getCaseCoordonnee(mapHandler, §\x03\x15§)
	{
		var loc4 = mapHandler.getWidth();
		var loc5 = Math.floor(loc3 / (loc4 * 2 - 1));
		var loc6 = loc3 - loc5 * (loc4 * 2 - 1);
		var loc7 = loc6 % loc4;
		var loc8 = new Object();
		loc8.y = loc5 - loc7;
		loc8.x = (loc3 - (loc4 - 1) * loc8.y) / loc4;
		return loc8;
	}
	static function getDirection(mapHandler, §\t\x02§, §\t\x01§)
	{
		var loc5 = mapHandler.getWidth();
		var loc6 = [1,loc5,loc5 * 2 - 1,loc5 - 1,-1,- loc5,- loc5 * 2 + 1,- loc5 - 1];
		var loc7 = loc4 - loc3;
		var loc8 = 7;
		while(loc8 >= 0)
		{
			if(loc6[loc8] == loc7)
			{
				return loc8;
			}
			loc8 = loc8 - 1;
		}
		var loc9 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc3);
		var loc10 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc4);
		var loc11 = loc10.x - loc9.x;
		var loc12 = loc10.y - loc9.y;
		if(loc11 == 0)
		{
			if(loc12 > 0)
			{
				return 3;
			}
			return 7;
		}
		if(loc11 > 0)
		{
			return 1;
		}
		return 5;
	}
	static function getDirectionFromCoordinates(loc2, loc3, loc4, loc5, loc6)
	{
		var loc7 = Math.atan2(loc5 - loc3,loc4 - loc2);
		if(loc6)
		{
			if(loc7 >= (- Math.PI) / 8 && loc7 < Math.PI / 8)
			{
				return 0;
			}
			if(loc7 >= Math.PI / 8 && loc7 < Math.PI / 3)
			{
				return 1;
			}
			if(loc7 >= Math.PI / 3 && loc7 < 2 * Math.PI / 3)
			{
				return 2;
			}
			if(loc7 >= 2 * Math.PI / 3 && loc7 < 7 * Math.PI / 8)
			{
				return 3;
			}
			if(loc7 >= 7 * Math.PI / 8 || loc7 < -7 * Math.PI / 8)
			{
				return 4;
			}
			if(loc7 >= -7 * Math.PI / 8 && loc7 < -2 * Math.PI / 3)
			{
				return 5;
			}
			if(loc7 >= -2 * Math.PI / 3 && loc7 < (- Math.PI) / 3)
			{
				return 6;
			}
			if(loc7 >= (- Math.PI) / 3 && loc7 < (- Math.PI) / 8)
			{
				return 7;
			}
		}
		else
		{
			if(loc7 >= 0 && loc7 < Math.PI / 2)
			{
				return 1;
			}
			if(loc7 >= Math.PI / 2 && loc7 <= Math.PI)
			{
				return 3;
			}
			if(loc7 >= - Math.PI && loc7 < (- Math.PI) / 2)
			{
				return 5;
			}
			if(loc7 >= (- Math.PI) / 2 && loc7 < 0)
			{
				return 7;
			}
		}
		return 1;
	}
	static function getArroundCellNum(mapHandler, §\b\x1a§, §\x07\x10§, §\x05\x1a§)
	{
		var loc6 = mapHandler.getWidth();
		var loc7 = [1,loc6,loc6 * 2 - 1,loc6 - 1,-1,- loc6,- loc6 * 2 + 1,- loc6 - 1];
		var loc8 = 0;
		switch(loc5 % 8)
		{
			case 0:
				loc8 = 2;
				break;
			case 1:
				loc8 = 6;
				break;
			case 2:
				loc8 = 4;
				break;
			default:
				switch(null)
				{
					case 3:
						loc8 = 0;
						break;
					case 4:
						loc8 = 3;
						break;
					case 5:
						loc8 = 5;
						break;
					case 6:
						loc8 = 1;
						break;
					case 7:
						loc8 = 7;
				}
		}
		loc8 = (loc8 + loc4) % 8;
		var loc9 = loc3 + loc7[loc8];
		var loc10 = mapHandler.getCellsData();
		var loc11 = loc10[loc9];
		if(loc11.active && (loc10[loc9] != undefined && Math.abs(loc10[loc9].x - loc10[loc3].x) <= 53))
		{
			return loc9;
		}
		return loc3;
	}
	static function convertHeightToFourDirection(loc2)
	{
		return loc2 | 1;
	}
	static function getSlopeOk(loc2, loc3, loc4, loc5, loc6)
	{
		switch(loc6)
		{
			case 0:
				if(((loc2 - 1 & 2) >> 1) + loc3 != (loc4 - 1 & 1) + loc5)
				{
					return false;
				}
				break;
			case 1:
				if(((loc2 - 1 & 4) >> 2) + loc3 != ((loc4 - 1 & 2) >> 1) + loc5)
				{
					return false;
				}
				if(((loc2 - 1 & 8) >> 3) + loc3 != (loc4 - 1 & 1) + loc5)
				{
					return false;
				}
				break;
			case 2:
				if(((loc2 - 1 & 8) >> 3) + loc3 != ((loc4 - 1 & 2) >> 1) + loc5)
				{
					return false;
				}
				break;
			default:
				switch(null)
				{
					case 3:
						if(((loc2 - 1 & 8) >> 3) + loc3 != ((loc4 - 1 & 4) >> 2) + loc5)
						{
							return false;
						}
						if((loc2 - 1 & 1) + loc3 != ((loc4 - 1 & 2) >> 1) + loc5)
						{
							return false;
						}
						break;
					case 4:
						if((loc2 - 1 & 1) + loc3 != ((loc4 - 1 & 4) >> 2) + loc5)
						{
							return false;
						}
						break;
					case 5:
						if((loc2 - 1 & 1) + loc3 != ((loc4 - 1 & 8) >> 3) + loc5)
						{
							return false;
						}
						if(((loc2 - 1 & 2) >> 1) + loc3 != ((loc4 - 1 & 4) >> 2) + loc5)
						{
							return false;
						}
						break;
					case 6:
						if(((loc2 - 1 & 2) >> 1) + loc3 != ((loc4 - 1 & 8) >> 3) + loc5)
						{
							return false;
						}
						break;
					case 7:
						if(((loc2 - 1 & 2) >> 1) + loc3 != (loc4 - 1 & 1) + loc5)
						{
							return false;
						}
						if(((loc2 - 1 & 4) >> 2) + loc3 != ((loc4 - 1 & 8) >> 3) + loc5)
						{
							return false;
						}
						break;
				}
		}
		return true;
	}
	static function checkView(mapHandler, §\x14\x05§, §\x14\x04§)
	{
		var loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc3);
		var loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc4);
		var loc7 = mapHandler.getCellData(loc3);
		var loc8 = mapHandler.getCellData(loc4);
		var loc9 = !loc7.spriteOnID?0:1.5;
		var loc10 = !loc8.spriteOnID?0:1.5;
		loc9 = loc9 + (!loc7.carriedSpriteOnId?0:1.5);
		loc10 = loc10 + (!loc8.carriedSpriteOnId?0:1.5);
		loc5.z = mapHandler.getCellHeight(loc3) + loc9;
		loc6.z = mapHandler.getCellHeight(loc4) + loc10;
		var loc11 = loc6.z - loc5.z;
		var loc12 = Math.max(Math.abs(loc5.y - loc6.y),Math.abs(loc5.x - loc6.x));
		var loc13 = (loc5.y - loc6.y) / (loc5.x - loc6.x);
		var loc14 = loc5.y - loc13 * loc5.x;
		var loc15 = loc6.x - loc5.x >= 0?1:-1;
		var loc16 = loc6.y - loc5.y >= 0?1:-1;
		var loc17 = loc5.y;
		var loc18 = loc5.x;
		var loc19 = loc6.x * loc15;
		var loc20 = loc6.y * loc16;
		var loc27 = loc5.x + 0.5 * loc15;
		while(loc27 * loc15 <= loc19)
		{
			var loc25 = loc13 * loc27 + loc14;
			if(loc16 > 0)
			{
				var loc21 = Math.round(loc25);
				var loc22 = Math.ceil(loc25 - 0.5);
			}
			else
			{
				loc21 = Math.ceil(loc25 - 0.5);
				loc22 = Math.round(loc25);
			}
			var loc26 = loc17;
			while(loc26 * loc16 <= loc22 * loc16)
			{
				if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,loc27 - loc15 / 2,loc26,false,loc5,loc6,loc11,loc12))
				{
					return false;
				}
				loc26 = loc26 + loc16;
			}
			loc17 = loc21;
			loc27 = loc27 + loc15;
		}
		loc26 = loc17;
		while(loc26 * loc16 <= loc6.y * loc16)
		{
			if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,loc27 - 0.5 * loc15,loc26,false,loc5,loc6,loc11,loc12))
			{
				return false;
			}
			loc26 = loc26 + loc16;
		}
		if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,loc27 - 0.5 * loc15,loc26 - loc16,true,loc5,loc6,loc11,loc12))
		{
			return false;
		}
		return true;
	}
	static function checkCellView(mapHandler, §\x1e\x0b\x1d§, §\x1e\x0b\x14§, §\x17\x0b§, §\x1e\x18\x17§, §\x1e\x18\x16§, §\x1e\x0b\x0f§, §\x12\x0f§)
	{
		var loc10 = ank.battlefield.utils.Pathfinding.getCaseNum(mapHandler,loc3,loc4);
		var loc11 = mapHandler.getCellData(loc10);
		var loc12 = Math.max(Math.abs(loc6.y - loc4),Math.abs(loc6.x - loc3));
		var loc13 = loc12 / loc9 * loc8 + loc6.z;
		var loc14 = mapHandler.getCellHeight(loc10);
		var loc15 = !(loc11.spriteOnID == undefined || (loc12 == 0 || (loc5 || loc7.x == loc3 && loc7.y == loc4)))?true:false;
		if(loc11.lineOfSight && (loc11.active && (loc14 <= loc13 && !loc15)))
		{
			return true;
		}
		if(loc5)
		{
			return true;
		}
		return false;
	}
	static function getCaseNum(mapHandler, §\x1e\x0b\x1d§, §\x1e\x0b\x14§)
	{
		var loc5 = mapHandler.getWidth();
		return loc3 * loc5 + loc4 * (loc5 - 1);
	}
	static function checkAlign(mapHandler, §\x14\x05§, §\x14\x04§)
	{
		var loc5 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc3);
		var loc6 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,loc4);
		if(loc5.x == loc6.x)
		{
			return true;
		}
		if(loc5.y == loc6.y)
		{
			return true;
		}
		return false;
	}
	static function checkRange(mapHandler, §\t\x02§, §\t\x01§, §\x18\x10§, §\x02\x06§, §\x02\x07§, §\x02\x05§)
	{
		loc6 = Number(loc6);
		loc7 = Number(loc7);
		loc8 = Number(loc8);
		if(loc7 != 0)
		{
			loc7 = loc7 + loc8;
			loc7 = Math.max(loc6,loc7);
		}
		if(loc5)
		{
			if(!ank.battlefield.utils.Pathfinding.checkAlign(mapHandler,loc3,loc4))
			{
				return false;
			}
		}
		if(ank.battlefield.utils.Pathfinding.goalDistance(mapHandler,loc3,loc4) > loc7 || ank.battlefield.utils.Pathfinding.goalDistance(mapHandler,loc3,loc4) < loc6)
		{
			return false;
		}
		return true;
	}
}
