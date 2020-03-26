class ank.gapi.controls.DataGrid extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "DataGrid";
   var _nRowHeight = 20;
   var _nTitleHeight = 20;
   var _sCellRenderer = "DefaultCellRenderer";
   var _bMultipleSelection = false;
   function DataGrid()
   {
      super();
   }
   function __set__titleHeight(nTitleHeight)
   {
      this._nTitleHeight = nTitleHeight;
      return this.__get__titleHeight();
   }
   function __get__titleHeight()
   {
      return this._nTitleHeight;
   }
   function __set__columnsWidths(aColumnsWidths)
   {
      this._aColumnsWidths = aColumnsWidths;
      return this.__get__columnsWidths();
   }
   function __get__columnsWidths()
   {
      return this._aColumnsWidths;
   }
   function __set__columnsNames(aColumnsNames)
   {
      this._aColumnsNames = aColumnsNames;
      this.setLabels();
      return this.__get__columnsNames();
   }
   function __get__columnsNames()
   {
      return this._aColumnsNames;
   }
   function __set__columnsProperties(aColumnsProperties)
   {
      this._aColumnsProperties = aColumnsProperties;
      return this.__get__columnsProperties();
   }
   function __get__columnsProperties()
   {
      return this._aColumnsProperties;
   }
   function __set__multipleSelection(bMultipleSelection)
   {
      this._bMultipleSelection = bMultipleSelection;
      return this.__get__multipleSelection();
   }
   function __get__multipleSelection()
   {
      return this._bMultipleSelection;
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
   function __set__cellRenderer(sCellRenderer)
   {
      this._sCellRenderer = sCellRenderer;
      return this.__get__cellRenderer();
   }
   function __get__cellRenderer()
   {
      return this._sCellRenderer;
   }
   function __set__dataProvider(eaDataProvider)
   {
      this._lstList.dataProvider = eaDataProvider;
      return this.__get__dataProvider();
   }
   function __get__dataProvider()
   {
      return this._lstList.dataProvider;
   }
   function __set__selectedIndex(nIndex)
   {
      this._lstList.selectedIndex = nIndex;
      return this.__get__selectedIndex();
   }
   function __get__selectedIndex()
   {
      return this._lstList.selectedIndex;
   }
   function __get__selectedItem()
   {
      return this._lstList.selectedItem;
   }
   function addItem(oItem)
   {
      this._lstList.addItem(oItem);
   }
   function addItemAt(oItem, nIndex)
   {
      this._lstList.addItemAt(oItem,nIndex);
   }
   function removeItemAt(oItem, nIndex)
   {
      this._lstList.removeItemAt(oItem,nIndex);
   }
   function removeAll()
   {
      this._lstList.removeAll();
   }
   function setVPosition(nPosition)
   {
      this._lstList.setVPosition(nPosition);
   }
   function sortOn(sPropName, nOption)
   {
      this._lstList.selectedIndex = -1;
      this._lstList.sortOn(sPropName,nOption);
   }
   function init()
   {
      super.init(false,ank.gapi.controls.DataGrid.CLASS_NAME);
   }
   function createChildren()
   {
      this.attachMovie("List","_lstList",10,{styleName:"none",multipleSelection:this._bMultipleSelection,rowHeight:this._nRowHeight,cellRenderer:this._sCellRenderer,enabled:this.enabled});
      this._lstList.addEventListener("itemSelected",this);
      this._lstList.addEventListener("itemdblClick",this);
      this._lstList.addEventListener("itemRollOver",this);
      this._lstList.addEventListener("itemRollOut",this);
      this._lstList.addEventListener("itemDrag",this);
      this.createEmptyMovieClip("_mcTitle",20);
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      this._lstList._y = this._nTitleHeight;
      this._lstList.setSize(this.__width,this.__height - this._nTitleHeight);
      this._mcTitle._width = this.__width;
      this._mcTitle._height = this._nTitleHeight;
      var _loc2_ = 0;
      var _loc3_ = 0;
      while(_loc3_ < this._aColumnsWidths.length)
      {
         var _loc4_ = _loc2_ + this._aColumnsWidths[_loc3_] >= this.__width?this.__width - _loc2_:this._aColumnsWidths[_loc3_];
         if(this._aColumnsProperties[_loc3_] != undefined)
         {
            var _loc5_ = this.attachMovie("Button","_btnTitle" + _loc3_,this.getNextHighestDepth(),{_x:_loc2_,styleName:"none",label:"",backgroundDown:"ButtonTransparentUp",backgroundUp:"ButtonTransparentUp",toggle:true,params:{index:_loc3_}});
            _loc5_.setSize(_loc4_,this._nTitleHeight);
            _loc5_.addEventListener("click",this);
         }
         this["_lblTitle" + _loc3_].removeMovieClip();
         var _loc6_ = this.attachMovie("Label","_lblTitle" + _loc3_,this.getNextHighestDepth(),{_x:_loc2_,styleName:this.getStyle().labelstyle,text:this._aColumnsNames[_loc3_]});
         _loc6_.setSize(_loc4_,this._nTitleHeight);
         _loc2_ = _loc2_ + _loc4_;
         _loc3_ = _loc3_ + 1;
      }
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this._lstList.styleName = _loc2_.liststyle;
      if(this.initialized)
      {
         var _loc3_ = this.getStyle().labelstyle;
         var _loc4_ = 0;
         while(_loc4_ < this._aColumnsWidths.length)
         {
            this["_lblTitle" + _loc4_].styleName = _loc3_;
            _loc4_ = _loc4_ + 1;
         }
      }
      this.drawRoundRect(this._mcTitle,0,0,1,1,0,_loc2_.titlebgcolor);
      this._mcTitle._alpha = _loc2_.titlebgcolor != -1?100:0;
   }
   function setLabels()
   {
      if(this.initialized)
      {
         var _loc2_ = 0;
         while(_loc2_ < this._aColumnsWidths.length)
         {
            this["_lblTitle" + _loc2_].text = this._aColumnsNames[_loc2_];
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function click(oEvent)
   {
      var _loc3_ = oEvent.target.params.index;
      var _loc4_ = this._aColumnsProperties[_loc3_];
      var _loc5_ = !oEvent.target.selected?Array.CASEINSENSITIVE | Array.DESCENDING:Array.CASEINSENSITIVE;
      if(!_global.isNaN(Number(this._lstList.dataProvider[0][_loc4_])))
      {
         _loc5_ = _loc5_ | Array.NUMERIC;
      }
      this.sortOn(_loc4_,_loc5_);
   }
   function itemSelected(oEvent)
   {
      oEvent.list = oEvent.target;
      oEvent.target = this;
      this.dispatchEvent(oEvent);
   }
   function itemRollOver(oEvent)
   {
      this.dispatchEvent(oEvent);
   }
   function itemRollOut(oEvent)
   {
      this.dispatchEvent(oEvent);
   }
   function itemDrag(oEvent)
   {
      this.dispatchEvent(oEvent);
   }
   function itemdblClick(oEvent)
   {
      this.dispatchEvent(oEvent);
   }
}
