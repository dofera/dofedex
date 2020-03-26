class dofus.graphics.battlefield.EffectIcon extends MovieClip
{
   static var COLOR_PLUS = 255;
   static var COLOR_MINUS = 16711680;
   static var COLOR_FACTOR = 65280;
   function EffectIcon()
   {
      super();
      _global.subtrace("yahoo");
      this.initialize(this._sOperator,this._nQte);
   }
   function __set__operator(sOperator)
   {
      this._sOperator = sOperator;
      return this.__get__operator();
   }
   function __set__qte(nQte)
   {
      this._nQte = nQte;
      return this.__get__qte();
   }
   function initialize(sOperator, nQte)
   {
      switch(sOperator)
      {
         case "-":
            this.attachMovie("Icon-","_mcOp",10,{_x:1,_y:1});
            var _loc4_ = new Color(this._mcbackground);
            _loc4_.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_MINUS);
            break;
         case "+":
            this.attachMovie("Icon+","_mcOp",10,{_x:1,_y:1});
            var _loc5_ = new Color(this._mcbackground);
            _loc5_.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_PLUS);
            break;
         case "*":
            this.attachMovie("Icon*","_mcOp",10,{_x:1,_y:1});
            var _loc6_ = new Color(this._mcbackground);
            _loc6_.setRGB(dofus.graphics.battlefield.EffectIcon.COLOR_FACTOR);
      }
   }
}
