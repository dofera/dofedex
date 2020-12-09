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
	function initialize(§\x1d\x03§)
	{
		this._mcBattlefield = var2;
	}
	function _release(§\x1e\n\f§)
	{
		this._mcBattlefield.onCellRelease(this);
	}
	function _rollOver(§\x1e\n\f§)
	{
		this._mcBattlefield.onCellRollOver(this);
	}
	function _rollOut(§\x1e\n\f§)
	{
		this._mcBattlefield.onCellRollOut(this);
	}
}
