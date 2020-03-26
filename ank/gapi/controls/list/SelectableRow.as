class ank.gapi.controls.list.SelectableRow extends ank.gapi.core.UIBasicComponent
{
   var _bDblClickEnabled = false;
   function SelectableRow()
   {
      super();
   }
   function __set__itemIndex(nItemIndex)
   {
      this._nItemIndex = nItemIndex;
      return this.__get__itemIndex();
   }
   function __get__itemIndex()
   {
      return this._nItemIndex;
   }
   function __get__item()
   {
      return this._oItem;
   }
   function __set__index(nIndex)
   {
      this._nIndex = nIndex;
      return this.__get__index();
   }
   function __get__index()
   {
      return this._nIndex;
   }
   function setCellRenderer(link)
   {
      this.cellRenderer_mc.removeMovieClip();
      this.attachMovie(link,"cellRenderer_mc",100,{styleName:this.getStyle().cellrendererstyle,list:this._parent._parent,row:this});
   }
   function setState(sState)
   {
      this.cellRenderer_mc.setState(sState);
      switch(sState)
      {
         case "selected":
            this.selected_mc._visible = true;
            break;
         case "normal":
            this.selected_mc._visible = false;
      }
   }
   function setValue(sSuggested, oItem, sState)
   {
      this._bUsed = oItem != undefined;
      this._oItem = oItem;
      this.cellRenderer_mc.setValue(this._bUsed,sSuggested,oItem);
      this.setState(sState);
   }
   function select()
   {
      this.bg_mc.onRelease();
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("selected_mc",-10);
      this.createEmptyMovieClip("over_mc",-20);
      this.createEmptyMovieClip("bg_mc",-30);
      this.bg_mc.trackAsMenu = true;
      this.over_mc._visible = false;
      this.selected_mc._visible = false;
      this.bg_mc.useHandCursor = false;
      this.bg_mc.onRollOver = function()
      {
         if(this._parent._bUsed && this._parent._bEnabled)
         {
            this._parent.over_mc._visible = true;
            this._parent.dispatchEvent({type:"itemRollOver",target:this._parent});
            this._parent._sLastMouseAction = "RollOver";
         }
      };
      this.bg_mc.onRollOut = this.bg_mc.onReleaseOutside = function()
      {
         if(this._parent._bUsed && this._parent._bEnabled)
         {
            this._parent.dispatchEvent({type:"itemRollOut",target:this._parent});
            this._parent._sLastMouseAction = "RollOut";
         }
         this._parent.over_mc._visible = false;
      };
      this.bg_mc.onPress = function()
      {
         this._parent._sLastMouseAction = "Press";
      };
      this.bg_mc.onRelease = function()
      {
         if(this._parent._bUsed && this._parent._bEnabled)
         {
            if(this._parent._sLastMouseAction == "DragOver")
            {
               this._parent.dispatchEvent({type:"itemDrop"});
            }
            else if(getTimer() - this._parent._nLastClickTime < ank.gapi.Gapi.DBLCLICK_DELAY && !this._parent._bDblClickEnabled)
            {
               ank.utils.Timer.removeTimer(this._parent,"selectablerow");
               this._parent.dispatchEvent({type:"itemdblClick"});
            }
            else if(this._parent._bDblClickEnabled)
            {
               ank.utils.Timer.setTimer(this._parent,"selectablerow",this._parent,this._parent.dispatchEvent,ank.gapi.Gapi.DBLCLICK_DELAY,[{type:"itemSelected"}]);
            }
            else
            {
               this._parent.dispatchEvent({type:"itemSelected"});
            }
            this._parent._sLastMouseAction = "Release";
            this._parent._nLastClickTime = getTimer();
         }
      };
      this.bg_mc.onDragOver = function()
      {
         if(this._parent._bUsed && this._parent._bEnabled)
         {
            this._parent.over_mc._visible = true;
            this._parent.dispatchEvent({type:"itemRollOver",target:this._parent});
            this._parent._sLastMouseAction = "DragOver";
         }
      };
      this.bg_mc.onDragOut = function()
      {
         if(this._parent._bUsed && this._parent._bEnabled)
         {
            if(this._parent._sLastMouseAction == "Press")
            {
               this._parent.dispatchEvent({type:"itemDrag"});
            }
            this._parent._sLastMouseAction = "DragOut";
            this._parent.dispatchEvent({type:"itemRollOut",target:this._parent});
         }
         this._parent.over_mc._visible = false;
      };
   }
   function size()
   {
      super.size();
      this.cellRenderer_mc.setSize(this.__width,this.__height);
      this.arrange();
   }
   function arrange()
   {
      this.over_mc._width = this.selected_mc._width = this.bg_mc._width = this.__width;
      this.over_mc._height = this.selected_mc._height = this.bg_mc._height = this.__height;
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      var _loc3_ = _loc2_.cellbgcolor;
      var _loc4_ = _loc2_.cellselectedcolor;
      var _loc5_ = _loc2_.cellovercolor;
      this.over_mc.clear();
      this.selected_mc.clear();
      this.bg_mc.clear();
      this.drawRoundRect(this.over_mc,0,0,1,1,0,_loc5_,_loc5_ != -1?100:0);
      this.drawRoundRect(this.selected_mc,0,0,1,1,0,_loc4_,_loc4_ != -1?100:0);
      this.drawRoundRect(this.bg_mc,0,0,1,1,0,typeof _loc3_ != "object"?Number(_loc3_):Number(_loc3_[this._nIndex % _loc3_.length]),_loc3_ != -1?100:0);
      this.cellRenderer_mc.styleName = _loc2_.cellrendererstyle;
   }
}
