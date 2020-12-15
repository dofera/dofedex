class ank.gapi.controls.VolumeSlider extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "VolumeSlider";
	var _nMin = 0;
	var _nMax = 100;
	var _nValue = 0;
	var _nMarkerCount = 5;
	var _nMarkerWidthRatio = 0.7;
	var _sMarkerSkin = "VolumeSliderMarkerDefault";
	function VolumeSlider()
	{
		super();
	}
	function __set__min(var2)
	{
		this._nMin = Number(var2);
		return this.__get__min();
	}
	function __get__min()
	{
		return this._nMin;
	}
	function __set__max(var2)
	{
		this._nMax = Number(var2);
		return this.__get__max();
	}
	function __get__max()
	{
		return this._nMax;
	}
	function __set__value(var2)
	{
		var2 = Number(var2);
		if(_global.isNaN(var2))
		{
			return undefined;
		}
		if(var2 > this.max)
		{
			var2 = this.max;
		}
		if(var2 < this.min)
		{
			var2 = this.min;
		}
		this._nValue = var2;
		if(this._bInitialized)
		{
			var var3 = Math.floor((this._nMarkerCount - 1) * (var2 - this._nMin) / (this._nMax - this._nMin));
			this.setValueByIndex(var3);
		}
		return this.__get__value();
	}
	function __get__value()
	{
		return this._nValue;
	}
	function __set__markerCount(var2)
	{
		if(Number(var2) > 0)
		{
			this._nMarkerCount = Number(var2);
		}
		else
		{
			ank.utils.Logger.err("[markerCount] ne peut être < à 0");
		}
		return this.__get__markerCount();
	}
	function __get__markerWidth()
	{
		return this._nMarkerCount;
	}
	function __set__markerWidthRatio(var2)
	{
		if(Number(var2) >= 0 && Number(var2) <= 1)
		{
			this._nMarkerWidthRatio = Number(var2);
		}
		else
		{
			ank.utils.Logger.err("[markerCount] ne peut être < à 0 et > 1");
		}
		return this.__get__markerWidthRatio();
	}
	function __get__markerWidthRatio()
	{
		return this._nMarkerWidthRatio;
	}
	function __set__markerSkin(var2)
	{
		this._sMarkerSkin = var2;
		return this.__get__markerSkin();
	}
	function __get__markerSkin()
	{
		return this._sMarkerSkin;
	}
	function redraw()
	{
		this.createMarkers();
		this.arrange();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.VolumeSlider.CLASS_NAME);
	}
	function createChildren()
	{
		this.createMarkers();
	}
	function arrange()
	{
		var var2 = this.__height;
		var var3 = this.__height / 2;
		var var4 = this.__width / this._nMarkerCount;
		var var5 = (this.__width + var4 * (1 - this._nMarkerWidthRatio)) / this._nMarkerCount;
		var var6 = 0;
		while(var6 < this._nMarkerCount)
		{
			var var7 = this._mcMarkers["mcMarker" + var6];
			var var8 = this._mcOvers["mcOver" + var6];
			var var9 = var8.index;
			var var10 = var9 / this._nMarkerCount;
			var7._width = var5 * this._nMarkerWidthRatio;
			var8._width = var5;
			var7._height = var3 + var10 * (var2 - var3);
			var8._height = this.__height;
			var7._x = var9 * var5;
			var7._y = this.__height;
			var8._x = var9 * var5;
			var8._y = 0;
			var6 = var6 + 1;
		}
	}
	function draw()
	{
		this.addToQueue({object:this,method:function()
		{
			this.value = this._nValue;
		}});
	}
	function createMarkers()
	{
		this._mcMarkers.removeMovieClip();
		this.createEmptyMovieClip("_mcOvers",10);
		this.createEmptyMovieClip("_mcMarkers",20);
		var var2 = 0;
		while(var2 < this._nMarkerCount)
		{
			var var3 = this._mcMarkers.attachMovie(this._sMarkerSkin,"mcMarker" + var2,var2);
			var var4 = this._mcOvers.createEmptyMovieClip("mcOver" + var2,var2);
			this.drawRoundRect(var4,0,0,1,1,0,16711935,0);
			var4.index = var2;
			this.setMovieClipColor(var3,this.getStyle().offcolor);
			var4.trackAsMenu = true;
			var4.onDragOver = function()
			{
				this._parent._parent.dragOver({target:this});
			};
			var4.onPress = function()
			{
				this._parent._parent.press({target:this});
			};
			var2 = var2 + 1;
		}
	}
	function setValueByIndex(var2)
	{
		if(var2 > this._nMarkerCount - 1)
		{
			return undefined;
		}
		if(var2 < 0)
		{
			return undefined;
		}
		if(var2 == undefined)
		{
			return undefined;
		}
		var var3 = this.getStyle().oncolor;
		var var4 = this.getStyle().offcolor;
		var var5 = 0;
		while(var5 <= var2)
		{
			this.setMovieClipColor(this._mcMarkers["mcMarker" + var5],var3);
			var5 = var5 + 1;
		}
		var var6 = var2 + 1;
		while(var6 < this._nMarkerCount)
		{
			this.setMovieClipColor(this._mcMarkers["mcMarker" + var6],var4);
			var6 = var6 + 1;
		}
	}
	function getValueByIndex(var2)
	{
		return var2 * (this._nMax - this._nMin) / (this._nMarkerCount - 1) + this._nMin;
	}
	function dragOver(var2)
	{
		this.value = this.getValueByIndex(var2.target.index);
		this.dispatchEvent({type:"change"});
	}
	function press(var2)
	{
		this.value = this.getValueByIndex(var2.target.index);
		this.dispatchEvent({type:"change"});
	}
}
