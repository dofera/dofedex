class ank.battlefield.utils.Compressor extends ank.utils.Compressor
{
	function Compressor()
	{
		super();
	}
	static function uncompressMap(var2, var3, var4, var5, var6, var7, var8, var9)
	{
		if(var8 == undefined)
		{
			return undefined;
		}
		var var10 = new Array();
		var var11 = var7.length;
		var var13 = 0;
		var var14 = 0;
		while(var14 < var11)
		{
			var var12 = ank.battlefield.utils.Compressor.uncompressCell(var7.substring(var14,var14 + 10),var9,0);
			var12.num = var13;
			var10.push(var12);
			var13 = var13 + 1;
			var14 = var14 + 10;
		}
		var8.id = Number(var2);
		var8.name = var3;
		var8.width = Number(var4);
		var8.height = Number(var5);
		var8.backgroundNum = var6;
		var8.data = var10;
	}
	static function uncompressCell(§\x1e\x13\x04§, §\x19\x19§, nPermanentLevel)
	{
		if(var3 == undefined)
		{
			var3 = false;
		}
		if(nPermanentLevel == undefined)
		{
			nPermanentLevel = 0;
		}
		else
		{
			nPermanentLevel = Number(nPermanentLevel);
		}
		var var5 = new ank.battlefield.datacenter.
();
		var var6 = var2.split("");
		var var7 = var6.length - 1;
		var var8 = new Array();
		while(var7 >= 0)
		{
			var8[var7] = ank.utils.Compressor._self._hashCodes[var6[var7]];
			var7 = var7 - 1;
		}
		var5.active = !((var8[0] & 32) >> 5)?false:true;
		if(var5.active || var3)
		{
			var5.nPermanentLevel = nPermanentLevel;
			var5.lineOfSight = !(var8[0] & 1)?false:true;
			var5.layerGroundRot = (var8[1] & 48) >> 4;
			var5.groundLevel = var8[1] & 15;
			var5.movement = (var8[2] & 56) >> 3;
			var5.layerGroundNum = ((var8[0] & 24) << 6) + ((var8[2] & 7) << 6) + var8[3];
			var5.groundSlope = (var8[4] & 60) >> 2;
			var5.layerGroundFlip = !((var8[4] & 2) >> 1)?false:true;
			var5.layerObject1Num = ((var8[0] & 4) << 11) + ((var8[4] & 1) << 12) + (var8[5] << 6) + var8[6];
			var5.layerObject1Rot = (var8[7] & 48) >> 4;
			var5.layerObject1Flip = !((var8[7] & 8) >> 3)?false:true;
			var5.layerObject2Flip = !((var8[7] & 4) >> 2)?false:true;
			var5.layerObject2Interactive = !((var8[7] & 2) >> 1)?false:true;
			var5.layerObject2Num = ((var8[0] & 2) << 12) + ((var8[7] & 1) << 12) + (var8[8] << 6) + var8[9];
			var5.layerObjectExternal = "";
			var5.layerObjectExternalInteractive = false;
		}
		return var5;
	}
	static function compressMap(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		var var3 = new Array();
		var var4 = var2.data;
		var var5 = var4.length;
		var var6 = 0;
		while(var6 < var5)
		{
			var3.push(ank.battlefield.utils.Compressor.compressCell(var4[var6]));
			var6 = var6 + 1;
		}
		return var3.join("");
	}
	static function compressCell(var2)
	{
		var var4 = new Array(0,0,0,0,0,0,0,0,0,0);
		var4[0] = (!var2.active?0:1) << 5;
		var4[0] = var4[0] | (!var2.lineOfSight?0:1);
		var4[0] = var4[0] | (var2.layerGroundNum & 1536) >> 6;
		var4[0] = var4[0] | (var2.layerObject1Num & 8192) >> 11;
		var4[0] = var4[0] | (var2.layerObject2Num & 8192) >> 12;
		var4[1] = (var2.layerGroundRot & 3) << 4;
		var4[1] = var4[1] | var2.groundLevel & 15;
		var4[2] = (var2.movement & 7) << 3;
		var4[2] = var4[2] | var2.layerGroundNum >> 6 & 7;
		var4[3] = var2.layerGroundNum & 63;
		var4[4] = (var2.groundSlope & 15) << 2;
		var4[4] = var4[4] | (!var2.layerGroundFlip?0:1) << 1;
		var4[4] = var4[4] | var2.layerObject1Num >> 12 & 1;
		var4[5] = var2.layerObject1Num >> 6 & 63;
		var4[6] = var2.layerObject1Num & 63;
		var4[7] = (var2.layerObject1Rot & 3) << 4;
		var4[7] = var4[7] | (!var2.layerObject1Flip?0:1) << 3;
		var4[7] = var4[7] | (!var2.layerObject2Flip?0:1) << 2;
		var4[7] = var4[7] | (!var2.layerObject2Interactive?0:1) << 1;
		var4[7] = var4[7] | var2.layerObject2Num >> 12 & 1;
		var4[8] = var2.layerObject2Num >> 6 & 63;
		var4[9] = var2.layerObject2Num & 63;
		var var5 = var4.length - 1;
		while(var5 >= 0)
		{
			var4[var5] = ank.utils.Compressor.encode64(var4[var5]);
			var5 = var5 - 1;
		}
		var var3 = var4.join("");
		return var3;
	}
	static function compressPath(var2, var3)
	{
		var var4 = new String();
		var var5 = ank.battlefield.utils.Compressor.makeLightPath(var2,var3);
		var var11 = var5.length;
		var var6 = 0;
		while(var6 < var11)
		{
			var var7 = var5[var6];
			var var8 = var7.dir & 7;
			var var9 = (var7.num & 4032) >> 6;
			var var10 = var7.num & 63;
			var4 = var4 + ank.utils.Compressor.encode64(var8);
			var4 = var4 + ank.utils.Compressor.encode64(var9);
			var4 = var4 + ank.utils.Compressor.encode64(var10);
			var6 = var6 + 1;
		}
		return var4;
	}
	static function makeLightPath(var2, var3)
	{
		if(var2 == undefined)
		{
			ank.utils.Logger.err("Le chemin est vide");
			return new Array();
		}
		var var4 = new Array();
		if(var3)
		{
			var4.push(var2[0]);
		}
		var var6 = var2.length - 1;
		while(var6 >= 0)
		{
			if(var2[var6].dir != var5)
			{
				var4.splice(0,0,var2[var6]);
				var var5 = var2[var6].dir;
			}
			var6 = var6 - 1;
		}
		return var4;
	}
	static function extractFullPath(mapHandler, §\x12\x0f§)
	{
		var var4 = new Array();
		var var5 = var3.split("");
		var var7 = var3.length;
		var var8 = mapHandler.getCellCount();
		var var6 = 0;
		while(var6 < var7)
		{
			var5[var6] = ank.utils.Compressor.decode64(var5[var6]);
			var5[var6 + 1] = ank.utils.Compressor.decode64(var5[var6 + 1]);
			var5[var6 + 2] = ank.utils.Compressor.decode64(var5[var6 + 2]);
			var var9 = (var5[var6 + 1] & 15) << 6 | var5[var6 + 2];
			if(var9 < 0)
			{
				ank.utils.Logger.err("Case pas sur carte");
				return null;
			}
			if(var9 > var8)
			{
				ank.utils.Logger.err("Case pas sur carte");
				return null;
			}
			var4.push({num:var9,dir:var5[var6]});
			var6 = var6 + 3;
		}
		return ank.battlefield.utils.Compressor.makeFullPath(mapHandler,var4);
	}
	static function makeFullPath(mapHandler, §\x1e\r§)
	{
		var var4 = new Array();
		var var6 = 0;
		var var7 = mapHandler.getWidth();
		var var8 = [1,var7,var7 * 2 - 1,var7 - 1,-1,- var7,- var7 * 2 + 1,- var7 - 1];
		var var5 = var3[0].num;
		var4[var6] = var5;
		var var9 = 1;
		while(var9 < var3.length)
		{
			var var10 = var3[var9].num;
			var var11 = var3[var9].dir;
			var var12 = 2 * var7 + 1;
			while(var4[var6] != var10)
			{
				var5 = var5 + var8[var11];
				var4[var6 = var6 + 1] = var5;
				if((var12 = var12 - 1) < 0)
				{
					ank.utils.Logger.err("Chemin impossible");
					return null;
				}
			}
			var5 = var10;
			var9 = var9 + 1;
		}
		return var4;
	}
}
