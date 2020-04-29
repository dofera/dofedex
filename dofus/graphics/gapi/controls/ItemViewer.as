class dofus.graphics.gapi.controls.ItemViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ItemViewer";
	var _nDisplayWidth = 316;
	var _bUseButton = false;
	var _bDestroyButton = false;
	var _bTargetButton = false;
	var _sCurrentTab = "Effects";
	var _bShowBaseEffects = false;
	function ItemViewer()
	{
		super();
	}
	function __set__useButton(var2)
	{
		this._bUseButton = var2;
		return this.__get__useButton();
	}
	function __get__useButton()
	{
		return this._bUseButton;
	}
	function __set__destroyButton(var2)
	{
		this._bDestroyButton = var2;
		return this.__get__destroyButton();
	}
	function __get__destroyButton()
	{
		return this._bDestroyButton;
	}
	function __set__targetButton(var2)
	{
		this._bTargetButton = var2;
		return this.__get__targetButton();
	}
	function __get__targetButton()
	{
		return this._bTargetButton;
	}
	function __set__displayPrice(var2)
	{
		this._bPrice = var2;
		this._lblPrice._visible = var2;
		this._mcKamaSymbol._visible = var2;
		return this.__get__displayPrice();
	}
	function __get__displayPrice()
	{
		return this._bPrice;
	}
	function __set__hideDesc(var2)
	{
		this._bDesc = !var2;
		this._txtDescription._visible = this._bDesc;
		this._txtDescription.scrollBarRight = this._bDesc;
		return this.__get__hideDesc();
	}
	function __get__hideDesc()
	{
		return this._bDesc;
	}
	function __set__itemData(var2)
	{
		this._oItem = var2;
		this.addToQueue({object:this,method:this.showItemData,params:[var2]});
		return this.__get__itemData();
	}
	function __get__itemData()
	{
		return this._oItem;
	}
	function __set__displayWidth(var2)
	{
		this._nDisplayWidth = Math.max(316,var2 + 2);
		return this.__get__displayWidth();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ItemViewer.CLASS_NAME);
	}
	function arrange()
	{
		this._lstInfos._width = this._nDisplayWidth - this._lstInfos._x;
		this._txtDescription._width = this._nDisplayWidth - this._txtDescription._x - 1;
		this._mcTitle._width = this._nDisplayWidth - this._mcTitle._x;
		this._lblLevel._x = this._nDisplayWidth - (316 - this._lblLevel._x);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this._btnTabCharacteristics._visible = false;
		this._pbEthereal._visible = false;
		this._ldrTwoHanded._visible = false;
	}
	function initTexts()
	{
		this._btnTabEffects.label = this.api.lang.getText("EFFECTS");
		this._btnTabConditions.label = this.api.lang.getText("CONDITIONS");
		this._btnTabCharacteristics.label = this.api.lang.getText("CHARACTERISTICS");
	}
	function addListeners()
	{
		this._btnAction.addEventListener("click",this);
		this._btnAction.addEventListener("over",this);
		this._btnAction.addEventListener("out",this);
		this._btnTabEffects.addEventListener("click",this);
		this._btnTabCharacteristics.addEventListener("click",this);
		this._btnTabConditions.addEventListener("click",this);
		this._pbEthereal.addEventListener("over",this);
		this._pbEthereal.addEventListener("out",this);
		this._ldrTwoHanded.onRollOver = function()
		{
			this._parent.over({target:this});
		};
		this._ldrTwoHanded.onRollOut = function()
		{
			this._parent.out({target:this});
		};
	}
	function showItemData(var2)
	{
		if(var2 != undefined)
		{
			this._lblName.text = var2.name;
			if(dofus.Constants.DEBUG)
			{
				this._lblName.text = this._lblName.text + (" (" + var2.unicID + ")");
			}
			if(var2.style == "")
			{
				this._lblName.styleName = "WhiteLeftMediumBoldLabel";
			}
			else
			{
				this._lblName.styleName = var2.style + "LeftMediumBoldLabel";
			}
			this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL") + var2.level;
			this._txtDescription.text = var2.description;
			this._ldrIcon.contentParams = var2.params;
			this._ldrIcon.contentPath = var2.iconFile;
			this._bShowBaseEffects = false;
			this.updateCurrentTabInformations();
			if(var2.superType == 2)
			{
				this._btnTabCharacteristics._visible = true;
			}
			else
			{
				if(this._sCurrentTab == "Characteristics")
				{
					this.setCurrentTab("Effects");
				}
				this._btnTabCharacteristics._visible = false;
			}
			this._lblPrice.text = var2.price != undefined?new ank.utils.(var2.price).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3):"";
			this._lblWeight.text = var2.weight + " " + ank.utils.PatternDecoder.combine(this._parent.api.lang.getText("PODS"),"m",var2.weight < 2);
			if(var2.isEthereal)
			{
				var var3 = var2.etherealResistance;
				this._pbEthereal.maximum = var3.param3;
				this._pbEthereal.value = var3.param2;
				this._pbEthereal._visible = true;
				if(var3.param2 < 4)
				{
					this._pbEthereal.styleName = "EtherealCriticalProgressBar";
				}
				else
				{
					this._pbEthereal.styleName = "EtherealNormalProgressBar";
				}
			}
			else
			{
				this._pbEthereal._visible = false;
			}
			this._ldrTwoHanded._visible = var2.needTwoHands;
		}
		else if(this._lblName.text != undefined)
		{
			this._lblName.text = "";
			this._lblLevel.text = "";
			this._txtDescription.text = "";
			this._ldrIcon.contentPath = "";
			this._lstInfos.removeAll();
			this._lblPrice.text = "";
			this._lblWeight.text = "";
			this._pbEthereal._visible = false;
			this._ldrTwoHanded._visible = false;
		}
	}
	function updateCurrentTabInformations()
	{
		var var2 = new ank.utils.();
		if((var var0 = this._sCurrentTab) !== "Effects")
		{
			switch(null)
			{
				case "Characteristics":
					§§enumerate(this._oItem.characteristics);
					while((var0 = §§enumeration()) != null)
					{
						if(this._oItem.characteristics[s].length > 0)
						{
							var2.push(this._oItem.characteristics[s]);
						}
					}
					break;
				case "Conditions":
					§§enumerate(this._oItem.conditions);
					while((var var0 = §§enumeration()) != null)
					{
						if(this._oItem.conditions[s].length > 0)
						{
							var2.push(this._oItem.conditions[s]);
						}
					}
			}
		}
		else
		{
			for(var s in this._oItem.effects)
			{
				if(this._oItem.effects[s].description.length > 0)
				{
					var2.push(this._oItem.effects[s]);
				}
			}
		}
		var2.reverse();
		this._lstInfos.dataProvider = var2;
	}
	function setCurrentTab(var2)
	{
		this._bShowBaseEffects = false;
		var var3 = this["_btnTab" + this._sCurrentTab];
		var var4 = this["_btnTab" + var2];
		var3.selected = true;
		var3.enabled = true;
		var4.selected = false;
		if(var2 != "Effects")
		{
			var4.enabled = false;
		}
		this._sCurrentTab = var2;
		this.updateCurrentTabInformations();
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnTabEffects":
				if(this._sCurrentTab == "Effects")
				{
					var var3 = this["_btnTab" + this._sCurrentTab];
					var3.selected = false;
					if(this._bShowBaseEffects)
					{
						this.updateCurrentTabInformations();
					}
					else
					{
						var var4 = this.api.lang.getItemStats(this._oItem.unicID);
						if(var4 != undefined)
						{
							var var5 = new ank.utils.();
							var var6 = new Array();
							var var7 = var4.split(",");
							var var8 = 0;
							while(var8 < var7.length)
							{
								var var9 = var7[var8].split("#");
								var9[0] = _global.parseInt(var9[0],16);
								var9[1] = var9[1] != "0"?_global.parseInt(var9[1],16):undefined;
								var9[2] = var9[2] != "0"?_global.parseInt(var9[2],16):undefined;
								var9[3] = var9[3] != "0"?_global.parseInt(var9[3],16):undefined;
								var6.push(var9);
								var8 = var8 + 1;
							}
							var var10 = dofus.datacenter.Item.getItemDescriptionEffects(var6);
							§§enumerate(var10);
							while((var0 = §§enumeration()) != null)
							{
								if(var10[s].description.length > 0)
								{
									var5.push(var10[s]);
								}
							}
							var5.reverse();
							this._lstInfos.dataProvider = var5;
						}
					}
					this._bShowBaseEffects = !this._bShowBaseEffects;
				}
				else
				{
					this.setCurrentTab("Effects");
				}
				break;
			case "_btnTabCharacteristics":
				this.setCurrentTab("Characteristics");
				break;
			case "_btnTabConditions":
				this.setCurrentTab("Conditions");
				break;
			default:
				if(§§enum_assign() !== "_btnAction")
				{
					break;
				}
				var var11 = this.api.ui.createPopupMenu();
				var11.addStaticItem(this._oItem.name);
				if(this._bUseButton && this._oItem.canUse)
				{
					var11.addItem(this._parent.api.lang.getText("CLICK_TO_USE"),this,this.dispatchEvent,[{type:"useItem",item:this._oItem}]);
				}
				var11.addItem(this._parent.api.lang.getText("CLICK_TO_INSERT"),this.api.kernel.GameManager,this.api.kernel.GameManager.insertItemInChat,[this._oItem]);
				if(this._bTargetButton && this._oItem.canTarget)
				{
					var11.addItem(this._parent.api.lang.getText("CLICK_TO_TARGET"),this,this.dispatchEvent,[{type:"targetItem",item:this._oItem}]);
				}
				var11.addItem(this._parent.api.lang.getText("ASSOCIATE_RECEIPTS"),this.api.ui,this.api.ui.loadUIComponent,["ItemUtility","ItemUtility",{item:this._oItem}]);
				if(this._bDestroyButton && this._oItem.canDestroy)
				{
					var11.addItem(this._parent.api.lang.getText("CLICK_TO_DESTROY"),this,this.dispatchEvent,[{type:"destroyItem",item:this._oItem}]);
				}
				var11.show(_root._xmouse,_root._ymouse);
				break;
		}
	}
	function over(var2)
	{
		switch(var2.target._name)
		{
			case "_pbEthereal":
				var var3 = this._oItem.etherealResistance;
				this.gapi.showTooltip(var3.description,var2.target,-20);
				break;
			case "_ldrTwoHanded":
				this.gapi.showTooltip(this.api.lang.getText("TWO_HANDS_WEAPON"),this._ldrTwoHanded,-20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
}
