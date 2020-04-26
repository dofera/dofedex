class ank.gapi.controls.ColorPicker extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ColorPicker";
	static var MATRIX_V = {matrixType:"box",x:0,y:0,w:1,h:1,r:0};
	static var MATRIX_H = {matrixType:"box",x:0,y:0,w:1,h:1,r:Math.PI / 2};
	static var COLORS_V = [16711680,16776960,65280,65535,255,16711935,16711680];
	static var ALPHAS_V = [100,100,100,100,100,100,100];
	static var RATIOS_V = [0,42.5,85,127.5,170,212.5,255];
	static var COLORS_H = [8421504,8421504];
	static var ALPHAS_H = [0,100];
	static var RATIOS_H = [0,255];
	static var COLORS_SLIDER = [16711680,16711680,16711680];
	static var ALPHAS_SLIDER = [0,100,0];
	static var RATIOS_SLIDER = [0,127.5,255];
	var _nSliderOutWidth = 30;
	var _nSliderInWidth = 10;
	var _bMoveColorsCross = false;
	var _bMoveSliderCross = false;
	function ColorPicker()
	{
		super();
	}
	function __set__sliderOutWidth(loc2)
	{
		this._nSliderOutWidth = Number(loc2);
		return this.__get__sliderOutWidth();
	}
	function __get__sliderOutWidth()
	{
		return this._nSliderOutWidth;
	}
	function __set__sliderInWidth(loc2)
	{
		this._nSliderInWidth = Number(loc2);
		return this.__get__sliderInWidth();
	}
	function __get__sliderInWidth()
	{
		return this._nSliderInWidth;
	}
	function init()
	{
		super.init(false,ank.gapi.controls.ColorPicker.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcColorsV",10);
		this.createEmptyMovieClip("_mcColorsH",20);
		this.createEmptyMovieClip("_mcSlider",30);
		this.createEmptyMovieClip("_mcSliderUp",40);
		this._cSliderUpColor = new Color(this._mcSliderUp);
		this.attachMovie("ColorPickerColorsCross","_mcColorsCross",50);
		this.attachMovie("ColorPickerSliderCross","_mcSliderCross",60);
		this._mcColorsV.onPress = function()
		{
			this._parent.onStartColorsCrossMove();
		};
		this._mcColorsV.onRelease = this._mcColorsV.onReleaseOutside = function()
		{
			this._parent.onStopColorsCrossMove();
		};
		this._mcSlider.onPress = function()
		{
			this._parent.onStartSliderCrossMove();
		};
		this._mcSlider.onRelease = this._mcSlider.onReleaseOutside = function()
		{
			this._parent.onStopSliderCrossMove();
		};
	}
	function arrange()
	{
		this._mcColorsV._width = this._mcColorsH._width = this.__width - this._nSliderOutWidth;
		this._mcColorsV._height = this._mcColorsH._height = this.__height;
		this._mcSlider._x = this._mcSliderUp._x = this.__width - (this._nSliderOutWidth + this._nSliderInWidth) / 2;
		this._mcSlider._width = this._mcSliderUp._width = this._nSliderInWidth;
		this._mcSlider._height = this._mcSliderUp._height = this.__height;
		this._nColorsWidth = this.__width - 30;
		this._nSliderCenterX = this.__width - this._nSliderOutWidth / 2;
		this.placeSliderCross(this._nSliderCenterX,this.__height / 2);
	}
	function draw()
	{
		this.drawRoundRect(this._mcColorsV,0,0,1,1,0,ank.gapi.controls.ColorPicker.COLORS_V,ank.gapi.controls.ColorPicker.ALPHAS_V,ank.gapi.controls.ColorPicker.MATRIX_V,"linear",ank.gapi.controls.ColorPicker.RATIOS_V);
		this.drawRoundRect(this._mcColorsH,0,0,1,1,0,ank.gapi.controls.ColorPicker.COLORS_H,ank.gapi.controls.ColorPicker.ALPHAS_H,ank.gapi.controls.ColorPicker.MATRIX_H,"linear",ank.gapi.controls.ColorPicker.RATIOS_H);
		this.drawRoundRect(this._mcSlider,0,0,1,0.5,0,16777215);
		this.drawRoundRect(this._mcSlider,0,0.5,1,0.5,0,0);
		this.drawRoundRect(this._mcSliderUp,0,0,1,1,0,ank.gapi.controls.ColorPicker.COLORS_SLIDER,ank.gapi.controls.ColorPicker.ALPHAS_SLIDER,ank.gapi.controls.ColorPicker.MATRIX_H,"linear",ank.gapi.controls.ColorPicker.RATIOS_SLIDER);
	}
	function getGradientColor()
	{
		var loc2 = this._mcColorsCross._x / Math.floor(this._nColorsWidth);
		var loc3 = Math.floor(loc2 * (ank.gapi.controls.ColorPicker.RATIOS_V.length - 1));
		loc2 = loc2 * 255;
		var loc4 = 255 * (1 - (ank.gapi.controls.ColorPicker.RATIOS_V[loc3 + 1] - loc2) / (ank.gapi.controls.ColorPicker.RATIOS_V[loc3 + 1] - ank.gapi.controls.ColorPicker.RATIOS_V[loc3]));
		var loc5 = ank.gapi.controls.ColorPicker.COLORS_V[loc3];
		var loc6 = ank.gapi.controls.ColorPicker.COLORS_V[loc3 + 1];
		var loc7 = loc5 & 16711680;
		var loc8 = loc5 & 65280;
		var loc9 = loc5 & 255;
		var loc10 = loc6 & 16711680;
		var loc11 = loc6 & 65280;
		var loc12 = loc6 & 255;
		if(loc7 != loc10)
		{
			var loc13 = Math.round(loc7 <= loc10?loc4:255 - loc4);
		}
		else
		{
			loc13 = loc7 >> 16;
		}
		if(loc8 != loc11)
		{
			var loc14 = Math.round(loc8 <= loc11?loc4:255 - loc4);
		}
		else
		{
			loc14 = loc8 >> 8;
		}
		if(loc9 != loc12)
		{
			var loc15 = Math.round(loc9 <= loc12?loc4:255 - loc4);
		}
		else
		{
			loc15 = loc9;
		}
		var loc16 = this._mcColorsCross._y / this.__height * 255;
		loc13 = loc13 + (127 - loc13) * loc16 / 255;
		loc14 = loc14 + (127 - loc14) * loc16 / 255;
		loc15 = loc15 + (127 - loc15) * loc16 / 255;
		return (loc13 << 16) + (loc14 << 8) + loc15;
	}
	function placeColorsCross(loc2, loc3)
	{
		this._mcColorsCross._x = loc2;
		this._mcColorsCross._y = loc3;
	}
	function placeSliderCross(loc2, loc3)
	{
		this._mcSliderCross._x = loc2;
		this._mcSliderCross._y = loc3;
	}
	function setColor(loc2)
	{
		var loc3 = ((loc2 & 16711680) >> 16) / 255;
		var loc4 = ((loc2 & 65280) >> 8) / 255;
		var loc5 = (loc2 & 255) / 255;
		var loc6 = Math.min(Math.min(loc3,loc4),loc5);
		var loc7 = Math.max(Math.max(loc3,loc4),loc5);
		var loc8 = loc7 - loc6;
		var loc9 = Math.acos((loc3 - loc4 + (loc3 - loc5)) / 2 / Math.sqrt(Math.pow(loc3 - loc4,2) + (loc3 - loc5) * (loc4 - loc5)));
		var loc10 = (loc7 + loc6) / 2;
		var loc11 = loc10 >= 0.5?loc8 / (2 - loc7 - loc6):loc8 / (loc7 + loc6);
		if(loc5 > loc4)
		{
			loc9 = 2 * Math.PI - loc9;
		}
		var loc12 = Math.floor(loc9 / (2 * Math.PI) * this._nColorsWidth);
		var loc13 = Math.floor((1 - Math.abs(loc11)) * this.__height);
		var loc14 = Math.floor((1 - loc10) * this.__height);
		if(_global.isNaN(loc12))
		{
			loc12 = 0;
		}
		this.placeColorsCross(loc12,loc13);
		this.placeSliderCross(this._nSliderCenterX,loc14);
		var loc15 = this.getGradientColor();
		this._cSliderUpColor.setRGB(loc15);
		this._nLastGradiantColor = loc15;
	}
	function getColor()
	{
		var loc2 = 255 * (1 - this._mcSliderCross._y / Math.floor(this.__height) * 2);
		var loc3 = (this._nLastGradiantColor & 16711680) >> 16;
		var loc4 = (this._nLastGradiantColor & 65280) >> 8;
		var loc5 = this._nLastGradiantColor & 255;
		if(loc2 >= 0)
		{
			var loc6 = loc2 * (255 - loc3) / 255 + loc3;
			var loc7 = loc2 * (255 - loc4) / 255 + loc4;
			var loc8 = loc2 * (255 - loc5) / 255 + loc5;
		}
		else
		{
			loc2 = loc2 * -1;
			loc6 = Math.round(loc3 - loc3 * loc2 / 255);
			loc7 = Math.round(loc4 - loc4 * loc2 / 255);
			loc8 = Math.round(loc5 - loc5 * loc2 / 255);
		}
		return Math.round((loc6 << 16) + (loc7 << 8) + loc8);
	}
	function onStartColorsCrossMove()
	{
		this._bMoveColorsCross = true;
		this.placeColorsCross(this._xmouse,this._ymouse);
		this._mcColorsCross.startDrag(true,0,0,this._nColorsWidth - 1,this.__height);
		this._nLastGradiantColor = this.getGradientColor();
		this._cSliderUpColor.setRGB(this._nLastGradiantColor);
		this.dispatchEvent({type:"change",value:this.getColor()});
	}
	function onStopColorsCrossMove()
	{
		this._bMoveColorsCross = false;
		this._mcColorsCross.stopDrag();
	}
	function onStartSliderCrossMove()
	{
		this._bMoveSliderCross = true;
		this.placeSliderCross(this._nSliderCenterX,this._ymouse);
		this._mcSliderCross.startDrag(true,this._nSliderCenterX,0,this._nSliderCenterX,this.__height);
		this._nLastGradiantColor = this.getGradientColor();
		this.dispatchEvent({type:"change",value:this.getColor()});
	}
	function onStopSliderCrossMove()
	{
		this._bMoveSliderCross = false;
		this._mcSliderCross.stopDrag();
	}
	function onMouseMove()
	{
		if(this._bMoveColorsCross)
		{
			var loc2 = this.getGradientColor();
			this._cSliderUpColor.setRGB(loc2);
			this._nLastGradiantColor = loc2;
			this.dispatchEvent({type:"change",value:this.getColor()});
		}
		if(this._bMoveSliderCross)
		{
			this.dispatchEvent({type:"change",value:this.getColor()});
		}
	}
}
