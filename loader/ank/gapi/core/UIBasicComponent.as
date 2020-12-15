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
	function __set__gapi(var2)
	{
		this._mcGAPI = var2;
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
	function __set__enabled(var2)
	{
		this._bEnabled = var2;
		this.addToQueue({object:this,method:this.setEnabled});
		return this.__get__enabled();
	}
	function __get__enabled()
	{
		return this._bEnabled;
	}
	function __set__styleName(var2)
	{
		this._sStyleName = var2;
		if(this._bInitialized && (var2 != "none" && var2 != undefined))
		{
			this.draw();
		}
		return this.__get__styleName();
	}
	function __get__styleName()
	{
		var var2 = this._sStyleName;
		if(var2.length == 0 || (var2 == undefined || var2 == "default"))
		{
			var var3 = this._parent;
			while(!(var3 instanceof ank.gapi.core.UIBasicComponent) && var3 != undefined)
			{
				var3 = var3._parent;
			}
			var2 = var3.styleName;
		}
		if(var2 == undefined)
		{
			var2 = this._sClassName;
		}
		return var2;
	}
	function __set__width(var2)
	{
		this.setSize(var2,null);
		return this.__get__width();
	}
	function __get__width()
	{
		return this.__width;
	}
	function __set__height(var2)
	{
		this.setSize(null,var2);
		return this.__get__height();
	}
	function __get__height()
	{
		return this.__height;
	}
	function __set__params(var2)
	{
		this._oParams = var2;
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
	function setSize(var2, var3)
	{
		if(Math.abs(this._rotation) == 90)
		{
			var var4 = var2;
			var2 = var3;
			var3 = var4;
		}
		if(var2 != undefined && var2 != null)
		{
			this.__width = var2;
		}
		if(var3 != undefined && var3 != null)
		{
			this.__height = var3;
		}
		this.size();
	}
	function move(var2, var3)
	{
		if(var2 != undefined)
		{
			this._x = var2;
		}
		if(var2 != undefined)
		{
			this._y = var3;
		}
	}
	function init(var2, var3)
	{
		this._sClassName = var3;
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
		if(!var2)
		{
			this.boundingBox_mc._visible = false;
			this.boundingBox_mc._width = this.boundingBox_mc._height = 0;
		}
		eval(mx).events.EventDispatcher.initialize(this);
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
	function drawRoundRect(var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12)
	{
		if(typeof var7 == "object")
		{
			var var13 = var7.br;
			var var14 = var7.bl;
			var var15 = var7.tl;
			var var16 = var7.tr;
		}
		else
		{
			var13 = var14 = var15 = var16 = var7;
		}
		if(var9 == undefined)
		{
			var9 = 100;
		}
		if(typeof var8 == "object")
		{
			if(typeof var9 != "object")
			{
				var var17 = [var9,var9];
			}
			else
			{
				var17 = var9;
			}
			if(var12 == undefined)
			{
				var12 = [0,255];
			}
			var var18 = var6 * 0.7;
			if(typeof rot != "object")
			{
				var var19 = {matrixType:"box",x:- var18,y:var18,w:var5 * 2,h:var6 * 4,r:rot * 0.0174532925199433};
			}
			else
			{
				var19 = rot;
				if(var19.w == undefined)
				{
					var19.w = var5;
				}
				if(var19.h == undefined)
				{
					var19.h = var6;
				}
			}
			if(var11 == "radial")
			{
				var2.beginGradientFill("radial",var8,var17,var12,var19);
			}
			else
			{
				var2.beginGradientFill("linear",var8,var17,var12,var19);
			}
		}
		else if(var8 != undefined)
		{
			var2.beginFill(var8,var9);
		}
		var7 = var13;
		if(var7 != 0)
		{
			var var20 = var7 - var7 * 0.707106781186547;
			var var21 = var7 - var7 * 0.414213562373095;
			var2.moveTo(var3 + var5,var4 + var6 - var7);
			var2.lineTo(var3 + var5,var4 + var6 - var7);
			var2.curveTo(var3 + var5,var4 + var6 - var21,var3 + var5 - var20,var4 + var6 - var20);
			var2.curveTo(var3 + var5 - var21,var4 + var6,var3 + var5 - var7,var4 + var6);
		}
		else
		{
			var2.moveTo(var3 + var5,var4 + var6);
		}
		var7 = var14;
		if(var7 != 0)
		{
			var var22 = var7 - var7 * 0.707106781186547;
			var var23 = var7 - var7 * 0.414213562373095;
			var2.lineTo(var3 + var7,var4 + var6);
			var2.curveTo(var3 + var23,var4 + var6,var3 + var22,var4 + var6 - var22);
			var2.curveTo(var3,var4 + var6 - var23,var3,var4 + var6 - var7);
		}
		else
		{
			var2.lineTo(var3,var4 + var6);
		}
		var7 = var15;
		if(var7 != 0)
		{
			var var24 = var7 - var7 * 0.707106781186547;
			var var25 = var7 - var7 * 0.414213562373095;
			var2.lineTo(var3,var4 + var7);
			var2.curveTo(var3,var4 + var25,var3 + var24,var4 + var24);
			var2.curveTo(var3 + var25,var4,var3 + var7,var4);
		}
		else
		{
			var2.lineTo(var3,var4);
		}
		var7 = var16;
		if(var7 != 0)
		{
			var var26 = var7 - var7 * 0.707106781186547;
			var var27 = var7 - var7 * 0.414213562373095;
			var2.lineTo(var3 + var5 - var7,var4);
			var2.curveTo(var3 + var5 - var27,var4,var3 + var5 - var26,var4 + var26);
			var2.curveTo(var3 + var5,var4 + var27,var3 + var5,var4 + var7);
			var2.lineTo(var3 + var5,var4 + var6 - var7);
		}
		else
		{
			var2.lineTo(var3 + var5,var4);
			var2.lineTo(var3 + var5,var4 + var6);
		}
		if(var8 != undefined)
		{
			var2.endFill();
		}
	}
	function setMovieClipColor(var2, var3)
	{
		var var4 = new Color(var2);
		var4.setRGB(var3);
		if(var3 == -1)
		{
			var2._alpha = 0;
		}
	}
	function setMovieClipTransform(var2, var3)
	{
		var var4 = new Color(var2);
		var4.setTransform(var3);
	}
}
