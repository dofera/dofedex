class dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var DEPTH_X_OFFSET = 10;
   function AlignmentViewerTreeItem()
   {
      super();
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         var _loc5_ = dofus.graphics.gapi.controls.alignmentviewer.AlignmentViewerTreeItem.DEPTH_X_OFFSET * oItem.depth;
         if(oItem.data instanceof dofus.datacenter.Alignment)
         {
            this._ldrIcon._x = this._nLdrX + _loc5_;
            this._lblName._x = this._nLdrX + _loc5_;
            this._lblName.width = this.__width - this._lblName._x;
            this._lblName.styleName = "BrownLeftMediumBoldLabel";
            this._mcBackgroundLight._visible = false;
            this._mcBackgroundDark._visible = true;
            this._ldrIcon.contentPath = "";
            this._lblName.text = oItem.data.name;
            this._lblLevel.text = "";
         }
         if(oItem.data instanceof dofus.datacenter.Order)
         {
            this._ldrIcon._x = this._nLdrX + _loc5_;
            this._lblName._x = this._nLblX + _loc5_;
            this._lblName.width = this.__width - this._lblName._x;
            this._lblName.styleName = "BrownLeftSmallBoldLabel";
            this._mcBackgroundLight._visible = false;
            this._mcBackgroundDark._visible = false;
            this._ldrIcon.contentPath = oItem.data.iconFile;
            this._lblName.text = oItem.data.name;
            this._lblLevel.text = "";
         }
         else if(oItem.data instanceof dofus.datacenter.Specialization)
         {
            this._ldrIcon._x = this._nLdrX + _loc5_;
            this._lblName._x = this._nLblX + _loc5_;
            this._lblName.width = this.__width - this._lblName._x;
            this._lblName.styleName = "BrownLeftSmallLabel";
            this._mcBackgroundLight._visible = false;
            this._mcBackgroundDark._visible = false;
            this._ldrIcon.contentPath = "";
            this._lblLevel.text = oItem.data.alignment.value <= 0?"- ":oItem.data.alignment.value + " ";
            this._lblName.text = oItem.data.name;
            this._lblLevel.setSize(this.__width);
            this._lblName.setSize(this.__width - this._lblName._x - this._lblLevel.textWidth - 30);
         }
      }
      else if(this._lblName.text != undefined)
      {
         this._ldrIcon._x = this._nLdrX;
         this._lblName._x = this._nLblX;
         this._ldrIcon.contentPath = "";
         this._lblName.text = "";
         this._lblLevel.text = "";
         this._mcBackgroundLight._visible = false;
         this._mcBackgroundDark._visible = false;
      }
   }
   function init()
   {
      super.init(false);
      this._nLdrX = this._ldrIcon._x;
      this._nLblX = this._lblName._x;
   }
}
