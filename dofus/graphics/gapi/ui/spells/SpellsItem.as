class dofus.graphics.gapi.ui.spells.SpellsItem extends ank.gapi.core.UIBasicComponent
{
   function SpellsItem()
   {
      super();
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
         oItem.sortName = oItem.name;
         oItem.sortLevel = oItem.level;
         var _loc5_ = this._mcList._parent._parent.api;
         this._lblName.text = oItem.name;
         this._lblLevel.text = _loc5_.lang.getText("LEVEL") + " " + oItem.level;
         this._lblRange.text = (oItem.rangeMin == 0?"":oItem.rangeMin + "-") + oItem.rangeMax + " " + _loc5_.lang.getText("RANGE");
         this._lblAP.text = oItem.apCost + " " + _loc5_.lang.getText("AP");
         this._ldrIcon.contentPath = oItem.iconFile;
         var _loc6_ = this._mcList._parent._parent.canBoost(oItem) && _loc5_.datacenter.Basics.canUseSeeAllSpell;
         var _loc7_ = this._mcList._parent._parent.getCostForBoost(oItem);
         this._btnBoost.enabled = true;
         this._btnBoost._visible = _loc6_;
         this._lblBoost.text = !(_loc7_ != -1 && _loc5_.datacenter.Basics.canUseSeeAllSpell)?"":_loc5_.lang.getText("POINT_NEED_TO_BOOST_SPELL",[_loc7_]);
         if(_loc5_.datacenter.Player.Level < oItem._minPlayerLevel)
         {
            var _loc8_ = 50;
            this._lblName._alpha = _loc8_;
            this._ldrIcon._alpha = _loc8_;
            this._lblAP._alpha = _loc8_;
            this._lblRange._alpha = _loc8_;
            this._lblLevel._visible = false;
            this._lblBoost._visible = false;
            this._btnBoost._visible = false;
         }
         else
         {
            this._lblName._alpha = 100;
            this._ldrIcon._alpha = 100;
            this._lblAP._alpha = 100;
            this._lblRange._alpha = 100;
            this._lblLevel._alpha = 100;
            this._lblLevel._visible = true;
            this._lblBoost._visible = true;
         }
      }
      else if(this._lblName.text != undefined)
      {
         this._lblName.text = "";
         this._lblLevel.text = "";
         this._lblBoost.text = "";
         this._lblRange.text = "";
         this._lblAP.text = "";
         this._ldrIcon.contentPath = "";
         this._btnBoost._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._btnBoost._visible = false;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnBoost.addEventListener("click",this);
      this._btnBoost.addEventListener("over",this);
      this._btnBoost.addEventListener("out",this);
   }
   function click(oEvent)
   {
      var _loc3_ = this._mcList._parent._parent.api;
      if((var _loc0_ = oEvent.target) === this._btnBoost)
      {
         if(!_loc3_.datacenter.Player.isAuthorized)
         {
            _loc3_.kernel.showMessage(_loc3_.lang.getText("UPGRADE_SPELL"),_loc3_.lang.getText("UPGRADE_SPELL_WARNING",[this._mcList._parent._parent.getCostForBoost(this._oItem),this._oItem.name,String(this._oItem.level + 1)]),"CAUTION_YESNO",{name:"UpgradeSpellWarning",listener:this});
         }
         else
         {
            this.yes();
         }
      }
   }
   function yes(oEvent)
   {
      if(this._mcList._parent._parent.boostSpell(this._oItem))
      {
         this._btnBoost.enabled = false;
         if(this._lblBoost.text != undefined)
         {
            this._lblBoost.text = "";
         }
      }
   }
   function over(oEvent)
   {
      var _loc3_ = this._mcList._parent._parent.api;
      if((var _loc0_ = oEvent.target) === this._btnBoost)
      {
         _loc3_.ui.showTooltip(_loc3_.lang.getText("CLICK_HERE_FOR_SPELL_BOOST",[this._mcList._parent._parent.getCostForBoost(this._oItem),this._oItem.name,String(this._oItem.level + 1)]),oEvent.target,-30,{bXLimit:true,bYLimit:false});
      }
   }
   function out(oEvent)
   {
      var _loc3_ = this._mcList._parent._parent.api;
      if((var _loc0_ = oEvent.target) === this._btnBoost)
      {
         _loc3_.ui.hideTooltip();
      }
   }
}
