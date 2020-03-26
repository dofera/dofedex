class ank.gapi.controls.List extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "List";
   var _aRows = new Array();
   var _nRowHeight = 20;
   var _bInvalidateLayout = true;
   var _bInvalidateScrollBar = true;
   var _nScrollPosition = 0;
   var _sCellRenderer = "DefaultCellRenderer";
   var _bMultipleSelection = false;
   var _bAutoScroll = false;
   var _bDblClickEnabled = false;
   function List()
   {
      super();
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
      if(sCellRenderer != undefined)
      {
         this._sCellRenderer = sCellRenderer;
      }
      return this.__get__cellRenderer();
   }
   function __get__cellRenderer()
   {
      return this._sCellRenderer;
   }
   function __set__dataProvider(ea)
   {
      delete this._nSelectedIndex;
      this._eaDataProvider = ea;
      this._eaDataProvider.addEventListener("modelChanged",this);
      var _loc3_ = Math.ceil(this.__height / this._nRowHeight);
      if(ea.length <= _loc3_)
      {
         this.setVPosition(0);
      }
      this.modelChanged();
      return this.__get__dataProvider();
   }
   function __get__dataProvider()
   {
      return this._eaDataProvider;
   }
   function __set__selectedIndex(nIndex)
   {
      var _loc3_ = this._mcContent["row" + nIndex];
      this._nSelectedIndex = nIndex;
      this.layoutSelection(nIndex,_loc3_);
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
   function __set__autoScroll(bAutoScroll)
   {
      this._bAutoScroll = bAutoScroll;
      return this.__get__autoScroll();
   }
   function __get__autoScroll()
   {
      return this._bAutoScroll;
   }
   function __set__dblClickEnabled(bDblClickEnabled)
   {
      this._bDblClickEnabled = bDblClickEnabled;
      return this.__get__dblClickEnabled();
   }
   function __get__dblClickEnabled()
   {
      return this._bDblClickEnabled;
   }
   function addItem(oItem)
   {
      this._aRows.push({item:oItem,selected:false});
      this.setScrollBarProperties(true);
      this.layoutContent();
   }
   function addItemAt(oItem, nIndex)
   {
      this._aRows.splice(nIndex,0,{item:oItem,selected:false});
      this.setScrollBarProperties(true);
      this.layoutContent();
   }
   function removeItemAt(oItem, nIndex)
   {
      this._aRows.splice(nIndex,1);
      this.setScrollBarProperties(true);
      this.layoutContent();
   }
   function removeAll()
   {
      this._aRows = new Array();
      this.setScrollBarProperties(true);
      this.layoutContent();
   }
   function setVPosition(nPosition, bForced)
   {
      var _loc4_ = this._eaDataProvider.length - Math.floor(this.__height / this._nRowHeight);
      if(nPosition > _loc4_)
      {
         nPosition = _loc4_;
      }
      if(nPosition < 0)
      {
         nPosition = 0;
      }
      if(this._nScrollPosition != nPosition || bForced)
      {
         this._nScrollPosition = nPosition;
         this.setScrollBarProperties(bForced == true);
         this.layoutContent();
      }
   }
   function sortOn(sPropName, nOption)
   {
      this._eaDataProvider.sortOn(sPropName,nOption);
      this.modelChanged();
   }
   function init()
   {
      super.init(false,ank.gapi.controls.List.CLASS_NAME);
   }
   function createChildren()
   {
      this.attachMovie("ScrollBar","_sbVertical",10,{styleName:this.styleName});
      this._sbVertical.addEventListener("scroll",this);
      this.createEmptyMovieClip("_mcContent",20);
      this.createEmptyMovieClip("_mcMask",30);
      this.drawRoundRect(this._mcMask,0,0,100,100,0,16711680);
      this._mcContent.setMask(this._mcMask);
      ank.utils.MouseEvents.addListener(this);
   }
   function size()
   {
      super.size();
      this._bInvalidateScrollBar = true;
      this.arrange();
      if(this.initialized)
      {
         this.setVPosition(this._nScrollPosition,true);
      }
   }
   function draw()
   {
      if(this.styleName == "none")
      {
         return undefined;
      }
      var _loc2_ = this.getStyle();
      for(var k in this._mcContent)
      {
         this._mcContent[k].styleName = this.styleName;
      }
      this._sbVertical.styleName = _loc2_.scrollbarstyle;
   }
   function arrange()
   {
      if(this._bInvalidateScrollBar)
      {
         this.setScrollBarProperties(false);
      }
      if(this._sbVertical._visible)
      {
         this._sbVertical.setSize(this.__height);
         this._sbVertical._x = this.__width - this._sbVertical.width;
         this._sbVertical._y = 0;
      }
      this._nMaskWidth = !this._sbVertical._visible?this.__width:this.__width - this._sbVertical.width;
      this._mcMask._width = this._nMaskWidth;
      this._mcMask._height = this.__height;
      this._bInvalidateLayout = true;
      this.layoutContent();
   }
   function layoutContent()
   {
      var _loc2_ = Math.ceil(this.__height / this._nRowHeight);
      var _loc3_ = 0;
      while(_loc3_ < _loc2_)
      {
         var _loc4_ = this._mcContent["row" + _loc3_];
         if(_loc4_ == undefined)
         {
            _loc4_ = (ank.gapi.controls.list.SelectableRow)this._mcContent.attachMovie("SelectableRow","row" + _loc3_,_loc3_,{_x:0,_y:_loc3_ * this._nRowHeight,index:_loc3_,styleName:this.styleName,enabled:this._bEnabled,gapi:this.gapi});
            _loc4_.setCellRenderer(this._sCellRenderer);
            _loc4_.addEventListener("itemSelected",this);
            _loc4_.addEventListener("itemdblClick",this);
            _loc4_.addEventListener("itemRollOver",this);
            _loc4_.addEventListener("itemRollOut",this);
            _loc4_.addEventListener("itemDrag",this);
            _loc4_.addEventListener("itemDrop",this);
         }
         var _loc5_ = _loc3_ + this._nScrollPosition;
         if(this._bInvalidateLayout)
         {
            _loc4_.setSize(this._nMaskWidth,this._nRowHeight);
         }
         var _loc6_ = this._aRows[_loc5_];
         var _loc7_ = _loc6_.item;
         var _loc8_ = typeof _loc7_ != "string"?_loc7_.label:_loc7_;
         var _loc9_ = !((_loc6_.selected || _loc5_ == this._nSelectedIndex) && _loc7_ != undefined)?"normal":"selected";
         _loc4_.setValue(_loc8_,_loc7_,_loc9_);
         _loc4_.itemIndex = _loc5_;
         _loc3_ = _loc3_ + 1;
      }
      this._bInvalidateLayout = false;
   }
   function addScrollBar(bArrange)
   {
      if(!this._sbVertical._visible)
      {
         this._sbVertical._visible = true;
         if(bArrange)
         {
            this.arrange();
         }
      }
   }
   function removeScrollBar(bArrange)
   {
      if(this._sbVertical._visible)
      {
         this._sbVertical._visible = false;
         if(bArrange)
         {
            this.arrange();
         }
      }
   }
   function setScrollBarProperties(bArrange)
   {
      this._bInvalidateScrollBar = false;
      var _loc3_ = Math.floor(this.__height / this._nRowHeight);
      var _loc4_ = this._aRows.length - _loc3_;
      var _loc5_ = _loc3_ * (_loc4_ / this._aRows.length);
      if(_loc3_ >= this._aRows.length || this._aRows.length == 0)
      {
         this.removeScrollBar(bArrange);
      }
      else
      {
         this.addScrollBar(bArrange);
         this._sbVertical.setScrollProperties(_loc5_,0,_loc4_);
         this._sbVertical.scrollPosition = this._nScrollPosition;
      }
   }
   function layoutSelection(nIndex, srRow)
   {
      if(nIndex == undefined)
      {
         nIndex = this._nSelectedIndex;
      }
      var _loc4_ = this._aRows[nIndex];
      var _loc5_ = this._aRows[nIndex].selected;
      if(!this._bMultipleSelection)
      {
         var _loc6_ = this._aRows.length;
         while((_loc6_ = _loc6_ - 1) >= 0)
         {
            if(this._aRows[_loc6_].selected)
            {
               this._aRows[_loc6_].selected = false;
               this._mcContent["row" + (_loc6_ - this._nScrollPosition)].setState("normal");
            }
         }
      }
      if(_loc5_ && this._bMultipleSelection)
      {
         _loc4_.selected = false;
         srRow.setState("normal");
      }
      else
      {
         _loc4_.selected = true;
         srRow.setState("selected");
      }
   }
   function modelChanged()
   {
      this.selectedIndex = -1;
      this._aRows = new Array();
      var _loc2_ = this._eaDataProvider.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc2_)
      {
         this._aRows[_loc3_] = {item:this._eaDataProvider[_loc3_],selected:false};
         _loc3_ = _loc3_ + 1;
      }
      if(this._bAutoScroll)
      {
         this.setVPosition(_loc2_,true);
      }
      else
      {
         this.setScrollBarProperties(true);
         this.layoutContent();
      }
   }
   function scroll(oEvent)
   {
      this.setVPosition(oEvent.target.scrollPosition);
   }
   function itemSelected(oEvent)
   {
      var _loc3_ = oEvent.target.itemIndex;
      var _loc4_ = oEvent.target;
      this._nSelectedIndex = _loc3_;
      this.layoutSelection(_loc3_,_loc4_);
      this.dispatchEvent({type:"itemSelected",row:oEvent.target});
   }
   function itemdblClick(oEvent)
   {
      var _loc3_ = oEvent.target.itemIndex;
      var _loc4_ = oEvent.target;
      this._nSelectedIndex = _loc3_;
      this.layoutSelection(_loc3_,_loc4_);
      this.dispatchEvent({type:"itemdblClick",row:oEvent.target});
   }
   function itemRollOver(oEvent)
   {
      this.dispatchEvent({type:"itemRollOver",row:oEvent.target});
   }
   function itemRollOut(oEvent)
   {
      this.dispatchEvent({type:"itemRollOut",row:oEvent.target});
   }
   function itemDrag(oEvent)
   {
      this.dispatchEvent({type:"itemDrag",row:oEvent.target});
   }
   function itemDrop(oEvent)
   {
      this.dispatchEvent({type:"itemDrop",row:oEvent.target});
   }
   function onMouseWheel(nDelta, mc)
   {
      if(String(mc._target).indexOf(this._target) != -1)
      {
         this.setVPosition(this._nScrollPosition - nDelta);
      }
   }
}
