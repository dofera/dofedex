class ank.gapi.controls.Label extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Label";
	var _sTextfiledType = "dynamic";
	var _bMultiline = false;
	var _bWordWrap = false;
	var bDisplayDebug = false;
	function Label()
	{
		super();
	}
	function __set__html(var2)
	{
		this._bHTML = var2;
		this.setTextFieldProperties();
		return this.__get__html();
	}
	function __get__html()
	{
		return this._bHTML;
	}
	function __set__multiline(var2)
	{
		this._bMultiline = var2;
		this.setTextFieldProperties();
		return this.__get__multiline();
	}
	function __get__multiline()
	{
		return this._bMultiline;
	}
	function __set__wordWrap(var2)
	{
		this._bWordWrap = var2;
		this.setTextFieldProperties();
		return this.__get__wordWrap();
	}
	function __get__wordWrap()
	{
		return this._bWordWrap;
	}
	function __set__text(var2)
	{
		this._sText = var2;
		this._bSettingNewText = true;
		this.setTextFieldProperties();
		return this.__get__text();
	}
	function __get__text()
	{
		return this._tText.text != undefined?this._tText.text:this._sText;
	}
	function __get__textHeight()
	{
		return this._tText.textHeight;
	}
	function __get__textWidth()
	{
		return this._tText.textWidth;
	}
	function __set__textColor(var2)
	{
		this._tText.textColor = var2;
		return this.__get__textColor();
	}
	function setPreferedSize(var2)
	{
		this._tText.autoSize = var2;
		this.setSize(this.textWidth + 5,this.textHeight);
	}
	function init()
	{
		super.init(false,ank.gapi.controls.Label.CLASS_NAME);
		this._tfFormatter = new TextFormat();
	}
	function createChildren()
	{
		this.createTextField("_tText",10,0,1,this.__width,this.__height - 1);
		this._tText.addListener(this);
		this._tText.onKillFocus = function()
		{
			this._parent.onKillFocus();
		};
		this._tText.onSetFocus = function()
		{
			this._parent.onSetFocus();
		};
		this.setTextFieldProperties();
	}
	function size()
	{
		super.size();
		this._tText._height = this.__height - 1;
		this._tDotText.removeTextField();
		this._mcDot.removeMovieClip();
		if(this._tText.textWidth > this.__width && this._sTextfiledType == "dynamic")
		{
			this.createTextField("_tDotText",20,0,1,this.__width,this.__height - 1);
			this._tDotText.selectable = false;
			this._tDotText.autoSize = "right";
			this._tDotText.embedFonts = this.getStyle().labelembedfonts;
			this._tDotText.text = "...";
			this._tDotText.setNewTextFormat(this._tfFormatter);
			this._tDotText.setTextFormat(this._tfFormatter);
			this._tText._width = this.__width - this._tDotText.textWidth;
			this.createEmptyMovieClip("_mcDot",30);
			this.drawRoundRect(this._mcDot,this.__width - this._tDotText.textWidth,0,this._tDotText.textWidth + 5,this.__height,0,0,0);
			this._mcDot.onRollOver = function()
			{
				this._parent.gapi.showTooltip(this._parent._sText,this._parent,0);
			};
			this._mcDot.onRollOut = function()
			{
				this._parent.gapi.hideTooltip();
			};
		}
		else
		{
			this._tText._width = this.__width;
		}
	}
	function draw()
	{
		var var2 = this.getStyle();
		this._tfFormatter = this._tText.getTextFormat();
		this._tfFormatter.font = var2.labelfont;
		this._tfFormatter.align = var2.labelalign;
		this._tfFormatter.size = var2.labelsize;
		if(!this._bHTML)
		{
			this._tfFormatter.color = var2.labelcolor;
		}
		this._tfFormatter.bold = var2.labelbold;
		this._tfFormatter.italic = var2.labelitalic;
		this._tText.embedFonts = var2.labelembedfonts;
		this._tText.antiAliasType = var2.antialiastype;
		this.setTextFieldProperties();
	}
	function setTextFieldProperties()
	{
		if(this._tText != undefined)
		{
			this._tText.wordWrap = this._bWordWrap;
			this._tText.multiline = this._bMultiline;
			this._tText.selectable = this._sTextfiledType == "input";
			this._tText.type = this._sTextfiledType;
			this._tText.html = !this._bHTML?false:true;
			if(this._tfFormatter.font != undefined)
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
			if(this._tText.textWidth > this.__width && this._sTextfiledType == "dynamic")
			{
				this.size();
			}
			else
			{
				this._tDotText.removeTextField();
				this._mcDot.removeMovieClip();
			}
			this.onChanged();
		}
	}
	function onChanged()
	{
		this.dispatchEvent({type:"change"});
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
