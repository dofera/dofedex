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
	function __set__rotate(§\x16\x06§)
	{
		this._bRotate = var2;
		return this.__get__rotate();
	}
	function __set__coordinates(§\x07§)
	{
		this._aCoordinates = var2;
		return this.__get__coordinates();
	}
	function __set__offset(§\x02\x0f§)
	{
		this._nOffset = var2;
		return this.__get__offset();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Indicator.CLASS_NAME);
	}
	function createChildren()
	{
		var var2 = this._aCoordinates[0];
		var var3 = this._aCoordinates[1];
		if(this._bRotate)
		{
			var var5 = this.gapi.screenWidth / 2;
			var var6 = this.gapi.screenHeight / 2;
			var var7 = Math.atan2(this._aCoordinates[1] - var6,this._aCoordinates[0] - var5);
			var var4 = var7 * 180 / Math.PI - 90;
			var2 = var2 - (this._nOffset != undefined?this._nOffset * Math.cos(var7):0);
			var3 = var3 - (this._nOffset != undefined?this._nOffset * Math.sin(var7):0);
		}
		else
		{
			var3 = var3 - (this._nOffset != undefined?this._nOffset:0);
		}
		this.attachMovie("UI_Indicatorlight","_mcLight",10,{_x:var2,_y:var3});
		var var8 = "UI_IndicatorArrow";
		if(dofus.Constants.DOUBLEFRAMERATE)
		{
			var8 = var8 + "_DoubleFramerate";
		}
		this.attachMovie(var8,"_mcArrowShadow",20,{_x:var2 + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET,_y:var3 + dofus.graphics.gapi.ui.Indicator.SHADOW_OFFSET});
		this.attachMovie(var8,"_mcArrow",30,{_x:var2,_y:var3});
		var var9 = new Color(this._mcArrowShadow);
		var9.setTransform(dofus.graphics.gapi.ui.Indicator.SHADOW_TRANSFORM);
		if(this._bRotate)
		{
			this._mcLight._rotation = var4;
			this._mcArrow._rotation = var4;
			this._mcArrowShadow._rotation = var4;
		}
	}
}
