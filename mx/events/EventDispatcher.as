class mx.events.EventDispatcher
{
   static var _fEventDispatcher = undefined;
   function EventDispatcher()
   {
   }
   static function _removeEventListener(queue, event, handler)
   {
      if(queue != undefined)
      {
         var _loc5_ = queue.length;
         var _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            var _loc7_ = queue[_loc6_];
            if(_loc7_ == handler)
            {
               queue.splice(_loc6_,1);
               return undefined;
            }
            _loc6_ = _loc6_ + 1;
         }
      }
   }
   static function initialize(object)
   {
      if(mx.events.EventDispatcher._fEventDispatcher == undefined)
      {
         mx.events.EventDispatcher._fEventDispatcher = new mx.events.EventDispatcher();
      }
      object.__proto__.addEventListener = mx.events.EventDispatcher._fEventDispatcher.addEventListener;
      object.__proto__.removeEventListener = mx.events.EventDispatcher._fEventDispatcher.removeEventListener;
      object.__proto__.dispatchEvent = mx.events.EventDispatcher._fEventDispatcher.dispatchEvent;
      object.__proto__.dispatchQueue = mx.events.EventDispatcher._fEventDispatcher.dispatchQueue;
   }
   function dispatchQueue(queueObj, eventObj)
   {
      var _loc4_ = "__q_" + eventObj.type;
      var _loc5_ = queueObj[_loc4_];
      if(_loc5_ != undefined)
      {
         for(var _loc6_ in _loc5_)
         {
            var _loc7_ = _loc5_[_loc6_];
            var _loc8_ = typeof _loc7_;
            if(_loc8_ == "object" || _loc8_ == "movieclip")
            {
               if(_loc7_.handleEvent == undefined)
               {
                  _loc7_[eventObj.type](eventObj);
               }
               else
               {
                  _loc7_.handleEvent(eventObj);
               }
            }
            else
            {
               _loc7_.apply(queueObj,[eventObj]);
            }
         }
      }
   }
   function dispatchEvent(eventObj)
   {
      if(eventObj.target == undefined)
      {
         eventObj.target = this;
      }
      this[eventObj.type + "Handler"](eventObj);
      this.dispatchQueue(this,eventObj);
   }
   function addEventListener(event, handler)
   {
      var _loc4_ = "__q_" + event;
      if(this[_loc4_] == undefined)
      {
         this[_loc4_] = new Array();
      }
      _global.ASSetPropFlags(this,_loc4_,1);
      mx.events.EventDispatcher._removeEventListener(this[_loc4_],event,handler);
      this[_loc4_].push(handler);
   }
   function removeEventListener(event, handler)
   {
      var _loc4_ = "__q_" + event;
      mx.events.EventDispatcher._removeEventListener(this[_loc4_],event,handler);
   }
}
