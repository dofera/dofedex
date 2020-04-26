class ank.gapi.controls.Container extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "Container";
	var _sBackground = "DefaultBackground";
	var _sHighlight = "DefaultHighlight";
	var _bDragAndDrop = true;
	var _bShowLabel = false;
	var _bSelected = false;
	var _nMargin = 2;
	var _bHighlightFront = true;
	function Container()
	{
		super();
	}
	function __set__contentPath(loc2)
	{
		this.addToQueue({object:this,method:function(loc2)
		{
			this._ldrContent.contentPath = loc2;
		},params:[loc2]});
		return this.__get__contentPath();
	}
	function __set__forceReload(loc2)
	{
		this._ldrContent.forceReload = loc2;
		return this.__get__forceReload();
	}
	function __get__contentPath()
	{
		return this._ldrContent.contentPath;
	}
	function __set__contentData(loc2)
	{
		this._oContentData = loc2;
		if(this._oContentData.params != undefined)
		{
			this._ldrContent.contentParams = this._oContentData.params;
		}
		if(loc2.iconFile != undefined)
		{
			this.contentPath = loc2.iconFile;
		}
		else
		{
			this.contentPath = "";
		}
		if(loc2.label != undefined)
		{
			if(this.label != loc2.label)
			{
				this.label = loc2.label;
			}
		}
		else
		{
			this.label = "";
		}
		return this.__get__contentData();
	}
	function __get__contentData()
	{
		return this._oContentData;
	}
	function __get__content()
	{
		return this._ldrContent.content;
	}
	function __get__holder()
	{
		return this._ldrContent.holder;
	}
	function __set__selected(bSelected)
	{
		this._bSelected = bSelected;
		this.addToQueue({object:this,method:function()
		{
			this._mcHighlight._visible = bSelected;
		}});
		return this.__get__selected();
	}
	function __get__selected()
	{
		return this._bSelected;
	}
	function __set__backgroundRenderer(loc2)
	{
		if(loc2.length == 0 || loc2 == undefined)
		{
			return undefined;
		}
		this._sBackground = loc2;
		this.attachBackground();
		if(this._bInitialized)
		{
			this.size();
		}
		return this.__get__backgroundRenderer();
	}
	function __set__borderRenderer(loc2)
	{
		if(loc2.length == 0 || loc2 == undefined)
		{
			return undefined;
		}
		this._sBorder = loc2;
		this.attachBorder();
		if(this._bInitialized)
		{
			this.size();
		}
		return this.__get__borderRenderer();
	}
	function __set__highlightRenderer(loc2)
	{
		if(loc2.length == 0 || loc2 == undefined)
		{
			return undefined;
		}
		this._sHighlight = loc2;
		this.attachHighlight();
		if(this._bInitialized)
		{
			this.size();
		}
		return this.__get__highlightRenderer();
	}
	function __set__dragAndDrop(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		this._bDragAndDrop = loc2;
		if(this._bInitialized)
		{
			this.setEnabled();
		}
		return this.__get__dragAndDrop();
	}
	function __get__dragAndDrop()
	{
		return this._bDragAndDrop;
	}
	function __set__showLabel(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		this._bShowLabel = loc2;
		if(loc2)
		{
			if(this._sLabel != undefined)
			{
				if(this._lblText == undefined)
				{
					this.attachMovie("Label","_lblText",30,{_width:this.__width,_height:this.__height,styleName:this.getStyle().labelstyle});
				}
				this.addToQueue({object:this,method:this.setLabel,params:[this._sLabel]});
			}
		}
		else
		{
			this._lblText.removeMovieClip();
			this._mcLabelBackground.clear();
		}
		return this.__get__showLabel();
	}
	function __get__showLabel()
	{
		return this._bShowLabel;
	}
	function __set__label(loc2)
	{
		this._sLabel = loc2;
		if(this._bShowLabel)
		{
			if(this._lblText == undefined)
			{
				this.attachMovie("Label","_lblText",30,{_width:this.__width,_height:this.__height,styleName:this.getStyle().labelstyle});
			}
			this.addToQueue({object:this,method:this.setLabel,params:[loc2]});
		}
		return this.__get__label();
	}
	function __get__label()
	{
		return this._sLabel;
	}
	function __set__margin(loc2)
	{
		loc2 = Number(loc2);
		if(_global.isNaN(loc2))
		{
			return undefined;
		}
		this._nMargin = loc2;
		if(this.initialized)
		{
			this._ldrContent.move(this._nMargin,this._nMargin);
		}
		return this.__get__margin();
	}
	function __get__margin()
	{
		return this._nMargin;
	}
	function __set__highlightFront(loc2)
	{
		this._bHighlightFront = loc2;
		if(!loc2 && this._mcHighlight != undefined)
		{
			this._mcHighlight.swapDepths(1);
		}
		return this.__get__highlightFront();
	}
	function __get__highlightFront()
	{
		return this._bHighlightFront;
	}
	function __set__id(loc2)
	{
		this._nId = loc2;
		return this.__get__id();
	}
	function __get__id()
	{
		return this._nId;
	}
	function forceNextLoad()
	{
		this._ldrContent.forceNextLoad();
	}
	function emulateClick()
	{
		this.dispatchEvent({type:"click"});
	}
	function init()
	{
		super.init(false,ank.gapi.controls.Container.CLASS_NAME);
	}
	function createChildren()
	{
		this.createEmptyMovieClip("_mcInteraction",0);
		this.drawRoundRect(this._mcInteraction,0,0,1,1,0,0,0);
		this._mcInteraction.trackAsMenu = true;
		this.attachMovie("Loader","_ldrContent",20,{scaleContent:true});
		this._ldrContent.move(this._nMargin,this._nMargin);
		this.createEmptyMovieClip("_mcLabelBackground",29);
	}
	function size()
	{
		super.size();
		if(this._bInitialized)
		{
			this.arrange();
		}
	}
	function arrange()
	{
		this._mcInteraction._width = this.__width;
		this._mcInteraction._height = this.__height;
		this._ldrContent.setSize(this.__width - this._nMargin * 2,this.__height - this._nMargin * 2);
		this._mcBg.setSize(this.__width,this.__height);
		this._mcHighlight.setSize(this.__width,this.__height);
		this._lblText.setSize(this.__width,this.__height);
	}
	function draw()
	{
		var loc2 = this.getStyle();
		this._mcBg.styleName = loc2.backgroundstyle;
		this._lblText.styleName = loc2.labelstyle;
	}
	function setEnabled()
	{
		if(this._bEnabled)
		{
			this._mcInteraction.onRelease = function()
			{
				if(this._parent._sLastMouseAction == "DragOver")
				{
					this._parent.dispatchEvent({type:"drop"});
				}
				else if(getTimer() - this._parent._nLastClickTime < ank.gapi.Gapi.DBLCLICK_DELAY)
				{
					ank.utils.Timer.removeTimer(this._parent,"container");
					this._parent.dispatchEvent({type:"dblClick"});
				}
				else
				{
					ank.utils.Timer.setTimer(this._parent,"container",this._parent,this._parent.dispatchEvent,ank.gapi.Gapi.DBLCLICK_DELAY,[{type:"click"}]);
				}
				this._parent._sLastMouseAction = "Release";
				this._parent._nLastClickTime = getTimer();
			};
			this._mcInteraction.onPress = function()
			{
				this._parent._sLastMouseAction = "Press";
			};
			this._mcInteraction.onRollOver = function()
			{
				this._parent._mcHighlight._visible = true;
				this._parent._sLastMouseAction = "RollOver";
				this._parent.dispatchEvent({type:"over"});
			};
			this._mcInteraction.onRollOut = function()
			{
				if(!this._parent._bSelected)
				{
					this._parent._mcHighlight._visible = false;
				}
				this._parent._sLastMouseAction = "RollOver";
				this._parent.dispatchEvent({type:"out"});
			};
			if(this._bDragAndDrop)
			{
				this._mcInteraction.onDragOver = function()
				{
					this._parent._mcHighlight._visible = true;
					this._parent._sLastMouseAction = "DragOver";
					this._parent.dispatchEvent({type:"over"});
				};
				this._mcInteraction.onDragOut = function()
				{
					if(!this._parent._bSelected)
					{
						this._parent._mcHighlight._visible = false;
					}
					if(this._parent._sLastMouseAction == "Press")
					{
						this._parent.dispatchEvent({type:"drag"});
					}
					this._parent._sLastMouseAction = "DragOut";
					this._parent.dispatchEvent({type:"out"});
				};
			}
		}
		else
		{
			delete this._mcInteraction.onRelease;
			delete this._mcInteraction.onPress;
			delete this._mcInteraction.onRollOver;
			delete this._mcInteraction.onRollOut;
			delete this._mcInteraction.onDragOver;
			delete this._mcInteraction.onDragOut;
		}
	}
	function attachBackground()
	{
		this.attachMovie(this._sBackground,"_mcBg",10);
	}
	function attachBorder()
	{
		this.attachMovie(this._sBorder,"_mcBorder",90);
	}
	function attachHighlight()
	{
		this.attachMovie(this._sHighlight,"_mcHighlight",!this._bHighlightFront?5:100);
		this._mcHighlight._visible = false;
	}
	function setLabel(loc2)
	{
		if(this._bShowLabel)
		{
			this._lblText.text = loc2;
			var loc3 = Math.min(this._lblText.textWidth + 2,this.__width - 4);
			var loc4 = this._lblText.textHeight;
			this._mcLabelBackground.clear();
			if(loc3 > 2 && loc4 != 0)
			{
				this.drawRoundRect(this._mcLabelBackground,2,2,loc3,loc4 + 2,0,0,50);
			}
		}
		else
		{
			this._lblText.removeMovieClip();
			this._mcLabelBackground.clear();
		}
	}
}
