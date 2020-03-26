class ank.gapi.controls.ContainerGrid extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "ContainerGrid";
   var _nVisibleRowCount = 3;
   var _nVisibleColumnCount = 3;
   var _nRowCount = 1;
   var _bInvalidateLayout = false;
   var _bScrollBar = true;
   var _bSelectable = true;
   var _nScrollPosition = 0;
   var _nStyleMargin = 0;
   function ContainerGrid()
   {
      super();
   }
   function __set__selectable(bSelectable)
   {
      this._bSelectable = bSelectable;
      return this.__get__selectable();
   }
   function __get__selectable()
   {
      return this._bSelectable;
   }
   function __set__visibleRowCount(nVisibleRowCount)
   {
      this._nVisibleRowCount = nVisibleRowCount;
      return this.__get__visibleRowCount();
   }
   function __get__visibleRowCount()
   {
      return this._nVisibleRowCount;
   }
   function __set__visibleColumnCount(nVisibleColumnCount)
   {
      this._nVisibleColumnCount = nVisibleColumnCount;
      return this.__get__visibleColumnCount();
   }
   function __get__visibleColumnCount()
   {
      return this._nVisibleColumnCount;
   }
   function __set__dataProvider(eaDataProvider)
   {
      this._eaDataProvider = eaDataProvider;
      this._eaDataProvider.addEventListener("modelChanged",this);
      this.modelChanged();
      var _loc3_ = this.getMaxRow();
      if(this._nScrollPosition > _loc3_)
      {
         this.setVPosition(_loc3_);
      }
      return this.__get__dataProvider();
   }
   function __get__dataProvider()
   {
      return this._eaDataProvider;
   }
   function __set__selectedIndex(nSelectedIndex)
   {
      this.setSelectedItem(nSelectedIndex);
      return this.__get__selectedIndex();
   }
   function __get__selectedIndex()
   {
      return this._nSelectedIndex;
   }
   function __get__selectedItem()
   {
      return this._mcScrollContent["c" + this._nSelectedIndex];
   }
   function __set__scrollBar(bScrollBar)
   {
      this._bScrollBar = bScrollBar;
      return this.__get__scrollBar();
   }
   function __get__scrollBar()
   {
      return this._bScrollBar;
   }
   function setVPosition(nPosition)
   {
      var _loc3_ = this.getMaxRow();
      if(nPosition > _loc3_)
      {
         nPosition = _loc3_;
      }
      if(nPosition < 0)
      {
         nPosition = 0;
      }
      if(this._nScrollPosition != nPosition)
      {
         this._nScrollPosition = nPosition;
         this.setScrollBarProperties();
         var _loc4_ = this.__height / this._nVisibleRowCount;
         this.layoutContent();
      }
   }
   function getContainer(nIndex)
   {
      return (ank.gapi.controls.Container)this._mcScrollContent["c" + nIndex];
   }
   function init()
   {
      super.init(false,ank.gapi.controls.ContainerGrid.CLASS_NAME);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("_mcScrollContent",10);
      this.createEmptyMovieClip("_mcMask",20);
      this.drawRoundRect(this._mcMask,0,0,1,1,0,0);
      this._mcScrollContent.setMask(this._mcMask);
      if(this._bScrollBar)
      {
         this.attachMovie("ScrollBar","_sbVertical",30);
         this._sbVertical.addEventListener("scroll",this);
      }
      ank.utils.MouseEvents.addListener(this);
   }
   function size()
   {
      super.size();
      this.arrange();
   }
   function arrange()
   {
      if(this._bScrollBar)
      {
         this._sbVertical.setSize(this.__height);
         this._sbVertical.move(this.__width - this._sbVertical.width,0);
      }
      this._mcMask._width = this.__width - (!this._bScrollBar?0:this._sbVertical.width);
      this._mcMask._height = this.__height;
      this.setScrollBarProperties();
      this._bInvalidateLayout = this._bInitialized;
      this.layoutContent();
   }
   function layoutContent()
   {
      var _loc2_ = (this.__width - (!this._bScrollBar?0:this._sbVertical.width)) / this._nVisibleColumnCount;
      var _loc3_ = this.__height / this._nVisibleRowCount;
      var _loc4_ = 0;
      if(!this._bInvalidateLayout)
      {
         var _loc5_ = 0;
         while(_loc5_ < this._nVisibleRowCount)
         {
            var _loc6_ = 0;
            while(_loc6_ < this._nVisibleColumnCount)
            {
               var _loc7_ = this._mcScrollContent["c" + _loc4_];
               if(_loc7_ == undefined)
               {
                  _loc7_ = (ank.gapi.controls.Container)this._mcScrollContent.attachMovie("Container","c" + _loc4_,_loc4_,{margin:this._nStyleMargin});
                  _loc7_.addEventListener("drag",this);
                  _loc7_.addEventListener("drop",this);
                  _loc7_.addEventListener("over",this);
                  _loc7_.addEventListener("out",this);
                  _loc7_.addEventListener("click",this);
                  _loc7_.addEventListener("dblClick",this);
               }
               _loc7_._x = _loc2_ * _loc6_;
               _loc7_._y = _loc3_ * _loc5_;
               _loc7_.setSize(_loc2_,_loc3_);
               _loc4_ = _loc4_ + 1;
               _loc6_ = _loc6_ + 1;
            }
            _loc5_ = _loc5_ + 1;
         }
      }
      var _loc8_ = 0;
      _loc4_ = this._nScrollPosition * this._nVisibleColumnCount;
      var _loc9_ = 0;
      while(_loc9_ < this._nVisibleRowCount)
      {
         var _loc10_ = 0;
         while(_loc10_ < this._nVisibleColumnCount)
         {
            var _loc11_ = this._mcScrollContent["c" + _loc8_];
            _loc11_.showLabel = this._eaDataProvider[_loc4_].label != undefined && this._eaDataProvider[_loc4_].label > 0;
            _loc11_.contentData = this._eaDataProvider[_loc4_];
            _loc11_.id = _loc4_;
            if(_loc4_ == this._nSelectedIndex)
            {
               _loc11_.selected = true;
            }
            else
            {
               _loc11_.selected = false;
            }
            _loc11_.enabled = this._bEnabled;
            _loc4_ = _loc4_ + 1;
            _loc8_ = _loc8_ + 1;
            _loc10_ = _loc10_ + 1;
         }
         _loc9_ = _loc9_ + 1;
      }
      if(this._bInvalidateLayout)
      {
      }
      this._bInvalidateLayout = false;
   }
   function draw()
   {
      this._bInvalidateLayout = !this._bInitialized;
      this.layoutContent();
      var _loc2_ = this.getStyle();
      var _loc3_ = _loc2_.containerbackground;
      var _loc4_ = _loc2_.containerborder;
      var _loc5_ = _loc2_.containerhighlight;
      this._nStyleMargin = _loc2_.containermargin;
      for(var k in this._mcScrollContent)
      {
         var _loc6_ = this._mcScrollContent[k];
         _loc6_.backgroundRenderer = _loc3_;
         _loc6_.borderRenderer = _loc4_;
         _loc6_.highlightRenderer = _loc5_;
         _loc6_.margin = this._nStyleMargin;
         _loc6_.styleName = _loc2_.containerstyle;
      }
      if(this._bScrollBar)
      {
         this._sbVertical.styleName = _loc2_.scrollbarstyle;
      }
   }
   function setEnabled()
   {
      for(var k in this._mcScrollContent)
      {
         this._mcScrollContent[k].enabled = this._bEnabled;
      }
      this.addToQueue({object:this,method:function()
      {
         this._sbVertical.enabled = this._bEnabled;
      }});
   }
   function getMaxRow()
   {
      return Math.ceil(this._eaDataProvider.length / this._nVisibleColumnCount) - this._nVisibleRowCount;
   }
   function setScrollBarProperties()
   {
      var _loc2_ = this._nRowCount - this._nVisibleRowCount;
      var _loc3_ = this._nVisibleRowCount * (_loc2_ / this._nRowCount);
      this._sbVertical.setScrollProperties(_loc3_,0,_loc2_);
      this._sbVertical.scrollPosition = this._nScrollPosition;
   }
   function getItemById(nIndex)
   {
      var _loc3_ = 0;
      var _loc4_ = 0;
      var _loc5_ = 0;
      while(_loc5_ < this._nVisibleRowCount)
      {
         var _loc6_ = 0;
         while(_loc6_ < this._nVisibleColumnCount)
         {
            var _loc7_ = this._mcScrollContent["c" + _loc3_];
            if(nIndex == _loc7_.id)
            {
               return _loc7_;
            }
            _loc3_ = _loc3_ + 1;
            _loc6_ = _loc6_ + 1;
         }
         _loc5_ = _loc5_ + 1;
      }
   }
   function setSelectedItem(nIndex)
   {
      var _loc3_ = 0;
      var _loc4_ = 0;
      var _loc5_ = 0;
      while(_loc5_ < this._nVisibleRowCount)
      {
         var _loc6_ = 0;
         while(_loc6_ < this._nVisibleColumnCount)
         {
            var _loc7_ = this._mcScrollContent["c" + _loc3_];
            if(nIndex == _loc7_.id)
            {
               nIndex = _loc3_;
               _loc4_ = _loc7_.id;
            }
            _loc3_ = _loc3_ + 1;
            _loc6_ = _loc6_ + 1;
         }
         _loc5_ = _loc5_ + 1;
      }
      if(this._nSelectedIndex != _loc4_)
      {
         var _loc8_ = this.getItemById(this._nSelectedIndex);
         var _loc9_ = this._mcScrollContent["c" + nIndex];
         if(_loc9_.contentData == undefined)
         {
            return undefined;
         }
         _loc8_.selected = false;
         _loc9_.selected = true;
         this._nSelectedIndex = _loc4_;
      }
   }
   function modelChanged(oEvent)
   {
      var _loc3_ = this._nRowCount;
      this._nRowCount = Math.ceil(this._eaDataProvider.length / this._nVisibleColumnCount);
      this._bInvalidateLayout = true;
      this.layoutContent();
      this.draw();
      this.setScrollBarProperties();
   }
   function scroll(oEvent)
   {
      this.setVPosition(oEvent.target.scrollPosition);
   }
   function drag(oEvent)
   {
      this.dispatchEvent({type:"dragItem",target:oEvent.target});
   }
   function drop(oEvent)
   {
      this.dispatchEvent({type:"dropItem",target:oEvent.target});
   }
   function over(oEvent)
   {
      this.dispatchEvent({type:"overItem",target:oEvent.target});
   }
   function out(oEvent)
   {
      this.dispatchEvent({type:"outItem",target:oEvent.target});
   }
   function click(oEvent)
   {
      if(this._bSelectable)
      {
         this.setSelectedItem(oEvent.target.id);
      }
      this.dispatchEvent({type:"selectItem",target:oEvent.target,owner:this});
   }
   function dblClick(oEvent)
   {
      this.dispatchEvent({type:"dblClickItem",target:oEvent.target,owner:this});
   }
   function onMouseWheel(nDelta, mc)
   {
      if(String(mc._target).indexOf(this._target) != -1)
      {
         this._sbVertical.scrollPosition = this._sbVertical.scrollPosition - (nDelta <= 0?-1:1);
      }
   }
}
