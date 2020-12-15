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
	function initialize(var2)
	{
		this._mcBattlefield = var2;
	}
	function _release(var2)
	{
		this._mcBattlefield.onCellRelease(this);
	}
	function _rollOver(var2)
	{
		this._mcBattlefield.onCellRollOver(this);
	}
	function _rollOut(var2)
	{
		this._mcBattlefield.onCellRollOut(this);
	}
}
