class dofus.graphics.gapi.ui.DirectionChooser extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DirectionChooser";
	function DirectionChooser()
	{
		super();
	}
	function __set__target(var2)
	{
		this._mcSprite = var2;
		return this.__get__target();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.DirectionChooser.CLASS_NAME);
	}
	function createChildren()
	{
		var var2 = this.api.gfx.getZoom();
		var var3 = {x:this._mcSprite._x,y:this._mcSprite._y};
		this._mcSprite._parent.localToGlobal(var3);
		this._mcArrows._x = var3.x;
		this._mcArrows._y = var3.y;
		this._mcArrows._xscale = this._mcArrows._yscale = var2;
		this._btnTL = this._mcArrows._btnTL;
		this._btnTR = this._mcArrows._btnTR;
		this._btnBL = this._mcArrows._btnBL;
		this._btnBR = this._mcArrows._btnBR;
		this._btnT = this._mcArrows._btnT;
		this._btnL = this._mcArrows._btnL;
		this._btnR = this._mcArrows._btnR;
		this._btnB = this._mcArrows._btnB;
		if(!this.allDirections)
		{
			this._btnT._visible = false;
			this._mcArrows._mcShadowT._visible = false;
			this._btnB._visible = false;
			this._mcArrows._mcShadowB._visible = false;
			this._btnL._visible = false;
			this._mcArrows._mcShadowL._visible = false;
			this._btnR._visible = false;
			this._mcArrows._mcShadowR._visible = false;
		}
		this.out({target:this._btnT});
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnTL.addEventListener("click",this);
		this._btnTR.addEventListener("click",this);
		this._btnBL.addEventListener("click",this);
		this._btnBR.addEventListener("click",this);
		this._btnT.addEventListener("click",this);
		this._btnL.addEventListener("click",this);
		this._btnR.addEventListener("click",this);
		this._btnB.addEventListener("click",this);
		this._btnTL.addEventListener("over",this);
		this._btnTR.addEventListener("over",this);
		this._btnBL.addEventListener("over",this);
		this._btnBR.addEventListener("over",this);
		this._btnT.addEventListener("over",this);
		this._btnL.addEventListener("over",this);
		this._btnR.addEventListener("over",this);
		this._btnB.addEventListener("over",this);
		this._btnTL.addEventListener("out",this);
		this._btnTR.addEventListener("out",this);
		this._btnBL.addEventListener("out",this);
		this._btnBR.addEventListener("out",this);
		this._btnT.addEventListener("out",this);
		this._btnL.addEventListener("out",this);
		this._btnR.addEventListener("out",this);
		this._btnB.addEventListener("out",this);
	}
	function click(var2)
	{
		var var3 = 0;
		switch(var2.target)
		{
			case this._btnR:
				var3 = 0;
				break;
			case this._btnBR:
				var3 = 1;
				break;
			default:
				switch(null)
				{
					case this._btnB:
						var3 = 2;
						break;
					case this._btnBL:
						var3 = 3;
						break;
					case this._btnL:
						var3 = 4;
						break;
					case this._btnTL:
						var3 = 5;
						break;
					case this._btnT:
						var3 = 6;
						break;
					case this._btnTR:
						var3 = 7;
				}
		}
		this.api.network.Emotes.setDirection(var3);
		this.unloadThis();
	}
	function over(var2)
	{
		var2.target._alpha = 80;
		this.onMouseUp = undefined;
	}
	function out(var2)
	{
		if((var var0 = var2.target) !== this._btnT)
		{
			var2.target._alpha = 100;
		}
		else
		{
			this._btnT._alpha = 0;
		}
		this.onMouseUp = this._onMouseUp;
	}
	function _onMouseUp()
	{
		this.unloadThis();
	}
	function onMouseUp()
	{
		this.out();
	}
}
