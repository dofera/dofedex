class ank.gapi.controls.CircleChrono extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "CircleChrono";
	var _sBackgroundLink = "CircleChronoHalfDefault";
	var _nFinalCountDownTrigger = 5;
	var _nBackgroundColor = -1;
	function CircleChrono()
	{
		super();
	}
	function __set__background(§\x1e\x14\x1a§)
	{
		this._sBackgroundLink = var2;
		return this.__get__background();
	}
	function __set__finalCountDownTrigger(§\x05\x0f§)
	{
		var2 = Number(var2);
		if(_global.isNaN(var2))
		{
			return undefined;
		}
		if(var2 < 0)
		{
			return undefined;
		}
		this._nFinalCountDownTrigger = var2;
		return this.__get__finalCountDownTrigger();
	}
	function setGaugeChrono(§\x02\x02§, §\x06\x1d§)
	{
		_global.clearInterval(this._nIntervalID);
		this.dispatchEvent({type:"finish"});
		if(var2 > 100)
		{
			var2 = 100;
		}
		else if(var2 < 0)
		{
			var2 = 0;
		}
		this._nMaxTime = 100;
		this._nTimerValue = 100 - var2;
		this.draw(var3);
		this.chronoUpdate();
	}
	function startTimer(§\x06\t§)
	{
		_global.clearInterval(this._nIntervalID);
		var2 = Number(var2);
		if(_global.isNaN(var2))
		{
			return undefined;
		}
		if(var2 < 0)
		{
			return undefined;
		}
		this._nMaxTime = var2;
		this._nTimerValue = var2;
		this.updateTimer();
		this._nIntervalID = _global.setInterval(this,"updateTimer",1000);
	}
	function stopTimer()
	{
		_global.clearInterval(this._nIntervalID);
		this.dispatchEvent({type:"finish"});
		this.addToQueue({object:this,method:this.initialize});
	}
	function redraw()
	{
		this.draw();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.CircleChrono.CLASS_NAME);
	}
	function createChildren()
	{
		this.attachMovie(this._sBackgroundLink,"_mcLeft",10);
		this.attachMovie(this._sBackgroundLink,"_mcRight",20);
	}
	function arrange()
	{
		this._mcLeft._width = this._mcRight._width = this.__width;
		this._mcLeft._height = this._mcRight._height = this.__height;
		this._mcLeft._xscale = this._mcLeft._xscale * -1;
		this._mcLeft._yscale = this._mcLeft._yscale * -1;
		this._mcLeft._x = this._mcRight._x = this.__width / 2;
		this._mcLeft._y = this._mcRight._y = this.__height / 2;
	}
	function draw(§\x06\x1d§)
	{
		var var3 = var2 == undefined?this.getStyle().bgcolor:var2;
		if(var3 != undefined && this._nBackgroundColor != var2)
		{
			this._nBackgroundColor = var3;
			this.setMovieClipColor(this._mcLeft.bg_mc,var3);
			this.setMovieClipColor(this._mcRight.bg_mc,var3);
		}
	}
	function chronoUpdate()
	{
		var var2 = this._nTimerValue / this._nMaxTime;
		var var3 = 360 * (1 - this._nTimerValue / this._nMaxTime);
		if(var3 < 180)
		{
			this.setRtation(this._mcRight,var3);
			this.setRtation(this._mcLeft,0);
		}
		else
		{
			this.setRtation(this._mcRight,180);
			this.setRtation(this._mcLeft,var3 - 180);
		}
	}
	function updateTimer()
	{
		this.dispatchEvent({type:"tictac"});
		this.chronoUpdate();
		if(this._nTimerValue - 5 <= this._nFinalCountDownTrigger)
		{
			this.dispatchEvent({type:"beforeFinalCountDown",value:Math.ceil(this._nTimerValue)});
		}
		if(this._nTimerValue <= this._nFinalCountDownTrigger)
		{
			this.dispatchEvent({type:"finalCountDown",value:Math.ceil(this._nTimerValue)});
		}
		this._nTimerValue--;
		if(this._nTimerValue < 0)
		{
			this.stopTimer();
		}
	}
	function initialize()
	{
		this.setRtation(this._mcLeft,0);
		this.setRtation(this._mcRight,0);
	}
	function setRtation(§\x0b\r§, §\t\x04§)
	{
		var2._mcMask._rotation = var3;
	}
}
