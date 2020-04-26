class dofus.graphics.gapi.ui.CenterText extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CenterText";
	var _sText = "";
	var _bBackground = false;
	var _nTimer = 0;
	function CenterText()
	{
		super();
	}
	function __set__text(loc2)
	{
		this._sText = loc2;
		return this.__get__text();
	}
	function __set__background(loc2)
	{
		this._bBackground = loc2;
		return this.__get__background();
	}
	function __set__timer(loc2)
	{
		this._nTimer = loc2;
		return this.__get__timer();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.CenterText.CLASS_NAME);
	}
	function createChildren()
	{
		if(this._sText.length == 0)
		{
			return undefined;
		}
		this.addToQueue({object:this,method:this.initText});
		this._mcBackground._visible = false;
		this._prgbGfxLoad._visible = false;
		if(this._nTimer != 0)
		{
			ank.utils.Timer.setTimer(this,"centertext",this,this.unloadThis,this._nTimer);
		}
	}
	function initText()
	{
		this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this._sText;
		var loc2 = this._lblWhite.textHeight;
		this._mcBackground._visible = this._bBackground;
		this._mcBackground._height = loc2 + 2.5 * (this._lblWhite._y - this._mcBackground._y);
	}
	function updateProgressBar(loc2, loc3, loc4)
	{
		var loc5 = Math.floor(loc3 / loc4 * 100);
		if(_global.isNaN(loc5))
		{
			loc5 = 0;
		}
		this._prgbGfxLoad._visible = true;
		this._prgbGfxLoad["\x1e\f\x1a"].text = loc2;
		this._prgbGfxLoad["\x1e\f\x19"].text = loc5 + "%";
		this._prgbGfxLoad["\x0b\x17"]._width = loc5;
	}
}
