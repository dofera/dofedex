class ank.battlefield.mc.OverHead extends MovieClip
{
	static var TOP_Y = -50;
	static var BOTTOM_Y = 10;
	static var MODERATOR_Y = 15;
	function OverHead(§\x0b\x13§, §\x1e\x1c\x05§, mcBattlefield)
	{
		super();
		this._mcBattlefield = mcBattlefield;
		this._mcSprite = loc3;
		this._nZoom = loc4 != undefined?loc4:100;
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
	function setPosition(loc2, loc3)
	{
		var loc4 = {x:this._parent._parent._x,y:this._parent._parent._y};
		this._parent._parent.localToGlobal(loc4);
		this._x = this._mcSprite._x;
		this._y = this._mcSprite._y;
		var loc5 = 100 / this._nZoom;
		var loc6 = this.top;
		var loc7 = this.moderator;
		loc2 = loc2 * loc5;
		if(this._mcSprite._y < - loc6 + loc2 - loc4.y + loc7)
		{
			this._mcItems._y = this._mcItems._y + (this.bottom + loc2);
			var loc8 = 0;
			for(var k in this._oLayers)
			{
				var loc9 = this._mcItems["item" + loc8];
				loc9.reverseClip();
				loc8 = loc8 + 1;
			}
		}
		else
		{
			var loc10 = Math.abs(loc6);
			if(this._mcSprite._height > loc10 + loc7)
			{
				this._mcItems._y = this._mcItems._y + (loc6 - loc7);
			}
			else if(this._mcSprite._height < loc10 - loc7)
			{
				this._mcItems._y = this._mcItems._y + (loc6 + loc7);
			}
			else
			{
				this._mcItems._y = this._mcItems._y + loc6;
			}
		}
		var loc11 = loc3 * loc5 / 2;
		if(this._mcSprite._x < loc11 - loc4.x)
		{
			this._x = loc11;
		}
		if(this._mcSprite._x > this._mcBattlefield.screenWidth * loc5 - loc11 + loc4.x)
		{
			this._x = this._mcBattlefield.screenWidth * loc5 - loc11;
		}
	}
	function addItem(loc2, loc3, loc4, loc5)
	{
		var loc6 = new Object();
		loc6.id = this._nCurrentItemID;
		loc6.className = className;
		loc6.args = loc4;
		if(loc5 != undefined)
		{
			ank.utils.Timer.setTimer(loc6,"battlefield",this,this.removeItem,loc5,[this._nCurrentItemID]);
		}
		this._oLayers[loc2] = loc6;
		this._nCurrentItemID++;
		this.refresh();
	}
	function remove(loc2)
	{
		this.swapDepths(1);
		this.removeMovieClip();
	}
	function refresh()
	{
		this.clearView();
		var loc2 = 0;
		var loc3 = 0;
		var loc4 = 0;
		for(var k in this._oLayers)
		{
			var loc5 = this._oLayers[k];
			var loc6 = this._mcItems.attachClassMovie(loc5.className,"item" + loc2,loc2,loc5.args);
			loc3 = loc3 - loc6.height;
			loc4 = Math.max(loc4,loc6.width);
			loc6._y = loc3;
			loc2 = loc2 + 1;
		}
		this.setPosition(Math.abs(loc3),loc4);
	}
	function removeLayer(loc2)
	{
		delete this._oLayers.register2;
		this.refresh();
	}
	function removeItem(loc2)
	{
		for(var loc3 in this._oLayers)
		{
			if(this._oLayers[loc3].id == loc2)
			{
				delete this._oLayers.register3;
				this.refresh();
				break;
			}
		}
	}
}
