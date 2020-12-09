class ank.battlefield.mc.InteractiveObject extends MovieClip
{
	function InteractiveObject()
	{
		super();
	}
	function initialize(§\x1d\x03§, §\x1e\x1a\r§, §\x18\x1c§)
	{
		this._battlefield = var2;
		this._oCell = var3;
		this._bInteractive = var4 != undefined?var4:true;
	}
	function select(§\x16\x1d§)
	{
		var var3 = new Color(this);
		var var4 = new Object();
		if(var2)
		{
			var4 = {ra:60,rb:80,ga:60,gb:80,ba:60,bb:80};
		}
		else
		{
			var4 = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
		}
		var3.setTransform(var4);
	}
	function loadExternalClip(§\x1e\x12\x18§, §\x1c\b§)
	{
		var3 = var3 != undefined?var3:true;
		this.createEmptyMovieClip("_mcExternal",10);
		this._mclLoader = new MovieClipLoader();
		if(var3)
		{
			this._mclLoader.addListener(this);
		}
		this._mclLoader.loadClip(var2,this._mcExternal);
	}
	function __get__cellData()
	{
		return this._oCell;
	}
	function _release(§\x1e\n\f§)
	{
		if(this._bInteractive)
		{
			this._battlefield.onObjectRelease(this);
		}
	}
	function _rollOver(§\x1e\n\f§)
	{
		if(this._bInteractive)
		{
			this._battlefield.onObjectRollOver(this);
		}
	}
	function _rollOut(§\x1e\n\f§)
	{
		if(this._bInteractive)
		{
			this._battlefield.onObjectRollOut(this);
		}
	}
	function onLoadInit(§\x0b\r§)
	{
		var var3 = var2._width;
		var var4 = var2._height;
		var var5 = var3 / var4;
		var var6 = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
		if(var5 == var6)
		{
			var2._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
			var2._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
		}
		else if(var5 > var6)
		{
			var2._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
			var2._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / var5;
		}
		else
		{
			var2._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE * var5;
			var2._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
		}
		var var7 = var2.getBounds(var2._parent);
		var2._x = - var7.xMin - var2._width / 2;
		var2._y = - var7.yMin - var2._height;
	}
}
