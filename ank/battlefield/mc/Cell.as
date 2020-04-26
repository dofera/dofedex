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
	function initialize(loc2)
	{
		this._mcBattlefield = loc2;
	}
	function _release(loc2)
	{
		this._mcBattlefield.onCellRelease(this);
	}
	function _rollOver(loc2)
	{
		this._mcBattlefield.onCellRollOver(this);
	}
	function _rollOut(loc2)
	{
		this._mcBattlefield.onCellRollOut(this);
	}
}
