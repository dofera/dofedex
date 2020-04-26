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
	function __set__min(loc2)
	{
		this._nMin = Number(loc2);
		return this.__get__min();
	}
	function __get__min()
	{
		return this._nMin;
	}
	function __set__max(loc2)
	{
		this._nMax = Number(loc2);
		return this.__get__max();
	}
	function __get__max()
	{
		return this._nMax;
	}
	function __set__value(loc2)
	{
		loc2 = Number(loc2);
		if(_global.isNaN(loc2))
		{
			return undefined;
		}
		if(loc2 > this.max)
		{
			loc2 = this.max;
		}
		if(loc2 < this.min)
		{
			loc2 = this.min;
		}
		this._nValue = loc2;
		if(this._bInitialized)
		{
			var loc3 = Math.floor((this._nMarkerCount - 1) * (loc2 - this._nMin) / (this._nMax - this._nMin));
			this.setValueByIndex(loc3);
		}
		return this.__get__value();
	}
	function __get__value()
	{
		return this._nValue;
	}
	function __set__markerCount(loc2)
	{
		if(Number(loc2) > 0)
		{
			this._nMarkerCount = Number(loc2);
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
	function __set__markerWidthRatio(loc2)
	{
		if(Number(loc2) >= 0 && Number(loc2) <= 1)
		{
			this._nMarkerWidthRatio = Number(loc2);
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
	function __set__markerSkin(loc2)
	{
		this._sMarkerSkin = loc2;
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
		var loc2 = this.__height;
		var loc3 = this.__height / 2;
		var loc4 = this.__width / this._nMarkerCount;
		var loc5 = (this.__width + loc4 * (1 - this._nMarkerWidthRatio)) / this._nMarkerCount;
		var loc6 = 0;
		while(loc6 < this._nMarkerCount)
		{
			var loc7 = this._mcMarkers["mcMarker" + loc6];
			var loc8 = this._mcOvers["mcOver" + loc6];
			var loc9 = loc8.index;
			var loc10 = loc9 / this._nMarkerCount;
			loc7._width = loc5 * this._nMarkerWidthRatio;
			loc8._width = loc5;
			loc7._height = loc3 + loc10 * (loc2 - loc3);
			loc8._height = this.__height;
			loc7._x = loc9 * loc5;
			loc7._y = this.__height;
			loc8._x = loc9 * loc5;
			loc8._y = 0;
			loc6 = loc6 + 1;
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
		var loc2 = 0;
		while(loc2 < this._nMarkerCount)
		{
			var loc3 = this._mcMarkers.attachMovie(this._sMarkerSkin,"mcMarker" + loc2,loc2);
			var loc4 = this._mcOvers.createEmptyMovieClip("mcOver" + loc2,loc2);
			this.drawRoundRect(loc4,0,0,1,1,0,16711935,0);
			loc4.index = loc2;
			this.setMovieClipColor(loc3,this.getStyle().offcolor);
			loc4.trackAsMenu = true;
			loc4.onDragOver = function()
			{
				this._parent._parent.dragOver({target:this});
			};
			loc4.onPress = function()
			{
				this._parent._parent.press({target:this});
			};
			loc2 = loc2 + 1;
		}
	}
	function setValueByIndex(loc2)
	{
		if(loc2 > this._nMarkerCount - 1)
		{
			return undefined;
		}
		if(loc2 < 0)
		{
			return undefined;
		}
		if(loc2 == undefined)
		{
			return undefined;
		}
		var loc3 = this.getStyle().oncolor;
		var loc4 = this.getStyle().offcolor;
		var loc5 = 0;
		while(loc5 <= loc2)
		{
			this.setMovieClipColor(this._mcMarkers["mcMarker" + loc5],loc3);
			loc5 = loc5 + 1;
		}
		var loc6 = loc2 + 1;
		while(loc6 < this._nMarkerCount)
		{
			this.setMovieClipColor(this._mcMarkers["mcMarker" + loc6],loc4);
			loc6 = loc6 + 1;
		}
	}
	function getValueByIndex(loc2)
	{
		return loc2 * (this._nMax - this._nMin) / (this._nMarkerCount - 1) + this._nMin;
	}
	function dragOver(loc2)
	{
		this.value = this.getValueByIndex(loc2.target.index);
		this.dispatchEvent({type:"change"});
	}
	function press(loc2)
	{
		this.value = this.getValueByIndex(loc2.target.index);
		this.dispatchEvent({type:"change"});
	}
}
