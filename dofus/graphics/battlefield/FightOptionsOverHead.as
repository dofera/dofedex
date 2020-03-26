class dofus.graphics.battlefield.FightOptionsOverHead extends MovieClip
{
   static var ICON_WIDTH = 20;
   function FightOptionsOverHead(tTeam)
   {
      super();
      this.initialize(tTeam);
      this.draw();
   }
   function __get__height()
   {
      return 20;
   }
   function initialize(tTeam)
   {
      this._mc.removeMovieClip();
      this.createEmptyMovieClip("_mc",10);
      this._tTeam = tTeam;
   }
   function draw()
   {
      for(var a in this._mc)
      {
         this._mc[a].removeMovieClip();
      }
      var _loc2_ = 0;
      for(var a in this._tTeam.options)
      {
         var _loc3_ = this._tTeam.options[a];
         if(_loc3_ == true)
         {
            var _loc4_ = this._mc.attachMovie("UI_FightOption" + a + "Up","mcOption" + _loc2_,_loc2_);
            _loc4_._x = _loc2_ * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH;
            _loc4_.onEnterFrame = function()
            {
               this.play();
               delete this.onEnterFrame;
            };
            _loc2_ = _loc2_ + 1;
         }
      }
      this._x = (- _loc2_ * dofus.graphics.battlefield.FightOptionsOverHead.ICON_WIDTH) / 2;
   }
}
