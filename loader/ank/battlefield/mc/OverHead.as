class ank.battlefield.mc.OverHead extends MovieClip
{
	static var TOP_Y = -50;
	static var BOTTOM_Y = 10;
	static var MODERATOR_Y = 15;
	function OverHead(§\n\x0e§, §\x1e\x1a\x12§, mcBattlefield)
	{
		super();
		this._mcBattlefield = mcBattlefield;
		this._mcSprite = var3;
		this._nZoom = var4 != undefined?var4:100;
		this.initialize();
	}
	function __get__top()
	{
		return ank.battlefield.mc.OverHead.TOP_Y * this._nZoom / 100;
	}
	function __get__bottom()
	{
		return ank.battlefield.mc.OverHead.BOTTOM_Y * this._nZoom / 100;
	}
	function __get__moderator()
	{
		return ank.battlefield.mc.OverHead.MODERATOR_Y * this._nZoom / 100;
	}
	function initialize()
	{
		this._nCurrentItemID = 0;
		this.clear();
	}
	function clear()
	{
		this._oLayers = new Object();
		this.clearView();
	}
	function clearView()
	{
		this.createEmptyMovieClip("_mcItems",10);
	}
	function setPosition(var2, var3)
	{
		var var4 = {x:this._parent._parent._x,y:this._parent._parent._y};
		this._parent._parent.localToGlobal(var4);
		this._x = this._mcSprite._x;
		this._y = this._mcSprite._y;
		var var5 = 100 / this._nZoom;
		var var6 = this.top;
		var var7 = this.moderator;
		var2 = var2 * var5;
		if(this._mcSprite._y < - var6 + var2 - var4.y + var7)
		{
			this._mcItems._y = this._mcItems._y + (this.bottom + var2);
			var var8 = 0;
			for(var k in this._oLayers)
			{
				var var9 = this._mcItems["item" + var8];
				var9.reverseClip();
				var8 = var8 + 1;
			}
		}
		else
		{
			var var10 = Math.abs(var6);
			if(this._mcSprite._height > var10 + var7)
			{
				this._mcItems._y = this._mcItems._y + (var6 - var7);
			}
			else if(this._mcSprite._height < var10 - var7)
			{
				this._mcItems._y = this._mcItems._y + (var6 + var7);
			}
			else
			{
				this._mcItems._y = this._mcItems._y + var6;
			}
		}
		var var11 = var3 * var5 / 2;
		if(this._mcSprite._x < var11 - var4.x)
		{
			this._x = var11;
		}
		if(this._mcSprite._x > this._mcBattlefield.screenWidth * var5 - var11 + var4.x)
		{
			this._x = this._mcBattlefield.screenWidth * var5 - var11;
		}
	}
	function addItem(var2, var3, var4, var5)
	{
		var var6 = new Object();
		var6.id = this._nCurrentItemID;
		var6.className = className;
		var6.args = var4;
		if(var5 != undefined)
		{
			ank.utils.Timer.setTimer(var6,"battlefield",this,this.removeItem,var5,[this._nCurrentItemID]);
		}
		this._oLayers[var2] = var6;
		this._nCurrentItemID++;
		this.refresh();
	}
	function remove(var2)
	{
		this.swapDepths(1);
		this.removeMovieClip();
	}
	function refresh()
	{
		this.clearView();
		var var2 = 0;
		var var3 = 0;
		var var4 = 0;
		for(var k in this._oLayers)
		{
			var var5 = this._oLayers[k];
			var var6 = this._mcItems.attachClassMovie(var5.className,"item" + var2,var2,var5.args);
			var3 = var3 - var6.height;
			var4 = Math.max(var4,var6.width);
			var6._y = var3;
			var2 = var2 + 1;
		}
		this.setPosition(Math.abs(var3),var4);
	}
	function removeLayer(var2)
	{
		delete this._oLayers.register2;
		this.refresh();
	}
	function removeItem(var2)
	{
		for(var var3 in this._oLayers)
		{
			if(this._oLayers[var3].id == var2)
			{
				delete this._oLayers.register3;
				this.refresh();
				break;
			}
		}
	}
}
