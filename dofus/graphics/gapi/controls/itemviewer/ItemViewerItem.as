class dofus.graphics.gapi.controls.itemviewer.ItemViewerItem extends ank.gapi.core.UIBasicComponent
{
   function ItemViewerItem()
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
      this._oItem = oItem;
      if(bUsed)
      {
         this.showButton(false);
         this.showLoader(false);
         if(oItem instanceof dofus.datacenter.Effect)
         {
            this._lbl.text = oItem.description;
            switch(oItem.operator)
            {
               case "+":
                  this._lbl.styleName = "GreenLeftSmallLabel";
                  break;
               case "-":
                  this._lbl.styleName = "RedLeftSmallLabel";
                  break;
               default:
                  this._lbl.styleName = "BrownLeftSmallLabel";
            }
            if((_loc0_ = oItem.type) !== 995)
            {
               this.showButton(false,"");
               this._btn.removeEventListener();
            }
            else
            {
               this.showButton(true,"ItemViewerUseHand");
               this._btn.addEventListener("click",this);
            }
            if(oItem.element != undefined)
            {
               switch(oItem.element)
               {
                  case "W":
                     this.showLoader(true,"IconWaterDommage");
                     break;
                  case "F":
                     this.showLoader(true,"IconFireDommage");
                     break;
                  case "E":
                     this.showLoader(true,"IconEarthDommage");
                     break;
                  case "A":
                     this.showLoader(true,"IconAirDommage");
                     break;
                  case "N":
                     this.showLoader(true,"IconNeutralDommage");
               }
            }
            else
            {
               switch(Number(oItem.characteristic))
               {
                  case 13:
                     this.showLoader(true,"IconWaterBonus");
                     break;
                  case 35:
                     this.showLoader(true,"IconWater");
                     break;
                  case 15:
                     this.showLoader(true,"IconFireBonus");
                     break;
                  case 34:
                     this.showLoader(true,"IconFire");
                     break;
                  case 10:
                     this.showLoader(true,"IconEarthBonus");
                     break;
                  case 33:
                     this.showLoader(true,"IconEarth");
                     break;
                  case 14:
                     this.showLoader(true,"IconAirBonus");
                     break;
                  case 36:
                     this.showLoader(true,"IconAir");
                     break;
                  case 37:
                     this.showLoader(true,"IconNeutral");
                     break;
                  case 1:
                     this.showLoader(true,"Star");
                     break;
                  case 11:
                     this.showLoader(true,"IconVita");
                     break;
                  case 12:
                     this.showLoader(true,"IconWisdom");
                     break;
                  case 44:
                     this.showLoader(true,"IconInit");
                     break;
                  case 48:
                     this.showLoader(true,"IconPP");
                     break;
                  case 2:
                     this.showLoader(true,"KamaSymbol");
                     break;
                  case 23:
                     this.showLoader(true,"IconMP");
               }
            }
         }
         else
         {
            this._lbl.text = sSuggested;
            this._lbl.styleName = "BrownLeftSmallLabel";
         }
      }
      else if(this._lbl.text != undefined)
      {
         this._lbl.text = "";
         this.showLoader(false,"");
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
      this._lbl.setSize(this.__width,this.__height);
   }
   function showButton(bShow, sIcon)
   {
      this._btn._visible = bShow;
      this._btn.icon = sIcon;
      this.moveLabel(!bShow?0:20);
      if(bShow == false)
      {
         this._btn.removeEventListener("click",this);
      }
   }
   function showLoader(bShow, sIcon)
   {
      this._ldr._visible = bShow;
      this._ldr.contentPath = sIcon;
      this._ldr._x = this.__width - 17;
   }
   function moveLabel(x)
   {
      this._lbl._x = x;
   }
   function click()
   {
      this._mcList.gapi.api.network.Mount.data(this._oItem.param1,this._oItem.param2);
   }
}
