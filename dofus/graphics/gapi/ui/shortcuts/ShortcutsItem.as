class dofus.graphics.gapi.ui.shortcuts.ShortcutsItem extends ank.gapi.core.UIBasicComponent
{
   function ShortcutsItem()
   {
      super();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         if(oItem.c)
         {
            this._btnMain._visible = false;
            this._btnAlt._visible = false;
            this._rctCatBg._visible = true;
            this._lblDescription.styleName = "GrayLeftSmallBoldLabel";
            this._lblDescription.text = oItem.d;
         }
         else
         {
            var _loc5_ = _global.API;
            this._btnMain._visible = true;
            this._btnAlt._visible = true;
            this._rctCatBg._visible = false;
            this._lblDescription.styleName = "BrownLeftSmallLabel";
            this._lblDescription.text = "    " + oItem.d;
            if(oItem.s.k != undefined)
            {
               if(oItem.s.d == undefined || (oItem.s.d == "" || new ank.utils.ExtendedString(oItem.s.d).trim().toString() == ""))
               {
                  this._btnMain.label = _loc5_.lang.getControlKeyString(oItem.s.c) + _loc5_.lang.getKeyStringFromKeyCode(oItem.s.k);
               }
               else
               {
                  this._btnMain.label = oItem.s.d;
               }
            }
            else
            {
               this._btnMain.label = _loc5_.lang.getText("KEY_UNDEFINED");
            }
            if(oItem.s.k2 != undefined)
            {
               if(oItem.s.d2 == undefined || (oItem.s.d2 == "" || new ank.utils.ExtendedString(oItem.s.d2).trim().toString() == ""))
               {
                  this._btnAlt.label = _loc5_.lang.getControlKeyString(oItem.s.c2) + _loc5_.lang.getKeyStringFromKeyCode(oItem.s.k2);
               }
               else
               {
                  this._btnAlt.label = oItem.s.d2;
               }
            }
            else
            {
               this._btnAlt.label = _loc5_.lang.getText("KEY_UNDEFINED");
            }
            this._btnMain.enabled = this._btnAlt.enabled = !oItem.l;
         }
         this._sShortcut = oItem.k;
      }
      else if(this._lblDescription.text != undefined)
      {
         this._lblDescription.styleName = "BrownLeftSmallLabel";
         this._lblDescription.text = "";
         this._rctCatBg._visible = false;
         this._btnMain._visible = false;
         this._btnMain.label = "";
         this._btnAlt._visible = false;
         this._btnAlt.label = "";
         this._sShortcut = undefined;
      }
   }
   function init()
   {
      super.init(false);
      this._rctCatBg._visible = false;
      this._btnMain._visible = false;
      this._btnAlt._visible = false;
   }
   function createChildren()
   {
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnMain.addEventListener("click",this);
      this._btnAlt.addEventListener("click",this);
   }
   function click(oEvent)
   {
      if(this._sShortcut == undefined)
      {
         return undefined;
      }
      var _loc3_ = _global.API;
      switch(oEvent.target._name)
      {
         case "_btnMain":
            _loc3_.kernel.KeyManager.askCustomShortcut(this._sShortcut,false);
            break;
         case "_btnAlt":
            _loc3_.kernel.KeyManager.askCustomShortcut(this._sShortcut,true);
      }
   }
}
