class ank.gapi.controls.Fps extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Fps";
	var _nAverageOffset = 10;
	var _aValues = new Array();
	function Fps()
	{
		super();
	}
	function __set__averageOffset(§\b\x1c§)
	{
		this._nAverageOffset = var2;
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
		var var2 = this.getStyle();
		if(var2.backcolor != undefined)
		{
			this.setMovieClipColor(this._mcBack,var2.backcolor);
		}
		this._mcBack._alpha = var2.backalpha;
		this._lblText.styleName = var2.labelstyle;
	}
	function pushValue(§\x1e\x1b\x17§)
	{
		this._aValues.push(var2);
		if(this._aValues.length > this._nAverageOffset)
		{
			this._aValues.shift();
		}
	}
	function getAverage()
	{
		var var2 = 0;
		for(var k in this._aValues)
		{
			var2 = var2 + Number(this._aValues[k]);
		}
		return Math.round(var2 / this._aValues.length);
	}
	function onEnterFrame()
	{
		var var2 = getTimer();
		var var3 = var2 - this._nSaveTime;
		this.pushValue(1 / (var3 / 1000));
		this._lblText.text = String(this.getAverage());
		this._nSaveTime = var2;
	}
}
