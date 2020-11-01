class dofus.datacenter.Item extends Object
{
	static var OBJECT_ACTION_SUMMON = 623;
	static var LEVEL_STEP = [0,10,21,33,46,60,75,91,108,126,145,165,186,208,231,255,280,306,333,361];
	static var DATE_ID = 0;
	function Item(var3, var4, var5, var6, var7, var8, var9, var10)
	{
		super();
		this.initialize(var3,var4,var5,var6,var7,var8,var9,var10);
	}
	function __get__label()
	{
		return this._nQuantity <= 1?undefined:this._nQuantity;
	}
	function __get__ID()
	{
		return this._nID;
	}
	function __get__unicID()
	{
		return this._nUnicID;
	}
	function __get__compressedEffects()
	{
		return this._sEffects;
	}
	function __set__Quantity(var2)
	{
		if(_global.isNaN(Number(var2)))
		{
			return undefined;
		}
		this._nQuantity = Number(var2);
		return this.__get__Quantity();
	}
	function __get__Quantity()
	{
		return this._nQuantity;
	}
	function __set__remainingHours(var2)
	{
		this._nRemainingHours = var2;
		return this.__get__remainingHours();
	}
	function __get__remainingHours()
	{
		return this._nRemainingHours;
	}
	function __set__position(var2)
	{
		if(_global.isNaN(Number(var2)))
		{
			return undefined;
		}
		this._nPosition = Number(var2);
		return this.__get__position();
	}
	function __get__position()
	{
		return this._nPosition;
	}
	function __set__priceMultiplicator(var2)
	{
		if(_global.isNaN(Number(var2)))
		{
			return undefined;
		}
		this._nPriceMultiplicator = Number(var2);
		return this.__get__priceMultiplicator();
	}
	function __get__priceMultiplicator()
	{
		return this._nPriceMultiplicator;
	}
	function __get__name()
	{
		return ank.utils.PatternDecoder.getDescription(this.api.lang.fetchString(this._oUnicInfos.n),this.api.lang.getItemUnicStringText());
	}
	function __get__description()
	{
		var var2 = this.api.lang.getItemTypeText(this.type).n;
		var var3 = "";
		if(this.isFromItemSet)
		{
			var var4 = new dofus.datacenter.ItemSet(this.itemSetID);
			var3 = "<u>" + var4.name + " (" + this.api.lang.getText("ITEM_TYPE") + " : " + var2 + ")</u>\n";
		}
		else
		{
			var3 = "<u>" + this.api.lang.getText("ITEM_TYPE") + " : " + var2 + "</u>\n";
		}
		return var3 + ank.utils.PatternDecoder.getDescription(this.api.lang.fetchString(this._oUnicInfos.d),this.api.lang.getItemUnicStringText());
	}
	function __get__type()
	{
		if(this._nRealType)
		{
			return this._nRealType;
		}
		return Number(this._oUnicInfos.t);
	}
	function __set__type(var2)
	{
		this._nRealType = var2;
		return this.__get__type();
	}
	function __get__realType()
	{
		return Number(this._oUnicInfos.t);
	}
	function __get__enhanceable()
	{
		return !!this._oUnicInfos.fm;
	}
	function __get__style()
	{
		if(this.isFromItemSet)
		{
			return "ItemSet";
		}
		if(this.isEthereal)
		{
			return "Ethereal";
		}
		return "";
	}
	function __get__needTwoHands()
	{
		return this._oUnicInfos.tw == true;
	}
	function __get__isEthereal()
	{
		return this._oUnicInfos.et == true;
	}
	function __get__isHidden()
	{
		return this._oUnicInfos.h == true;
	}
	function __get__etherealResistance()
	{
		if(this.isEthereal)
		{
			for(var k in this._aEffects)
			{
				var var2 = this._aEffects[k];
				if(var2[0] == 812)
				{
					while(§§pop() != null)
					{
					}
					return new dofus.datacenter.(var2[0],var2[1],var2[2],var2[3]);
				}
			}
		}
		return new Array();
	}
	function __get__isFromItemSet()
	{
		return this._oUnicInfos.s != undefined;
	}
	function __get__itemSetID()
	{
		return this._oUnicInfos.s;
	}
	function __get__typeText()
	{
		return this.api.lang.getItemTypeText(this.type);
	}
	function __get__superType()
	{
		return this.typeText.t;
	}
	function __get__superTypeText()
	{
		return this.api.lang.getItemSuperTypeText(this.superType);
	}
	function __get__iconFile()
	{
		return dofus.Constants.ITEMS_PATH + this.type + "/" + this.gfx + ".swf";
	}
	function __get__effects()
	{
		return dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects);
	}
	function __get__visibleEffects()
	{
		return dofus.datacenter.Item.getItemDescriptionEffects(this._aEffects,true);
	}
	function __get__canUse()
	{
		return this._oUnicInfos.u != undefined?true:false;
	}
	function __get__canTarget()
	{
		return this._oUnicInfos.ut != undefined?true:false;
	}
	function __get__canDestroy()
	{
		return this.superType != 14 && !this.isCursed;
	}
	function __get__canDrop()
	{
		return this.superType != 14 && !this.isCursed;
	}
	function __get__canMoveToShortut()
	{
		return this.canUse == true || this.canTarget == true;
	}
	function __get__level()
	{
		return Number(this._oUnicInfos.l);
	}
	function __get__gfx()
	{
		if(this._sGfx)
		{
			return this._sGfx;
		}
		if(this._sCustomFullGfx != undefined)
		{
			return this._sCustomFullGfx;
		}
		return this._oUnicInfos.g;
	}
	function __set__gfx(var2)
	{
		this._sGfx = var2;
		return this.__get__gfx();
	}
	function __get__realGfx()
	{
		if(this._sCustomFullGfx != undefined)
		{
			return this._sCustomFullGfx;
		}
		return this._sRealGfx;
	}
	function __get__price()
	{
		if(this._nPrice == undefined)
		{
			return Math.max(0,Math.round(Number(this._oUnicInfos.p) * (this._nPriceMultiplicator != undefined?this._nPriceMultiplicator:0)));
		}
		return this._nPrice;
	}
	function __get__weight()
	{
		return Number(this._oUnicInfos.w);
	}
	function __get__isCursed()
	{
		return this._oUnicInfos.m;
	}
	function __get__normalHit()
	{
		return this._aEffects;
	}
	function __get__criticalHitBonus()
	{
		return this.getItemFightEffectsText(0);
	}
	function __get__apCost()
	{
		return this.getItemFightEffectsText(1);
	}
	function __get__rangeMin()
	{
		return this.getItemFightEffectsText(2);
	}
	function __get__rangeMax()
	{
		return this.getItemFightEffectsText(3);
	}
	function __get__criticalHit()
	{
		return this.getItemFightEffectsText(4);
	}
	function __get__criticalFailure()
	{
		return this.getItemFightEffectsText(5);
	}
	function __get__lineOnly()
	{
		return this.getItemFightEffectsText(6);
	}
	function __get__lineOfSight()
	{
		return this.getItemFightEffectsText(7);
	}
	function __get__effectZones()
	{
		return this._aEffectZones;
	}
	function __get__characteristics()
	{
		var var2 = new Array();
		var2.push(this.api.lang.getText("ITEM_AP",[this.apCost]));
		var2.push(this.api.lang.getText("ITEM_RANGE",[(this.rangeMin == 0?"":this.rangeMin + " " + this.api.lang.getText("TO_RANGE") + " ") + this.rangeMax]));
		var2.push(this.api.lang.getText("ITEM_CRITICAL_BONUS",[this.criticalHitBonus <= 0?String(this.criticalHitBonus):"+" + this.criticalHitBonus]));
		var2.push((this.criticalHit == 0?"":this.api.lang.getText("ITEM_CRITICAL",[this.criticalHit])) + (!(this.criticalHit != 0 && this.criticalFailure != 0)?"":" - ") + (this.criticalFailure == 0?"":this.api.lang.getText("ITEM_MISS",[this.criticalFailure])));
		if(this.criticalHit > 0 && this.ID == this.api.datacenter.Player.weaponItem.ID)
		{
			var var3 = this.api.kernel.GameManager.getCriticalHitChance(this.criticalHit);
			var2.push(this.api.lang.getText("ITEM_CRITICAL_REAL",["1/" + var3]));
		}
		return var2;
	}
	function __get__conditions()
	{
		var var2 = [">","<","=","!"];
		var var3 = this._oUnicInfos.c;
		if(var3 == undefined || var3.length == 0)
		{
			return [String(this.api.lang.getText("NO_CONDITIONS"))];
		}
		var var4 = var3.split("&");
		var var5 = new Array();
		var var6 = 0;
		while(var6 < var4.length)
		{
			var4[var6] = new ank.utils.(var4[var6]).replace(["(",")"],["",""]);
			var var7 = var4[var6].split("|");
			var var8 = 0;
			for(; var8 < var7.length; var8 = var8 + 1)
			{
				var var11 = 0;
				while(var11 < var2.length)
				{
					var var10 = var2[var11];
					var var9 = var7[var8].split(var10);
					if(var9.length > 1)
					{
						break;
					}
					var11 = var11 + 1;
				}
				if(var9 != undefined)
				{
					var var12 = String(var9[0]);
					var var13 = var9[1];
					if(var12 == "PZ")
					{
						break;
					}
					loop3:
					switch(var12)
					{
						case "Ps":
							var13 = this.api.lang.getAlignment(Number(var13)).n;
							break;
						case "PS":
							var13 = var13 != "1"?this.api.lang.getText("MALE"):this.api.lang.getText("FEMELE");
							break;
						case "Pr":
							var13 = this.api.lang.getAlignmentSpecialization(Number(var13)).n;
							break;
						case "Pg":
							var var14 = var13.split(",");
							if(var14.length == 2)
							{
								var13 = this.api.lang.getAlignmentFeat(Number(var14[0])).n + " (" + Number(var14[1]) + ")";
							}
							else
							{
								var13 = this.api.lang.getAlignmentFeat(Number(var13)).n;
							}
							break;
						case "PG":
							var13 = this.api.lang.getClassText(Number(var13)).sn;
							break;
						default:
							switch(null)
							{
								case "PJ":
								case "Pj":
									var var15 = var13.split(",");
									var13 = this.api.lang.getJobText(var15[0]).n + (var15[1] != undefined?" (" + this.api.lang.getText("LEVEL_SMALL") + " " + var15[1] + ")":"");
									break loop3;
								case "PM":
									continue;
								case "PO":
									var var16 = new dofus.datacenter.(-1,Number(var13),1,0,"",0);
									var13 = var16.name;
							}
					}
					var12 = new ank.utils.(var12).replace(["CS","Cs","CV","Cv","CA","Ca","CI","Ci","CW","Cw","CC","Cc","CA","PG","PJ","Pj","PM","PA","PN","PE","<NO>","PS","PR","PL","PK","Pg","Pr","Ps","Pa","PP","PZ","CM"],this.api.lang.getText("ITEM_CHARACTERISTICS").split(","));
					var var17 = var10 == "!";
					var10 = new ank.utils.(var10).replace(["!"],[this.api.lang.getText("ITEM_NO")]);
					switch(var12)
					{
						case "BI":
							var5.push(this.api.lang.getText("UNUSABLE"));
							break;
						case "PO":
							if(var17)
							{
								var5.push(this.api.lang.getText("ITEM_DO_NOT_POSSESS",[var13]) + " <" + var10 + ">");
							}
							else
							{
								var5.push(this.api.lang.getText("ITEM_DO_POSSESS",[var13]) + " <" + var10 + ">");
							}
							break;
						default:
							var5.push((var8 <= 0?"":this.api.lang.getText("ITEM_OR") + " ") + var12 + " " + var10 + " " + var13);
					}
				}
			}
			var6 = var6 + 1;
		}
		return var5;
	}
	function __get__mood()
	{
		return this._nMood;
	}
	function __get__skin()
	{
		return this._nSkin;
	}
	function __set__skin(var2)
	{
		this._nSkin = var2;
		return this.__get__skin();
	}
	function __get__params()
	{
		if(!this.isLeavingItem)
		{
			return undefined;
		}
		var var3 = this.skin;
		if(var3 == undefined || _global.isNaN(var3))
		{
			var3 = 0;
		}
		switch(this.mood)
		{
			case 1:
				var var2 = "H";
				break;
			case 2:
			case 0:
				var2 = "U";
				break;
			default:
				var2 = "H";
		}
		return {frame:var2 + var3,forceReload:this.isLeavingItem};
	}
	function __get__skineable()
	{
		return this._bIsSkineable;
	}
	function __get__isAssociate()
	{
		return this.skineable && this.realType != 113;
	}
	function __get__realUnicId()
	{
		if(this._nRealUnicId)
		{
			return this._nRealUnicId;
		}
		return this._nUnicID;
	}
	function __get__maxSkin()
	{
		var var2 = 1;
		while(var2 < dofus.datacenter.Item.LEVEL_STEP.length)
		{
			if(this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[var2])
			{
				return var2;
			}
			var2 = var2 + 1;
		}
		return dofus.datacenter.Item.LEVEL_STEP.length;
	}
	function __get__currentLivingXp()
	{
		return this._nLivingXp;
	}
	function __get__currentLivingLevelXpMax()
	{
		var var2 = 1;
		while(var2 < dofus.datacenter.Item.LEVEL_STEP.length)
		{
			if(this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[var2])
			{
				return dofus.datacenter.Item.LEVEL_STEP[var2];
			}
			var2 = var2 + 1;
		}
		return -1;
	}
	function __get__currentLivingLevelXpMin()
	{
		var var2 = 1;
		while(var2 < dofus.datacenter.Item.LEVEL_STEP.length)
		{
			if(this._nLivingXp < dofus.datacenter.Item.LEVEL_STEP[var2])
			{
				return dofus.datacenter.Item.LEVEL_STEP[var2 - 1];
			}
			var2 = var2 + 1;
		}
		return -1;
	}
	function __get__isSpeakingItem()
	{
		return this.isAssociate || this.realType == 113;
	}
	function __get__isLeavingItem()
	{
		return this.isAssociate || this.realType == 113;
	}
	function __get__canBeExchange()
	{
		return this._bCanBeExchange;
	}
	function initialize(var2, var3, var4, var5, var6, var7, var8, var9)
	{
		this.api = _global.API;
		this._itemDateId = dofus.datacenter.Item.DATE_ID--;
		this._nID = var2;
		this._nUnicID = var3;
		this._nQuantity = var4 != undefined?var4:1;
		this._nPosition = var5 != undefined?var5:-1;
		if(var7 != undefined)
		{
			this._nPrice = var7;
		}
		this._bCanBeExchange = true;
		this._oUnicInfos = this.api.lang.getItemUnicText(var3);
		this.setEffects(var6);
		this._bIsSkineable = false;
		this.updateDataFromEffect();
		var var10 = this.typeText.z;
		var var11 = var10.split("");
		this._aEffectZones = new Array();
		var var12 = 0;
		while(var12 < var11.length)
		{
			this._aEffectZones.push({shape:var11[var12],size:ank.utils.Compressor.decode64(var11[var12 + 1])});
			var12 = var12 + 2;
		}
		this._itemLevel = this.level;
		this._itemType = this.type;
		this._itemPrice = this.price;
		this._itemName = this.name;
		this._itemWeight = this.weight;
		if(var8 != undefined)
		{
			this._nSkin = var8;
		}
		if(var9 != undefined)
		{
			this._nMood = var9;
		}
	}
	function hasCustomGfx()
	{
		return this._sCustomFullGfx != undefined;
	}
	function setEffects(var2)
	{
		this._sEffects = var2;
		this._aEffects = new Array();
		var var3 = var2.split(",");
		var var4 = 0;
		while(var4 < var3.length)
		{
			var var5 = var3[var4].split("#");
			var5[0] = _global.parseInt(var5[0],16);
			var5[1] = !(var5[1] == "" || var5[1] == "0")?_global.parseInt(var5[1],16):undefined;
			var5[2] = !(var5[2] == "" || var5[2] == "0")?_global.parseInt(var5[2],16):undefined;
			var5[3] = !(var5[3] == "" || var5[3] == "0")?_global.parseInt(var5[3],16):undefined;
			var5[4] = var5[4];
			this._aEffects.push(var5);
			var4 = var4 + 1;
		}
	}
	function clone()
	{
		return new dofus.datacenter.(this._nID,this._nUnicID,this._nQuantity,this._nPosition,this._sEffects);
	}
	function equals(var2)
	{
		return this.unicID == var2.unicID;
	}
	function showStatsTooltip(var2, var3)
	{
		var var4 = -20;
		var var5 = this.name + " (" + this.api.lang.getText("LEVEL_SMALL") + " " + this.level + ")";
		var var6 = true;
		for(var s in this.effects)
		{
			var var7 = this.effects[s];
			if(var7.description.length > 0)
			{
				if(var6)
				{
					var5 = var5 + "\n";
					var4 = var4 - 10;
					var6 = false;
				}
				var5 = var5 + "\n" + var7.description;
				var4 = var4 - 12;
			}
		}
		this.api.ui.showTooltip(var5,var2,var4,undefined,var3 + "ToolTip");
	}
	function getItemFightEffectsText(var2)
	{
		return this._oUnicInfos.e[var2];
	}
	function updateDataFromEffect()
	{
		for(var k in this._aEffects)
		{
			var var2 = this._aEffects[k];
			switch(var2[0])
			{
				case 974:
					this._nLivingXp = !var2[3]?0:var2[3];
					break;
				case 973:
					this._nRealType = !var2[3]?0:var2[3];
					break;
				case 972:
					this._nSkin = !var2[3]?0:_global.parseInt(var2[3]) - 1;
					this._bIsSkineable = true;
					break;
				default:
					switch(null)
					{
						case 971:
							this._nMood = !var2[3]?0:var2[3];
							break;
						case 969:
							var var3 = this.api.lang.getItemUnicText(!var2[3]?0:var2[3]).g;
							this._sCustomFullGfx = var3;
							break;
						case 970:
							this._sRealGfx = this._oUnicInfos.g;
							this._sGfx = this.api.lang.getItemUnicText(!var2[3]?0:var2[3]).g;
							this._nRealUnicId = var2[3];
							break;
						case 983:
							this._bCanBeExchange = false;
					}
			}
		}
	}
	static function getItemDescriptionEffects(var2, var3)
	{
		var var4 = new Array();
		var var5 = var2.length;
		if(typeof var2 == "object")
		{
			var var6 = 0;
			while(var6 < var5)
			{
				var var7 = var2[var6];
				var var8 = var7[0];
				var var9 = new Array();
				if(var8 == dofus.datacenter.Item.OBJECT_ACTION_SUMMON)
				{
					var var10 = var7[4].split(dofus.aks.Items.EFFECT_APPEND_CHAR);
					var var11 = 0;
					while(var11 < var10.length)
					{
						var var12 = _global.parseInt(var10[var11],dofus.aks.Items.COMPRESSION_RADIX);
						var var13 = new dofus.datacenter.(var8,undefined,undefined,var12);
						var9.push(var13);
						var11 = var11 + 1;
					}
				}
				else
				{
					var var14 = new dofus.datacenter.(var8,var7[1],var7[2],var7[3],var7[4]);
					var9.push(var14);
				}
				var var15 = 0;
				while(var15 < var9.length)
				{
					var var16 = var9[var15];
					if(var16.description != undefined)
					{
						if(var3 == true)
						{
							if(var16.showInTooltip)
							{
								var4.push(var16);
							}
						}
						else
						{
							var4.push(var16);
						}
					}
					var15 = var15 + 1;
				}
				var6 = var6 + 1;
			}
			return var4;
		}
		return null;
	}
}
