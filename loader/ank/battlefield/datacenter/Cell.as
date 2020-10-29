class ank.battlefield.datacenter.Cell extends Object
{
	var active = true;
	var lineOfSight = true;
	var layerGroundRot = 0;
	var groundLevel = 7;
	var movement = 4;
	var layerGroundNum = 0;
	var groundSlope = 1;
	var layerGroundFlip = false;
	var layerObject1Num = 0;
	var layerObject1Rot = 0;
	var layerObject1Flip = false;
	var layerObject2Flip = false;
	var layerObject2Interactive = false;
	var layerObject2Num = 0;
	function Cell()
	{
		super();
	}
	function __get__rootY()
	{
		return this.y - (7 - this.groundLevel) * ank.battlefield.Constants.LEVEL_HEIGHT;
	}
	function __get__isTrigger()
	{
		var var2 = false;
		var var3 = 0;
		while(var3 < dofus.Constants.MAP_TRIGGER_LAYEROBJECTS.length)
		{
			var var4 = dofus.Constants.MAP_TRIGGER_LAYEROBJECTS[var3];
			if(this.layerObject1Num == var4 || this.layerObject2Num == var4)
			{
				var2 = true;
				break;
			}
			var3 = var3 + 1;
		}
		return var2;
	}
	function __get__isUnwalkableLayerObject()
	{
		var var2 = false;
		var var3 = 0;
		while(var3 < dofus.Constants.MAP_UNWALKABLE_LAYEROBJECTS.length)
		{
			var var4 = dofus.Constants.MAP_UNWALKABLE_LAYEROBJECTS[var3];
			if(this.layerObject1Num == var4 || this.layerObject2Num == var4)
			{
				var2 = true;
				break;
			}
			var3 = var3 + 1;
		}
		return var2;
	}
	function __get__isTactic()
	{
		var var2 = false;
		if(this.layerGroundNum == 0 && (this.groundSlope == 1 && (this.layerObject2Num == 0 || (this.layerObject2Num == 25 || this.layerObject2Num == 1030))))
		{
			if(!this.lineOfSight)
			{
				if(this.layerObject1Num == 10000)
				{
					var2 = true;
				}
			}
			else if(this.movement == 0 || this.movement == 1)
			{
				if(this.layerObject1Num == 10002)
				{
					var2 = true;
				}
			}
			else if(this.layerObject1Num == 10001)
			{
				var2 = true;
			}
		}
		return var2;
	}
	function addSpriteOnID(sID)
	{
		if(this.allSpritesOn == undefined)
		{
			this.allSpritesOn = new Object();
		}
		if(sID == undefined)
		{
			return undefined;
		}
		if(this.allSpritesOn[sID])
		{
			return undefined;
		}
		this.allSpritesOn[sID] = true;
	}
	function removeSpriteOnID(sID)
	{
		this.allSpritesOn[sID] = undefined;
		delete this.allSpritesOn.sID;
	}
	function removeAllSpritesOnID()
	{
		for(this.allSpritesOn[k] in this.allSpritesOn)
		{
			delete this.allSpritesOn.k;
		}
		delete this.allSpritesOn;
	}
	function __get__spriteOnCount()
	{
		var var2 = 0;
		for(var k in this.allSpritesOn)
		{
			var2 = var2 + 1;
		}
		return var2;
	}
	function __get__spriteOnID()
	{
		if(this.allSpritesOn == undefined)
		{
			return undefined;
		}
		for(var k in this.allSpritesOn)
		{
			if(this.allSpritesOn[k])
			{
				return String(k);
			}
		}
		return undefined;
	}
	function __get__carriedSpriteOnId()
	{
		if(this.allSpritesOn == undefined)
		{
			return false;
		}
		§§enumerate(this.allSpritesOn);
		while((var var0 = §§enumeration()) != null)
		{
			if(this.allSpritesOn[k].hasCarriedChild())
			{
				return true;
			}
		}
		return false;
	}
	function turnTactic()
	{
		var var2 = this.isTrigger;
		if(this.nPermanentLevel == 0)
		{
			this.nPermanentLevel = 1;
		}
		this.layerGroundNum = 0;
		this.groundSlope = 1;
		this.layerObject1Rot = 0;
		if(!this.lineOfSight)
		{
			this.layerObject1Num = 10000;
		}
		else if(this.movement == 0 || this.movement == 1)
		{
			this.layerObject1Num = 10002;
		}
		else
		{
			this.layerObject1Num = 10001;
		}
		if(this.layerObject2Num != 25)
		{
			if(var2)
			{
				this.layerObject2Num = 1030;
			}
			else
			{
				this.layerObject2Num = 0;
			}
		}
	}
}
