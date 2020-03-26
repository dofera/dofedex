class dofus.graphics.gapi.controls.statsviewer.StatsViewerStatItem extends ank.gapi.core.UIBasicComponent
{
   function StatsViewerStatItem()
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
         if(oItem.isCat)
         {
            this._mcCatBackground._visible = true;
            this._ldrIcon.contentPath = "";
            this._lblCatName.text = oItem.name;
            this._lblName.text = "";
            this._lblBase.text = "";
            this._lblItems.text = "";
            this._lblAlign.text = "";
            this._lblBoost.text = "";
            this._lblTotal.text = "";
         }
         else
         {
            this._mcCatBackground._visible = false;
            if(oItem.p != undefined)
            {
               this._ldrIcon.contentPath = oItem.p;
            }
            else
            {
               this._ldrIcon.contentPath = "";
            }
            this._lblCatName.text = "";
            this._lblName.text = oItem.name;
            if(oItem.s != 0)
            {
               this._lblBase.text = oItem.s;
               if(oItem.s > 0)
               {
                  this._lblBase.styleName = "GreenCenterSmallLabel";
               }
               else
               {
                  this._lblBase.styleName = "RedCenterSmallLabel";
               }
            }
            else
            {
               this._lblBase.text = "-";
               this._lblBase.styleName = "BrownCenterSmallLabel";
            }
            if(oItem.i != 0)
            {
               this._lblItems.text = oItem.i;
               if(oItem.i > 0)
               {
                  this._lblItems.styleName = "GreenCenterSmallLabel";
               }
               else
               {
                  this._lblItems.styleName = "RedCenterSmallLabel";
               }
            }
            else
            {
               this._lblItems.text = "-";
               this._lblItems.styleName = "BrownCenterSmallLabel";
            }
            if(oItem.d != 0)
            {
               this._lblAlign.text = oItem.d;
               if(oItem.d > 0)
               {
                  this._lblAlign.styleName = "GreenCenterSmallLabel";
               }
               else
               {
                  this._lblAlign.styleName = "RedCenterSmallLabel";
               }
            }
            else
            {
               this._lblAlign.text = "-";
               this._lblAlign.styleName = "BrownCenterSmallLabel";
            }
            if(oItem.b != 0)
            {
               this._lblBoost.text = oItem.b;
               if(oItem.b > 0)
               {
                  this._lblBoost.styleName = "GreenCenterSmallLabel";
               }
               else
               {
                  this._lblBoost.styleName = "RedCenterSmallLabel";
               }
            }
            else
            {
               this._lblBoost.text = "-";
               this._lblBoost.styleName = "BrownCenterSmallLabel";
            }
            var _loc5_ = oItem.b + oItem.d + oItem.i + oItem.s;
            if(_loc5_ != 0)
            {
               this._lblTotal.text = String(_loc5_);
               if(_loc5_ > 0)
               {
                  this._lblTotal.styleName = "GreenCenterSmallLabel";
               }
               else
               {
                  this._lblTotal.styleName = "RedCenterSmallLabel";
               }
            }
            else
            {
               this._lblTotal.text = "-";
               this._lblTotal.styleName = "BrownCenterSmallLabel";
            }
         }
      }
      else if(this._lblName.text != undefined)
      {
         this._mcCatBackground._visible = false;
         this._ldrIcon.contentPath = "";
         this._lblCatName.text = "";
         this._lblName.text = "";
         this._lblBase.text = "";
         this._lblBase.styleName = "BrownCenterSmallLabel";
         this._lblItems.text = "";
         this._lblItems.styleName = "BrownCenterSmallLabel";
         this._lblAlign.text = "";
         this._lblAlign.styleName = "BrownCenterSmallLabel";
         this._lblBoost.text = "";
         this._lblBoost.styleName = "BrownCenterSmallLabel";
         this._lblTotal.text = "";
         this._lblTotal.styleName = "BrownCenterSmallLabel";
      }
   }
   function init()
   {
      super.init(false);
      this._mcCatBackground._visible = false;
   }
}
