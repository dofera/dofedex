class dofus.graphics.gapi.ui.DirectionChooser extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
   static var CLASS_NAME = "DirectionChooser";
   function DirectionChooser()
   {
      super();
   }
   function __set__target(mcSprite)
   {
      this._mcSprite = mcSprite;
      return this.__get__target();
   }
   function init()
   {
      super.init(false,dofus.graphics.gapi.ui.DirectionChooser.CLASS_NAME);
   }
   function createChildren()
   {
      var _loc2_ = this.api.gfx.getZoom();
      var _loc3_ = {x:this._mcSprite._x,y:this._mcSprite._y};
      this._mcSprite._parent.localToGlobal(_loc3_);
      this._mcArrows._x = _loc3_.x;
      this._mcArrows._y = _loc3_.y;
      this._mcArrows._xscale = this._mcArrows._yscale = _loc2_;
      this._btnTL = this._mcArrows._btnTL;
      this._btnTR = this._mcArrows._btnTR;
      this._btnBL = this._mcArrows._btnBL;
      this._btnBR = this._mcArrows._btnBR;
      this._btnT = this._mcArrows._btnT;
      this._btnL = this._mcArrows._btnL;
      this._btnR = this._mcArrows._btnR;
      this._btnB = this._mcArrows._btnB;
      if(!this.allDirections)
      {
         this._btnT._visible = false;
         this._mcArrows._mcShadowT._visible = false;
         this._btnB._visible = false;
         this._mcArrows._mcShadowB._visible = false;
         this._btnL._visible = false;
         this._mcArrows._mcShadowL._visible = false;
         this._btnR._visible = false;
         this._mcArrows._mcShadowR._visible = false;
      }
      this.out({target:this._btnT});
      this.addToQueue({object:this,method:this.addListeners});
   }
   function addListeners()
   {
      this._btnTL.addEventListener("click",this);
      this._btnTR.addEventListener("click",this);
      this._btnBL.addEventListener("click",this);
      this._btnBR.addEventListener("click",this);
      this._btnT.addEventListener("click",this);
      this._btnL.addEventListener("click",this);
      this._btnR.addEventListener("click",this);
      this._btnB.addEventListener("click",this);
      this._btnTL.addEventListener("over",this);
      this._btnTR.addEventListener("over",this);
      this._btnBL.addEventListener("over",this);
      this._btnBR.addEventListener("over",this);
      this._btnT.addEventListener("over",this);
      this._btnL.addEventListener("over",this);
      this._btnR.addEventListener("over",this);
      this._btnB.addEventListener("over",this);
      this._btnTL.addEventListener("out",this);
      this._btnTR.addEventListener("out",this);
      this._btnBL.addEventListener("out",this);
      this._btnBR.addEventListener("out",this);
      this._btnT.addEventListener("out",this);
      this._btnL.addEventListener("out",this);
      this._btnR.addEventListener("out",this);
      this._btnB.addEventListener("out",this);
   }
   function click(oEvent)
   {
      var _loc3_ = 0;
      switch(oEvent.target)
      {
         case this._btnR:
            _loc3_ = 0;
            break;
         case this._btnBR:
            _loc3_ = 1;
            break;
         case this._btnB:
            _loc3_ = 2;
            break;
         case this._btnBL:
            _loc3_ = 3;
            break;
         case this._btnL:
            _loc3_ = 4;
            break;
         case this._btnTL:
            _loc3_ = 5;
            break;
         case this._btnT:
            _loc3_ = 6;
            break;
         case this._btnTR:
            _loc3_ = 7;
      }
      this.api.network.Emotes.setDirection(_loc3_);
      this.unloadThis();
   }
   function over(oEvent)
   {
      oEvent.target._alpha = 80;
      this.onMouseUp = undefined;
   }
   function out(oEvent)
   {
      if((var _loc0_ = oEvent.target) !== this._btnT)
      {
         oEvent.target._alpha = 100;
      }
      else
      {
         this._btnT._alpha = 0;
      }
      this.onMouseUp = this._onMouseUp;
   }
   function _onMouseUp()
   {
      this.unloadThis();
   }
   function onMouseUp()
   {
      this.out();
   }
}
