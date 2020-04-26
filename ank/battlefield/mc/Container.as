class ank.battlefield.mc.Container extends MovieClip
{
	function Container(loc3, loc4, loc5)
	{
		super();
		if(loc3 != undefined)
		{
			this.initialize(loc3,loc4,loc5);
		}
	}
	function initialize(loc2, loc3, loc4)
	{
		if(loc3 == undefined)
		{
			ank.utils.Logger.err("pas de _oDatacenter !");
		}
		this._mcBattlefield = loc2;
		this._oDatacenter = loc3;
		this._sObjectsFile = loc4;
		this.clear(true);
	}
	function clear(loc2)
	{
		this.maxDepth = 0;
		this.minDepth = -1000;
		this.zoom(100);
		if(this.ExternalContainer == undefined || loc2)
		{
			this.createEmptyMovieClip("ExternalContainer",100);
			var loc3 = new MovieClipLoader();
			loc3.addListener(this._parent);
			if(loc2)
			{
				this.ExternalContainer.clear();
			}
			loc3.loadClip(this._sObjectsFile,this.ExternalContainer);
		}
		else
		{
			this.ExternalContainer.clear();
		}
		this.SpriteInfos.removeMovieClip();
		this.createEmptyMovieClip("SpriteInfos",200);
		this.Points.removeMovieClip();
		this.createEmptyMovieClip("Points",300);
		this.Text.removeMovieClip();
		this.createEmptyMovieClip("Text",400);
		this.OverHead.removeMovieClip();
		this.createEmptyMovieClip("OverHead",500);
		if(!this.LoadManager)
		{
			this.createEmptyMovieClip("LoadManager",600);
		}
	}
	function applyMask(loc2)
	{
		var loc3 = this._oDatacenter.Map.width - 1;
		var loc4 = this._oDatacenter.Map.height - 1;
		if(loc2 == undefined)
		{
			loc2 = true;
		}
		this.createEmptyMovieClip("_mcMask",10);
		if(loc2)
		{
			this._mcMask.beginFill(0);
			this._mcMask.moveTo(0,0);
			this._mcMask.lineTo(loc3 * ank.battlefield.Constants.CELL_WIDTH,0);
			this._mcMask.lineTo(loc3 * ank.battlefield.Constants.CELL_WIDTH,loc4 * ank.battlefield.Constants.CELL_HEIGHT);
			this._mcMask.lineTo(0,loc4 * ank.battlefield.Constants.CELL_HEIGHT);
			this._mcMask.lineTo(0,0);
			this._mcMask.endFill();
		}
		else
		{
			this._mcMask.beginFill(0);
			this._mcMask.moveTo(-1000,-1000);
			this._mcMask.lineTo(-1000,-999);
			this._mcMask.lineTo(-999,-999);
			this._mcMask.lineTo(-999,-1000);
			this._mcMask.lineTo(-1000,-1000);
			this._mcMask.endFill();
		}
		this.setMask(this._mcMask);
	}
	function adjusteMap(loc2)
	{
		this.zoomMap();
		this.center();
	}
	function setColor(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = new Object();
			loc2.ra = 100;
			loc2.rb = 0;
			loc2.ga = 100;
			loc2.gb = 0;
			loc2.ba = 100;
			loc2.bb = 0;
		}
		var loc3 = new Color(this);
		loc3.setTransform(loc2);
	}
	function zoom(loc2)
	{
		this._xscale = loc2;
		this._yscale = loc2;
	}
	function getZoom()
	{
		return this._xscale;
	}
	function setXY(loc2, loc3)
	{
		this._x = loc2;
		this._y = loc3;
	}
	function center(loc2)
	{
		var loc3 = this._xscale / 100;
		var loc4 = this._yscale / 100;
		var loc5 = (this._mcBattlefield.screenWidth - ank.battlefield.Constants.CELL_WIDTH * loc3 * (this._oDatacenter.Map.width - 1)) / 2;
		var loc6 = (this._mcBattlefield.screenHeight - ank.battlefield.Constants.CELL_HEIGHT * loc4 * (this._oDatacenter.Map.height - 1)) / 2;
		this.setXY(loc5,loc6);
	}
	function zoomMap(loc2)
	{
		var loc3 = this.getZoomFactor();
		if(loc3 == 100)
		{
			return false;
		}
		this.zoom(loc3,false);
		return true;
	}
	function getZoomFactor(loc2)
	{
		var loc3 = this._oDatacenter.Map.width;
		var loc4 = this._oDatacenter.Map.height;
		var loc5 = 0;
		if(loc3 <= ank.battlefield.Constants.DEFAULT_MAP_WIDTH)
		{
			return 100;
		}
		if(loc4 <= ank.battlefield.Constants.DEFAULT_MAP_HEIGHT)
		{
			return 100;
		}
		if(loc4 > loc3)
		{
			loc5 = this._mcBattlefield.screenWidth / (ank.battlefield.Constants.CELL_WIDTH * (loc3 - 1)) * 100;
		}
		else
		{
			loc5 = this._mcBattlefield.screenHeight / (ank.battlefield.Constants.CELL_HEIGHT * (loc4 - 1)) * 100;
		}
		return loc5;
	}
}
