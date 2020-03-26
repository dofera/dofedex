class dofus.graphics.gapi.controls.PlayerWeight extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "PlayerWeight";
   function PlayerWeight()
   {
      super();
   }
   function __set__styleName(sStyleName)
   {
      this._sStyleName = sStyleName;
      if(this.initialized)
      {
         this._pbWeight.styleName = sStyleName;
      }
      return this.__get__styleName();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.controls.PlayerWeight.CLASS_NAME);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
      this.addToQueue({object:this,method:this.initData});
   }
   function addListeners()
   {
      this._pbWeight.addEventListener("over",this);
      this._pbWeight.addEventListener("out",this);
      this.api.datacenter.Player.addEventListener("maxWeightChanged",this);
      this.api.datacenter.Player.addEventListener("currentWeightChanged",this);
   }
   function initData()
   {
      if(this._sStyleName != undefined)
      {
         this._pbWeight.styleName = this._sStyleName;
      }
      this.currentWeightChanged({value:this.api.datacenter.Player.currentWeight});
   }
   function currentWeightChanged(oEvent)
   {
      var _loc3_ = this.api.datacenter.Player.maxWeight;
      var _loc4_ = oEvent.value;
      this._nCurrentWeight = _loc4_;
      this._pbWeight.maximum = _loc3_;
      this._pbWeight.value = _loc4_;
   }
   function maxWeightChanged(oEvent)
   {
      this._pbWeight.maximum = oEvent.value;
   }
   function over(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._pbWeight)
      {
         var _loc3_ = oEvent.target.maximum;
         var _loc4_ = new ank.utils.ExtendedString(this._nCurrentWeight).addMiddleChar(" ",3);
         var _loc5_ = new ank.utils.ExtendedString(_loc3_).addMiddleChar(" ",3);
         this.gapi.showTooltip(this.api.lang.getText("PLAYER_WEIGHT",[_loc4_,_loc5_]),oEvent.target,-20);
      }
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
