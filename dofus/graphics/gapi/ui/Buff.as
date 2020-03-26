class dofus.graphics.gapi.ui.Buff extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Buff";
   static var LAST_CONTAINER = 27;
   function Buff()
   {
      super();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Buff.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.updateData});
   }
   function addListeners()
   {
      var _loc2_ = 20;
      while(_loc2_ <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
      {
         var _loc3_ = this["_ctr" + _loc2_];
         _loc3_.addEventListener("click",this);
         _loc3_.addEventListener("over",this);
         _loc3_.addEventListener("out",this);
         _loc2_ = _loc2_ + 1;
      }
      this.api.datacenter.Player.Inventory.addEventListener("modelChanged",this);
   }
   function updateData()
   {
      var _loc2_ = new Array();
      var _loc3_ = 20;
      while(_loc3_ <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
      {
         _loc2_[_loc3_] = true;
         _loc3_ = _loc3_ + 1;
      }
      var _loc4_ = this.api.datacenter.Player.Inventory;
      for(var k in _loc4_)
      {
         var _loc5_ = _loc4_[k];
         if(!_global.isNaN(_loc5_.position))
         {
            var _loc6_ = _loc5_.position;
            if(_loc6_ < 20 || _loc6_ > dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
            {
               continue;
            }
            var _loc7_ = this["_ctr" + _loc6_];
            _loc7_.contentData = _loc5_;
            _loc7_.enabled = true;
            _loc2_[_loc6_] = false;
         }
      }
      var _loc8_ = 20;
      while(_loc8_ <= dofus.graphics.gapi.ui.Buff.LAST_CONTAINER)
      {
         if(_loc2_[_loc8_])
         {
            var _loc9_ = this["_ctr" + _loc8_];
            _loc9_.contentData = undefined;
            _loc9_.enabled = false;
         }
         _loc8_ = _loc8_ + 1;
      }
   }
   function modelChanged(oEvent)
   {
      switch(oEvent.eventName)
      {
         case "updateOne":
         case "updateAll":
      }
      this.updateData();
   }
   function click(oEvent)
   {
      this.gapi.loadUIComponent("BuffInfos","BuffInfos",{data:oEvent.target.contentData},{bStayIfPresent:true});
   }
   function over(oEvent)
   {
      var _loc3_ = oEvent.target.contentData;
      if(_loc3_ != undefined)
      {
         this.gapi.showTooltip(_loc3_.name + "\n" + _loc3_.visibleEffects,oEvent.target,30);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
