class ank.gapi.core.UIBasicComponent extends ank.utils.QueueEmbedMovieClip
{
	static var BORDER_TICKNESS = 1;
	static var BORDER_ALPHA = 50;
	var _bInitialized = false;
	var _sStyleName = "default";
	var _bEnabled = true;
	function UIBasicComponent()
	{
		super();
		this.init();
		this.createChildren();
		this.draw();
		this.arrange();
		this.size();
		this._bInitialized = true;
	}
	function __set__gapi(loc2)
	{
		this._mcGAPI = loc2;
		return this.__get__gapi();
	}
	function __get__gapi()
	{
		if(this._mcGAPI == undefined)
		{
			return this._parent.gapi;
		}
		return this._mcGAPI;
	}
	function __get__className()
	{
		return this._sClassName;
	}
	function __set__enabled(loc2)
	{
		this._bEnabled = loc2;
		this.addToQueue({object:this,method:this.setEnabled});
		return this.__get__enabled();
	}
	function __get__enabled()
	{
		return this._bEnabled;
	}
	function __set__styleName(loc2)
	{
		this._sStyleName = loc2;
		if(this._bInitialized && (loc2 != "none" && loc2 != undefined))
		{
			this.draw();
		}
		return this.__get__styleName();
	}
	function __get__styleName()
	{
		var loc2 = this._sStyleName;
		if(loc2.length == 0 || (loc2 == undefined || loc2 == "default"))
		{
			var loc3 = this._parent;
			while(!(loc3 instanceof ank.gapi.core.UIBasicComponent) && loc3 != undefined)
			{
				loc3 = loc3._parent;
			}
			loc2 = loc3.styleName;
		}
		if(loc2 == undefined)
		{
			loc2 = this._sClassName;
		}
		return loc2;
	}
	function __set__width(loc2)
	{
		this.setSize(loc2,null);
		return this.__get__width();
	}
	function __get__width()
	{
		return this.__width;
	}
	function __set__height(loc2)
	{
		this.setSize(null,loc2);
		return this.__get__height();
	}
	function __get__height()
	{
		return this.__height;
	}
	function __set__params(loc2)
	{
		this._oParams = loc2;
		return this.__get__params();
	}
	function __get__params()
	{
		return this._oParams;
	}
	function __get__initialized()
	{
		return this._bInitialized;
	}
	function setSize(loc2, loc3)
	{
		if(Math.abs(this._rotation) == 90)
		{
			var loc4 = loc2;
			loc2 = loc3;
			loc3 = loc4;
		}
		if(loc2 != undefined && loc2 != null)
		{
			this.__width = loc2;
		}
		if(loc3 != undefined && loc3 != null)
		{
			this.__height = loc3;
		}
		this.size();
	}
	function move(loc2, loc3)
	{
		if(loc2 != undefined)
		{
			this._x = loc2;
		}
		if(loc2 != undefined)
		{
			this._y = loc3;
		}
	}
	function init(loc2, loc3)
	{
		this._sClassName = loc3;
		if(Math.ceil(this._rotation % 180) > 45)
		{
			this.__width = this._height;
			this.__height = this._width;
		}
		else
		{
			this.__width = this._width;
			this.__height = this._height;
		}
		if(!loc2)
		{
			this.boundingBox_mc._visible = false;
			this.boundingBox_mc._width = this.boundingBox_mc._height = 0;
		}
		mx.events.EventDispatcher.initialize(this);
	}
	function getStyle()
	{
		return ank.gapi.styles.StylesManager.getStyle(this.styleName);
	}
	function size()
	{
		this.initScale();
	}
	function initScale()
	{
		this._xscale = this._yscale = 100;
	}
	function drawBorder()
	{
		if(this.border_mc == undefined)
		{
			this.createEmptyMovieClip("border_mc",0);
		}
		this.border_mc.clear();
		this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,7305079,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
		this.border_mc.lineTo(this.__width,0);
		this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,9542041,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
		this.border_mc.lineTo(this.__width,this.__height);
		this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,14015965,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
		this.border_mc.lineTo(0,this.__height);
		this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,9542041,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
		this.border_mc.lineTo(0,0);
		this.border_mc.moveTo(1,1);
		this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,13290700,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
		this.border_mc.lineTo(this.__width - 1,1);
		this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,14015965,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
		this.border_mc.lineTo(this.__width - 1,this.__height - 1);
		this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,15658734,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
		this.border_mc.lineTo(1,this.__height - 1);
		this.border_mc.lineStyle(ank.gapi.core.UIBasicComponent.BORDER_TICKNESS,14015965,ank.gapi.core.UIBasicComponent.BORDER_ALPHA);
		this.border_mc.lineTo(1,1);
	}
	function drawRoundRect(loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9, loc10, loc11, loc12)
	{
		if(typeof loc7 == "object")
		{
			var loc13 = loc7.br;
			var loc14 = loc7.bl;
			var loc15 = loc7.tl;
			var loc16 = loc7.tr;
		}
		else
		{
			loc13 = loc14 = loc15 = loc16 = loc7;
		}
		if(loc9 == undefined)
		{
			loc9 = 100;
		}
		if(typeof loc8 == "object")
		{
			if(typeof loc9 != "object")
			{
				var loc17 = [loc9,loc9];
			}
			else
			{
				loc17 = loc9;
			}
			if(loc12 == undefined)
			{
				loc12 = [0,255];
			}
			var loc18 = loc6 * 0.7;
			if(typeof rot != "object")
			{
				var loc19 = {matrixType:"box",x:- loc18,y:loc18,w:loc5 * 2,h:loc6 * 4,r:rot * 0.0174532925199433};
			}
			else
			{
				loc19 = rot;
				if(loc19.w == undefined)
				{
					loc19.w = loc5;
				}
				if(loc19.h == undefined)
				{
					loc19.h = loc6;
				}
			}
			if(loc11 == "radial")
			{
				loc2.beginGradientFill("radial",loc8,loc17,loc12,loc19);
			}
			else
			{
				loc2.beginGradientFill("linear",loc8,loc17,loc12,loc19);
			}
		}
		else if(loc8 != undefined)
		{
			loc2.beginFill(loc8,loc9);
		}
		loc7 = loc13;
		if(loc7 != 0)
		{
			var loc20 = loc7 - loc7 * 0.707106781186547;
			var loc21 = loc7 - loc7 * 0.414213562373095;
			loc2.moveTo(loc3 + loc5,loc4 + loc6 - loc7);
			loc2.lineTo(loc3 + loc5,loc4 + loc6 - loc7);
			loc2.curveTo(loc3 + loc5,loc4 + loc6 - loc21,loc3 + loc5 - loc20,loc4 + loc6 - loc20);
			loc2.curveTo(loc3 + loc5 - loc21,loc4 + loc6,loc3 + loc5 - loc7,loc4 + loc6);
		}
		else
		{
			loc2.moveTo(loc3 + loc5,loc4 + loc6);
		}
		loc7 = loc14;
		if(loc7 != 0)
		{
			var loc22 = loc7 - loc7 * 0.707106781186547;
			var loc23 = loc7 - loc7 * 0.414213562373095;
			loc2.lineTo(loc3 + loc7,loc4 + loc6);
			loc2.curveTo(loc3 + loc23,loc4 + loc6,loc3 + loc22,loc4 + loc6 - loc22);
			loc2.curveTo(loc3,loc4 + loc6 - loc23,loc3,loc4 + loc6 - loc7);
		}
		else
		{
			loc2.lineTo(loc3,loc4 + loc6);
		}
		loc7 = loc15;
		if(loc7 != 0)
		{
			var loc24 = loc7 - loc7 * 0.707106781186547;
			var loc25 = loc7 - loc7 * 0.414213562373095;
			loc2.lineTo(loc3,loc4 + loc7);
			loc2.curveTo(loc3,loc4 + loc25,loc3 + loc24,loc4 + loc24);
			loc2.curveTo(loc3 + loc25,loc4,loc3 + loc7,loc4);
		}
		else
		{
			loc2.lineTo(loc3,loc4);
		}
		loc7 = loc16;
		if(loc7 != 0)
		{
			var loc26 = loc7 - loc7 * 0.707106781186547;
			var loc27 = loc7 - loc7 * 0.414213562373095;
			loc2.lineTo(loc3 + loc5 - loc7,loc4);
			loc2.curveTo(loc3 + loc5 - loc27,loc4,loc3 + loc5 - loc26,loc4 + loc26);
			loc2.curveTo(loc3 + loc5,loc4 + loc27,loc3 + loc5,loc4 + loc7);
			loc2.lineTo(loc3 + loc5,loc4 + loc6 - loc7);
		}
		else
		{
			loc2.lineTo(loc3 + loc5,loc4);
			loc2.lineTo(loc3 + loc5,loc4 + loc6);
		}
		if(loc8 != undefined)
		{
			loc2.endFill();
		}
	}
	function setMovieClipColor(loc2, loc3)
	{
		var loc4 = new Color(loc2);
		loc4.setRGB(loc3);
		if(loc3 == -1)
		{
			loc2._alpha = 0;
		}
	}
	function setMovieClipTransform(loc2, loc3)
	{
		var loc4 = new Color(loc2);
		loc4.setTransform(loc3);
	}
}
