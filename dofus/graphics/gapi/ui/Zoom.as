class dofus.graphics.gapi.ui.Zoom extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "Zoom";
   function Zoom()
   {
      super();
   }
   function __set__sprite(oSprite)
   {
      this._oSprite = oSprite;
      return this.__get__sprite();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.Zoom.CLASS_NAME);
   }
   function callClose()
   {
      Mouse.removeListener(this);
      this.api.kernel.GameManager.zoomGfx();
      this.unloadThis();
   }
   function createChildren()
   {
      Mouse.addListener(this);
      this.api.kernel.GameManager.zoomGfx();
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnCancel.addEventListener("click",this);
      this._btnCancel.addEventListener("over",this);
      this._btnCancel.addEventListener("out",this);
      this._vsZoom.addEventListener("change",this);
      this._vsZoom.min = this.api.gfx.getZoom();
   }
   function setZoom(bOnSprite)
   {
      if(this._vsZoom.value < this._vsZoom.min + this._vsZoom.min * 10 / 100)
      {
         this.api.kernel.GameManager.zoomGfx();
      }
      else if(bOnSprite)
      {
         this.api.kernel.GameManager.zoomGfx(this._vsZoom.value,this._oSprite.mc._x,this._oSprite.mc._y - 20);
      }
      else
      {
         var _loc3_ = this.api.gfx.getZoom();
         var _loc4_ = (_root._xmouse - this.api.gfx.container._x) * 100 / _loc3_;
         var _loc5_ = (_root._ymouse - this.api.gfx.container._y) * 100 / _loc3_;
         this.api.kernel.GameManager.zoomGfx(this._vsZoom.value,_loc4_,_loc5_,_root._xmouse,_root._ymouse);
      }
   }
   function onMouseWheel(nValue)
   {
      this._vsZoom.value = this._vsZoom.value + nValue * 5;
      this.setZoom(false);
   }
   function click(oEvent)
   {
      if((var _loc0_ = oEvent.target) === this._btnCancel)
      {
         this.callClose();
      }
   }
   function change(oEvent)
   {
      this.setZoom(true);
   }
   function over(oEvent)
   {
      this.gapi.showTooltip(this.api.lang.getText("CLOSE"),oEvent.target,-20);
   }
   function out(oEvent)
   {
      this.gapi.hideTooltip();
   }
}
