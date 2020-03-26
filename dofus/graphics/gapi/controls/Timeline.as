class dofus.graphics.gapi.controls.Timeline extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Timeline";
   static var ITEM_WIDTH = 34;
   static var ITEM_SUMMONED_HEIGHT_DELTA = 2;
   static var ITEM_SUMMONED_WIDTH = 28;
   static var HIDE_COLOR = 4473924;
   var _currentDisplayIndex = 0;
   var _itemsList = new Array();
   var _previousCharacList = new Array();
   var _depth = 0;
   var _bOpened = true;
   function Timeline()
   {
      super();
   }
   function __set__opened(bOpened)
   {
      this._bOpened = bOpened;
      this.layout_mc._visible = bOpened;
      return this.__get__opened();
   }
   function __get__opened()
   {
      return this._bOpened;
   }
   function update()
   {
      this.generate();
   }
   function nextTurn(id, bWithoutTween)
   {
      if(bWithoutTween = undefined)
      {
         bWithoutTween = false;
      }
      var _loc4_ = this.layout_mc.items_mc["item" + id];
      if(_loc4_ == undefined)
      {
         return undefined;
      }
      this.layout_mc.pointer_mc._visible = true;
      this.stopChrono();
      this._vcChrono = _loc4_.chrono;
      if(bWithoutTween)
      {
         this.layout_mc.pointer_mc.move(_loc4_._x,0);
         this.layout_mc.pointer_mc._xscale = _loc4_._xscale;
         this.layout_mc.pointer_mc._yscale = _loc4_._yscale;
      }
      else
      {
         this.layout_mc.pointer_mc.moveTween(_loc4_._x,_loc4_._xscale);
      }
      this.layout_mc.pointer_mc._y = !_loc4_._oData.isSummoned?0:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_HEIGHT_DELTA;
      this._currentDisplayIndex = id;
   }
   function hideItem(id)
   {
      var _loc3_ = this.layout_mc.items_mc["item" + id];
      var _loc4_ = new Color(_loc3_.sprite);
      _loc4_.setRGB(dofus.graphics.gapi.controls.Timeline.HIDE_COLOR);
   }
   function showItem(id)
   {
      var _loc3_ = this.layout_mc.items_mc["item" + id];
      var _loc4_ = new Color(_loc3_.sprite);
      _loc4_.setTransform({ra:100,ga:100,ba:100,rb:0,gb:0,bb:0});
   }
   function startChrono(nDuration)
   {
      this._vcChrono.startTimer(nDuration);
   }
   function stopChrono()
   {
      this._vcChrono.stopTimer();
   }
   function updateCharacters()
   {
      var _loc2_ = this.api.datacenter;
      var _loc3_ = new Array();
      var _loc4_ = 0;
      while(_loc4_ < this._aTs.length)
      {
         _loc3_.push(_loc2_.Sprites.getItemAt(this._aTs[_loc4_]));
         _loc4_ = _loc4_ + 1;
      }
      var _loc5_ = _loc3_.length;
      _loc4_ = 0;
      while(_loc4_ < _loc5_)
      {
         var _loc7_ = _loc3_[_loc4_];
         var _loc6_ = _loc7_.id;
         this.layout_mc.items_mc["item" + _loc6_].data = _loc7_;
         _loc4_ = _loc4_ + 1;
      }
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.Timeline.CLASS_NAME);
   }
   function createChildren()
   {
      this.createEmptyMovieClip("layout_mc",10);
      this.layout_mc.createEmptyMovieClip("SummonedLayout",9);
      var _loc2_ = this.layout_mc.attachMovie("TimelinePointer","pointer_mc",10);
      _loc2_._visible = false;
      this.generate();
   }
   function generate(cs)
   {
      var _loc3_ = this.api.datacenter;
      if(cs == undefined)
      {
         cs = _loc3_.Game.turnSequence;
      }
      this._aTs = cs;
      var _loc4_ = new Array();
      var _loc5_ = 0;
      while(_loc5_ < cs.length)
      {
         _loc4_.push(_loc3_.Sprites.getItemAt(cs[_loc5_]));
         _loc5_ = _loc5_ + 1;
      }
      var _loc6_ = _loc4_.length;
      if(this.layout_mc.items_mc == undefined)
      {
         this.layout_mc.createEmptyMovieClip("items_mc",20);
      }
      var _loc7_ = 20;
      _loc5_ = 0;
      while(_loc5_ < _loc6_)
      {
         var _loc8_ = _loc4_[_loc5_];
         _loc7_ = _loc7_ + (!_loc8_.isSummoned?dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_WIDTH);
         _loc5_ = _loc5_ + 1;
      }
      for(var k in this._previousCharacList)
      {
         var _loc9_ = this._previousCharacList[k].id;
         var _loc10_ = false;
         for(var kk in _loc4_)
         {
            var _loc11_ = _loc4_[kk].id;
            if(_loc9_ == _loc11_)
            {
               _loc10_ = true;
            }
         }
         if(!_loc10_)
         {
            this.layout_mc.items_mc["item" + _loc9_].removeMovieClip();
         }
      }
      var _loc13_ = - _loc7_;
      _loc5_ = 0;
      while(_loc5_ < _loc6_)
      {
         var _loc16_ = _loc4_[_loc5_];
         var _loc12_ = _loc16_.id;
         var _loc17_ = this.layout_mc.items_mc["item" + _loc12_];
         if(_loc17_ == undefined)
         {
            this._depth = this._depth + 1;
            _loc17_ = this.layout_mc.items_mc.attachMovie("TimelineItem","item" + _loc12_,this._depth,{index:_loc5_,data:_loc16_,api:this.api,gapi:this.gapi});
         }
         if(_loc16_.isSummoned)
         {
            _loc17_._xscale = 80;
            _loc17_._yscale = 80;
         }
         _loc17_._x = _loc13_;
         _loc17_._y = !_loc16_.isSummoned?0:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_HEIGHT_DELTA;
         if(!_loc16_.isSummoned)
         {
            var _loc14_ = _loc17_;
            this.layout_mc.SummonedLayout["TISB" + _loc17_.index].removeMovieClip();
         }
         else
         {
            var _loc18_ = this.layout_mc.SummonedLayout["TISB" + _loc14_.index];
            if(_loc18_ == undefined)
            {
               _loc18_ = this.layout_mc.SummonedLayout.attachMovie("TimelineItemSummonedBg","TISB" + _loc14_.index,_loc14_.index);
            }
            _loc18_._x = _loc14_._x;
            _loc18_._mcBody._width = _loc17_._x - _loc14_._x + _loc17_._width + 1;
            _loc18_._mcEnd._x = _loc18_._mcBody._width;
         }
         _loc13_ = _loc13_ + (!_loc16_.isSummoned?dofus.graphics.gapi.controls.Timeline.ITEM_WIDTH:dofus.graphics.gapi.controls.Timeline.ITEM_SUMMONED_WIDTH);
         var _loc15_ = _loc17_;
         _loc5_ = _loc5_ + 1;
      }
      this.nextTurn(this._currentDisplayIndex,true);
      this._previousCharacList = _loc4_;
   }
}
