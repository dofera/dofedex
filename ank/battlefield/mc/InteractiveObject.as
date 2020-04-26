class ank.battlefield.mc.InteractiveObject extends MovieClip
{
	function InteractiveObject()
	{
		super();
	}
	function initialize(loc2, loc3, loc4)
	{
		this._battlefield = loc2;
		this._oCell = loc3;
		this._bInteractive = loc4 != undefined?loc4:true;
	}
	function select(loc2)
	{
		var loc3 = new Color(this);
		var loc4 = new Object();
		if(loc2)
		{
			loc4 = {ra:60,rb:80,ga:60,gb:80,ba:60,bb:80};
		}
		else
		{
			loc4 = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
		}
		loc3.setTransform(loc4);
	}
	function loadExternalClip(loc2, loc3)
	{
		loc3 = loc3 != undefined?loc3:true;
		this.createEmptyMovieClip("_mcExternal",10);
		this._mclLoader = new MovieClipLoader();
		if(loc3)
		{
			this._mclLoader.addListener(this);
		}
		this._mclLoader.loadClip(loc2,this._mcExternal);
	}
	function __get__cellData()
	{
		return this._oCell;
	}
	function _release(loc2)
	{
		if(this._bInteractive)
		{
			this._battlefield.onObjectRelease(this);
		}
	}
	function _rollOver(loc2)
	{
		if(this._bInteractive)
		{
			this._battlefield.onObjectRollOver(this);
		}
	}
	function _rollOut(loc2)
	{
		if(this._bInteractive)
		{
			this._battlefield.onObjectRollOut(this);
		}
	}
	function onLoadInit(loc2)
	{
		var loc3 = loc2._width;
		var loc4 = loc2._height;
		var loc5 = loc3 / loc4;
		var loc6 = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
		if(loc5 == loc6)
		{
			loc2._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
			loc2._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
		}
		else if(loc5 > loc6)
		{
			loc2._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
			loc2._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / loc5;
		}
		else
		{
			loc2._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE * loc5;
			loc2._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
		}
		var loc7 = loc2.getBounds(loc2._parent);
		loc2._x = - loc7.xMin - loc2._width / 2;
		loc2._y = - loc7.yMin - loc2._height;
	}
}
