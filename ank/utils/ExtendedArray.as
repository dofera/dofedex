class ank.utils.ExtendedArray extends Array
{
   function ExtendedArray()
   {
      super();
      this.initialize();
   }
   function removeEventListener()
   {
   }
   function addEventListener()
   {
   }
   function dispatchEvent()
   {
   }
   function dispatchQueue()
   {
   }
   function initialize(Void)
   {
      mx.events.EventDispatcher.initialize(this);
   }
   function createFromArray(aData)
   {
      this.splice(0,this.length);
      var _loc3_ = 0;
      while(_loc3_ < aData.length)
      {
         this.push(aData[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
   }
   function removeAll(Void)
   {
      this.splice(0,this.length);
      this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
   }
   function push(value)
   {
      var _loc4_ = super.push(value);
      this.dispatchEvent({type:"modelChanged",eventName:"addItem"});
      return _loc4_;
   }
   function pop()
   {
      var _loc3_ = super.pop();
      this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
      return _loc3_;
   }
   function shift()
   {
      var _loc3_ = super.shift();
      this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
      return _loc3_;
   }
   function unshift(value)
   {
      var _loc4_ = super.unshift(value);
      this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
      return _loc4_;
   }
   function reverse()
   {
      super.reverse();
      this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
   }
   function replaceAll(nStart, aNew)
   {
      var _loc4_ = [nStart,0];
      for(var k in aNew)
      {
         _loc4_.push(aNew[k]);
      }
      this.splice.apply(this,_loc4_);
      this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
   }
   function removeItems(nIndex, deleteCount)
   {
      this.splice(nIndex,deleteCount);
      this.dispatchEvent({type:"modelChanged",eventName:"updateAll"});
   }
   function updateItem(nIndex, newValue)
   {
      this.splice(nIndex,1,newValue);
      this.dispatchEvent({type:"modelChanged",eventName:"updateOne",updateIndex:nIndex});
   }
   function findFirstItem(sPropName, propValue)
   {
      var _loc4_ = 0;
      while(_loc4_ < this.length)
      {
         var _loc5_ = this[_loc4_];
         if(_loc5_[sPropName] == propValue)
         {
            return {index:_loc4_,item:_loc5_};
         }
         _loc4_ = _loc4_ + 1;
      }
      return {index:-1};
   }
   function clone()
   {
      var _loc2_ = new ank.utils.ExtendedArray();
      var _loc3_ = 0;
      while(_loc3_ < this.length)
      {
         _loc2_.push(this[_loc3_].clone());
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
   function shuffle()
   {
      var _loc2_ = this.clone();
      var _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         var _loc4_ = _loc2_[_loc3_];
         var _loc5_ = random(_loc2_.length);
         _loc2_[_loc3_] = _loc2_[_loc5_];
         _loc2_[_loc5_] = _loc4_;
         _loc3_ = _loc3_ + 1;
      }
      return _loc2_;
   }
   function bubbleSortOn(prop, flags)
   {
      if((flags & Array.ASCENDING) == 0 && (flags & Array.DESCENDING) == 0)
      {
         flags = flags | Array.ASCENDING;
      }
      while(true)
      {
         var _loc4_ = false;
         var _loc5_ = 1;
         while(_loc5_ < this.length)
         {
            if((flags & Array.ASCENDING) > 0 && this[_loc5_ - 1][prop] > this[_loc5_][prop] || (flags & Array.DESCENDING) > 0 && this[_loc5_ - 1][prop] < this[_loc5_][prop])
            {
               var _loc6_ = this[_loc5_ - 1];
               this[_loc5_ - 1] = this[_loc5_];
               this[_loc5_] = _loc6_;
               _loc4_ = true;
            }
            _loc5_ = _loc5_ + 1;
         }
         if(_loc4_)
         {
            continue;
         }
         break;
      }
   }
   function concat(oArray)
   {
      var _loc4_ = super.concat(oArray);
      var _loc5_ = new ank.utils.ExtendedArray();
      _loc5_.createFromArray(_loc4_);
      return _loc5_;
   }
}
