class ank.gapi.controls.ComboBox extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ComboBox";
   var _bButtonLeft = false;
   var _nRowHeight = 20;
   var _nButtonWidth = 20;
   var _nLabelLeftMargin = 4;
   var _nLabelRightMargin = 4;
   var _nLabelTopMargin = 0;
   var _nLabelBottomMargin = 0;
   var _nListLeftMargin = 4;
   var _nListRightMargin = 4;
   var _nRowCount = 4;
   var _sMcListParent = "_root";
   var _sCellRenderer = "DefaultCellRenderer";
   var _sButtonBackgroundUp = "ButtonComboBoxUp";
   var _sButtonBackgroundDown = "ButtonComboBoxDown";
   var _sButtonIcon = "ComboBoxButtonNormalIcon";
   var _sBackground = "ComboBoxNormal";
   function ComboBox()
   {
      super();
   }
   function __set__cellRenderer(sCellRenderer)
   {
      this._sCellRenderer = sCellRenderer;
      return this.__get__cellRenderer();
   }
   function __get__cellRenderer()
   {
      return this._sCellRenderer;
   }
   function __set__isButtonLeft(bButtonLeft)
   {
      this._bButtonLeft = bButtonLeft;
      return this.__get__isButtonLeft();
   }
   function __get__isButtonLeft()
   {
      return this._bButtonLeft;
   }
   function __set__rowHeight(nRowHeight)
   {
      if(nRowHeight == 0)
      {
         return undefined;
      }
      this._nRowHeight = nRowHeight;
      return this.__get__rowHeight();
   }
   function __get__rowHeight()
   {
      return this._nRowHeight;
   }
   function __set__buttonWidth(nButtonWidth)
   {
      this._nButtonWidth = nButtonWidth;
      return this.__get__buttonWidth();
   }
   function __get__buttonWidth()
   {
      return this._nButtonWidth;
   }
   function __set__labelLeftMargin(nLabelLeftMargin)
   {
      this._nLabelLeftMargin = nLabelLeftMargin;
      return this.__get__labelLeftMargin();
   }
   function __get__labelLeftMargin()
   {
      return this._nLabelLeftMargin;
   }
   function __set__labelRightMargin(nLabelRightMargin)
   {
      this._nLabelRightMargin = nLabelRightMargin;
      return this.__get__labelRightMargin();
   }
   function __get__labelRightMargin()
   {
      return this._nLabelRightMargin;
   }
   function __set__labelTopMargin(nLabelTopMargin)
   {
      this._nLabelTopMargin = nLabelTopMargin;
      return this.__get__labelTopMargin();
   }
   function __get__labelTopMargin()
   {
      return this._nLabelTopMargin;
   }
   function __set__labelBottomMargin(nLabelBottomMargin)
   {
      this._nLabelBottomMargin = nLabelBottomMargin;
      return this.__get__labelBottomMargin();
   }
   function __get__labelBottomMargin()
   {
      return this._nLabelBottomMargin;
   }
   function __set__listLeftMargin(nListLeftMargin)
   {
      this._nListLeftMargin = nListLeftMargin;
      return this.__get__listLeftMargin();
   }
   function __get__listLeftMargin()
   {
      return this._nListLeftMargin;
   }
   function __set__listRightMargin(nListRightMargin)
   {
      this._nListRightMargin = nListRightMargin;
      return this.__get__listRightMargin();
   }
   function __get__listRightMargin()
   {
      return this._nListRightMargin;
   }
   function __set__rowCount(nRowCount)
   {
      this._nRowCount = nRowCount;
      return this.__get__rowCount();
   }
   function __get__rowCount()
   {
      return this._nRowCount;
   }
   function __set__mcListParent(sMcListParent)
   {
      this._sMcListParent = sMcListParent;
      return this.__get__mcListParent();
   }
   function __get__mcListParent()
   {
      return this._sMcListParent;
   }
   function __set__background(sBackground)
   {
      this._sBackground = sBackground;
      return this.__get__background();
   }
   function __get__background()
   {
      return this._sBackground;
   }
   function __set__buttonBackgroundUp(sButtonBackgroundUp)
   {
      this._sButtonBackgroundUp = sButtonBackgroundUp;
      return this.__get__buttonBackgroundUp();
   }
   function __get__backgroundUp()
   {
      return this._sButtonBackgroundUp;
   }
   function __set__buttonBackgroundDown(sButtonBackgroundDown)
   {
      this._sButtonBackgroundDown = sButtonBackgroundDown;
      return this.__get__buttonBackgroundDown();
   }
   function __get__buttonBackgroundDown()
   {
      return this._sButtonBackgroundDown;
   }
   function __set__buttonIcon(sButtonIcon)
   {
      this._sButtonIcon = sButtonIcon;
      if(this.initialized)
      {
         this._btnOpen.icon = sButtonIcon;
      }
      return this.__get__buttonIcon();
   }
   function __get__buttonIcon()
   {
      return this._sButtonIcon;
   }
   function __set__dataProvider(eaDataProvider)
   {
      this._eaDataProvider = eaDataProvider;
      this._eaDataProvider.addEventListener("modelChanged",this);
      this.modelChanged();
      if(this.initialized)
      {
         this.removeList();
         this.calculateListSize();
      }
      return this.__get__dataProvider();
   }
   function __get__dataProvider()
   {
      return this._eaDataProvider;
   }
   function __set__selectedIndex(nSelectedIndex)
   {
      this._nSelectedIndex = nSelectedIndex;
      if(this.initialized)
      {
         this.removeList();
         this.setLabel(this.getSelectedItemText());
      }
      return this.__get__selectedIndex();
   }
   function __get__selectedIndex()
   {
      return this._nSelectedIndex;
   }
   function __get__selectedItem()
   {
      return this._eaDataProvider[this._nSelectedIndex];
   }
   function init()
   {
      super.init(false,ank.gapi.controls.ComboBox.CLASS_NAME);
   }
   function createChildren()
   {
      this.attachMovie(this._sBackground,"_mcBack",this.getNextHighestDepth());
      this._mcBack.onRelease = function()
      {
         this._parent.autoOpenCloseList();
      };
      this._mcBack.useHandCursor = false;
      this.attachMovie("Button","_btnOpen",this.getNextHighestDepth(),{toggle:true,icon:this._sButtonIcon,backgroundUp:this._sButtonBackgroundUp,backgroundDown:this._sButtonBackgroundDown});
      this._btnOpen.addEventListener("click",this);
      this.attachMovie("Label","_lblCombo",this.getNextHighestDepth(),{text:""});
      Key.addListener(this);
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      var _loc2_ = Math.max(this.__width - this._nButtonWidth - this._nLabelLeftMargin - this._nLabelRightMargin,0);
      var _loc3_ = Math.max(this.__height - this._nLabelTopMargin - this._nLabelBottomMargin,0);
      this._lblCombo.setSize(_loc2_,_loc3_);
      this._btnOpen.setSize(this._nButtonWidth,this.__height);
      this._lblCombo._y = this._nLabelTopMargin;
      if(this._bButtonLeft)
      {
         this._lblCombo._x = this._nButtonWidth + this._nLabelLeftMargin;
      }
      else
      {
         this._lblCombo._x = this._nLabelLeftMargin;
         this._btnOpen._x = this.__width - this._nButtonWidth;
      }
      this._mcBack.setSize(this.__width,this.__height,true);
      this.calculateListSize();
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this._lblCombo.styleName = _loc2_.labelstyle;
      this._btnOpen.styleName = _loc2_.buttonstyle;
      this._mcBack.setStyleColor(_loc2_,"color");
   }
   function setEnabled()
   {
      this._btnOpen.enabled = this._bEnabled;
      if(!this._bEnabled)
      {
         this.setMovieClipTransform(this,this.getStyle().disabledtransform);
      }
      else
      {
         this.setMovieClipTransform(this,{ra:100,rb:0,ga:100,gb:0,ba:100,bb:0,aa:100,ab:0});
      }
   }
   function calculateListSize()
   {
      var _loc2_ = this._eaDataProvider != undefined?this._eaDataProvider.length:1;
      var _loc3_ = this._nListLeftMargin;
      var _loc4_ = this.__height;
      this._nListWidth = this.__width - this._nListLeftMargin - this._nListRightMargin - 2;
      this._nListHeight = Math.min(_loc2_,this._nRowCount) * this._nRowHeight + 1;
      var _loc5_ = {x:_loc3_,y:_loc4_};
      this.localToGlobal(_loc5_);
      this._nListX = _loc5_.x;
      this._nListY = _loc5_.y;
   }
   function clearDrawedList()
   {
      this._mcComboBoxPopup.removeMovieClip();
   }
   function drawList()
   {
      if(this._sMcListParent == "_parent")
      {
         var _loc2_ = this._parent;
      }
      else
      {
         var _loc3_ = new ank.utils.ExtendedString(String(this._sMcListParent));
         var _loc4_ = _loc3_.replace("this",String(this));
         _loc2_ = eval(String(_loc4_));
      }
      if(_loc2_ == undefined)
      {
         _loc2_ = this._parent;
      }
      if(_loc2_._mcComboBoxPopup != undefined)
      {
         _loc2_._mcComboBoxPopup.comboBox.removeList();
      }
      this._mcComboBoxPopup = _loc2_.createEmptyMovieClip("_mcComboBoxPopup",_loc2_.getNextHighestDepth());
      this._mcComboBoxPopup.comboBox = this;
      this.drawRoundRect(this._mcComboBoxPopup,this._nListX,this._nListY,this._nListWidth,this._nListHeight,0,this.getStyle().listbordercolor);
      this._mcComboBoxPopup.attachMovie("List","_lstCombo",this._mcComboBoxPopup.getNextHighestDepth(),{styleName:this.getStyle().liststyle,rowHeight:this._nRowHeight,_x:this._nListX + 1,_y:this._nListY,_width:this._nListWidth - 2,_height:this._nListHeight - 1,dataProvider:this._eaDataProvider,selectedIndex:this._nSelectedIndex,cellRenderer:this._sCellRenderer});
      this._lstCombo = this._mcComboBoxPopup._lstCombo;
      this._lstCombo.addEventListener("itemSelected",this);
      this._btnOpen.selected = true;
   }
   function removeList()
   {
      this._mcComboBoxPopup.removeMovieClip();
      this._btnOpen.selected = false;
   }
   function autoOpenCloseList()
   {
      if(!this._bEnabled)
      {
         return undefined;
      }
      if(this._btnOpen.selected)
      {
         this.removeList();
      }
      else
      {
         this.drawList();
      }
   }
   function setLabel(sText)
   {
      this._lblCombo.text = sText != undefined?sText:"";
   }
   function getSelectedItemText()
   {
      var _loc2_ = this.selectedItem;
      if(typeof _loc2_ == "string")
      {
         return String(_loc2_);
      }
      if(_loc2_.label != undefined)
      {
         return _loc2_.label;
      }
      return "";
   }
   function modelChanged()
   {
      this.setLabel(this.getSelectedItemText());
   }
   function onKeyUp()
   {
      this.removeList();
   }
   function click(oEvent)
   {
      if(this._btnOpen.selected)
      {
         this.drawList();
      }
      else
      {
         this.removeList();
      }
   }
   function itemSelected(oEvent)
   {
      this._nSelectedIndex = this._lstCombo.selectedIndex;
      this.setLabel(this.getSelectedItemText());
      this.removeList();
      this.dispatchEvent({type:"itemSelected",target:this});
   }
}
