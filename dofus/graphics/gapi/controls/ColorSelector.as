class dofus.graphics.gapi.controls.ColorSelector extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ColorSelector";
	static var MAXIMUM_COLOR_INDEX = 3;
	var _nSelectedColorIndex = 1;
	static var HEX_CHARS = ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
	function ColorSelector()
	{
		super();
	}
	function __set__colors(loc2)
	{
		this.addToQueue({object:this,method:this.applyColor,params:[loc2[0],1]});
		this.addToQueue({object:this,method:this.applyColor,params:[loc2[1],2]});
		this.addToQueue({object:this,method:this.applyColor,params:[loc2[2],3]});
		return this.__get__colors();
	}
	function __set__breed(loc2)
	{
		this._nBreed = loc2;
		return this.__get__breed();
	}
	function __set__sex(loc2)
	{
		this._nSex = loc2;
		return this.__get__sex();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.ColorSelector.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function initData()
	{
		this._oColors = {color1:-1,color2:-1,color3:-1};
		this._oBakColors = {color1:-1,color2:-1,color3:-1};
	}
	function addListeners()
	{
		this._btnColor1.addEventListener("click",this);
		this._btnColor2.addEventListener("click",this);
		this._btnColor3.addEventListener("click",this);
		this._btnColor1.addEventListener("over",this);
		this._btnColor2.addEventListener("over",this);
		this._btnColor3.addEventListener("over",this);
		this._btnColor1.addEventListener("out",this);
		this._btnColor2.addEventListener("out",this);
		this._btnColor3.addEventListener("out",this);
		this._cpColorPicker.addEventListener("change",this);
		this._btnReset.addEventListener("click",this);
		this._btnReset.addEventListener("over",this);
		this._btnReset.addEventListener("out",this);
		var ref = this;
		this._mcRandomColor1.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcRandomColor2.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcRandomColor3.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcRandomAll.onPress = function()
		{
			ref.click({target:this});
		};
		this._mcRandomColor1.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcRandomColor2.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcRandomColor3.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcRandomAll.onRollOver = function()
		{
			ref.over({target:this});
		};
		this._mcRandomColor1.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcRandomColor2.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcRandomColor3.onRollOut = function()
		{
			ref.out({target:this});
		};
		this._mcRandomAll.onRollOut = function()
		{
			ref.out({target:this});
		};
	}
	function setColorIndex(loc2)
	{
		var loc3 = this["_btnColor" + this._nSelectedColorIndex];
		var loc4 = this["_btnColor" + loc2];
		loc3.selected = false;
		loc4.selected = true;
		this._nSelectedColorIndex = loc2;
	}
	function applyColor(loc2, loc3)
	{
		if(loc3 == undefined)
		{
			loc3 = this._nSelectedColorIndex;
		}
		var loc4 = {ColoredButton:{bgcolor:(loc2 != -1?loc2:16711680),highlightcolor:(loc2 != -1?loc2:16777215),bgdowncolor:(loc2 != -1?loc2:16711680),highlightdowncolor:(loc2 != -1?loc2:16777215)}};
		ank.gapi.styles.StylesManager.loadStylePackage(loc4);
		this["_btnColor" + loc3].styleName = "ColoredButton";
		this._oColors["color" + loc3] = loc2;
		this._oBakColors["color" + loc3] = loc2;
	}
	function selectColor(loc2)
	{
		var loc3 = this._oBakColors["color" + loc2];
		if(loc3 != -1)
		{
			this._cpColorPicker.setColor(loc3);
		}
		this.setColorIndex(loc2);
	}
	static function d2h(loc2)
	{
		if(loc2 > 255)
		{
			loc2 = 255;
		}
		return dofus.graphics.gapi.controls.ColorSelector.HEX_CHARS[Math.floor(loc2 / 16)] + dofus.graphics.gapi.controls.ColorSelector.HEX_CHARS[loc2 % 16];
	}
	function displayColorCode(loc2)
	{
		this.selectColor(loc2);
		var loc3 = (this._oColors["color" + loc2] & 16711680) >> 16;
		var loc4 = (this._oColors["color" + loc2] & 65280) >> 8;
		var loc5 = this._oColors["color" + loc2] & 255;
		var loc6 = dofus.graphics.gapi.controls.ColorSelector.d2h(loc3) + dofus.graphics.gapi.controls.ColorSelector.d2h(loc4) + dofus.graphics.gapi.controls.ColorSelector.d2h(loc5);
		if(this._oColors["color" + loc2] == undefined || this._oColors["color" + loc2] == -1)
		{
			loc6 = "";
		}
		var loc7 = this.gapi.loadUIComponent("PopupHexa","PopupHexa",{value:loc6,params:{targetType:"colorCode",colorIndex:loc2}});
		loc7.addEventListener("validate",this);
	}
	function setColor(loc2, loc3)
	{
		this.setColorIndex(loc2);
		this.change({target:this._cpColorPicker,value:loc3});
		this.click({target:this["_btnColor" + loc2]});
	}
	function hueVariation(loc2, loc3, loc4)
	{
		var loc5 = this.rgb2hsl(loc2);
		if(loc5.h < 0.5 && !loc4)
		{
			loc3 = - loc3;
		}
		loc5.h = loc5.h + loc3;
		if(loc5.h > 1)
		{
			loc5.h--;
		}
		if(loc5.h < 0)
		{
			loc5.h++;
		}
		return this.hsl2rgb(loc5.h,loc5.s,loc5.l);
	}
	function lightVariation(loc2, loc3)
	{
		var loc4 = this.rgb2hsl(loc2);
		loc4.l = loc4.l + loc3;
		if(loc4.l > 1)
		{
			loc4.l = 1;
		}
		if(loc4.l < 0)
		{
			loc4.l = 0;
		}
		return this.hsl2rgb(loc4.h,loc4.s,loc4.l);
	}
	function complementaryColor(loc2)
	{
		var loc3 = this.rgb2hsl(loc2);
		var loc4 = loc3.h + 0.5;
		if(loc4 > 1)
		{
			loc4 = loc4 - 1;
		}
		return this.hsl2rgb(loc4,loc3.s,loc3.l);
	}
	function hsl2rgb(loc2, loc3, loc4)
	{
		if(loc3 == 0)
		{
			var loc5 = loc4 * 255;
			var loc6 = loc4 * 255;
			var loc7 = loc4 * 255;
		}
		else
		{
			if(loc4 < 0.5)
			{
				var loc8 = loc4 * (1 + loc3);
			}
			else
			{
				loc8 = loc4 + loc3 - loc3 * loc4;
			}
			var loc9 = 2 * loc4 - loc8;
			loc5 = 255 * this.h2rgb(loc9,loc8,loc2 + 1 / 3);
			loc6 = 255 * this.h2rgb(loc9,loc8,loc2);
			loc7 = 255 * this.h2rgb(loc9,loc8,loc2 - 1 / 3);
		}
		return Number("0x" + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(loc5)) + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(loc6)) + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(loc7)));
	}
	function rgb2hsl(loc2)
	{
		var loc3 = ((loc2 & 16711680) >> 16) / 255;
		var loc4 = ((loc2 & 65280) >> 8) / 255;
		var loc5 = (loc2 & 255) / 255;
		var loc6 = this.min(loc3,loc4,loc5);
		var loc7 = this.max(loc3,loc4,loc5);
		var loc8 = loc7 - loc6;
		var loc9 = (loc7 + loc6) / 2;
		if(loc8 == 0)
		{
			var loc10 = 0;
			var loc11 = 0;
		}
		else
		{
			if(loc9 < 0.5)
			{
				loc11 = loc8 / (loc7 + loc6);
			}
			else
			{
				loc11 = loc8 / (2 - loc7 - loc6);
			}
			var loc12 = ((loc7 - loc3) / 6 + loc8 / 2) / loc8;
			var loc13 = ((loc7 - loc4) / 6 + loc8 / 2) / loc8;
			var loc14 = ((loc7 - loc5) / 6 + loc8 / 2) / loc8;
			if(loc3 == loc7)
			{
				loc10 = loc14 - loc13;
			}
			else if(loc4 == loc7)
			{
				loc10 = 1 / 3 + loc12 - loc14;
			}
			else if(loc5 == loc7)
			{
				loc10 = 2 / 3 + loc13 - loc12;
			}
			if(loc10 < 0)
			{
				loc10 = loc10 + 1;
			}
			if(loc10 > 1)
			{
				loc10 = loc10 - 1;
			}
		}
		return {h:loc10,s:loc11,l:loc9};
	}
	function h2rgb(loc2, loc3, loc4)
	{
		if(loc4 < 0)
		{
			loc4 = loc4 + 1;
		}
		if(loc4 > 1)
		{
			loc4 = loc4 - 1;
		}
		if(6 * loc4 < 1)
		{
			return loc2 + (loc3 - loc2) * 6 * loc4;
		}
		if(2 * loc4 < 1)
		{
			return loc3;
		}
		if(3 * loc4 < 2)
		{
			return loc2 + (loc3 - loc2) * ((2 / 3 - loc4) * 6);
		}
		return loc2;
	}
	function min()
	{
		var loc2 = Number.POSITIVE_INFINITY;
		var loc3 = 0;
		while(loc3 < arguments.length)
		{
			if(!_global.isNaN(Number(arguments[loc3])) && loc2 > Number(arguments[loc3]))
			{
				loc2 = Number(arguments[loc3]);
			}
			loc3 = loc3 + 1;
		}
		return loc2;
	}
	function max()
	{
		var loc2 = Number.NEGATIVE_INFINITY;
		var loc3 = 0;
		while(loc3 < arguments.length)
		{
			if(!_global.isNaN(Number(arguments[loc3])) && loc2 < Number(arguments[loc3]))
			{
				loc2 = Number(arguments[loc3]);
			}
			loc3 = loc3 + 1;
		}
		return loc2;
	}
	function isSkin(loc2)
	{
		return dofus.Constants.BREED_SKIN_INDEXES[this._nSex][this._nBreed - 1] == loc2;
	}
	function randomSkin()
	{
		return this.lightVariation(dofus.Constants.BREED_SKIN_BASE_COLOR[this._nSex][this._nBreed - 1],Math.random() * 0.2 * (Math.random() <= 0.5?-1:1));
	}
	function click(loc2)
	{
		loop1:
		switch(loc2.target)
		{
			case this._btnColor1:
			case this._btnColor2:
			case this._btnColor3:
				var loc3 = Number(loc2.target._name.substr(9));
				if(Key.isDown(Key.SHIFT))
				{
					this.displayColorCode(loc3);
				}
				else if(Key.isDown(Key.CONTROL))
				{
					this.applyColor(-1,loc3);
				}
				else
				{
					this.selectColor(loc3);
				}
				break;
			default:
				switch(null)
				{
					case this._mcRandomColor1:
					case this._mcRandomColor2:
					case this._mcRandomColor3:
						var loc4 = Number(loc2.target._name.substr(14));
						this.setColor(loc4,Math.round(Math.random() * 16777215));
						break loop1;
					case this._mcRandomAll:
						var loc5 = Math.floor(Math.random() * dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX);
						var loc6 = Math.ceil(Math.random() * 16777215);
						this.setColor(loc5,!this.isSkin(loc5)?loc6:this.randomSkin());
						loc5 = loc5 + 1;
						if(loc5 > dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
						{
							loc5 = loc5 - dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX;
						}
						this.setColor(loc5,!this.isSkin(loc5)?this.complementaryColor(loc6):this.randomSkin());
						loc5 = loc5 + 1;
						if(loc5 > dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
						{
							loc5 = loc5 - dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX;
						}
						this.setColor(loc5,!this.isSkin(loc5)?this.hueVariation(loc6,Math.random()):this.randomSkin());
						break loop1;
					default:
						if(loc0 !== this._btnReset)
						{
							break loop1;
						}
						var loc7 = 1;
						while(loc7 <= dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
						{
							this.applyColor(-1,loc7);
							loc7 = loc7 + 1;
						}
						this.dispatchEvent({type:"change",value:this._oColors});
						break loop1;
				}
		}
	}
	function over(loc2)
	{
		loop0:
		switch(loc2.target)
		{
			case this._btnColor1:
			case this._btnColor2:
			case this._btnColor3:
				var loc3 = Number(loc2.target._name.substr(9));
				this.dispatchEvent({type:"over",index:loc3});
				break;
			default:
				switch(null)
				{
					case this._btnReset:
						this.gapi.showTooltip(this.api.lang.getText("REINIT_WORD"),loc2.target,-20);
						break loop0;
					case this._mcRandomColor1:
					case this._mcRandomColor2:
					case this._mcRandomColor3:
						this.gapi.showTooltip(this.api.lang.getText("RANDOM_COLOR"),_root._xmouse,_root._ymouse - 20);
						break loop0;
					default:
						if(loc0 !== this._mcRandomAll)
						{
							break loop0;
						}
						this.gapi.showTooltip(this.api.lang.getText("RANDOM_ALL_COLORS"),_root._xmouse,_root._ymouse - 20);
						break loop0;
				}
		}
	}
	function out(loc2)
	{
		switch(loc2.target)
		{
			case this._btnColor1:
			case this._btnColor2:
			case this._btnColor3:
				var loc3 = Number(loc2.target._name.substr(9));
				this.dispatchEvent({type:"out",index:loc3});
				break;
			default:
				this.gapi.hideTooltip();
		}
	}
	function change(loc2)
	{
		if((var loc0 = loc2.target) === this._cpColorPicker)
		{
			this.applyColor(loc2.value);
			this.dispatchEvent({type:"change",value:this._oColors});
		}
	}
	function validate(loc2)
	{
		if((var loc0 = loc2.params.targetType) === "colorCode")
		{
			if(!(_global.isNaN(loc2.value) || (loc2.value > 16777215 || loc2.value == undefined)))
			{
				this.setColor(loc2.params.colorIndex,loc2.value);
			}
		}
	}
}
