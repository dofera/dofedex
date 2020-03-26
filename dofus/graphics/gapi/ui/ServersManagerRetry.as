class dofus.graphics.gapi.ui.ServersManagerRetry extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "ServersManagerRetry";
   var _nTimer = 0;
   function ServersManagerRetry()
   {
      super();
   }
   function __set__timer(nTimer)
   {
      this.addToQueue({object:this,method:function(n)
      {
         this._nTimer = Number(n);
         if(this.initialized)
         {
            this.updateLabel();
         }
      },params:[nTimer]});
      return this.__get__timer();
   }
   function updateLabel()
   {
      var _loc2_ = this.api.lang.getText("SERVERS_MANAGER_RETRY",[this._nTimer]);
      this._lblCounter.text = _loc2_;
      this._lblCounterShadow.text = _loc2_;
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.ServersManagerRetry.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.updateLabel});
   }
}
