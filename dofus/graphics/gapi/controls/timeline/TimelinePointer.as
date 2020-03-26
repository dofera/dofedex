class dofus.graphics.gapi.controls.timeline.TimelinePointer extends ank.gapi.core.UIBasicComponent
{
   static var CLASS_NAME = "Timeline";
   function TimelinePointer()
   {
      super();
   }
   function moveTween(destX, destScale)
   {
      var nDir = destX <= this._x?-1:1;
      var i = 0;
      this._destX = destX;
      this.onEnterFrame = function()
      {
         i++;
         this._x = this._x + i * i * nDir;
         this._xscale = this._xscale + (destScale - this._xscale) / 2;
         this._yscale = this._yscale + (destScale - this._yscale) / 2;
         if(this._x * nDir > this._destX * nDir)
         {
            this._x = this._destX;
            this._xscale = destScale;
            this._yscale = destScale;
            delete this.onEnterFrame;
         }
      };
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.timeline.TimelinePointer.CLASS_NAME);
   }
}
