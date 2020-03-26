class ank.battlefield.mc.Cell extends MovieClip
{
   function Cell()
   {
      super();
   }
   function __get__num()
   {
      return this.data.num;
   }
   function initialize(b)
   {
      this._mcBattlefield = b;
   }
   function _release(Void)
   {
      this._mcBattlefield.onCellRelease(this);
   }
   function _rollOver(Void)
   {
      this._mcBattlefield.onCellRollOver(this);
   }
   function _rollOut(Void)
   {
      this._mcBattlefield.onCellRollOut(this);
   }
}
