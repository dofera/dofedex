class ank.gapi.controls.VerticalChrono extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "VerticalChrono";
	function VerticalChrono()
	{
		super();
	}
	function startTimer(var2, var3)
	{
		this._nTimerValue = Math.ceil(var2);
		this._nMaxTime = var3 != undefined?var3:this._nTimerValue;
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
		var var2 = this.getStyle();
		var var3 = var2 == undefined?0:var2.bgcolor;
		var var4 = var2 == undefined?100:var2.bgalpha;
		this._mcRectangle.clear();
		this.drawRoundRect(this._mcRectangle,0,0,100,100,0,var3,var4);
	}
	function updateTimer()
	{
		var var2 = this._nTimerValue / this._nMaxTime;
		var var3 = (this._nMaxTime - this._nTimerValue) / this._nMaxTime * this.__height;
		var var4 = var2 * this.__height;
		this._mcRectangle._y = var4;
		this._mcRectangle._height = var3;
		if(this._nTimerValue < 0)
		{
			this.stopTimer();
			this.dispatchEvent({type:"endTimer"});
		}
		this._nTimerValue--;
	}
}
