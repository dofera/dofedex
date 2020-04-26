class dofus.graphics.gapi.ui.Indicator extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Indicator";
	static var SHADOW_OFFSET = 3;
	static var SHADOW_TRANSFORM = {ra:0,rb:0,ga:0,gb:0,ba:0,bb:0,aa:40,ab:0};
	var _bRotate = true;
	var _nOffset = 0;
	function Indicator()
	{
		super();
	}
	function __set__rotate(loc2)
	{
		this._bRotate = loc2;
		return this.__get__rotate();
	}
	function __set__coordinates(loc2)
	{
		this._aCoordinates = loc2;
		return this.__get__coordinates();
	}
	function __set__offset(loc2)
	{
		this._nOffset = loc2;
		return this.__get__offset();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Indicator.CLASS_NAME);
	}
	function createChildren()
	{
		var loc2 = this._aCoordinates[0];
		var loc3 = this._aCoordinates[1];
		if(this._bRotate)
		{
			var loc5 = this.gapi.screenWidth / 2;
			var loc6 = this.gapi.screenHeight / 2;
			var loc7 = Math.atan2(this._aCoordinates[1] - loc6,this._aCoordinates[0] - loc5);
			var loc4 = loc7 * 180 / Math.PI - 90;
			loc2 = loc2 - (this._nOffset != undefined?this._nOffset * Math.cos(loc7):0);
			loc3 = loc3 - (this._nOffset != undefined?this._nOffset * Math.sin(loc7):0);
		}
		else
		{
			loc3 = loc3 - (this._nOffset != undefined?this._nOffset:0);
		}
		this.attachMovie("UI_Indicatorlight","_mcLight",10,{_x:loc2,_y:loc3});
		var loc8 = "UI_IndicatorArrow";
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			loc8 = loc8 + "_DoubleFramerate";
		}
		this.attachMovie(loc8,"_mcArrowShadow",20,{_x:loc2 + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET,_y:loc3 + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET});
		this.attachMovie(loc8,"_mcArrow",30,{_x:loc2,_y:loc3});
		var loc9 = new Color(this._mcArrowShadow);
		loc9.setTransform(dofus.graphics.gapi.ui.Indicator.SHADOW_TRANSFORM);
		if(this._bRotate)
		{
			this._mcLight._rotation = loc4;
			this._mcArrow._rotation = loc4;
			this._mcArrowShadow._rotation = loc4;
		}
	}
}
