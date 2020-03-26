class ank.utils.SWFLoader extends MovieClip
{
   function SWFLoader()
   {
      super();
      AsBroadcaster.initialize(this);
      this.initialize(0);
   }
   function initialize(frame, args)
   {
      this.clear();
      this._frameStart = frame;
      this._aArgs = args;
   }
   function clear()
   {
      this.createEmptyMovieClip("swf_mc",10);
   }
   function remove()
   {
      this.swf_mc.__proto__ = MovieClip.prototype;
      this.swf_mc.removeMovieClip();
   }
   function loadSWF(file, frame, args)
   {
      this.initialize(frame,args);
      var _loc5_ = new MovieClipLoader();
      _loc5_.addListener(this);
      _loc5_.loadClip(file,this.swf_mc);
   }
   function onLoadComplete(mc)
   {
      this.broadcastMessage("onLoadComplete",mc,this._aArgs);
   }
   function onLoadInit(mc)
   {
      if(this._frameStart != undefined)
      {
         mc.gotoAndStop(this._frameStart);
      }
      this.broadcastMessage("onLoadInit",mc,this._aArgs);
   }
}
