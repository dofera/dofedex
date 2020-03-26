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
   function __set__contentPath(sContentPath)
   {
      this.addToQueue({object:this,method:function(sPath)
      {
         this._ldrContent.contentPath = sPath;
      },params:[sContentPath]});
      return this.__get__contentPath();
   }
   function __set__forceReload(bReload)
   {
      this._ldrContent.forceReload = bReload;
      return this.__get__forceReload();
   }
   function __get__contentPath()
   {
      return this._ldrContent.contentPath;
   }
   function __set__contentData(oContentData)
   {
      this._oContentData = oContentData;
      if(this._oContentData.params != undefined)
      {
         this._ldrContent.contentParams = this._oContentData.params;
      }
      if(oContentData.iconFile != undefined)
      {
         this.contentPath = oContentData.iconFile;
      }
      else
      {
         this.contentPath = "";
      }
      if(oContentData.label != undefined)
      {
         if(this.label != oContentData.label)
         {
            this.label = oContentData.label;
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
   function __set__backgroundRenderer(sBackground)
   {
      if(sBackground.length == 0 || sBackground == undefined)
      {
         return undefined;
      }
      this._sBackground = sBackground;
      this.attachBackground();
      if(this._bInitialized)
      {
         this.size();
      }
      return this.__get__backgroundRenderer();
   }
   function __set__borderRenderer(sBorder)
   {
      if(sBorder.length == 0 || sBorder == undefined)
      {
         return undefined;
      }
      this._sBorder = sBorder;
      this.attachBorder();
      if(this._bInitialized)
      {
         this.size();
      }
      return this.__get__borderRenderer();
   }
   function __set__highlightRenderer(sHighlight)
   {
      if(sHighlight.length == 0 || sHighlight == undefined)
      {
         return undefined;
      }
      this._sHighlight = sHighlight;
      this.attachHighlight();
      if(this._bInitialized)
      {
         this.size();
      }
      return this.__get__highlightRenderer();
   }
   function __set__dragAndDrop(bDragAndDrop)
   {
      if(bDragAndDrop == undefined)
      {
         return undefined;
      }
      this._bDragAndDrop = bDragAndDrop;
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
   function __set__showLabel(bShowLabel)
   {
      if(bShowLabel == undefined)
      {
         return undefined;
      }
      this._bShowLabel = bShowLabel;
      if(bShowLabel)
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
   function __set__label(sLabel)
   {
      this._sLabel = sLabel;
      if(this._bShowLabel)
      {
         if(this._lblText == undefined)
         {
            this.attachMovie("Label","_lblText",30,{_width:this.__width,_height:this.__height,styleName:this.getStyle().labelstyle});
         }
         this.addToQueue({object:this,method:this.setLabel,params:[sLabel]});
      }
      return this.__get__label();
   }
   function __get__label()
   {
      return this._sLabel;
   }
   function __set__margin(nMargin)
   {
      nMargin = Number(nMargin);
      if(_global.isNaN(nMargin))
      {
         return undefined;
      }
      this._nMargin = nMargin;
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
   function __set__highlightFront(bHighlightFront)
   {
      this._bHighlightFront = bHighlightFront;
      if(!bHighlightFront && this._mcHighlight != undefined)
      {
         this._mcHighlight.swapDepths(1);
      }
      return this.__get__highlightFront();
   }
   function __get__highlightFront()
   {
      return this._bHighlightFront;
   }
   function __set__id(nId)
   {
      this._nId = nId;
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
      var _loc2_ = this.getStyle();
      this._mcBg.styleName = _loc2_.backgroundstyle;
      this._lblText.styleName = _loc2_.labelstyle;
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
   function setLabel(sLabel)
   {
      if(this._bShowLabel)
      {
         this._lblText.text = sLabel;
         var _loc3_ = Math.min(this._lblText.textWidth + 2,this.__width - 4);
         var _loc4_ = this._lblText.textHeight;
         this._mcLabelBackground.clear();
         if(_loc3_ > 2 && _loc4_ != 0)
         {
            this.drawRoundRect(this._mcLabelBackground,2,2,_loc3_,_loc4_ + 2,0,0,50);
         }
      }
      else
      {
         this._lblText.removeMovieClip();
         this._mcLabelBackground.clear();
      }
   }
}
