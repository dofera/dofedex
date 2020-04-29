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
	function __set__colors(var2)
	{
		this.addToQueue({object:this,method:this.applyColor,params:[var2[0],1]});
		this.addToQueue({object:this,method:this.applyColor,params:[var2[1],2]});
		this.addToQueue({object:this,method:this.applyColor,params:[var2[2],3]});
		return this.__get__colors();
	}
	function __set__breed(var2)
	{
		this._nBreed = var2;
		return this.__get__breed();
	}
	function __set__sex(var2)
	{
		this._nSex = var2;
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
	function setColorIndex(var2)
	{
		var var3 = this["_btnColor" + this._nSelectedColorIndex];
		var var4 = this["_btnColor" + var2];
		var3.selected = false;
		var4.selected = true;
		this._nSelectedColorIndex = var2;
	}
	function applyColor(var2, var3)
	{
		if(var3 == undefined)
		{
			var3 = this._nSelectedColorIndex;
		}
		var var4 = {ColoredButton:{bgcolor:(var2 != -1?var2:16711680),highlightcolor:(var2 != -1?var2:16777215),bgdowncolor:(var2 != -1?var2:16711680),highlightdowncolor:(var2 != -1?var2:16777215)}};
		ank.gapi.styles.StylesManager.loadStylePackage(var4);
		this["_btnColor" + var3].styleName = "ColoredButton";
		this._oColors["color" + var3] = var2;
		this._oBakColors["color" + var3] = var2;
	}
	function selectColor(var2)
	{
		var var3 = this._oBakColors["color" + var2];
		if(var3 != -1)
		{
			this._cpColorPicker.setColor(var3);
		}
		this.setColorIndex(var2);
	}
	static function d2h(var2)
	{
		if(var2 > 255)
		{
			var2 = 255;
		}
		return dofus.graphics.gapi.controls.ColorSelector.HEX_CHARS[Math.floor(var2 / 16)] + dofus.graphics.gapi.controls.ColorSelector.HEX_CHARS[var2 % 16];
	}
	function displayColorCode(var2)
	{
		this.selectColor(var2);
		var var3 = (this._oColors["color" + var2] & 16711680) >> 16;
		var var4 = (this._oColors["color" + var2] & 65280) >> 8;
		var var5 = this._oColors["color" + var2] & 255;
		var var6 = dofus.graphics.gapi.controls.ColorSelector.d2h(var3) + dofus.graphics.gapi.controls.ColorSelector.d2h(var4) + dofus.graphics.gapi.controls.ColorSelector.d2h(var5);
		if(this._oColors["color" + var2] == undefined || this._oColors["color" + var2] == -1)
		{
			var6 = "";
		}
		var var7 = this.gapi.loadUIComponent("PopupHexa","PopupHexa",{value:var6,params:{targetType:"colorCode",colorIndex:var2}});
		var7.addEventListener("validate",this);
	}
	function setColor(var2, var3)
	{
		this.setColorIndex(var2);
		this.change({target:this._cpColorPicker,value:var3});
		this.click({target:this["_btnColor" + var2]});
	}
	function hueVariation(var2, var3, var4)
	{
		var var5 = this.rgb2hsl(var2);
		if(var5.h < 0.5 && !var4)
		{
			var3 = - var3;
		}
		var5.h = var5.h + var3;
		if(var5.h > 1)
		{
			var5.h--;
		}
		if(var5.h < 0)
		{
			var5.h++;
		}
		return this.hsl2rgb(var5.h,var5.s,var5.l);
	}
	function lightVariation(var2, var3)
	{
		var var4 = this.rgb2hsl(var2);
		var4.l = var4.l + var3;
		if(var4.l > 1)
		{
			var4.l = 1;
		}
		if(var4.l < 0)
		{
			var4.l = 0;
		}
		return this.hsl2rgb(var4.h,var4.s,var4.l);
	}
	function complementaryColor(var2)
	{
		var var3 = this.rgb2hsl(var2);
		var var4 = var3.h + 0.5;
		if(var4 > 1)
		{
			var4 = var4 - 1;
		}
		return this.hsl2rgb(var4,var3.s,var3.l);
	}
	function hsl2rgb(var2, var3, var4)
	{
		if(var3 == 0)
		{
			var var5 = var4 * 255;
			var var6 = var4 * 255;
			var var7 = var4 * 255;
		}
		else
		{
			if(var4 < 0.5)
			{
				var var8 = var4 * (1 + var3);
			}
			else
			{
				var8 = var4 + var3 - var3 * var4;
			}
			var var9 = 2 * var4 - var8;
			var5 = 255 * this.h2rgb(var9,var8,var2 + 1 / 3);
			var6 = 255 * this.h2rgb(var9,var8,var2);
			var7 = 255 * this.h2rgb(var9,var8,var2 - 1 / 3);
		}
		return Number("0x" + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(var5)) + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(var6)) + dofus.graphics.gapi.controls.ColorSelector.d2h(Math.round(var7)));
	}
	function rgb2hsl(var2)
	{
		var var3 = ((var2 & 16711680) >> 16) / 255;
		var var4 = ((var2 & 65280) >> 8) / 255;
		var var5 = (var2 & 255) / 255;
		var var6 = this.min(var3,var4,var5);
		var var7 = this.max(var3,var4,var5);
		var var8 = var7 - var6;
		var var9 = (var7 + var6) / 2;
		if(var8 == 0)
		{
			var var10 = 0;
			var var11 = 0;
		}
		else
		{
			if(var9 < 0.5)
			{
				var11 = var8 / (var7 + var6);
			}
			else
			{
				var11 = var8 / (2 - var7 - var6);
			}
			var var12 = ((var7 - var3) / 6 + var8 / 2) / var8;
			var var13 = ((var7 - var4) / 6 + var8 / 2) / var8;
			var var14 = ((var7 - var5) / 6 + var8 / 2) / var8;
			if(var3 == var7)
			{
				var10 = var14 - var13;
			}
			else if(var4 == var7)
			{
				var10 = 1 / 3 + var12 - var14;
			}
			else if(var5 == var7)
			{
				var10 = 2 / 3 + var13 - var12;
			}
			if(var10 < 0)
			{
				var10 = var10 + 1;
			}
			if(var10 > 1)
			{
				var10 = var10 - 1;
			}
		}
		return {h:var10,s:var11,l:var9};
	}
	function h2rgb(var2, var3, var4)
	{
		if(var4 < 0)
		{
			var4 = var4 + 1;
		}
		if(var4 > 1)
		{
			var4 = var4 - 1;
		}
		if(6 * var4 < 1)
		{
			return var2 + (var3 - var2) * 6 * var4;
		}
		if(2 * var4 < 1)
		{
			return var3;
		}
		if(3 * var4 < 2)
		{
			return var2 + (var3 - var2) * ((2 / 3 - var4) * 6);
		}
		return var2;
	}
	function min()
	{
		var var2 = Number.POSITIVE_INFINITY;
		var var3 = 0;
		while(var3 < arguments.length)
		{
			if(!_global.isNaN(Number(arguments[var3])) && var2 > Number(arguments[var3]))
			{
				var2 = Number(arguments[var3]);
			}
			var3 = var3 + 1;
		}
		return var2;
	}
	function max()
	{
		var var2 = Number.NEGATIVE_INFINITY;
		var var3 = 0;
		while(var3 < arguments.length)
		{
			if(!_global.isNaN(Number(arguments[var3])) && var2 < Number(arguments[var3]))
			{
				var2 = Number(arguments[var3]);
			}
			var3 = var3 + 1;
		}
		return var2;
	}
	function isSkin(var2)
	{
		return dofus.Constants.BREED_SKIN_INDEXES[this._nSex][this._nBreed - 1] == var2;
	}
	function randomSkin()
	{
		return this.lightVariation(dofus.Constants.BREED_SKIN_BASE_COLOR[this._nSex][this._nBreed - 1],Math.random() * 0.2 * (Math.random() <= 0.5?-1:1));
	}
	function click(var2)
	{
		loop1:
		switch(var2.target)
		{
			default:
				switch(null)
				{
					case this._btnColor3:
						break loop1;
					default:
						switch(null)
						{
							case this._mcRandomColor3:
								break;
							case this._mcRandomAll:
								var var5 = Math.floor(Math.random() * dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX);
								var var6 = Math.ceil(Math.random() * 16777215);
								this.setColor(var5,!this.isSkin(var5)?var6:this.randomSkin());
								var5 = var5 + 1;
								if(var5 > dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
								{
									var5 = var5 - dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX;
								}
								this.setColor(var5,!this.isSkin(var5)?this.complementaryColor(var6):this.randomSkin());
								var5 = var5 + 1;
								if(var5 > dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
								{
									var5 = var5 - dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX;
								}
								this.setColor(var5,!this.isSkin(var5)?this.hueVariation(var6,Math.random()):this.randomSkin());
								break;
							case this._btnReset:
								var var7 = 1;
								while(var7 <= dofus.graphics.gapi.controls.ColorSelector.MAXIMUM_COLOR_INDEX)
								{
									this.applyColor(-1,var7);
									var7 = var7 + 1;
								}
								this.dispatchEvent({type:"change",value:this._oColors});
						}
					case this._mcRandomColor1:
					case this._mcRandomColor2:
						var var4 = Number(var2.target._name.substr(14));
						this.setColor(var4,Math.round(Math.random() * 16777215));
				}
			case this._btnColor1:
			case this._btnColor2:
		}
		var var3 = Number(var2.target._name.substr(9));
		if(Key.isDown(Key.SHIFT))
		{
			this.displayColorCode(var3);
		}
		else if(Key.isDown(Key.CONTROL))
		{
			this.applyColor(-1,var3);
		}
		else
		{
			this.selectColor(var3);
		}
	}
	function over(var2)
	{
		loop0:
		switch(var2.target)
		{
			default:
				switch(null)
				{
					case this._btnColor3:
						break loop0;
					case this._btnReset:
						this.gapi.showTooltip(this.api.lang.getText("REINIT_WORD"),var2.target,-20);
						break;
					default:
						switch(null)
						{
							case this._mcRandomColor2:
							case this._mcRandomColor3:
								break;
							case this._mcRandomAll:
								this.gapi.showTooltip(this.api.lang.getText("RANDOM_ALL_COLORS"),_root._xmouse,_root._ymouse - 20);
						}
						break;
					case this._mcRandomColor1:
						this.gapi.showTooltip(this.api.lang.getText("RANDOM_COLOR"),_root._xmouse,_root._ymouse - 20);
				}
			case this._btnColor1:
			case this._btnColor2:
		}
		var var3 = Number(var2.target._name.substr(9));
		this.dispatchEvent({type:"over",index:var3});
	}
	function out(var2)
	{
		switch(var2.target)
		{
			case this._btnColor1:
			case this._btnColor2:
			case this._btnColor3:
				var var3 = Number(var2.target._name.substr(9));
				this.dispatchEvent({type:"out",index:var3});
				break;
			default:
				this.gapi.hideTooltip();
		}
	}
	function change(var2)
	{
		if((var var0 = var2.target) === this._cpColorPicker)
		{
			this.applyColor(var2.value);
			this.dispatchEvent({type:"change",value:this._oColors});
		}
	}
	function validate(var2)
	{
		if((var var0 = var2.params.targetType) === "colorCode")
		{
			if(!(_global.isNaN(var2.value) || (var2.value > 16777215 || var2.value == undefined)))
			{
				this.setColor(var2.params.colorIndex,var2.value);
			}
		}
	}
}
