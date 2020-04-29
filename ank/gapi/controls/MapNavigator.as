class ank.gapi.controls.MapNavigator extends ank.gapi.core.UIAdvancedComponent
{
	static var CLASS_NAME = "MapNavigator";
	var _nButtonMargin = 5;
	var _bShowGrid = true;
	var _nZoom = 50;
	var _nWPage = 10;
	var _nHPage = 10;
	var _sInteractionMode = "move";
	var _nXCurrent = 0;
	var _nYCurrent = 0;
	function MapNavigator()
	{
		super();
	}
	function __set__buttonMargin(var2)
	{
		this._nButtonMargin = Number(var2);
		return this.__get__buttonMargin();
	}
	function __get__buttonMargin()
	{
		return this._nButtonMargin;
	}
	function __set__showGrid(var2)
	{
		this._bShowGrid = var2;
		if(this.initialized)
		{
			this.drawGrid();
		}
		return this.__get__showGrid();
	}
	function __get__showGrid()
	{
		return this._bShowGrid;
	}
	function __set__contentPath(sURL)
	{
		this._sURL = sURL;
		if(this.initialized)
		{
			this._ldrMap.contentPath = this._sURL;
		}
		return this.__get__contentPath();
	}
	function __get__contentPath()
	{
		return this._sURL;
	}
	function __set__wPage(var2)
	{
		this._nWPage = var2;
		return this.__get__wPage();
	}
	function __get__wPage()
	{
		return this._nWPage;
	}
	function __set__hPage(var2)
	{
		this._nHPage = var2;
		return this.__get__hPage();
	}
	function __get__hPage()
	{
		return this._nHPage;
	}
	function __set__zoom(var2)
	{
		if(_global.isNaN(var2))
		{
			return undefined;
		}
		if(var2 > 100)
		{
			var2 = 100;
		}
		if(var2 < 10)
		{
			var2 = 10;
		}
		this._nZoom = var2;
		if(this.initialized)
		{
			this.setZoom();
		}
		return this.__get__zoom();
	}
	function __get__zoom()
	{
		return this._nZoom;
	}
	function __set__interactionMode(var2)
	{
		this._sInteractionMode = var2;
		if(this.initialized)
		{
			this.applyInteractionMode();
		}
		return this.__get__interactionMode();
	}
	function __get__interactionMode()
	{
		return this._sInteractionMode;
	}
	function __get__virtualWPage()
	{
		return this._nWPage * this._nZoom / 100;
	}
	function __get__virtualHPage()
	{
		return this._nHPage * this._nZoom / 100;
	}
	function __get__currentX()
	{
		return this._nXCurrent;
	}
	function __get__currentY()
	{
		return this._nYCurrent;
	}
	function __get__loaderMap()
	{
		return this._ldrMap;
	}
	function setMapPosition(var2, var3)
	{
		this._mcXtra._xscale = this._mcXtra._yscale = this._nZoom;
		if(var2 == undefined || var3 == undefined)
		{
			return undefined;
		}
		this.removeAreaClip();
		this._nXCurrent = var2;
		this._nYCurrent = var3;
		var var4 = this._ldrMap.content;
		var4._x = this._mcXtra._x = (- this.virtualWPage) * (0.5 + var2);
		var4._y = this._mcXtra._y = (- this.virtualHPage) * (0.5 + var3);
		var var5 = 15;
		var var6 = 15;
		var var7 = Math.floor(var2 - this._nMapWidth / (2 * this.virtualWPage) + 0.5);
		var var8 = Math.floor(var3 - this._nMapHeight / (2 * this.virtualHPage) + 0.5);
		var var9 = Math.floor(var7 / var5);
		var var10 = Math.floor(var8 / var6);
		var var11 = var9 + Math.ceil(Math.floor(this._nMapWidth / this.virtualWPage) / var5);
		var var12 = var10 + Math.ceil(Math.floor(this._nMapHeight / this.virtualHPage) / var6);
		for(var k in this._ldrMap.content)
		{
			this._ldrMap.content[k].removeMovieClip();
		}
		var var13 = var9;
		while(var13 <= var11)
		{
			var var14 = var10;
			while(var14 <= var12)
			{
				this._ldrMap.content.attachMovie(var13 + "_" + var14,var13 + "_" + var14,this._ldrMap.content.getNextHighestDepth(),{_yscale:this._nZoom,_xscale:this._nZoom,_x:var13 * var5 * this.virtualWPage,_y:var14 * var6 * this.virtualHPage});
				var14 = var14 + 1;
			}
			var13 = var13 + 1;
		}
	}
	function addSubareaClip(var2, var3, var4)
	{
		if(var2 == this._nLastSubAreaID)
		{
			return undefined;
		}
		this.removeAreaClip();
		var var5 = this._ldrMap.content.attachMovie("subarea_" + var2,"_mcSubarea",this._ldrMap.content.getNextHighestDepth());
		var var6 = new Color(var5);
		var6.setRGB(var3);
		var5._alpha = var4;
		var5._xscale = var5._yscale = this._nZoom;
		this._nLastSubAreaID = var2;
	}
	function removeAreaClip()
	{
		this._ldrMap.content._mcSubarea.removeMovieClip();
		delete this._nLastSubAreaID;
	}
	function addXtraClip(var2, var3, var4, var5, var6, var7, var8, var9)
	{
		var var10 = this._mcXtra[var3]["clipByCoord_" + var4 + "_" + var5];
		if(var9 == true && var10 != undefined)
		{
			return var10;
		}
		var var11 = this._nWPage * (0.5 + var4);
		var var12 = this._nHPage * (0.5 + var5);
		var var13 = this._mcXtra.getNextHighestDepth();
		var var14 = this._mcXtra[var3];
		if(var14 == undefined)
		{
			var14 = this._mcXtra.createEmptyMovieClip(var3,var13);
		}
		var13 = var14.getNextHighestDepth();
		var var15 = var14.attachMovie(var2,"clip" + var13,var13,{_x:var11,_y:var12});
		this._mcXtra[var3]["clipByCoord_" + var4 + "_" + var5] = var15;
		if(var6 != undefined)
		{
			var var16 = new Color(var15._mcColor);
			var16.setRGB(var6);
		}
		if(var8)
		{
			var15.mn = this;
			var15.onRelease = function()
			{
				this.mn.click({target:this.mn._btnLocateClick});
			};
		}
		var15._alpha = var7 != undefined?var7:100;
		return var15;
	}
	function loadXtraLayer(var2, var3)
	{
		var var4 = this.createXtraLayer(var3);
		var var5 = new MovieClipLoader();
		var5.addListener(this);
		var5.loadClip(var2,var4);
	}
	function createXtraLayer(var2)
	{
		var var3 = this._mcXtra.getNextHighestDepth();
		var var4 = this._mcXtra[var2];
		if(var4 == undefined)
		{
			var4 = this._mcXtra.createEmptyMovieClip(var2,var3);
		}
		return var4;
	}
	function getXtraLayer(var2)
	{
		return this._mcXtra[var2];
	}
	function clear(var2)
	{
		if(var2 != undefined)
		{
			this._mcXtra[var2].removeMovieClip();
		}
		else
		{
			for(var k in this._mcXtra)
			{
				this._mcXtra[k].removeMovieClip();
			}
		}
	}
	function init()
	{
		super.init(false,ank.gapi.controls.MapNavigator.CLASS_NAME);
	}
	function createChildren()
	{
		var var2 = {styleName:"none",backgroundDown:"ButtonSimpleRectangleUpDown",backgroundUp:"ButtonSimpleRectangleUpDown"};
		this.attachMovie("Rectangle","_mcBorder",0);
		this.attachMovie("Button","_btnNW",10,var2);
		this.attachMovie("Button","_btnN",20,var2);
		this.attachMovie("Button","_btnNE",30,var2);
		this.attachMovie("Button","_btnW",40,var2);
		this.attachMovie("Button","_btnE",50,var2);
		this.attachMovie("Button","_btnSW",60,var2);
		this.attachMovie("Button","_btnS",70,var2);
		this.attachMovie("Button","_btnSE",80,var2);
		this.attachMovie("Button","_btnLocateClick",90,var2);
		this.attachMovie("Rectangle","_mcMapBorder",100);
		this.attachMovie("Rectangle","_mcMapBackground",110);
		this.createEmptyMovieClip("_mcMap",120);
		this._ldrMap = (ank.gapi.controls.Loader)this._mcMap.attachMovie("Loader","_ldrMap",10,{centerContent:false,scaleContent:false,autoLoad:true,contentPath:this._sURL});
		this.attachMovie("Rectangle","_mcMask",130);
		this._mcMap.setMask(this._mcMask);
		this._mcMap.createEmptyMovieClip("_mcGrid",140);
		this._mcGrid = this._mcMap._mcGrid;
		this._mcMap.createEmptyMovieClip("_mcXtra",200);
		this._mcXtra = this._mcMap._mcXtra;
		this._ldrMap.addEventListener("initialization",this);
		this._btnNW.addEventListener("click",this);
		this._btnN.addEventListener("click",this);
		this._btnNE.addEventListener("click",this);
		this._btnW.addEventListener("click",this);
		this._btnE.addEventListener("click",this);
		this._btnSW.addEventListener("click",this);
		this._btnS.addEventListener("click",this);
		this._btnSE.addEventListener("click",this);
		this._btnLocateClick.addEventListener("click",this);
		this._btnNW.addEventListener("over",this);
		this._btnN.addEventListener("over",this);
		this._btnNE.addEventListener("over",this);
		this._btnW.addEventListener("over",this);
		this._btnE.addEventListener("over",this);
		this._btnSW.addEventListener("over",this);
		this._btnS.addEventListener("over",this);
		this._btnSE.addEventListener("over",this);
		this._btnNW.addEventListener("out",this);
		this._btnN.addEventListener("out",this);
		this._btnNE.addEventListener("out",this);
		this._btnW.addEventListener("out",this);
		this._btnE.addEventListener("out",this);
		this._btnSW.addEventListener("out",this);
		this._btnS.addEventListener("out",this);
		this._btnSE.addEventListener("out",this);
		this.applyInteractionMode();
	}
	function arrange()
	{
		var var2 = this.__width - 2;
		var var3 = this.__height - 2;
		var var4 = var2 / 3;
		var var5 = var3 / 3;
		var var6 = var2 - this._nButtonMargin * 2 - 2;
		var var7 = var3 - this._nButtonMargin * 2 - 2;
		this._mcBorder._width = this.__width;
		this._mcBorder._height = this.__height;
		this._btnNW.setSize(var4,var5);
		this._btnN.setSize(var4 - 2,var5);
		this._btnNE.setSize(var4,var5);
		this._btnW.setSize(var4,var5 - 2);
		this._btnE.setSize(var4,var5 - 2);
		this._btnSW.setSize(var4,var5);
		this._btnS.setSize(var4 - 2,var5);
		this._btnSE.setSize(var4,var5);
		this._btnNW._x = this._btnW._x = this._btnSW._x = 1;
		this._btnN._x = this._btnS._x = var4 + 2;
		this._btnNE._x = this._btnE._x = this._btnSE._x = var4 * 2 + 1;
		this._btnNW._y = this._btnN._y = this._btnNE._y = 1;
		this._btnW._y = this._btnE._y = var5 + 2;
		this._btnSW._y = this._btnS._y = this._btnSE._y = var5 * 2 + 1;
		this._mcMapBorder._width = var6 + 2;
		this._mcMapBorder._height = var7 + 2;
		this._mcMapBorder._x = this._mcMapBorder._y = this._nButtonMargin + 1;
		this._mcMask._width = this._mcMapBackground._width = var6;
		this._mcMask._height = this._mcMapBackground._height = var7;
		this._btnLocateClick._x = this._btnLocateClick._y = this._mcMask._x = this._mcMask._y = this._mcMapBackground._x = this._mcMapBackground._y = this._nButtonMargin + 2;
		this._mcMap._x = this.__width / 2;
		this._mcMap._y = this.__height / 2;
		this._mcGrid._x = (- this.__width) / 2 + this._nButtonMargin + 2;
		this._mcGrid._y = (- this.__height) / 2 + this._nButtonMargin + 2;
		this._btnLocateClick.setSize(var6,var7);
		this._nMapWidth = this.__width - this._nButtonMargin * 2 - 4;
		this._nMapHeight = this.__height - this._nButtonMargin * 2 - 4;
		this.setZoom();
		this.setMapPosition(0,0);
	}
	function draw()
	{
		var var2 = this.getStyle();
		this._btnNW.styleName = this._btnN.styleName = this._btnNE.styleName = this._btnW.styleName = this._btnE.styleName = this._btnSW.styleName = this._btnS.styleName = this._btnSE.styleName = var2.buttonstyle;
		this.setMovieClipColor(this._mcBorder,var2.bordercolor);
		this.setMovieClipColor(this._mcMapBorder,var2.bordercolor);
		this.setMovieClipColor(this._mcGrid,var2.gridcolor);
		this.setMovieClipColor(this._mcMapBackground,var2.bgcolor);
	}
	function drawGrid(var2)
	{
		if(var2 == undefined)
		{
			var2 = true;
		}
		this._mcGrid.clear();
		if(this._bShowGrid && var2)
		{
			var var3 = (this._nMapWidth - this.virtualWPage) / 2;
			while(var3 > 0)
			{
				this.drawRoundRect(this._mcGrid,var3,0,1,this._nMapHeight,0,0);
				var3 = var3 - this.virtualWPage;
			}
			var3 = (this._nMapWidth + this.virtualWPage) / 2;
			while(var3 < this._nMapWidth)
			{
				this.drawRoundRect(this._mcGrid,var3,0,1,this._nMapHeight,0,0);
				var3 = var3 + this.virtualWPage;
			}
			var var4 = (this._nMapHeight - this.virtualHPage) / 2;
			while(var4 > 0)
			{
				this.drawRoundRect(this._mcGrid,0,var4,this._nMapWidth,1,0,0);
				var4 = var4 - this.virtualHPage;
			}
			var4 = (this._nMapHeight + this.virtualHPage) / 2;
			while(var4 < this._nMapHeight)
			{
				this.drawRoundRect(this._mcGrid,0,var4,this._nMapWidth,1,0,0);
				var4 = var4 + this.virtualHPage;
			}
		}
	}
	function setZoom()
	{
		this.setMapPosition(this._nXCurrent,this._nYCurrent);
		this.drawGrid(true);
		this.dispatchEvent({type:"zoom"});
	}
	function moveMap(var2, var3)
	{
		this.setMapPosition(this._nXCurrent + var2,this._nYCurrent + var3);
	}
	function applyInteractionMode()
	{
		delete this._oLastCoordsOver;
		switch(this._sInteractionMode)
		{
			case "move":
				this._btnNW.enabled = true;
				this._btnN.enabled = true;
				this._btnNE.enabled = true;
				this._btnW.enabled = true;
				this._btnE.enabled = true;
				this._btnSW.enabled = true;
				this._btnS.enabled = true;
				this._btnSE.enabled = true;
				break;
			default:
				switch(null)
				{
					case "zoom-":
					case "select":
				}
				break;
			case "zoom+":
				this._btnNW.enabled = false;
				this._btnN.enabled = false;
				this._btnNE.enabled = false;
				this._btnW.enabled = false;
				this._btnE.enabled = false;
				this._btnSW.enabled = false;
				this._btnS.enabled = false;
				this._btnSE.enabled = false;
		}
	}
	function getRealFromCoordinates(var2, var3)
	{
		var var4 = this.virtualWPage * (var2 - this._nXCurrent - 0.5);
		var var5 = this.virtualHPage * (var3 - this._nYCurrent - 0.5);
		return {x:var4,y:var5};
	}
	function getCoordinatesFromReal(var2, var3)
	{
		var var4 = Math.floor((var2 + this.virtualWPage * 0.5) / this.virtualWPage) + this._nXCurrent;
		var var5 = Math.floor((var3 + this.virtualHPage * 0.5) / this.virtualHPage) + this._nYCurrent;
		return {x:var4,y:var5};
	}
	function getCoordinatesFromRealWithRef(var2, var3)
	{
		var var4 = Math.floor((var2 + this.virtualWPage * 0.5) / this.virtualWPage) - this._nXRefPress;
		var var5 = Math.floor((var3 + this.virtualHPage * 0.5) / this.virtualHPage) - this._nYRefPress;
		return {x:var4,y:var5};
	}
	function onMouseDown()
	{
		if(this._sInteractionMode == "move")
		{
			if(this._mcMapBackground.hitTest(_root._xmouse,_root._ymouse,true))
			{
				delete this._oLastCoordsOver;
				var var2 = this.getCoordinatesFromReal(this._ldrMap._xmouse,this._ldrMap._ymouse);
				this._nXRefPress = var2.x;
				this._nYRefPress = var2.y;
				this.gapi.hideTooltip();
				this.gapi.setCursor({iconFile:"MapNavigatorMoveCursor"});
			}
		}
	}
	function onMouseUp()
	{
		delete this._nXRefPress;
		delete this._nYRefPress;
		this.gapi.removeCursor();
		if(this._mcMapBackground.hitTest(_root._xmouse,_root._ymouse,true))
		{
			if(this._bTimerEnable != true)
			{
				this._bTimerEnable = true;
				ank.utils.Timer.setTimer(this,"mapnavigator",this,this.onClickTimer,ank.gapi.Gapi.DBLCLICK_DELAY);
			}
			else
			{
				this.onClickTimer();
				var var2 = this._ldrMap._xmouse;
				var var3 = this._ldrMap._ymouse;
				var var4 = this.getCoordinatesFromReal(var2,var3);
				this.dispatchEvent({type:"doubleClick",coordinates:var4});
			}
		}
	}
	function onMouseMove()
	{
		if(this._mcMapBackground.hitTest(_root._xmouse,_root._ymouse,true))
		{
			var var2 = this._ldrMap._xmouse;
			var var3 = this._ldrMap._ymouse;
			if(this._nXRefPress == undefined)
			{
				var var4 = this.getCoordinatesFromReal(var2,var3);
				if(this._oLastCoordsOver.x != var4.x || this._oLastCoordsOver.y != var4.y)
				{
					var var5 = this.getRealFromCoordinates(var4.x,var4.y);
					this._ldrMap.localToGlobal(var5);
					this.gapi.showTooltip(var4.x + ", " + var4.y,var5.x,var5.y - 20);
					this.dispatchEvent({type:"overMap",coordinates:var4});
					this._sLastMapEvent = "overMap";
					this._oLastCoordsOver = var4;
				}
			}
			else
			{
				var var6 = this.getCoordinatesFromRealWithRef(var2,var3);
				this.setMapPosition(- var6.x,- var6.y);
			}
		}
		else if(this._sLastMapEvent != "outMap")
		{
			this.dispatchEvent({type:"outMap"});
			this._sLastMapEvent = "outMap";
			this.gapi.hideTooltip();
		}
	}
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
		{
			case "_btnNW":
				this.moveMap(-1,-1);
				break;
			case "_btnN":
				this.moveMap(0,-1);
				break;
			case "_btnNE":
				this.moveMap(1,-1);
				break;
			default:
				switch(null)
				{
					case "_btnW":
						this.moveMap(-1,0);
						break loop0;
					case "_btnE":
						this.moveMap(1,0);
						break loop0;
					case "_btnSW":
						this.moveMap(-1,1);
						break loop0;
					case "_btnS":
						this.moveMap(0,1);
						break loop0;
					case "_btnSE":
						this.moveMap(1,1);
						break loop0;
					default:
						if(var0 !== "_btnLocateClick")
						{
							break loop0;
						}
						var var3 = this._ldrMap._xmouse;
						var var4 = this._ldrMap._ymouse;
						var var5 = this.getCoordinatesFromReal(var3,var4);
						switch(this._sInteractionMode)
						{
							case "zoom+":
							case "zoom-":
								var var6 = this._nZoom + (this._sInteractionMode == "zoom+"?5:-5);
								if(var6 == 0)
								{
									var6 = 5;
								}
								this._nZoom = var6;
								this.setZoom();
								break;
							case "select":
								this.dispatchEvent({type:"select",coordinates:var5});
						}
						break loop0;
				}
		}
		this.gapi.hideTooltip();
	}
	function over(var2)
	{
		this.dispatchEvent(var2);
	}
	function out(var2)
	{
		this.dispatchEvent(var2);
	}
	function initialization(var2)
	{
		this.setZoom();
	}
	function onLoadInit(var2)
	{
		this.dispatchEvent({type:"xtraLayerLoad",mc:var2});
	}
	function onClickTimer()
	{
		ank.utils.Timer.removeTimer(this,"mapnavigator");
		this._bTimerEnable = false;
	}
}
