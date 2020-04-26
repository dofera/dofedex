class ank.gapi.controls.VerticalChrono extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "VerticalChrono";
	function VerticalChrono()
	{
		super();
	}
	function startTimer(loc2, loc3)
	{
		this._nTimerValue = Math.ceil(loc2);
		this._nMaxTime = loc3 != undefined?loc3:this._nTimerValue;
		this.addToQueue({object:this,method:this.updateTimer});
		_global.clearInterval(this._nIntervalID);
		this._nIntervalID = _global.setInterval(this,"updateTimer",1000);
	}
	function stopTimer()
	{
		_global.clearInterval(this._nIntervalID);
		this._mcRectangle._height = 0;
	}
	function init()
	{
		super.init(false,ank.gapi.controls.VerticalChrono.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcRectangle",10);
	}
	function arrange()
	{
		this._mcRectangle._width = this.__width;
		this._mcRectangle._height = 0;
		this._mcRectangle._x = 0;
		this._mcRectangle._y = this.__height;
	}
	function draw()
	{
		var loc2 = this.getStyle();
		var loc3 = loc2 == undefined?0:loc2.bgcolor;
		var loc4 = loc2 == undefined?100:loc2.bgalpha;
		this._mcRectangle.clear();
		this.drawRoundRect(this._mcRectangle,0,0,100,100,0,loc3,loc4);
	}
	function updateTimer()
	{
		var loc2 = this._nTimerValue / this._nMaxTime;
		var loc3 = (this._nMaxTime - this._nTimerValue) / this._nMaxTime * this.__height;
		var loc4 = loc2 * this.__height;
		this._mcRectangle._y = loc4;
		this._mcRectangle._height = loc3;
		if(this._nTimerValue < 0)
		{
			this.stopTimer();
			this.dispatchEvent({type:"endTimer"});
		}
		this._nTimerValue--;
	}
}
