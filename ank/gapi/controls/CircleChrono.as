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
	function __set__background(loc2)
	{
		this._sBackgroundLink = loc2;
		return this.__get__background();
	}
	function __set__finalCountDownTrigger(loc2)
	{
		loc2 = Number(loc2);
		if(_global.isNaN(loc2))
		{
			return undefined;
		}
		if(loc2 < 0)
		{
			return undefined;
		}
		this._nFinalCountDownTrigger = loc2;
		return this.__get__finalCountDownTrigger();
	}
	function setGaugeChrono(loc2, loc3)
	{
		_global.clearInterval(this._nIntervalID);
		this.dispatchEvent({type:"finish"});
		if(loc2 > 100)
		{
			loc2 = 100;
		}
		else if(loc2 < 0)
		{
			loc2 = 0;
		}
		this._nMaxTime = 100;
		this._nTimerValue = 100 - loc2;
		this.draw(loc3);
		this.chronoUpdate();
	}
	function startTimer(loc2)
	{
		_global.clearInterval(this._nIntervalID);
		loc2 = Number(loc2);
		if(_global.isNaN(loc2))
		{
			return undefined;
		}
		if(loc2 < 0)
		{
			return undefined;
		}
		this._nMaxTime = loc2;
		this._nTimerValue = loc2;
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
	function draw(loc2)
	{
		var loc3 = loc2 == undefined?this.getStyle().bgcolor:loc2;
		if(loc3 != undefined && this._nBackgroundColor != loc2)
		{
			this._nBackgroundColor = loc3;
			this.setMovieClipColor(this._mcLeft.bg_mc,loc3);
			this.setMovieClipColor(this._mcRight.bg_mc,loc3);
		}
	}
	function chronoUpdate()
	{
		var loc2 = this._nTimerValue / this._nMaxTime;
		var loc3 = 360 * (1 - this._nTimerValue / this._nMaxTime);
		if(loc3 < 180)
		{
			this.setRtation(this._mcRight,loc3);
			this.setRtation(this._mcLeft,0);
		}
		else
		{
			this.setRtation(this._mcRight,180);
			this.setRtation(this._mcLeft,loc3 - 180);
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
	function setRtation(loc2, loc3)
	{
		loc2._mcMask._rotation = loc3;
	}
}
