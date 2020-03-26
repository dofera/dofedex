class dofus.graphics.gapi.controls.spellfullinfosvieweritem.SpellFullInfosViewerItem extends ank.gapi.core.UIBasicComponent
{
   function SpellFullInfosViewerItem()
   {
      super();
      this._mcArea._visible = false;
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._oItem = oItem;
         if(oItem.fx.description == undefined && oItem.description == undefined)
         {
            this._lbl.text = sSuggested;
         }
         else
         {
            if(oItem.fx.description != undefined)
            {
               this._lbl.text = oItem.fx.description;
            }
            else if(oItem.description != undefined)
            {
               this._lbl.text = oItem.description;
            }
            var _loc5_ = undefined;
            if(oItem.fx.element != undefined)
            {
               _loc5_ = oItem.fx.element;
            }
            else if(oItem.element != undefined)
            {
               _loc5_ = oItem.element;
            }
            if(_loc5_ != undefined)
            {
               switch(_loc5_)
               {
                  case "N":
                     this._ctrElement.contentPath = "IconNeutralDommage";
                     break;
                  case "F":
                     this._ctrElement.contentPath = "IconFireDommage";
                     break;
                  case "A":
                     this._ctrElement.contentPath = "IconAirDommage";
                     break;
                  case "W":
                     this._ctrElement.contentPath = "IconWaterDommage";
                     break;
                  case "E":
                     this._ctrElement.contentPath = "IconEarthDommage";
                     break;
                  default:
                     this._ctrElement.contentPath = "";
               }
            }
            else if(oItem.fx.icon != undefined)
            {
               this._ctrElement.contentPath = oItem.fx.icon;
            }
            else if(oItem.icon != undefined)
            {
               this._ctrElement.contentPath = oItem.icon;
            }
            else
            {
               this._ctrElement.contentPath = "";
            }
         }
         if(oItem.ar > 1)
         {
            this._mcArea._visible = true;
            this._mcArea.onRollOver = function()
            {
               this._parent.onTooltipOver();
            };
            this._mcArea.onRollOut = function()
            {
               this._parent.onTooltipOut();
            };
            this._lblArea.text = (oItem.ar != 63?oItem.ar:_global.API.lang.getText("INFINIT_SHORT")) + " (" + oItem.at + ")";
         }
         else
         {
            this._mcArea._visible = false;
            this._mcArea.onRollOver = undefined;
            this._mcArea.onRollOut = undefined;
            this._lblArea.text = "";
         }
      }
      else if(this._lbl.text != undefined)
      {
         this._oItem = undefined;
         this._lbl.text = "";
         this._lblArea.text = "";
         this._mcArea._visible = false;
         this._ctrElement.contentPath = "";
      }
      else
      {
         this._oItem = undefined;
      }
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.arrange();
   }
   function size()
   {
      super.size();
      this.addToQueue({object:this,method:this.arrange});
   }
   function arrange()
   {
      this._lbl.setSize(this.__width - (this._oItem.ar <= 1?20:78),this.__height);
   }
   function onTooltipOver()
   {
      _global.API.ui.showTooltip(_global.API.lang.getText("EFFECT_SHAPE_TYPE_" + this._oItem.at,[this._oItem.ar != 63?this._oItem.ar:_global.API.lang.getText("INFINIT")]),this._mcArea,-20);
   }
   function onTooltipOut()
   {
      _global.API.ui.hideTooltip();
   }
}
