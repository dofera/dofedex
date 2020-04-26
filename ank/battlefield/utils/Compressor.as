class ank.battlefield.utils.Compressor extends ank.utils.Compressor
{
	function Compressor()
	{
		super();
	}
	static function uncompressMap(loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9)
	{
		if(loc8 == undefined)
		{
			return undefined;
		}
		var loc10 = new Array();
		var loc11 = loc7.length;
		var loc13 = 0;
		var loc14 = 0;
		while(loc14 < loc11)
		{
			var loc12 = ank.battlefield.utils.Compressor.uncompressCell(loc7.substring(loc14,loc14 + 10),loc9,0);
			loc12.num = loc13;
			loc10.push(loc12);
			loc13 = loc13 + 1;
			loc14 = loc14 + 10;
		}
		loc8.id = Number(loc2);
		loc8.name = loc3;
		loc8.width = Number(loc4);
		loc8.height = Number(loc5);
		loc8.backgroundNum = loc6;
		loc8.data = loc10;
	}
	static function uncompressCell(§\x1e\x14\x19§, §\x1a\x07§, nPermanentLevel)
	{
		if(loc3 == undefined)
		{
			loc3 = false;
		}
		if(nPermanentLevel == undefined)
		{
			nPermanentLevel = 0;
		}
		else
		{
			nPermanentLevel = Number(nPermanentLevel);
		}
		var loc5 = new ank.battlefield.datacenter.();
		var loc6 = loc2.split("");
		var loc7 = loc6.length - 1;
		var loc8 = new Array();
		while(loc7 >= 0)
		{
			loc8[loc7] = ank.utils.Compressor._self._hashCodes[loc6[loc7]];
			loc7 = loc7 - 1;
		}
		loc5.active = !((loc8[0] & 32) >> 5)?false:true;
		if(loc5.active || loc3)
		{
			loc5.nPermanentLevel = nPermanentLevel;
			loc5.lineOfSight = !(loc8[0] & 1)?false:true;
			loc5.layerGroundRot = (loc8[1] & 48) >> 4;
			loc5.groundLevel = loc8[1] & 15;
			loc5.movement = (loc8[2] & 56) >> 3;
			loc5.layerGroundNum = ((loc8[0] & 24) << 6) + ((loc8[2] & 7) << 6) + loc8[3];
			loc5.groundSlope = (loc8[4] & 60) >> 2;
			loc5.layerGroundFlip = !((loc8[4] & 2) >> 1)?false:true;
			loc5.layerObject1Num = ((loc8[0] & 4) << 11) + ((loc8[4] & 1) << 12) + (loc8[5] << 6) + loc8[6];
			loc5.layerObject1Rot = (loc8[7] & 48) >> 4;
			loc5.layerObject1Flip = !((loc8[7] & 8) >> 3)?false:true;
			loc5.layerObject2Flip = !((loc8[7] & 4) >> 2)?false:true;
			loc5.layerObject2Interactive = !((loc8[7] & 2) >> 1)?false:true;
			loc5.layerObject2Num = ((loc8[0] & 2) << 12) + ((loc8[7] & 1) << 12) + (loc8[8] << 6) + loc8[9];
			loc5.layerObjectExternal = "";
			loc5.layerObjectExternalInteractive = false;
		}
		return loc5;
	}
	static function compressMap(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		var loc3 = new Array();
		var loc4 = loc2.data;
		var loc5 = loc4.length;
		var loc6 = 0;
		while(loc6 < loc5)
		{
			loc3.push(ank.battlefield.utils.Compressor.compressCell(loc4[loc6]));
			loc6 = loc6 + 1;
		}
		return loc3.join("");
	}
	static function compressCell(loc2)
	{
		var loc4 = new Array(0,0,0,0,0,0,0,0,0,0);
		loc4[0] = (!loc2.active?0:1) << 5;
		loc4[0] = loc4[0] | (!loc2.lineOfSight?0:1);
		loc4[0] = loc4[0] | (loc2.layerGroundNum & 1536) >> 6;
		loc4[0] = loc4[0] | (loc2.layerObject1Num & 8192) >> 11;
		loc4[0] = loc4[0] | (loc2.layerObject2Num & 8192) >> 12;
		loc4[1] = (loc2.layerGroundRot & 3) << 4;
		loc4[1] = loc4[1] | loc2.groundLevel & 15;
		loc4[2] = (loc2.movement & 7) << 3;
		loc4[2] = loc4[2] | loc2.layerGroundNum >> 6 & 7;
		loc4[3] = loc2.layerGroundNum & 63;
		loc4[4] = (loc2.groundSlope & 15) << 2;
		loc4[4] = loc4[4] | (!loc2.layerGroundFlip?0:1) << 1;
		loc4[4] = loc4[4] | loc2.layerObject1Num >> 12 & 1;
		loc4[5] = loc2.layerObject1Num >> 6 & 63;
		loc4[6] = loc2.layerObject1Num & 63;
		loc4[7] = (loc2.layerObject1Rot & 3) << 4;
		loc4[7] = loc4[7] | (!loc2.layerObject1Flip?0:1) << 3;
		loc4[7] = loc4[7] | (!loc2.layerObject2Flip?0:1) << 2;
		loc4[7] = loc4[7] | (!loc2.layerObject2Interactive?0:1) << 1;
		loc4[7] = loc4[7] | loc2.layerObject2Num >> 12 & 1;
		loc4[8] = loc2.layerObject2Num >> 6 & 63;
		loc4[9] = loc2.layerObject2Num & 63;
		var loc5 = loc4.length - 1;
		while(loc5 >= 0)
		{
			loc4[loc5] = ank.utils.Compressor.encode64(loc4[loc5]);
			loc5 = loc5 - 1;
		}
		var loc3 = loc4.join("");
		return loc3;
	}
	static function compressPath(loc2, loc3)
	{
		var loc4 = new String();
		var loc5 = ank.battlefield.utils.Compressor.makeLightPath(loc2,loc3);
		var loc11 = loc5.length;
		var loc6 = 0;
		while(loc6 < loc11)
		{
			var loc7 = loc5[loc6];
			var loc8 = loc7.dir & 7;
			var loc9 = (loc7.num & 4032) >> 6;
			var loc10 = loc7.num & 63;
			loc4 = loc4 + ank.utils.Compressor.encode64(loc8);
			loc4 = loc4 + ank.utils.Compressor.encode64(loc9);
			loc4 = loc4 + ank.utils.Compressor.encode64(loc10);
			loc6 = loc6 + 1;
		}
		return loc4;
	}
	static function makeLightPath(loc2, loc3)
	{
		if(loc2 == undefined)
		{
			ank.utils.Logger.err("Le chemin est vide");
			return new Array();
		}
		var loc4 = new Array();
		if(loc3)
		{
			loc4.push(loc2[0]);
		}
		var loc6 = loc2.length - 1;
		while(loc6 >= 0)
		{
			if(loc2[loc6].dir != loc5)
			{
				loc4.splice(0,0,loc2[loc6]);
				var loc5 = loc2[loc6].dir;
			}
			loc6 = loc6 - 1;
		}
		return loc4;
	}
	static function extractFullPath(mapHandler, §\x13\x0e§)
	{
		var loc4 = new Array();
		var loc5 = loc3.split("");
		var loc7 = loc3.length;
		var loc8 = mapHandler.getCellCount();
		var loc6 = 0;
		while(loc6 < loc7)
		{
			loc5[loc6] = ank.utils.Compressor.decode64(loc5[loc6]);
			loc5[loc6 + 1] = ank.utils.Compressor.decode64(loc5[loc6 + 1]);
			loc5[loc6 + 2] = ank.utils.Compressor.decode64(loc5[loc6 + 2]);
			var loc9 = (loc5[loc6 + 1] & 15) << 6 | loc5[loc6 + 2];
			if(loc9 < 0)
			{
				ank.utils.Logger.err("Case pas sur carte");
				return null;
			}
			if(loc9 > loc8)
			{
				ank.utils.Logger.err("Case pas sur carte");
				return null;
			}
			loc4.push({num:loc9,dir:loc5[loc6]});
			loc6 = loc6 + 3;
		}
		return ank.battlefield.utils.Compressor.makeFullPath(mapHandler,loc4);
	}
	static function makeFullPath(mapHandler, §\x1e\x0e§)
	{
		var loc4 = new Array();
		var loc6 = 0;
		var loc7 = mapHandler.getWidth();
		var loc8 = [1,loc7,loc7 * 2 - 1,loc7 - 1,-1,- loc7,- loc7 * 2 + 1,- loc7 - 1];
		var loc5 = loc3[0].num;
		loc4[loc6] = loc5;
		var loc9 = 1;
		while(loc9 < loc3.length)
		{
			var loc10 = loc3[loc9].num;
			var loc11 = loc3[loc9].dir;
			var loc12 = 2 * loc7 + 1;
			while(loc4[loc6] != loc10)
			{
				loc5 = loc5 + loc8[loc11];
				loc4[loc6 = loc6 + 1] = loc5;
				if((loc12 = loc12 - 1) < 0)
				{
					ank.utils.Logger.err("Chemin impossible");
					return null;
				}
			}
			loc5 = loc10;
			loc9 = loc9 + 1;
		}
		return loc4;
	}
}
