class dofus.datacenter.CloseCombat extends Object
{
	function CloseCombat(loc3, loc4)
	{
		super();
		this.initialize(loc3,loc4);
	}
	function __get__ID()
	{
		return 0;
	}
	function __get__isValid()
	{
		return true;
	}
	function __get__maxLevel()
	{
		return 1;
	}
	function __get__position()
	{
		return 0;
	}
	function __get__item()
	{
		return this._oItem;
	}
	function __get__summonSpell()
	{
		return false;
	}
	function __get__glyphSpell()
	{
		return false;
	}
	function __get__trapSpell()
	{
		return false;
	}
	function __get__iconFile()
	{
		if(this._oItem == undefined)
		{
			return dofus.Constants.DEFAULT_CC_ICON_FILE;
		}
		return this._oItem.iconFile;
	}
	function __get__name()
	{
		return this.api.lang.getText("CC_DAMAGES");
	}
	function __get__apCost()
	{
		if(this._oItem == undefined)
		{
			return this.getDefaultProperty(2);
		}
		return this._oItem.apCost;
	}
	function __get__rangeMin()
	{
		if(this._oItem == undefined)
		{
			return this.getDefaultProperty(3);
		}
		return this._oItem.rangeMin;
	}
	function __get__rangeMax()
	{
		if(this._oItem == undefined)
		{
			return this.getDefaultProperty(4);
		}
		return this._oItem.rangeMax;
	}
	function __get__rangeStr()
	{
		return (this.rangeMin == 0?"":this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") + this.rangeMax;
	}
	function __get__criticalHit()
	{
		if(this._oItem == undefined)
		{
			return this.getDefaultProperty(5);
		}
		return this._oItem.criticalHit;
	}
	function __get__criticalFailure()
	{
		if(this._oItem == undefined)
		{
			return this.getDefaultProperty(6);
		}
		return this._oItem.criticalFailure;
	}
	function __get__lineOnly()
	{
		if(this._oItem == undefined)
		{
			return this.getDefaultProperty(7);
		}
		return this._oItem.lineOnly;
	}
	function __get__lineOfSight()
	{
		if(this._oItem == undefined)
		{
			return this.getDefaultProperty(8);
		}
		return this._oItem.lineOfSight;
	}
	function __get__freeCell()
	{
		return false;
	}
	function __get__canBoostRange()
	{
		return false;
	}
	function __get__classID()
	{
		return -1;
	}
	function __get__launchCountByTurn()
	{
		return 0;
	}
	function __get__launchCountByPlayerTurn()
	{
		return 0;
	}
	function __get__delayBetweenLaunch()
	{
		return 0;
	}
	function __get__descriptionVisibleEffects()
	{
		if(this._oItem == undefined)
		{
			var loc2 = this.getDefaultProperty(0);
			return this.api.kernel.GameManager.getSpellDescriptionWithEffects(loc2,true,0);
		}
		var loc3 = this._oItem.visibleEffects;
		var loc4 = new Array();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			loc4.push(loc3[loc5].description);
			loc5 = loc5 + 1;
		}
		return loc4.join(", ");
	}
	function __get__descriptionNormalHit()
	{
		if(this._oItem == undefined)
		{
			var loc2 = this.getDefaultProperty(0);
			return this.api.kernel.GameManager.getSpellDescriptionWithEffects(loc2,false,0);
		}
		var loc3 = this._oItem.normalHit;
		var loc4 = new Array();
		var loc5 = 0;
		while(loc5 < loc3.length)
		{
			loc4.push(loc3.description);
			loc5 = loc5 + 1;
		}
		return loc4.join(", ");
	}
	function __get__descriptionCriticalHit()
	{
		if(this._oItem == undefined)
		{
			var loc2 = this.getDefaultProperty(1);
		}
		else
		{
			loc2 = this._oItem.criticalHitBonus;
		}
		return this.api.kernel.GameManager.getSpellDescriptionWithEffects(loc2,false,0);
	}
	function __get__effectsNormalHit()
	{
		if(this._oItem == undefined)
		{
			var loc2 = this.getDefaultProperty(0);
		}
		else
		{
			loc2 = this._oItem.normalHit;
		}
		return this.api.kernel.GameManager.getSpellEffects(loc2,0);
	}
	function __get__effectsCriticalHit()
	{
		if(this._oItem == undefined)
		{
			var loc2 = this.getDefaultProperty(1);
		}
		else
		{
			loc2 = this._oItem.criticalHitBonus;
		}
		return this.api.kernel.GameManager.getSpellEffects(loc2,0);
	}
	function __get__elements()
	{
		var loc2 = {none:false,neutral:false,earth:false,fire:false,water:false,air:false};
		var loc3 = this.effectsNormalHit;
		for(var k in loc3)
		{
			var loc4 = loc3[k].element;
			switch(loc4)
			{
				case "N":
					loc2.neutral = true;
					break;
				case "E":
					loc2.earth = true;
					break;
				case "F":
					loc2.fire = true;
					break;
				case "W":
					loc2.water = true;
					break;
				case "A":
					loc2.air = true;
					break;
				default:
					loc2.none = true;
			}
		}
		return loc2;
	}
	function __get__effectZones()
	{
		return this._aEffectZones;
	}
	function __get__requiredStates()
	{
		return this._aRequiredStates;
	}
	function __get__forbiddenStates()
	{
		return this._aForbiddenStates;
	}
	function __get__needStates()
	{
		return this._aRequiredStates.length > 0 || this._aForbiddenStates.length > 0;
	}
	function initialize(loc2, loc3)
	{
		this.api = _global.API;
		this._oItem = loc2;
		if(loc2 == undefined)
		{
			this._oCloseCombatClassInfos = this.api.lang.getClassText(loc3).cc;
		}
		var loc4 = this.api.lang.getItemTypeText(this._oItem.type).z;
		if(loc4 == undefined)
		{
			loc4 = "Pa";
		}
		var loc5 = loc4.split("");
		this._aEffectZones = new Array();
		var loc6 = 0;
		while(loc6 < loc5.length)
		{
			this._aEffectZones.push({shape:loc5[loc6],size:ank.utils.Compressor.decode64(loc5[loc6 + 1])});
			loc6 = loc6 + 2;
		}
		var loc7 = this.api.lang.getClassText(this.api.datacenter.Player.Guild).cc;
		this._aRequiredStates = loc7[9];
		this._aForbiddenStates = loc7[10];
	}
	function getDefaultProperty(loc2)
	{
		return this._oCloseCombatClassInfos[loc2];
	}
}
