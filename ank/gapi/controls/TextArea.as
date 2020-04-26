class ank.gapi.controls.TextArea extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "TextArea";
	var _bEditable = true;
	var _bSelectable = true;
	var _bAutoHeight = false;
	var _bWordWrap = true;
	var _bScrollBarRight = true;
	var _bHTML = false;
	var _nScrollBarMargin = 0;
	function TextArea()
	{
		super();
	}
	function __set__border(loc2)
	{
		this._bBorder = loc2;
		if(this.border_mc == undefined)
		{
			this.drawBorder();
		}
		this.border_mc._visible = loc2;
		return this.__get__border();
	}
	function __get__border()
	{
		return this._bBorder;
	}
	function __set__url(sURL)
	{
		this._sURL = sURL;
		if(this._sURL != "")
		{
			this.loadText();
		}
		return this.__get__url();
	}
	function __set__editable(loc2)
	{
		this._bEditable = loc2;
		if(this._bInitialized)
		{
			this.addToQueue({object:this,method:this.setTextFieldProperties});
		}
		return this.__get__editable();
	}
	function __get__editable()
	{
		return this._bEditable;
	}
	function __set__autoHeight(loc2)
	{
		this._bAutoHeight = loc2;
		if(this._bInitialized)
		{
			this.addToQueue({object:this,method:this.setTextFieldProperties});
		}
		return this.__get__autoHeight();
	}
	function __get__autoHeight()
	{
		return this._bAutoHeight;
	}
	function __set__selectable(loc2)
	{
		this._bSelectable = loc2;
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
	function __set__wordWrap(loc2)
	{
		this._bWordWrap = loc2;
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
	function __set__html(loc2)
	{
		this._bHTML = loc2;
		if(this._bInitialized)
		{
			this.addToQueue({object:this,method:this.setTextFieldProperties});
		}
		return this.__get__html();
	}
	function __get__html()
	{
		return this._bHTML;
	}
	function __set__text(loc2)
	{
		this._sText = loc2;
		this._bSettingNewText = true;
		this.addToQueue({object:this,method:this.setTextFieldProperties});
		return this.__get__text();
	}
	function __get__text()
	{
		return this._tText.text;
	}
	function __set__scrollBarRight(loc2)
	{
		this._bScrollBarRight = loc2;
		return this.__get__scrollBarRight();
	}
	function __get__scrollBarRight()
	{
		return this._bScrollBarRight;
	}
	function __set__scrollBarMargin(loc2)
	{
		this._nScrollBarMargin = loc2;
		return this.__get__scrollBarMargin();
	}
	function __get__scrollBarMargin()
	{
		return this._nScrollBarMargin;
	}
	function __set__styleSheet(loc2)
	{
		if(loc2 != "")
		{
			var _owner = this;
			this._cssStyles = new TextField.StyleSheet();
			this._cssStyles.load(loc2);
			this._cssStyles.onLoad = function(loc2)
			{
				if(_owner._tText != undefined)
				{
					_owner.addToQueue({object:_owner,method:_owner.setTextFieldProperties});
				}
			};
		}
		else
		{
			this._cssStyles = undefined;
			this._tText.styleSheet = null;
		}
		return this.__get__styleSheet();
	}
	function __set__scrollPosition(loc2)
	{
		this._tText.scroll = loc2;
		return this.__get__scrollPosition();
	}
	function __get__scrollPosition()
	{
		return this._tText.scroll;
	}
	function __set__maxscroll(loc2)
	{
		this._tText.maxscroll = loc2;
		return this.__get__maxscroll();
	}
	function __get__maxscroll()
	{
		return this._tText.maxscroll;
	}
	function __set__maxChars(loc2)
	{
		this._tText.maxChars = loc2;
		return this.__get__maxChars();
	}
	function __get__maxChars()
	{
		return this._tText.maxChars;
	}
	function __get__textHeight()
	{
		return this._tText.textHeight;
	}
	function init()
	{
		super.init(false,ank.gapi.controls.TextArea.CLASS_NAME);
		if(this._sURL != undefined)
		{
			this.loadText();
		}
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
		ank.utils.MouseEvents.addListener(this);
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		this._sbVertical.setSize(this.__height);
		this._tText._height = this.__height;
		this._tText._width = this.__width;
	}
	function draw()
	{
		if(this._bBorder)
		{
			this.drawBorder();
		}
		if(!this._bBorder != undefined)
		{
			this.border_mc._visible = this._bBorder;
		}
		var loc2 = this.getStyle();
		this._tfFormatter = new TextFormat();
		this._tfFormatter.font = loc2.font;
		this._tfFormatter.align = loc2.align;
		this._tfFormatter.size = loc2.size;
		this._tfFormatter.color = loc2.color;
		this._tfFormatter.bold = loc2.bold;
		this._tfFormatter.italic = loc2.italic;
		this._tText.embedFonts = loc2.embedfonts;
		this._tText.antiAliasType = loc2.antialiastype;
		this._sbVertical.styleName = loc2.scrollbarstyle;
	}
	function loadText()
	{
		if(this._sURL == undefined || this._sURL == "")
		{
			return undefined;
		}
		this._lvText = new LoadVars();
		this._lvText.parent = this;
		this._lvText.onData = function(loc2)
		{
			this.parent.text = loc2;
		};
		this._lvText.load(this._sURL);
	}
	function setTextFieldProperties()
	{
		if(this._tText != undefined)
		{
			if(this._bAutoHeight)
			{
				this._tText.autoSize = "left";
			}
			this._tText.wordWrap = !this._bWordWrap?false:true;
			this._tText.multiline = true;
			this._tText.selectable = this._bSelectable;
			this._tText.type = !this._bEditable?"dynamic":"input";
			this._tText.html = this._bHTML;
			if(this._cssStyles != undefined)
			{
				this._tText.styleSheet = this._cssStyles;
				if(this._sText != undefined)
				{
					if(this._bHTML)
					{
						this._tText.htmlText = this._sText;
					}
					else
					{
						this._tText.text = this._sText;
					}
				}
			}
			else if(this._tfFormatter.font != undefined)
			{
				if(this._sText != undefined)
				{
					if(this._bHTML)
					{
						this._tText.htmlText = this._sText;
					}
					else
					{
						this._tText.text = this._sText;
					}
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
			this.attachMovie("ScrollBar","_sbVertical",20,{styleName:this.getStyle().scrollbarstyle});
			this._sbVertical.setSize(this.__height - 2);
			this._sbVertical._y = 1;
			this._sbVertical._x = !this._bScrollBarRight?0:this.__width - this._sbVertical._width - 3;
			this._tText._width = this.__width - this._sbVertical._width - 3 - this._nScrollBarMargin;
			this._tText._x = !this._bScrollBarRight?this._sbVertical._width + this._nScrollBarMargin:0;
			this._sbVertical.addEventListener("scroll",this);
		}
		var loc2 = this._tText.textHeight;
		var loc3 = 0.9 * this._tText._height / loc2 * this._tText.maxscroll;
		this._sbVertical.setScrollProperties(loc3,0,this._tText.maxscroll);
		this._sbVertical.scrollPosition = this._tText.scroll;
		if(this._bSettingNewText)
		{
			this._sbVertical.scrollPosition = 0;
			this._bSettingNewText = false;
		}
	}
	function removeScrollBar()
	{
		if(this._sbVertical != undefined)
		{
			this._sbVertical.removeMovieClip();
			this._tText._width = this.__width;
		}
	}
	function onChanged()
	{
		if(this._tText.textHeight >= this._tText._height || this._cssStyles != undefined && this._tText.textHeight + 5 >= this._tText._height)
		{
			this.addScrollBar();
		}
		else
		{
			this.removeScrollBar();
		}
		if(this._bAutoHeight && this._tText.textHeight != this.__height)
		{
			this.setSize(this.__width,this._tText.textHeight);
			this.dispatchEvent({type:"resize"});
		}
		this.dispatchEvent({type:"change"});
	}
	function scroll(loc2)
	{
		if(loc2.target == this._sbVertical)
		{
			this._tText.scroll = loc2.target.scrollPosition;
		}
	}
	function onMouseWheel(loc2, loc3)
	{
		if(String(loc3._target).indexOf(this._target) != -1)
		{
			this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - loc2;
		}
	}
	function onHref(loc2)
	{
		this.dispatchEvent({type:"href",params:loc2});
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
