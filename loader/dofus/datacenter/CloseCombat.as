class dofus.datacenter.CloseCombat extends Object
{
	function CloseCombat(var3, var4)
	{
		super();
		this.initialize(var3,var4);
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
			var var2 = this.getDefaultProperty(0);
			return this.api.kernel.GameManager.getSpellDescriptionWithEffects(var2,true,0);
		}
		var var3 = this._oItem.visibleEffects;
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var3.length)
		{
			var4.push(var3[var5].description);
			var5 = var5 + 1;
		}
		return var4.join(", ");
	}
	function __get__descriptionNormalHit()
	{
		if(this._oItem == undefined)
		{
			var var2 = this.getDefaultProperty(0);
			return this.api.kernel.GameManager.getSpellDescriptionWithEffects(var2,false,0);
		}
		var var3 = this._oItem.normalHit;
		var var4 = new Array();
		var var5 = 0;
		while(var5 < var3.length)
		{
			var4.push(var3.description);
			var5 = var5 + 1;
		}
		return var4.join(", ");
	}
	function __get__descriptionCriticalHit()
	{
		if(this._oItem == undefined)
		{
			var var2 = this.getDefaultProperty(1);
		}
		else
		{
			var2 = this._oItem.criticalHitBonus;
		}
		return this.api.kernel.GameManager.getSpellDescriptionWithEffects(var2,false,0);
	}
	function __get__effectsNormalHit()
	{
		if(this._oItem == undefined)
		{
			var var2 = this.getDefaultProperty(0);
		}
		else
		{
			var2 = this._oItem.normalHit;
		}
		return this.api.kernel.GameManager.getSpellEffects(var2,0);
	}
	function __get__effectsCriticalHit()
	{
		if(this._oItem == undefined)
		{
			var var2 = this.getDefaultProperty(1);
		}
		else
		{
			var2 = this._oItem.criticalHitBonus;
		}
		return this.api.kernel.GameManager.getSpellEffects(var2,0);
	}
	function __get__elements()
	{
		var var2 = {none:false,neutral:false,earth:false,fire:false,water:false,air:false};
		var var3 = this.effectsNormalHit;
		for(var k in var3)
		{
			var var4 = var3[k].element;
			switch(var4)
			{
				case "N":
					var2.neutral = true;
					break;
				case "E":
					var2.earth = true;
					break;
				case "F":
					var2.fire = true;
					break;
				case "W":
					var2.water = true;
					break;
				case "A":
					var2.air = true;
					break;
				default:
					var2.none = true;
			}
		}
		return var2;
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
	function initialize(var2, var3)
	{
		this.api = _global.API;
		this._oItem = var2;
		if(var2 == undefined)
		{
			this._oCloseCombatClassInfos = this.api.lang.getClassText(var3).cc;
		}
		var var4 = this.api.lang.getItemTypeText(this._oItem.type).z;
		if(var4 == undefined)
		{
			var4 = "Pa";
		}
		var var5 = var4.split("");
		this._aEffectZones = new Array();
		var var6 = 0;
		while(var6 < var5.length)
		{
			this._aEffectZones.push({shape:var5[var6],size:ank.utils.Compressor.decode64(var5[var6 + 1])});
			var6 = var6 + 2;
		}
		var var7 = this.api.lang.getClassText(this.api.datacenter.Player.Guild).cc;
		this._aRequiredStates = var7[9];
		this._aForbiddenStates = var7[10];
	}
	function getDefaultProperty(var2)
	{
		return this._oCloseCombatClassInfos[var2];
	}
}
