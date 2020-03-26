class dofus.graphics.gapi.ui.subway.SubwayItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   function SubwayItem()
   {
      super();
      this._mcUnderAttack._visible = false;
      this._mcUnderAttackInteractivity._visible = false;
      this.api = _global.API;
   }
   function __set__list(mcList)
   {
      this._mcList = mcList;
      return this.__get__list();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._oItem = oItem;
         this._lblCost.text = oItem.cost + " k";
         this._lblCoords.text = oItem.coordinates;
         this._lblName.text = oItem.name;
         this._btnLocate._visible = true;
         if(this._oItem.attackNear)
         {
            this._mcUnderAttack._visible = true;
            this._mcUnderAttackInteractivity._visible = true;
            var ref = this;
            this._mcUnderAttackInteractivity.onRollOver = function()
            {
               ref.over({target:this});
            };
            this._mcUnderAttackInteractivity.onRollOut = function()
            {
               ref.out({target:this});
            };
         }
         else
         {
            this._mcUnderAttack._visible = false;
            this._mcUnderAttackInteractivity._visible = false;
         }
      }
      else if(this._lblCost.text != undefined)
      {
         this._lblCost.text = "";
         this._lblCoords.text = "";
         this._lblName.text = "";
         this._btnLocate._visible = false;
         this._mcUnderAttack._visible = false;
         this._mcUnderAttackInteractivity._visible = false;
      }
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnLocate.addEventListener("click",this);
   }
   function click(oEvent)
   {
      this.api.kernel.GameManager.updateCompass(this._oItem.x,this._oItem.y,true);
   }
   function over(event)
   {
      if((var _loc0_ = event.target) === this._mcUnderAttackInteractivity)
      {
         this.api.ui.showTooltip(this.api.lang.getText("CONQUEST_NEAR_PRISM_UNDER_ATTACK"),_root._xmouse,_root._ymouse);
      }
   }
   function out(event)
   {
      this.api.ui.hideTooltip();
   }
}
