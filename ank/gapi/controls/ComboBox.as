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
	function __set__cellRenderer(loc2)
	{
		this._sCellRenderer = loc2;
		return this.__get__cellRenderer();
	}
	function __get__cellRenderer()
	{
		return this._sCellRenderer;
	}
	function __set__isButtonLeft(loc2)
	{
		this._bButtonLeft = loc2;
		return this.__get__isButtonLeft();
	}
	function __get__isButtonLeft()
	{
		return this._bButtonLeft;
	}
	function __set__rowHeight(loc2)
	{
		if(loc2 == 0)
		{
			return undefined;
		}
		this._nRowHeight = loc2;
		return this.__get__rowHeight();
	}
	function __get__rowHeight()
	{
		return this._nRowHeight;
	}
	function __set__buttonWidth(loc2)
	{
		this._nButtonWidth = loc2;
		return this.__get__buttonWidth();
	}
	function __get__buttonWidth()
	{
		return this._nButtonWidth;
	}
	function __set__labelLeftMargin(loc2)
	{
		this._nLabelLeftMargin = loc2;
		return this.__get__labelLeftMargin();
	}
	function __get__labelLeftMargin()
	{
		return this._nLabelLeftMargin;
	}
	function __set__labelRightMargin(loc2)
	{
		this._nLabelRightMargin = loc2;
		return this.__get__labelRightMargin();
	}
	function __get__labelRightMargin()
	{
		return this._nLabelRightMargin;
	}
	function __set__labelTopMargin(loc2)
	{
		this._nLabelTopMargin = loc2;
		return this.__get__labelTopMargin();
	}
	function __get__labelTopMargin()
	{
		return this._nLabelTopMargin;
	}
	function __set__labelBottomMargin(loc2)
	{
		this._nLabelBottomMargin = loc2;
		return this.__get__labelBottomMargin();
	}
	function __get__labelBottomMargin()
	{
		return this._nLabelBottomMargin;
	}
	function __set__listLeftMargin(loc2)
	{
		this._nListLeftMargin = loc2;
		return this.__get__listLeftMargin();
	}
	function __get__listLeftMargin()
	{
		return this._nListLeftMargin;
	}
	function __set__listRightMargin(loc2)
	{
		this._nListRightMargin = loc2;
		return this.__get__listRightMargin();
	}
	function __get__listRightMargin()
	{
		return this._nListRightMargin;
	}
	function __set__rowCount(loc2)
	{
		this._nRowCount = loc2;
		return this.__get__rowCount();
	}
	function __get__rowCount()
	{
		return this._nRowCount;
	}
	function __set__mcListParent(loc2)
	{
		this._sMcListParent = loc2;
		return this.__get__mcListParent();
	}
	function __get__mcListParent()
	{
		return this._sMcListParent;
	}
	function __set__background(loc2)
	{
		this._sBackground = loc2;
		return this.__get__background();
	}
	function __get__background()
	{
		return this._sBackground;
	}
	function __set__buttonBackgroundUp(loc2)
	{
		this._sButtonBackgroundUp = loc2;
		return this.__get__buttonBackgroundUp();
	}
	function __get__backgroundUp()
	{
		return this._sButtonBackgroundUp;
	}
	function __set__buttonBackgroundDown(loc2)
	{
		this._sButtonBackgroundDown = loc2;
		return this.__get__buttonBackgroundDown();
	}
	function __get__buttonBackgroundDown()
	{
		return this._sButtonBackgroundDown;
	}
	function __set__buttonIcon(loc2)
	{
		this._sButtonIcon = loc2;
		if(this.initialized)
		{
			this._btnOpen.icon = loc2;
		}
		return this.__get__buttonIcon();
	}
	function __get__buttonIcon()
	{
		return this._sButtonIcon;
	}
	function __set__dataProvider(loc2)
	{
		this._eaDataProvider = loc2;
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
	function __set__selectedIndex(loc2)
	{
		this._nSelectedIndex = loc2;
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
		var loc2 = Math.max(this.__width - this._nButtonWidth - this._nLabelLeftMargin - this._nLabelRightMargin,0);
		var loc3 = Math.max(this.__height - this._nLabelTopMargin - this._nLabelBottomMargin,0);
		this._lblCombo.setSize(loc2,loc3);
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
		var loc2 = this.getStyle();
		this._lblCombo.styleName = loc2.labelstyle;
		this._btnOpen.styleName = loc2.buttonstyle;
		this._mcBack.setStyleColor(loc2,"color");
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
		var loc2 = this._eaDataProvider != undefined?this._eaDataProvider.length:1;
		var loc3 = this._nListLeftMargin;
		var loc4 = this.__height;
		this._nListWidth = this.__width - this._nListLeftMargin - this._nListRightMargin - 2;
		this._nListHeight = Math.min(loc2,this._nRowCount) * this._nRowHeight + 1;
		var loc5 = {x:loc3,y:loc4};
		this.localToGlobal(loc5);
		this._nListX = loc5.x;
		this._nListY = loc5.y;
	}
	function clearDrawedList()
	{
		this._mcComboBoxPopup.removeMovieClip();
	}
	function drawList()
	{
		if(this._sMcListParent == "_parent")
		{
			var loc2 = this._parent;
		}
		else
		{
			var loc3 = new ank.utils.(String(this._sMcListParent));
			var loc4 = loc3.replace("this",String(this));
			loc2 = eval(String(loc4));
		}
		if(loc2 == undefined)
		{
			loc2 = this._parent;
		}
		if(loc2._mcComboBoxPopup != undefined)
		{
			loc2._mcComboBoxPopup.comboBox.removeList();
		}
		this._mcComboBoxPopup = loc2.createEmptyMovieClip("_mcComboBoxPopup",loc2.getNextHighestDepth());
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
	function setLabel(loc2)
	{
		this._lblCombo.text = loc2 != undefined?loc2:"";
	}
	function getSelectedItemText()
	{
		var loc2 = this.selectedItem;
		if(typeof loc2 == "string")
		{
			return String(loc2);
		}
		if(loc2.label != undefined)
		{
			return loc2.label;
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
	function click(loc2)
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
	function itemSelected(loc2)
	{
		this._nSelectedIndex = this._lstCombo.selectedIndex;
		this.setLabel(this.getSelectedItemText());
		this.removeList();
		this.dispatchEvent({type:"itemSelected",target:this});
	}
}
