class ank.utils.QueueEmbedMovieClip extends MovieClip
{
   static var _aQueue = new Array();
   static var _mcEnterFrame = _level0.createEmptyMovieClip("_mcQueueEnterFrame",_level0.getNextHighestDepth());
   function QueueEmbedMovieClip()
   {
      super();
   }
   function addToQueue(oCall)
   {
      ank.utils.QueueEmbedMovieClip._aQueue.push(oCall);
      if(ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame == undefined)
      {
         ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame = this.runQueue;
      }
   }
   function runQueue()
   {
      for(var k in ank.utils.QueueEmbedMovieClip._aQueue)
      {
         var _loc2_ = ank.utils.QueueEmbedMovieClip._aQueue.shift();
         _loc2_.method.apply(_loc2_.object,_loc2_.params);
         if(ank.utils.QueueEmbedMovieClip._aQueue.length == 0)
         {
            delete ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame;
         }
      }
   }
}
