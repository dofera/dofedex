class ank.gapi.controls.list.DefaultCellRenderer extends ank.gapi.core.UIBasicComponent
{
   function DefaultCellRenderer()
   {
      super();
   }
   function setState(sState)
   {
   }
   function setValue(bUsed, sSuggested, oItem)
   {
      if(bUsed)
      {
         this._lblText.text = sSuggested;
      }
      else if(this._lblText.text != undefined)
      {
         this._lblText.text = "";
      }
   }
   function init()
   {
      super.init(false);
   }
   function createChildren()
   {
      this.attachMovie("Label","_lblText",10,{styleName:this.getStyle().defaultstyle});
   }
   function size()
   {
      super.size();
      this._lblText.setSize(this.__width,this.__height);
   }
   function draw()
   {
      var _loc2_ = this.getStyle();
      this._lblText.styleName = _loc2_.defaultstyle;
   }
}
