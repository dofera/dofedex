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
	function __set__buttonMargin(loc2)
	{
		this._nButtonMargin = Number(loc2);
		return this.__get__buttonMargin();
	}
	function __get__buttonMargin()
	{
		return this._nButtonMargin;
	}
	function __set__showGrid(loc2)
	{
		this._bShowGrid = loc2;
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
	function __set__wPage(loc2)
	{
		this._nWPage = loc2;
		return this.__get__wPage();
	}
	function __get__wPage()
	{
		return this._nWPage;
	}
	function __set__hPage(loc2)
	{
		this._nHPage = loc2;
		return this.__get__hPage();
	}
	function __get__hPage()
	{
		return this._nHPage;
	}
	function __set__zoom(loc2)
	{
		if(_global.isNaN(loc2))
		{
			return undefined;
		}
		if(loc2 > 100)
		{
			loc2 = 100;
		}
		if(loc2 < 10)
		{
			loc2 = 10;
		}
		this._nZoom = loc2;
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
	function __set__interactionMode(loc2)
	{
		this._sInteractionMode = loc2;
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
	function setMapPosition(loc2, loc3)
	{
		this._mcXtra._xscale = this._mcXtra._yscale = this._nZoom;
		if(loc2 == undefined || loc3 == undefined)
		{
			return undefined;
		}
		this.removeAreaClip();
		this._nXCurrent = loc2;
		this._nYCurrent = loc3;
		var loc4 = this._ldrMap.content;
		loc4._x = this._mcXtra._x = (- this.virtualWPage) * (0.5 + loc2);
		loc4._y = this._mcXtra._y = (- this.virtualHPage) * (0.5 + loc3);
		var loc5 = 15;
		var loc6 = 15;
		var loc7 = Math.floor(loc2 - this._nMapWidth / (2 * this.virtualWPage) + 0.5);
		var loc8 = Math.floor(loc3 - this._nMapHeight / (2 * this.virtualHPage) + 0.5);
		var loc9 = Math.floor(loc7 / loc5);
		var loc10 = Math.floor(loc8 / loc6);
		var loc11 = loc9 + Math.ceil(Math.floor(this._nMapWidth / this.virtualWPage) / loc5);
		var loc12 = loc10 + Math.ceil(Math.floor(this._nMapHeight / this.virtualHPage) / loc6);
		for(var k in this._ldrMap.content)
		{
			this._ldrMap.content[k].removeMovieClip();
		}
		var loc13 = loc9;
		while(loc13 <= loc11)
		{
			var loc14 = loc10;
			while(loc14 <= loc12)
			{
				this._ldrMap.content.attachMovie(loc13 + "_" + loc14,loc13 + "_" + loc14,this._ldrMap.content.getNextHighestDepth(),{_yscale:this._nZoom,_xscale:this._nZoom,_x:loc13 * loc5 * this.virtualWPage,_y:loc14 * loc6 * this.virtualHPage});
				loc14 = loc14 + 1;
			}
			loc13 = loc13 + 1;
		}
	}
	function addSubareaClip(loc2, loc3, loc4)
	{
		if(loc2 == this._nLastSubAreaID)
		{
			return undefined;
		}
		this.removeAreaClip();
		var loc5 = this._ldrMap.content.attachMovie("subarea_" + loc2,"_mcSubarea",this._ldrMap.content.getNextHighestDepth());
		var loc6 = new Color(loc5);
		loc6.setRGB(loc3);
		loc5._alpha = loc4;
		loc5._xscale = loc5._yscale = this._nZoom;
		this._nLastSubAreaID = loc2;
	}
	function removeAreaClip()
	{
		this._ldrMap.content._mcSubarea.removeMovieClip();
		delete this._nLastSubAreaID;
	}
	function addXtraClip(loc2, loc3, loc4, loc5, loc6, loc7, loc8, loc9)
	{
		var loc10 = this._mcXtra[loc3]["clipByCoord_" + loc4 + "_" + loc5];
		if(loc9 == true && loc10 != undefined)
		{
			return loc10;
		}
		var loc11 = this._nWPage * (0.5 + loc4);
		var loc12 = this._nHPage * (0.5 + loc5);
		var loc13 = this._mcXtra.getNextHighestDepth();
		var loc14 = this._mcXtra[loc3];
		if(loc14 == undefined)
		{
			loc14 = this._mcXtra.createEmptyMovieClip(loc3,loc13);
		}
		loc13 = loc14.getNextHighestDepth();
		var loc15 = loc14.attachMovie(loc2,"clip" + loc13,loc13,{_x:loc11,_y:loc12});
		this._mcXtra[loc3]["clipByCoord_" + loc4 + "_" + loc5] = loc15;
		if(loc6 != undefined)
		{
			var loc16 = new Color(loc15._mcColor);
			loc16.setRGB(loc6);
		}
		if(loc8)
		{
			loc15.mn = this;
			loc15.onRelease = function()
			{
				this.mn.click({target:this.mn._btnLocateClick});
			};
		}
		loc15._alpha = loc7 != undefined?loc7:100;
		return loc15;
	}
	function loadXtraLayer(loc2, loc3)
	{
		var loc4 = this.createXtraLayer(loc3);
		var loc5 = new MovieClipLoader();
		loc5.addListener(this);
		loc5.loadClip(loc2,loc4);
	}
	function createXtraLayer(loc2)
	{
		var loc3 = this._mcXtra.getNextHighestDepth();
		var loc4 = this._mcXtra[loc2];
		if(loc4 == undefined)
		{
			loc4 = this._mcXtra.createEmptyMovieClip(loc2,loc3);
		}
		return loc4;
	}
	function getXtraLayer(loc2)
	{
		return this._mcXtra[loc2];
	}
	function clear(loc2)
	{
		if(loc2 != undefined)
		{
			this._mcXtra[loc2].removeMovieClip();
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
		var loc2 = {styleName:"none",backgroundDown:"ButtonSimpleRectangleUpDown",backgroundUp:"ButtonSimpleRectangleUpDown"};
		this.attachMovie("Rectangle","_mcBorder",0);
		this.attachMovie("Button","_btnNW",10,loc2);
		this.attachMovie("Button","_btnN",20,loc2);
		this.attachMovie("Button","_btnNE",30,loc2);
		this.attachMovie("Button","_btnW",40,loc2);
		this.attachMovie("Button","_btnE",50,loc2);
		this.attachMovie("Button","_btnSW",60,loc2);
		this.attachMovie("Button","_btnS",70,loc2);
		this.attachMovie("Button","_btnSE",80,loc2);
		this.attachMovie("Button","_btnLocateClick",90,loc2);
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
		var loc2 = this.__width - 2;
		var loc3 = this.__height - 2;
		var loc4 = loc2 / 3;
		var loc5 = loc3 / 3;
		var loc6 = loc2 - this._nButtonMargin * 2 - 2;
		var loc7 = loc3 - this._nButtonMargin * 2 - 2;
		this._mcBorder._width = this.__width;
		this._mcBorder._height = this.__height;
		this._btnNW.setSize(loc4,loc5);
		this._btnN.setSize(loc4 - 2,loc5);
		this._btnNE.setSize(loc4,loc5);
		this._btnW.setSize(loc4,loc5 - 2);
		this._btnE.setSize(loc4,loc5 - 2);
		this._btnSW.setSize(loc4,loc5);
		this._btnS.setSize(loc4 - 2,loc5);
		this._btnSE.setSize(loc4,loc5);
		this._btnNW._x = this._btnW._x = this._btnSW._x = 1;
		this._btnN._x = this._btnS._x = loc4 + 2;
		this._btnNE._x = this._btnE._x = this._btnSE._x = loc4 * 2 + 1;
		this._btnNW._y = this._btnN._y = this._btnNE._y = 1;
		this._btnW._y = this._btnE._y = loc5 + 2;
		this._btnSW._y = this._btnS._y = this._btnSE._y = loc5 * 2 + 1;
		this._mcMapBorder._width = loc6 + 2;
		this._mcMapBorder._height = loc7 + 2;
		this._mcMapBorder._x = this._mcMapBorder._y = this._nButtonMargin + 1;
		this._mcMask._width = this._mcMapBackground._width = loc6;
		this._mcMask._height = this._mcMapBackground._height = loc7;
		this._btnLocateClick._x = this._btnLocateClick._y = this._mcMask._x = this._mcMask._y = this._mcMapBackground._x = this._mcMapBackground._y = this._nButtonMargin + 2;
		this._mcMap._x = this.__width / 2;
		this._mcMap._y = this.__height / 2;
		this._mcGrid._x = (- this.__width) / 2 + this._nButtonMargin + 2;
		this._mcGrid._y = (- this.__height) / 2 + this._nButtonMargin + 2;
		this._btnLocateClick.setSize(loc6,loc7);
		this._nMapWidth = this.__width - this._nButtonMargin * 2 - 4;
		this._nMapHeight = this.__height - this._nButtonMargin * 2 - 4;
		this.setZoom();
		this.setMapPosition(0,0);
	}
	function draw()
	{
		var loc2 = this.getStyle();
		this._btnNW.styleName = this._btnN.styleName = this._btnNE.styleName = this._btnW.styleName = this._btnE.styleName = this._btnSW.styleName = this._btnS.styleName = this._btnSE.styleName = loc2.buttonstyle;
		this.setMovieClipColor(this._mcBorder,loc2.bordercolor);
		this.setMovieClipColor(this._mcMapBorder,loc2.bordercolor);
		this.setMovieClipColor(this._mcGrid,loc2.gridcolor);
		this.setMovieClipColor(this._mcMapBackground,loc2.bgcolor);
	}
	function drawGrid(loc2)
	{
		if(loc2 == undefined)
		{
			loc2 = true;
		}
		this._mcGrid.clear();
		if(this._bShowGrid && loc2)
		{
			var loc3 = (this._nMapWidth - this.virtualWPage) / 2;
			while(loc3 > 0)
			{
				this.drawRoundRect(this._mcGrid,loc3,0,1,this._nMapHeight,0,0);
				loc3 = loc3 - this.virtualWPage;
			}
			loc3 = (this._nMapWidth + this.virtualWPage) / 2;
			while(loc3 < this._nMapWidth)
			{
				this.drawRoundRect(this._mcGrid,loc3,0,1,this._nMapHeight,0,0);
				loc3 = loc3 + this.virtualWPage;
			}
			var loc4 = (this._nMapHeight - this.virtualHPage) / 2;
			while(loc4 > 0)
			{
				this.drawRoundRect(this._mcGrid,0,loc4,this._nMapWidth,1,0,0);
				loc4 = loc4 - this.virtualHPage;
			}
			loc4 = (this._nMapHeight + this.virtualHPage) / 2;
			while(loc4 < this._nMapHeight)
			{
				this.drawRoundRect(this._mcGrid,0,loc4,this._nMapWidth,1,0,0);
				loc4 = loc4 + this.virtualHPage;
			}
		}
	}
	function setZoom()
	{
		this.setMapPosition(this._nXCurrent,this._nYCurrent);
		this.drawGrid(true);
		this.dispatchEvent({type:"zoom"});
	}
	function moveMap(loc2, loc3)
	{
		this.setMapPosition(this._nXCurrent + loc2,this._nYCurrent + loc3);
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
	function getRealFromCoordinates(loc2, loc3)
	{
		var loc4 = this.virtualWPage * (loc2 - this._nXCurrent - 0.5);
		var loc5 = this.virtualHPage * (loc3 - this._nYCurrent - 0.5);
		return {x:loc4,y:loc5};
	}
	function getCoordinatesFromReal(loc2, loc3)
	{
		var loc4 = Math.floor((loc2 + this.virtualWPage * 0.5) / this.virtualWPage) + this._nXCurrent;
		var loc5 = Math.floor((loc3 + this.virtualHPage * 0.5) / this.virtualHPage) + this._nYCurrent;
		return {x:loc4,y:loc5};
	}
	function getCoordinatesFromRealWithRef(loc2, loc3)
	{
		var loc4 = Math.floor((loc2 + this.virtualWPage * 0.5) / this.virtualWPage) - this._nXRefPress;
		var loc5 = Math.floor((loc3 + this.virtualHPage * 0.5) / this.virtualHPage) - this._nYRefPress;
		return {x:loc4,y:loc5};
	}
	function onMouseDown()
	{
		if(this._sInteractionMode == "move")
		{
			if(this._mcMapBackground.hitTest(_root._xmouse,_root._ymouse,true))
			{
				delete this._oLastCoordsOver;
				var loc2 = this.getCoordinatesFromReal(this._ldrMap._xmouse,this._ldrMap._ymouse);
				this._nXRefPress = loc2.x;
				this._nYRefPress = loc2.y;
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
				var loc2 = this._ldrMap._xmouse;
				var loc3 = this._ldrMap._ymouse;
				var loc4 = this.getCoordinatesFromReal(loc2,loc3);
				this.dispatchEvent({type:"doubleClick",coordinates:loc4});
			}
		}
	}
	function onMouseMove()
	{
		if(this._mcMapBackground.hitTest(_root._xmouse,_root._ymouse,true))
		{
			var loc2 = this._ldrMap._xmouse;
			var loc3 = this._ldrMap._ymouse;
			if(this._nXRefPress == undefined)
			{
				var loc4 = this.getCoordinatesFromReal(loc2,loc3);
				if(this._oLastCoordsOver.x != loc4.x || this._oLastCoordsOver.y != loc4.y)
				{
					var loc5 = this.getRealFromCoordinates(loc4.x,loc4.y);
					this._ldrMap.localToGlobal(loc5);
					this.gapi.showTooltip(loc4.x + ", " + loc4.y,loc5.x,loc5.y - 20);
					this.dispatchEvent({type:"overMap",coordinates:loc4});
					this._sLastMapEvent = "overMap";
					this._oLastCoordsOver = loc4;
				}
			}
			else
			{
				var loc6 = this.getCoordinatesFromRealWithRef(loc2,loc3);
				this.setMapPosition(- loc6.x,- loc6.y);
			}
		}
		else if(this._sLastMapEvent != "outMap")
		{
			this.dispatchEvent({type:"outMap"});
			this._sLastMapEvent = "outMap";
			this.gapi.hideTooltip();
		}
	}
	function click(loc2)
	{
		loop0:
		switch(loc2.target._name)
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
					default:
						switch(null)
						{
							case "_btnSE":
								this.moveMap(1,1);
								break;
							case "_btnLocateClick":
								var loc3 = this._ldrMap._xmouse;
								var loc4 = this._ldrMap._ymouse;
								var loc5 = this.getCoordinatesFromReal(loc3,loc4);
								switch(this._sInteractionMode)
								{
									case "zoom+":
									case "zoom-":
										var loc6 = this._nZoom + (this._sInteractionMode == "zoom+"?5:-5);
										if(loc6 == 0)
										{
											loc6 = 5;
										}
										this._nZoom = loc6;
										this.setZoom();
										break;
									case "select":
										this.dispatchEvent({type:"select",coordinates:loc5});
								}
						}
				}
		}
		this.gapi.hideTooltip();
	}
	function over(loc2)
	{
		this.dispatchEvent(loc2);
	}
	function out(loc2)
	{
		this.dispatchEvent(loc2);
	}
	function initialization(loc2)
	{
		this.setZoom();
	}
	function onLoadInit(loc2)
	{
		this.dispatchEvent({type:"xtraLayerLoad",mc:loc2});
	}
	function onClickTimer()
	{
		ank.utils.Timer.removeTimer(this,"mapnavigator");
		this._bTimerEnable = false;
	}
}
