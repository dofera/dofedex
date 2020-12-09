class ank.gapi.controls.Button extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Button";
	var _bToggle = false;
	var _bRadio = false;
	var _sLabel = "";
	var _sBackgroundUp = "ButtonNormalUp";
	var _sBackgroundDown = "ButtonNormalDown";
	var _nLabelPadding = 0;
	function Button()
	{
		super();
	}
	function __set__label(§\x1e\x11\x0b§)
	{
		this._sLabel = var2;
		this.displayLabel();
		return this.__get__label();
	}
	function __set__selected(§\x15\x19§)
	{
		if(this._bSelected != var2)
		{
			this._lblLabel._x = this._lblLabel._x + (!var2?-0.5:0.5);
			this._lblLabel._y = this._lblLabel._y + (!var2?-0.5:0.5);
			this._mcIcon._x = this._mcIcon._x + (!var2?-0.5:0.5);
			this._mcIcon._y = this._mcIcon._y + (!var2?-0.5:0.5);
			this.dispatchEvent({type:"stateChanged",target:this,value:var2});
		}
		this._bSelected = var2;
		this._mcDown._visible = this._bSelected;
		this._mcUp._visible = !this._bSelected;
		this.setLabelStyle();
		return this.__get__selected();
	}
	function __get__selected()
	{
		return this._bSelected;
	}
	function __set__toggle(§\x14\x13§)
	{
		this._bToggle = var2;
		return this.__get__toggle();
	}
	function __get__toggle()
	{
		return this._bToggle;
	}
	function __set__radio(§\x16\x12§)
	{
		this._bRadio = var2;
		return this.__get__radio();
	}
	function __get__radio()
	{
		return this._bRadio;
	}
	function __set__icon(§\x1e\x11\x1b§)
	{
		this._sIcon = var2;
		if(this.initialized)
		{
			this.displayIcon();
		}
		return this.__get__icon();
	}
	function __get__icon()
	{
		return this._sIcon;
	}
	function __get__iconClip()
	{
		return this._mcIcon;
	}
	function __set__backgroundUp(§\x1e\x14\x18§)
	{
		this._sBackgroundUp = var2;
		if(this.initialized)
		{
			this.drawBackgrounds();
		}
		return this.__get__backgroundUp();
	}
	function __get__backgroundUp()
	{
		return this._sBackgroundUp;
	}
	function __set__backgroundDown(§\x1e\x14\x19§)
	{
		this._sBackgroundDown = var2;
		if(this.initialized)
		{
			this.drawBackgrounds();
		}
		return this.__get__backgroundDown();
	}
	function __get__backgroundDown()
	{
		return this._sBackgroundDown;
	}
	function setPreferedSize(§\x04\x05§)
	{
		if(this._sLabel != "")
		{
			if(_global.isNaN(Number(var2)))
			{
				this._nLabelPadding = 0;
			}
			else
			{
				this._nLabelPadding = Number(var2);
			}
			this._lblLabel.setPreferedSize("left");
			this.setSize(this._lblLabel.width + this._nLabelPadding * 2);
		}
	}
	function init()
	{
		super.init(false,ank.gapi.controls.Button.CLASS_NAME);
	}
	function createChildren()
	{
		super.createChildren();
		this.drawBackgrounds();
		this.selected = this._bSelected && this._bToggle;
		this.attachMovie("Label","_lblLabel",30,{styleName:this.getStyle().labelupstyle});
		this._lblLabel.addEventListener("change",this);
		if(this._sLabel == undefined)
		{
			this._sLabel = "Label";
		}
	}
	function draw()
	{
		var var2 = this.getStyle();
		this.setLabelStyle();
		this.displayLabel();
		this._mcUp.setStyleColor(var2,"color");
		this._mcDown.setStyleColor(var2,"downcolor");
	}
	function size()
	{
		super.size();
		this.arrange();
	}
	function arrange()
	{
		var var2 = this._mcUp;
		var var3 = this._mcDown;
		var2.setSize(this.__width,this.__height,true);
		var3.setSize(this.__width,this.__height,true);
		this.displayLabel();
		this.displayIcon();
	}
	function setEnabled()
	{
		if(!this._bEnabled)
		{
			this.setMovieClipTransform(this,this.getStyle().disabledtransform);
		}
		else
		{
			this.setMovieClipTransform(this,{ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
		}
	}
	function drawBackgrounds()
	{
		if(this._sBackgroundDown != "none")
		{
			this.attachMovie(this._sBackgroundDown,"_mcDown",10);
		}
		if(this._sBackgroundUp != "none")
		{
			this.attachMovie(this._sBackgroundUp,"_mcUp",20);
		}
	}
	function displayIcon()
	{
		if(this._mcIcon != undefined)
		{
			this._mcIcon.removeMovieClip();
		}
		if(this._sIcon.length == 0)
		{
			return undefined;
		}
		this.attachMovie(this._sIcon,"_mcIcon",40);
		var var2 = this._mcIcon.getBounds(this);
		this._mcIcon._x = (this.__width - this._mcIcon._width) / 2 - var2.xMin;
		this._mcIcon._y = (this.__height - this._mcIcon._height) / 2 - var2.yMin;
	}
	function setLabelStyle(§\x16\x18§)
	{
		if(this._bSelected)
		{
			this._lblLabel.styleName = this.getStyle().labeldownstyle;
		}
		else if(var2 == true && this.getStyle().labeloverstyle != undefined)
		{
			this._lblLabel.styleName = this.getStyle().labeloverstyle;
		}
		else
		{
			this._lblLabel.styleName = this.getStyle().labelupstyle;
		}
	}
	function displayLabel()
	{
		this._lblLabel.text = this._sLabel;
		if(this._bInitialized)
		{
			this.placeLabel();
		}
	}
	function placeLabel()
	{
		this._lblLabel.setSize(this.__width - 2 * this._nLabelPadding,this._lblLabel.textHeight + 4);
		if(this._sLabel.length == 0)
		{
			this._lblLabel._visible = false;
		}
		else
		{
			this._lblLabel._visible = true;
			this._lblLabel._x = (this.__width - this._lblLabel.width) / 2;
			this._lblLabel._y = (this.__height - this._lblLabel.textHeight) / 2 - 4;
		}
	}
	function change(§\x1e\x19\x18§)
	{
		this.placeLabel();
	}
	function onPress()
	{
		if(!this.selected && !this._bToggle)
		{
			this.selected = true;
		}
		else if(this._bToggle && !this.selected)
		{
			this._mcUp._visible = false;
			this._mcDown._visible = true;
		}
	}
	function onRelease()
	{
		if(this._bRadio)
		{
			this.selected = true;
		}
		else if(this._bToggle)
		{
			this.selected = !this.selected;
		}
		else
		{
			this.selected = false;
		}
		this.dispatchEvent({type:"click"});
	}
	function onReleaseOutside()
	{
		if(this._bToggle)
		{
			if(!this.selected)
			{
				this._mcUp._visible = true;
				this._mcDown._visible = false;
			}
		}
		else
		{
			this.selected = false;
		}
		this.onRollOut();
	}
	function onRollOver()
	{
		this.setLabelStyle(true);
		this.dispatchEvent({type:"over",target:this});
	}
	function onRollOut()
	{
		this.setLabelStyle(false);
		this.dispatchEvent({type:"out",target:this});
	}
}
