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
	function __set__useButton(loc2)
	{
		this._bUseButton = loc2;
		return this.__get__useButton();
	}
	function __get__useButton()
	{
		return this._bUseButton;
	}
	function __set__destroyButton(loc2)
	{
		this._bDestroyButton = loc2;
		return this.__get__destroyButton();
	}
	function __get__destroyButton()
	{
		return this._bDestroyButton;
	}
	function __set__targetButton(loc2)
	{
		this._bTargetButton = loc2;
		return this.__get__targetButton();
	}
	function __get__targetButton()
	{
		return this._bTargetButton;
	}
	function __set__displayPrice(loc2)
	{
		this._bPrice = loc2;
		this._lblPrice._visible = loc2;
		this._mcKamaSymbol._visible = loc2;
		return this.__get__displayPrice();
	}
	function __get__displayPrice()
	{
		return this._bPrice;
	}
	function __set__hideDesc(loc2)
	{
		this._bDesc = !loc2;
		this._txtDescription._visible = this._bDesc;
		this._txtDescription.scrollBarRight = this._bDesc;
		return this.__get__hideDesc();
	}
	function __get__hideDesc()
	{
		return this._bDesc;
	}
	function __set__itemData(loc2)
	{
		this._oItem = loc2;
		this.addToQueue({object:this,method:this.showItemData,params:[loc2]});
		return this.__get__itemData();
	}
	function __get__itemData()
	{
		return this._oItem;
	}
	function __set__displayWidth(loc2)
	{
		this._nDisplayWidth = Math.max(316,loc2 + 2);
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
	function showItemData(loc2)
	{
		if(loc2 != undefined)
		{
			this._lblName.text = loc2.name;
			if(dofus.Constants.DEBUG)
			{
				this._lblName.text = this._lblName.text + (" (" + loc2.unicID + ")");
			}
			if(loc2.style == "")
			{
				this._lblName.styleName = "WhiteLeftMediumBoldLabel";
			}
			else
			{
				this._lblName.styleName = loc2.style + "LeftMediumBoldLabel";
			}
			this._lblLevel.text = this.api.lang.getText("LEVEL_SMALL") + loc2.level;
			this._txtDescription.text = loc2.description;
			this._ldrIcon.contentParams = loc2.params;
			this._ldrIcon.contentPath = loc2.iconFile;
			this._bShowBaseEffects = false;
			this.updateCurrentTabInformations();
			if(loc2.superType == 2)
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
			this._lblPrice.text = loc2.price != undefined?new ank.utils.(loc2.price).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3):"";
			this._lblWeight.text = loc2.weight + " " + ank.utils.PatternDecoder.combine(this._parent.api.lang.getText("PODS"),"m",loc2.weight < 2);
			if(loc2.isEthereal)
			{
				var loc3 = loc2.etherealResistance;
				this._pbEthereal.maximum = loc3.param3;
				this._pbEthereal.value = loc3.param2;
				this._pbEthereal._visible = true;
				if(loc3.param2 < 4)
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
			this._ldrTwoHanded._visible = loc2.needTwoHands;
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
		var loc2 = new ank.utils.();
		switch(this._sCurrentTab)
		{
			case "Effects":
				for(var s in this._oItem.effects)
				{
					if(this._oItem.effects[s].description.length > 0)
					{
						loc2.push(this._oItem.effects[s]);
					}
				}
				break;
			case "Characteristics":
				for(var s in this._oItem.characteristics)
				{
					if(this._oItem.characteristics[s].length > 0)
					{
						loc2.push(this._oItem.characteristics[s]);
					}
				}
				break;
			case "Conditions":
				for(var s in this._oItem.conditions)
				{
					if(this._oItem.conditions[s].length > 0)
					{
						loc2.push(this._oItem.conditions[s]);
					}
				}
		}
		break loop2;
	}
	function setCurrentTab(loc2)
	{
		this._bShowBaseEffects = false;
		var loc3 = this["_btnTab" + this._sCurrentTab];
		var loc4 = this["_btnTab" + loc2];
		loc3.selected = true;
		loc3.enabled = true;
		loc4.selected = false;
		if(loc2 != "Effects")
		{
			loc4.enabled = false;
		}
		this._sCurrentTab = loc2;
		this.updateCurrentTabInformations();
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_btnTabEffects":
				if(this._sCurrentTab == "Effects")
				{
					var loc3 = this["_btnTab" + this._sCurrentTab];
					loc3.selected = false;
					if(this._bShowBaseEffects)
					{
						this.updateCurrentTabInformations();
					}
					else
					{
						var loc4 = this.api.lang.getItemStats(this._oItem.unicID);
						if(loc4 != undefined)
						{
							var loc5 = new ank.utils.();
							var loc6 = new Array();
							var loc7 = loc4.split(",");
							var loc8 = 0;
							while(loc8 < loc7.length)
							{
								var loc9 = loc7[loc8].split("#");
								loc9[0] = _global.parseInt(loc9[0],16);
								loc9[1] = loc9[1] != "0"?_global.parseInt(loc9[1],16):undefined;
								loc9[2] = loc9[2] != "0"?_global.parseInt(loc9[2],16):undefined;
								loc9[3] = loc9[3] != "0"?_global.parseInt(loc9[3],16):undefined;
								loc6.push(loc9);
								loc8 = loc8 + 1;
							}
							var loc10 = dofus.datacenter.Item.getItemDescriptionEffects(loc6);
							for(var s in loc10)
							{
								if(loc10[s].description.length > 0)
								{
									loc5.push(loc10[s]);
								}
							}
							loc5.reverse();
							this._lstInfos.dataProvider = loc5;
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
				var loc11 = this.api.ui.createPopupMenu();
				loc11.addStaticItem(this._oItem.name);
				if(this._bUseButton && this._oItem.canUse)
				{
					loc11.addItem(this._parent.api.lang.getText("CLICK_TO_USE"),this,this.dispatchEvent,[{type:"useItem",item:this._oItem}]);
				}
				loc11.addItem(this._parent.api.lang.getText("CLICK_TO_INSERT"),this.api.kernel.GameManager,this.api.kernel.GameManager.insertItemInChat,[this._oItem]);
				if(this._bTargetButton && this._oItem.canTarget)
				{
					loc11.addItem(this._parent.api.lang.getText("CLICK_TO_TARGET"),this,this.dispatchEvent,[{type:"targetItem",item:this._oItem}]);
				}
				loc11.addItem(this._parent.api.lang.getText("ASSOCIATE_RECEIPTS"),this.api.ui,this.api.ui.loadUIComponent,["ItemUtility","ItemUtility",{item:this._oItem}]);
				if(this._bDestroyButton && this._oItem.canDestroy)
				{
					loc11.addItem(this._parent.api.lang.getText("CLICK_TO_DESTROY"),this,this.dispatchEvent,[{type:"destroyItem",item:this._oItem}]);
				}
				loc11.show(_root._xmouse,_root._ymouse);
				break;
		}
	}
	function over(loc2)
	{
		switch(loc2.target._name)
		{
			case "_pbEthereal":
				var loc3 = this._oItem.etherealResistance;
				this.gapi.showTooltip(loc3.description,loc2.target,-20);
				break;
			case "_ldrTwoHanded":
				this.gapi.showTooltip(this.api.lang.getText("TWO_HANDS_WEAPON"),this._ldrTwoHanded,-20);
		}
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
}
