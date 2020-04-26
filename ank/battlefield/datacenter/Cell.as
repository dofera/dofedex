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
		var loc2 = false;
		var loc3 = 0;
		while(loc3 < dofus.Constants.MAP_TRIGGER_LAYEROBJECTS.length)
		{
			var loc4 = dofus.Constants.MAP_TRIGGER_LAYEROBJECTS[loc3];
			if(this.layerObject1Num == loc4 || this.layerObject2Num == loc4)
			{
				loc2 = true;
				break;
			}
			loc3 = loc3 + 1;
		}
		return loc2;
	}
	function __get__isUnwalkableLayerObject()
	{
		var loc2 = false;
		var loc3 = 0;
		while(loc3 < dofus.Constants.MAP_UNWALKABLE_LAYEROBJECTS.length)
		{
			var loc4 = dofus.Constants.MAP_UNWALKABLE_LAYEROBJECTS[loc3];
			if(this.layerObject1Num == loc4 || this.layerObject2Num == loc4)
			{
				loc2 = true;
				break;
			}
			loc3 = loc3 + 1;
		}
		return loc2;
	}
	function __get__isTactic()
	{
		var loc2 = false;
		if(this.layerGroundNum == 0 && (this.groundSlope == 1 && (this.layerObject2Num == 0 || (this.layerObject2Num == 25 || this.layerObject2Num == 1030))))
		{
			if(!this.lineOfSight)
			{
				if(this.layerObject1Num == 10000)
				{
					loc2 = true;
				}
			}
			else if(this.movement == 0 || this.movement == 1)
			{
				if(this.layerObject1Num == 10002)
				{
					loc2 = true;
				}
			}
			else if(this.layerObject1Num == 10001)
			{
				loc2 = true;
			}
		}
		return loc2;
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
		for(var k in this.allSpritesOn)
		{
			this.allSpritesOn[k] = undefined;
			delete this.allSpritesOn.k;
		}
		delete this.allSpritesOn;
	}
	function __get__spriteOnCount()
	{
		var loc2 = 0;
		for(var k in this.allSpritesOn)
		{
			loc2 = loc2 + 1;
		}
		return loc2;
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
		for(var k in this.allSpritesOn)
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
		var loc2 = this.isTrigger;
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
			if(loc2)
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
