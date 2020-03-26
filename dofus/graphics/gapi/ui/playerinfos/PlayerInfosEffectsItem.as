class dofus.graphics.gapi.ui.playerinfos.PlayerInfosEffectsItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   function PlayerInfosEffectsItem()
   {
      super();
      this.api = _global.API;
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._ldrIcon.forceNextLoad();
         this._ldrIcon.contentPath = dofus.Constants.EFFECTSICON_FILE;
         this._lblDescription.text = oItem.description;
         this._lblRemainingTurn.text = oItem.remainingTurnStr;
         this._lblSpell.text = oItem.spellName;
         var ref = this;
         this._mcInteractivity.onRollOver = function()
         {
            ref.over({target:this});
         };
         this._mcInteractivity.onRollOut = function()
         {
            ref.out({target:this});
         };
         this._oItem = oItem;
      }
      else if(this._lblSpell.text != undefined)
      {
         this._ldrIcon.contentPath = "";
         this._lblDescription.text = "";
         this._lblRemainingTurn.text = "";
         this._lblSpell.text = "";
         delete this._mcInteractivity.onRollOver;
         delete this._mcInteractivity.onRollOut;
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
      this._ldrIcon.addEventListener("initialization",this);
   }
   function initialization(oEvent)
   {
      var _loc3_ = this._ldrIcon.content.attachMovie("Icon_" + this._oItem.characteristic,"_mcIcon",10,{operator:this._oItem.operator});
      _loc3_.__proto__ = dofus.graphics.battlefield.EffectIcon.prototype;
      var _loc4_ = (dofus.graphics.battlefield.EffectIcon)_loc3_;
      _loc4_.initialize(this._oItem.operator,1);
   }
   function over(event)
   {
      if((var _loc0_ = event.target) === this._mcInteractivity)
      {
         if(this._oItem.spellDescription.length > 0)
         {
            this.api.ui.showTooltip(this._oItem.spellDescription,_root._xmouse,_root._ymouse - 30);
         }
      }
   }
   function out(event)
   {
      this.api.ui.hideTooltip();
   }
}
