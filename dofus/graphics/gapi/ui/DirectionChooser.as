class dofus.graphics.gapi.ui.DirectionChooser extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DirectionChooser";
	function DirectionChooser()
	{
		super();
	}
	function __set__target(loc2)
	{
		this._mcSprite = loc2;
		return this.__get__target();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.DirectionChooser.CLASS_NAME);
	}
	function createChildren()
	{
		var loc2 = this.api.gfx.getZoom();
		var loc3 = {x:this._mcSprite._x,y:this._mcSprite._y};
		this._mcSprite._parent.localToGlobal(loc3);
		this._mcArrows._x = loc3.x;
		this._mcArrows._y = loc3.y;
		this._mcArrows._xscale = this._mcArrows._yscale = loc2;
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
	function click(loc2)
	{
		var loc3 = 0;
		if((var loc0 = loc2.target) !== this._btnR)
		{
			switch(null)
			{
				case this._btnBR:
					loc3 = 1;
					break;
				case this._btnB:
					loc3 = 2;
					break;
				case this._btnBL:
					loc3 = 3;
					break;
				case this._btnL:
					loc3 = 4;
					break;
				case this._btnTL:
					loc3 = 5;
					break;
				case this._btnT:
					loc3 = 6;
					break;
				default:
					if(loc0 !== this._btnTR)
					{
						break;
					}
					loc3 = 7;
					break;
			}
		}
		else
		{
			loc3 = 0;
		}
		this.api.network.Emotes.setDirection(loc3);
		this.unloadThis();
	}
	function over(loc2)
	{
		loc2.target._alpha = 80;
		this.onMouseUp = undefined;
	}
	function out(loc2)
	{
		if((var loc0 = loc2.target) !== this._btnT)
		{
			loc2.target._alpha = 100;
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
