class ank.gapi.controls.ChatArea extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "ChatArea";
	static var STOP_SCROLL_LENGTH = 6;
	var _bSelectable = false;
	var _bWordWrap = true;
	var _sScrollBarSide = "right";
	var _nScrollBarMargin = 0;
	var _bHideScrollBar = false;
	var _bUseMouseWheel = true;
	var _bInvalidateMaxScrollStop = false;
	var _nPreviousMaxscroll = 1;
	var _nScrollPosition = 1;
	function ChatArea()
	{
		super();
	}
	function __set__selectable(var2)
	{
		this._bSelectable = var2;
		if(this._bInitialized)
		{
			this.addToQueue({object:this,method:this.setTextFieldProperties});
		}
		return this.__get__selectable();
	}
	function __get__selectable()
	{
		return this._bSelectable;
	}
	function __set__wordWrap(var2)
	{
		this._bWordWrap = var2;
		if(this._bInitialized)
		{
			this.addToQueue({object:this,method:this.setTextFieldProperties});
		}
		return this.__get__wordWrap();
	}
	function __get__wordWrap()
	{
		return this._bWordWrap;
	}
	function __set__text(var2)
	{
		this._sText = var2;
		if(this.initialized)
		{
			this.setTextFieldProperties();
		}
		return this.__get__text();
	}
	function __get__text()
	{
		return this._tText.text;
	}
	function __get__htmlText()
	{
		return this._tText.htmlText;
	}
	function __set__scrollBarSide(var2)
	{
		this._sScrollBarSide = var2;
		return this.__get__scrollBarSide();
	}
	function __get__scrollBarSide()
	{
		return this._sScrollBarSide;
	}
	function __set__scrollBarMargin(var2)
	{
		this._nScrollBarMargin = var2;
		return this.__get__scrollBarMargin();
	}
	function __get__scrollBarMargin()
	{
		return this._nScrollBarMargin;
	}
	function __set__hideScrollBar(var2)
	{
		this._bHideScrollBar = var2;
		return this.__get__hideScrollBar();
	}
	function __get__hideScrollBar()
	{
		return this._bHideScrollBar;
	}
	function __set__useMouseWheel(var2)
	{
		this._bUseMouseWheel = var2;
		return this.__get__useMouseWheel();
	}
	function __get__useMouseWheel()
	{
		return this._bUseMouseWheel;
	}
	function init()
	{
		super.init(false,ank.gapi.controls.ChatArea.CLASS_NAME);
		this._tfFormatter = new TextFormat();
	}
	function createChildren()
	{
		this.createTextField("_tText",10,0,0,this.__width - 2,this.__height - 2);
		this._tText._x = 1;
		this._tText._y = 1;
		this._tText.addListener(this);
		this._tText.onSetFocus = function()
		{
			this._parent.onSetFocus();
		};
		this._tText.onKillFocus = function()
		{
			this._parent.onKillFocus();
		};
		this._tText.mouseWheelEnabled = true;
		this.addToQueue({object:this,method:this.setTextFieldProperties});
		ank.utils.MouseEvents.addListener(this);
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		this._tText._height = this.__height;
		this._tText._width = this.__width;
		this._bInvalidateMaxScrollStop = true;
		this.setTextFieldProperties();
	}
	function draw()
	{
		var var2 = this.getStyle();
		this._tfFormatter = new TextFormat();
		this._tfFormatter.font = var2.font;
		this._tfFormatter.align = var2.align;
		this._tfFormatter.size = var2.size;
		this._tfFormatter.color = var2.color;
		this._tfFormatter.bold = var2.bold;
		this._tfFormatter.italic = var2.italic;
		this._tText.embedFonts = var2.embedfonts;
		this._tText.antiAliasType = var2.antialiastype;
		this._sbVertical.styleName = var2.scrollbarstyle;
		if(var2.filters != undefined)
		{
			this._tText.filters = var2.filters;
		}
	}
	function setTextFieldProperties()
	{
		if(this._tText != undefined)
		{
			this._tText.wordWrap = !this._bWordWrap?false:true;
			this._tText.multiline = true;
			this._tText.selectable = this._bSelectable;
			this._tText.embedFonts = this.getStyle().embedfonts;
			this._tText.type = "dynamic";
			this._tText.html = true;
			if(this._tfFormatter.font != undefined)
			{
				if(this._sText != undefined)
				{
					this._nPreviousMaxscroll = this._tText.maxscroll;
					this.setTextWithBottomStart();
				}
				this._tText.setNewTextFormat(this._tfFormatter);
				this._tText.setTextFormat(this._tfFormatter);
			}
			this.onChanged();
		}
	}
	function addScrollBar()
	{
		if(this._sbVertical == undefined)
		{
			this.attachMovie("ScrollBar","_sbVertical",20,{styleName:this.getStyle().scrollbarstyle,_visible:!this._bHideScrollBar});
			this._sbVertical.addEventListener("scroll",this);
		}
		this._sbVertical.setSize(this.__height - 2);
		this._sbVertical._y = 1;
		this._sbVertical._x = this._sScrollBarSide != "right"?0:this.__width - this._sbVertical._width - 3;
		if(this._bHideScrollBar)
		{
			this._tText._width = this.__width;
			this._tText._x = 0;
		}
		else
		{
			this._tText._width = this.__width - this._sbVertical._width - 3 - this._nScrollBarMargin;
			this._tText._x = this._sScrollBarSide != "right"?this._sbVertical._width + this._nScrollBarMargin:0;
		}
		this.setScrollBarPosition();
		if(Math.abs(this._nPreviousMaxscroll - this._tText.scroll) < ank.gapi.controls.ChatArea.STOP_SCROLL_LENGTH || this._bInvalidateMaxScrollStop)
		{
			this._tText.scroll = this._tText.maxscroll;
			this._nScrollPosition = this._tText.maxscroll;
		}
		this._bInvalidateMaxScrollStop = false;
	}
	function setScrollBarPosition()
	{
		var var2 = this._tText.textHeight;
		var var3 = 0.9 * this._tText._height / var2 * this._tText.maxscroll;
		this._sbVertical.setScrollProperties(var3,0,this._tText.maxscroll);
		this._tText.scroll = this._nScrollPosition;
		this._sbVertical.scrollPosition = this._tText.scroll;
	}
	function setTextWithBottomStart()
	{
		this._tText.text = "";
		var var2 = 0;
		while(this._tText.maxscroll == 1 && var2 < 50)
		{
			this._tText.text = this._tText.text + "\n";
			var2 = var2 + 1;
		}
		this._tText.htmlText = this._tText.htmlText + this._sText;
	}
	function onMouseWheel(var2, var3)
	{
		if(!this._bUseMouseWheel)
		{
			return undefined;
		}
		if(String(var3._target).indexOf(this._target) != -1)
		{
			this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - var2;
		}
	}
	function onChanged()
	{
		this.addScrollBar();
	}
	function onScroller()
	{
		this.setScrollBarPosition();
	}
	function scroll(var2)
	{
		if(var2.target == this._sbVertical)
		{
			this._tText.scroll = var2.target.scrollPosition;
			this._nScrollPosition = this._tText.scroll;
		}
	}
	function onHref(var2)
	{
		this.dispatchEvent({type:"href",params:var2});
	}
	function onSetFocus()
	{
		getURL("FSCommand:" add "trapallkeys","false");
	}
	function onKillFocus()
	{
		getURL("FSCommand:" add "trapallkeys","true");
	}
}
