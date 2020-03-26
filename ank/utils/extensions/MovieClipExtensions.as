class ank.utils.extensions.MovieClipExtensions extends MovieClip
{
   function MovieClipExtensions()
   {
      super();
   }
   function attachClassMovie(className, instanceName, depth, argv)
   {
      var _loc6_ = this.createEmptyMovieClip(instanceName,depth);
      _loc6_.__proto__ = className.prototype;
      className.apply(_loc6_,argv);
      return _loc6_;
   }
   function alignOnPixel()
   {
      var _loc2_ = new Object({x:0,y:0});
      this.localToGlobal(_loc2_);
      _loc2_.x = Math.floor(_loc2_.x);
      _loc2_.y = Math.floor(_loc2_.y);
      this.globalToLocal(_loc2_);
      this._x = this._x - _loc2_.x;
      this._y = this._y - _loc2_.y;
   }
   function playFirstChildren()
   {
      for(var a in this)
      {
         if(this[a].__proto__ == MovieClip.prototype)
         {
            this[a].gotoAndPlay(1);
         }
      }
   }
   function end(seq)
   {
      var _loc3_ = this.getFirstParentProperty("_ACTION");
      if(seq == undefined)
      {
         seq = _loc3_.sequencer;
      }
      seq.onActionEnd();
   }
   function getFirstParentProperty(prop)
   {
      var _loc3_ = 20;
      var _loc4_ = this;
      while(_loc3_ >= 0)
      {
         if(_loc4_[prop] != undefined)
         {
            return _loc4_[prop];
         }
         _loc4_ = _loc4_._parent;
         _loc3_ = _loc3_ - 1;
      }
   }
   function getActionClip(Void)
   {
      return this.getFirstParentProperty("_ACTION");
   }
   function playAll(mc)
   {
      if(mc == undefined)
      {
         mc = this;
      }
      mc.gotoAndPlay(1);
      for(var a in mc)
      {
         if(mc[a] instanceof MovieClip)
         {
            this.playAll(mc[a]);
         }
      }
   }
   function stopAll(mc)
   {
      if(mc == undefined)
      {
         mc = this;
      }
      mc.gotoAndStop(1);
      for(var a in mc)
      {
         if(mc[a] instanceof MovieClip)
         {
            this.stopAll(mc[a]);
         }
      }
   }
}
