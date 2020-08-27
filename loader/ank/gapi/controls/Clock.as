class ank.gapi.controls.Clock extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Clock";
	var _bHoursLoaded = false;
	var _bMinutesLoaded = false;
	function Clock()
	{
		super();
	}
	function __set__background(var2)
	{
		this._sBackground = var2;
		return this.__get__background();
	}
	function __get__background()
	{
		return this._sBackground;
	}
	function __set__arrowHours(var2)
	{
		this._sArrowHours = var2;
		return this.__get__arrowHours();
	}
	function __get__arrowHours()
	{
		return this._sArrowHours;
	}
	function __set__arrowMinutes(var2)
	{
		this._sArrowMinutes = var2;
		return this.__get__arrowMinutes();
	}
	function __get__arrowMinutes()
	{
		return this._sArrowMinutes;
	}
	function __set__hours(var2)
	{
		this._nHours = var2 % 12;
		if(this.initialized)
		{
			this.layoutContent();
		}
		return this.__get__hours();
	}
	function __get__hours()
	{
		return this._nHours;
	}
	function __set__minutes(var2)
	{
		this._nMinutes = var2 % 59;
		if(this.initialized)
		{
			this.layoutContent();
		}
		return this.__get__minutes();
	}
	function __get__minutes()
	{
		return this._nMinutes;
	}
	function __set__updateFunction(var2)
	{
		this._oUpdateFunction = var2;
		return this.__get__updateFunction();
	}
	function init()
	{
		super.init(false,ank.gapi.controls.Clock.CLASS_NAME);
	}
	function createChildren()
	{
		this.attachMovie("Loader","_ldrBack",10,{contentPath:this._sBackground,centerContent:false,scaleContent:true});
		this.attachMovie("Loader","_ldrArrowHours",20,{contentPath:this._sArrowHours,centerContent:false,scaleContent:true});
		this.attachMovie("Loader","_ldrArrowMinutes",30,{contentPath:this._sArrowMinutes,centerContent:false,scaleContent:true});
		this._ldrArrowHours._visible = false;
		this._ldrArrowMinutes._visible = false;
		this.addToQueue({object:this,method:this.layoutContent});
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		this._ldrBack.setSize(this.__width,this.__height);
		this._ldrArrowHours.setSize(this.__width,this.__height);
		this._ldrArrowMinutes.setSize(this.__width,this.__height);
	}
	function layoutContent()
	{
		if(this._oUpdateFunction != undefined)
		{
			var var2 = this._oUpdateFunction.method.apply(this._oUpdateFunction.object);
			ank.utils.Timer.setTimer(this,"clock",this,this.layoutContent,30000);
			this._nHours = var2[0];
			this._nMinutes = var2[1];
		}
		var var3 = 30 * this._nHours + 6 * this._nMinutes / 12 - 90;
		var var4 = 6 * this._nMinutes - 90;
		this._ldrArrowHours.content._rotation = var3;
		this._ldrArrowMinutes.content._rotation = var4;
		this._ldrArrowHours._visible = true;
		this._ldrArrowMinutes._visible = true;
	}
	function onRelease()
	{
		this.dispatchEvent({type:"click"});
	}
	function onReleaseOutside()
	{
		this.onRollOut();
	}
	function onRollOver()
	{
		this.dispatchEvent({type:"over"});
	}
	function onRollOut()
	{
		this.dispatchEvent({type:"out"});
	}
}
