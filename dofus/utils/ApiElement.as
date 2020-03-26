class dofus.utils.ApiElement extends Object
{
   static var _aQueue = new Array();
   function ApiElement()
   {
      super();
   }
   function __get__api()
   {
      return _global.API;
   }
   function __set__api(oApi)
   {
      this._oAPI = oApi;
      return this.__get__api();
   }
   function initialize(oAPI)
   {
      this._oAPI = oAPI;
   }
   function addToQueue(oCall)
   {
      dofus.utils.ApiElement._aQueue.push(oCall);
      if(_root.onEnterFrame == undefined)
      {
         _root.onEnterFrame = this.runQueue;
      }
   }
   function runQueue()
   {
      var _loc2_ = dofus.utils.ApiElement._aQueue.shift();
      _loc2_.method.apply(_loc2_.object,_loc2_.params);
      if(dofus.utils.ApiElement._aQueue.length == 0)
      {
         delete _root.onEnterFrame;
      }
   }
}
