class ank.gapi.controls.Fps extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Fps";
	var _nAverageOffset = 10;
	var _aValues = new Array();
	function Fps()
	{
		super();
	}
	function __set__averageOffset(loc2)
	{
		this._nAverageOffset = loc2;
		return this.__get__averageOffset();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.Fps.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcBack",this.getNextHighestDepth());
		this.drawRoundRect(this._mcBack,0,0,1,1,0,16777215);
		this.attachMovie("Label","_lblText",this.getNextHighestDepth(),{text:"--"});
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		this._mcBack._width = this.__width;
		this._mcBack._height = this.__height;
		this._lblText.setSize(this.__width,this.__height);
	}
	function draw()
	{
		var loc2 = this.getStyle();
		if(loc2.backcolor != undefined)
		{
			this.setMovieClipColor(this._mcBack,loc2.backcolor);
		}
		this._mcBack._alpha = loc2.backalpha;
		this._lblText.styleName = loc2.labelstyle;
	}
	function pushValue(loc2)
	{
		this._aValues.push(loc2);
		if(this._aValues.length > this._nAverageOffset)
		{
			this._aValues.shift();
		}
	}
	function getAverage()
	{
		var loc2 = 0;
		for(var k in this._aValues)
		{
			loc2 = loc2 + Number(this._aValues[k]);
		}
		return Math.round(loc2 / this._aValues.length);
	}
	function onEnterFrame()
	{
		var loc2 = getTimer();
		var loc3 = loc2 - this._nSaveTime;
		this.pushValue(1 / (loc3 / 1000));
		this._lblText.text = String(this.getAverage());
		this._nSaveTime = loc2;
	}
}
