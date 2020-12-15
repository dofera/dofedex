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
	function __set__sliderOutWidth(var2)
	{
		this._nSliderOutWidth = Number(var2);
		return this.__get__sliderOutWidth();
	}
	function __get__sliderOutWidth()
	{
		return this._nSliderOutWidth;
	}
	function __set__sliderInWidth(var2)
	{
		this._nSliderInWidth = Number(var2);
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
		var var2 = this._mcColorsCross._x / Math.floor(this._nColorsWidth);
		var var3 = Math.floor(var2 * (ank.gapi.controls.ColorPicker.RATIOS_V.length - 1));
		var2 = var2 * 255;
		var var4 = 255 * (1 - (ank.gapi.controls.ColorPicker.RATIOS_V[var3 + 1] - var2) / (ank.gapi.controls.ColorPicker.RATIOS_V[var3 + 1] - ank.gapi.controls.ColorPicker.RATIOS_V[var3]));
		var var5 = ank.gapi.controls.ColorPicker.COLORS_V[var3];
		var var6 = ank.gapi.controls.ColorPicker.COLORS_V[var3 + 1];
		var var7 = var5 & 16711680;
		var var8 = var5 & 65280;
		var var9 = var5 & 255;
		var var10 = var6 & 16711680;
		var var11 = var6 & 65280;
		var var12 = var6 & 255;
		if(var7 != var10)
		{
			var var13 = Math.round(var7 <= var10?var4:255 - var4);
		}
		else
		{
			var13 = var7 >> 16;
		}
		if(var8 != var11)
		{
			var var14 = Math.round(var8 <= var11?var4:255 - var4);
		}
		else
		{
			var14 = var8 >> 8;
		}
		if(var9 != var12)
		{
			var var15 = Math.round(var9 <= var12?var4:255 - var4);
		}
		else
		{
			var15 = var9;
		}
		var var16 = this._mcColorsCross._y / this.__height * 255;
		var13 = var13 + (127 - var13) * var16 / 255;
		var14 = var14 + (127 - var14) * var16 / 255;
		var15 = var15 + (127 - var15) * var16 / 255;
		return (var13 << 16) + (var14 << 8) + var15;
	}
	function placeColorsCross(nX, nY)
	{
		this._mcColorsCross._x = nX;
		this._mcColorsCross._y = nY;
	}
	function placeSliderCross(nX, nY)
	{
		this._mcSliderCross._x = nX;
		this._mcSliderCross._y = nY;
	}
	function setColor(var2)
	{
		var var3 = ((var2 & 16711680) >> 16) / 255;
		var var4 = ((var2 & 65280) >> 8) / 255;
		var var5 = (var2 & 255) / 255;
		var var6 = Math.min(Math.min(var3,var4),var5);
		var var7 = Math.max(Math.max(var3,var4),var5);
		var var8 = var7 - var6;
		var var9 = Math.acos((var3 - var4 + (var3 - var5)) / 2 / Math.sqrt(Math.pow(var3 - var4,2) + (var3 - var5) * (var4 - var5)));
		var var10 = (var7 + var6) / 2;
		var var11 = var10 >= 0.5?var8 / (2 - var7 - var6):var8 / (var7 + var6);
		if(var5 > var4)
		{
			var9 = 2 * Math.PI - var9;
		}
		var var12 = Math.floor(var9 / (2 * Math.PI) * this._nColorsWidth);
		var var13 = Math.floor((1 - Math.abs(var11)) * this.__height);
		var var14 = Math.floor((1 - var10) * this.__height);
		if(_global.isNaN(var12))
		{
			var12 = 0;
		}
		this.placeColorsCross(var12,var13);
		this.placeSliderCross(this._nSliderCenterX,var14);
		var var15 = this.getGradientColor();
		this._cSliderUpColor.setRGB(var15);
		this._nLastGradiantColor = var15;
	}
	function getColor()
	{
		var var2 = 255 * (1 - this._mcSliderCross._y / Math.floor(this.__height) * 2);
		var var3 = (this._nLastGradiantColor & 16711680) >> 16;
		var var4 = (this._nLastGradiantColor & 65280) >> 8;
		var var5 = this._nLastGradiantColor & 255;
		if(var2 >= 0)
		{
			var var6 = var2 * (255 - var3) / 255 + var3;
			var var7 = var2 * (255 - var4) / 255 + var4;
			var var8 = var2 * (255 - var5) / 255 + var5;
		}
		else
		{
			var2 = var2 * -1;
			var6 = Math.round(var3 - var3 * var2 / 255);
			var7 = Math.round(var4 - var4 * var2 / 255);
			var8 = Math.round(var5 - var5 * var2 / 255);
		}
		return Math.round((var6 << 16) + (var7 << 8) + var8);
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
			var var2 = this.getGradientColor();
			this._cSliderUpColor.setRGB(var2);
			this._nLastGradiantColor = var2;
			this.dispatchEvent({type:"change",value:this.getColor()});
		}
		if(this._bMoveSliderCross)
		{
			this.dispatchEvent({type:"change",value:this.getColor()});
		}
	}
}
