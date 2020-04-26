class dofus.graphics.gapi.controls.MiniMap extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MiniMap";
	static var HIDE_FLAG_ZONE = [[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,0,0,1,0,0,1],[1,0,0,0,0,0,1],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,1],[1,0,0,0,0,0,1],[1,1,0,0,0,1,1]];
	static var MAP_IMG_WIDTH = 15;
	static var MAP_IMG_HEIGHT = 15;
	var _aFlags = new Array();
	var _nMapScale = 40;
	var _nTileWidth = 40;
	var _nTileHeight = 23;
	function MiniMap()
	{
		super();
	}
	function updateFlags()
	{
		this.updateDataMap();
		if(this._oMap.x == undefined || this._oMap.y == undefined)
		{
			this.addToQueue({object:this,method:this.updateFlags});
			return undefined;
		}
		this.clearFlag();
		if(this.api.datacenter.Basics.banner_targetCoords)
		{
			this.addFlag(this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1],255);
		}
		if(this.api.datacenter.Basics.aks_infos_highlightCoords.length)
		{
			var loc2 = this.api.datacenter.Basics.aks_infos_highlightCoords;
			for(var i in loc2)
			{
				if(!loc2[i])
				{
					continue;
				}
				if(loc2[i].miniMapTagId == undefined)
				{
					loc2[i].miniMapTagId = this._nRandomTag;
				}
				if(loc2[i].miniMapTagId != this._nRandomTag)
				{
					delete register2.i;
					continue;
				}
				switch(loc2[i].type)
				{
					case 1:
						if(!loc3)
						{
							var loc3 = loc2[i];
						}
						else
						{
							var loc4 = Math.sqrt(Math.pow(loc3.x - this._oMap.x,2) + Math.pow(loc3.y - this._oMap.y,2));
							var loc5 = Math.sqrt(Math.pow(loc2[i].x - this._oMap.x,2) + Math.pow(loc2[i].y - this._oMap.y,2));
							if(loc5 < loc4)
							{
								loc3 = loc2[i];
							}
						}
						continue;
					case 2:
						var loc6 = _global.API.ui.getUIComponent("Party").getMemberById(loc2[i].playerID).name;
						if(loc6 == undefined)
						{
							delete register2.i;
						}
						else
						{
							this.addFlag(loc2[i].x,loc2[i].y,dofus.Constants.FLAG_MAP_GROUP,loc6);
						}
						continue;
					case 3:
						this.addFlag(loc2[i].x,loc2[i].y,dofus.Constants.FLAG_MAP_SEEK,loc2[i].playerName);
						continue;
					default:
						continue;
				}
			}
			if(loc3)
			{
				this.addFlag(loc3.x,loc3.y,dofus.Constants.FLAG_MAP_PHOENIX,this.api.lang.getText("BANNER_MAP_PHOENIX"));
			}
		}
	}
	function clearFlag()
	{
		for(var i in this._mcFlagsDirection)
		{
			this._mcFlagsDirection[i].removeMovieClip();
		}
		for(var i in this._mcFlagsContainer)
		{
			this._mcFlagsContainer[i].removeMovieClip();
		}
		this._aFlags = new Array();
	}
	function addFlag(loc2, loc3, loc4, loc5)
	{
		if(_global.isNaN(loc2) || _global.isNaN(loc3))
		{
			return undefined;
		}
		var loc6 = this._mcFlagsDirection.getNextHighestDepth();
		var loc7 = this._mcFlagsDirection.attachMovie("FlagDirection","dir" + loc6,loc6);
		loc7.stop();
		var loc8 = (loc4 & 16711680) >> 16;
		var loc9 = (loc4 & 65280) >> 8;
		var loc10 = loc4 & 255;
		var loc11 = new Color(loc7._mcCursor._mc._mcColor);
		var loc12 = new Object();
		loc12 = {ra:0,ga:0,ba:0,rb:loc8,gb:loc9,bb:loc10};
		loc11.setTransform(loc12);
		if(!this._mcFlagsContainer)
		{
			this._mcFlagsContainer = this._mcFlags.createEmptyMovieClip("_mcFlagsContainer",1);
		}
		var loc13 = this._nMapScale / 100 * this._nTileWidth;
		var loc14 = this._nMapScale / 100 * this._nTileHeight;
		loc6 = this._mcFlagsContainer.getNextHighestDepth();
		var loc15 = this._mcFlagsContainer.attachMovie("UI_MapExplorerFlag","flag" + loc6,loc6);
		loc15._x = loc13 * loc2 + loc13 / 2;
		loc15._y = loc14 * loc3 + loc14 / 2;
		loc15._xscale = this._nMapScale;
		loc15._yscale = this._nMapScale;
		loc11 = new Color(loc15._mcColor);
		loc12 = new Object();
		loc12 = {ra:0,ga:0,ba:0,rb:loc8,gb:loc9,bb:loc10};
		loc11.setTransform(loc12);
		this._aFlags.push({x:loc2,y:loc3,color:loc4,mcDirection:loc7});
		loc7.tooltipText = loc2 + "," + loc3 + (!loc5.length?"":" (" + loc5 + ")");
		loc15.tooltipText = loc7.tooltipText;
		loc15.gapi = this.gapi;
		loc7.gapi = this.gapi;
		loc7.mcTarget = loc7._mcCursor;
		loc15.mcTarget = loc15;
		loc7.onRollOver = loc15.onRollOver = function()
		{
			this.gapi.showTooltip(this.tooltipText,this,-20,{bXLimit:false,bYLimit:false});
		};
		loc7.onRollOut = loc15.onRollOut = function()
		{
			this.gapi.hideTooltip();
		};
		this.updateMap();
	}
	function updateHints()
	{
		if(_global.isNaN(this.dungeonID))
		{
			var loc2 = this.api.lang.getHintsCategories();
			loc2[-1] = {n:this.api.lang.getText("OPTION_GRID"),c:"Yellow"};
			var loc3 = this.api.kernel.OptionsManager.getOption("MapFilters");
			this._mcHintsContainer = this._ldrHints.content;
			var loc4 = -1;
			while(loc4 < loc2.length)
			{
				if(loc4 != -1)
				{
					this.showHintsCategory(loc4,loc3[loc4] == 1);
				}
				loc4 = loc4 + 1;
			}
		}
	}
	function __get__dungeonID()
	{
		return Number(this.api.lang.getMapText(this.api.datacenter.Map.id).d);
	}
	function __get__dungeonCurrentMap()
	{
		return this.dungeon.m[this.api.datacenter.Map.id];
	}
	function __get__dungeon()
	{
		return this.api.lang.getDungeonText(this.dungeonID);
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.MiniMap.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.loadMap});
		this.addToQueue({object:this,method:this.updateFlags});
		this._nRandomTag = Math.random();
	}
	function addListeners()
	{
		this.api.gfx.addEventListener("mapLoaded",this);
		this._ldrBitmapMap.addEventListener("initialization",this);
	}
	function initMap()
	{
		this._mcBitmapContainer.removeMovieClip();
		this._mcBitmapContainer = this._ldrBitmapMap.content.createEmptyMovieClip("_mcBitmapContainer",1);
		this._mcBitmapContainer._visible = false;
		if(this.api.datacenter.Player.isAuthorized)
		{
			this._mcBitmapContainer.onMouseUp = this.onMouseUp;
			this._mcBitmapContainer.onRelease = function()
			{
			};
		}
		else
		{
			this._mcBitmapContainer.onRelease = this.click;
		}
		this._mcCursor._xscale = this._nMapScale;
		this._mcCursor._yscale = this._nMapScale;
		this._mcCursor.oMap = this._oMap;
		this._mcCursor.gapi = this.gapi;
		this._mcCursor.onRollOver = function()
		{
			this.gapi.showTooltip(this.oMap.x + "," + this.oMap.y,this,-20,{bXLimit:false,bYLimit:false});
		};
		this._mcCursor.onRollOut = function()
		{
			this.gapi.hideTooltip();
		};
		this.updateMap();
		this.updateHints();
	}
	function drawMap()
	{
		var loc2 = -10;
		while(loc2 < 10)
		{
			var loc3 = -10;
			while(loc3 < 10)
			{
				var loc4 = Math.floor(this._oMap.x / dofus.graphics.gapi.controls.MiniMap.MAP_IMG_WIDTH);
				var loc5 = Math.floor(this._oMap.y / dofus.graphics.gapi.controls.MiniMap.MAP_IMG_HEIGHT);
				if(loc4 < loc2 - 2 || (loc4 > loc2 + 2 || (loc5 < loc3 - 2 || loc5 > loc3 + 2)))
				{
					if(this._mcBitmapContainer[loc2 + "_" + loc3] != undefined)
					{
						this._mcBitmapContainer[loc2 + "_" + loc3].removeMovieClip();
					}
				}
				else if(this._mcBitmapContainer[loc2 + "_" + loc3] == undefined)
				{
					var loc6 = this._mcBitmapContainer.attachMovie(loc2 + "_" + loc3,loc2 + "_" + loc3,this._mcBitmapContainer.getNextHighestDepth());
					loc6._xscale = this._nMapScale;
					loc6._yscale = this._nMapScale;
					loc6._x = loc6._width * loc2;
					loc6._y = loc6._height * loc3;
				}
				loc3 = loc3 + 1;
			}
			loc2 = loc2 + 1;
		}
	}
	function initDungeon()
	{
		this._mcBitmapContainer.removeMovieClip();
		this._mcBitmapContainer = this._ldrBitmapMap.createEmptyMovieClip("_mcDongeonContainer",1);
		this._mcBg.onRelease = this.click;
		this._mcCursor._xscale = this._nMapScale;
		this._mcCursor._yscale = this._nMapScale;
		var loc2 = this.dungeon.m;
		var loc3 = this.dungeonCurrentMap;
		var loc4 = 0;
		for(var a in loc2)
		{
			var loc5 = loc2[a];
			if(loc3.z == loc5.z)
			{
				loc4;
				var loc6 = this._mcBitmapContainer.attachMovie("UI_MapExplorerRectangle","dungeonMap" + loc4,loc4++);
				loc6._xscale = this._nMapScale;
				loc6._yscale = this._nMapScale;
				loc6._x = loc6._width * loc5.x + loc6._width / 2 + 1;
				loc6._y = loc6._height * loc5.y + loc6._height / 2 + 1;
				if(loc5.n != undefined)
				{
					loc6.label = loc5.n + " (" + loc5.x + "," + loc5.y + ")";
					loc6.gapi = this.gapi;
					loc6.onRollOver = function()
					{
						this.gapi.showTooltip(this.label,this,-20,{bXLimit:false,bYLimit:false});
					};
					loc6.onRollOut = function()
					{
						this.gapi.hideTooltip();
					};
				}
			}
		}
	}
	function loadMap(loc2)
	{
		if(this._oMap.superarea == undefined)
		{
			this.addToQueue({object:this,method:this.loadMap,params:[loc2]});
			return false;
		}
		if(_global.isNaN(this.dungeonID))
		{
			if(this._oMap.superarea !== this._nCurrentArea || loc2)
			{
				this._nCurrentArea = this._oMap.superarea;
				this._ldrBitmapMap.contentPath = dofus.Constants.LOCAL_MAPS_PATH + this._nCurrentArea + ".swf";
				return true;
			}
			return false;
		}
		this.initDungeon();
		this._nCurrentArea = -1;
	}
	function showHintsCategory(categoryID, §\x16\x06§)
	{
		var loc4 = this.api.kernel.OptionsManager.getOption("MapFilters");
		loc4[categoryID] = loc3;
		this.api.kernel.OptionsManager.setOption("MapFilters",loc4);
		var loc5 = "hints" + categoryID;
		if(!this._mcHintsContainer[loc5])
		{
			this._mcHintsContainer.createEmptyMovieClip(loc5,categoryID);
		}
		if(loc3)
		{
			var loc6 = this.api.lang.getHintsByCategory(categoryID);
			var loc7 = this._nMapScale / 100 * this._nTileWidth;
			var loc8 = this._nMapScale / 100 * this._nTileHeight;
			var loc9 = 0;
			for(; loc9 < loc6.length; loc9 = loc9 + 1)
			{
				var loc10 = new dofus.datacenter.(loc6[loc9]);
				if(loc10.superAreaID === this._oMap.superarea)
				{
					var loc11 = Math.sqrt(Math.pow(loc10.x - this._oMap.x,2) + Math.pow(loc10.y - this._oMap.y,2));
					if(loc11 > 6)
					{
						this._mcHintsContainer[loc5]["hint" + loc9].removeMovieClip();
						continue;
					}
					if(this._mcHintsContainer[loc5]["hint" + loc9] != undefined)
					{
						continue;
					}
					var loc12 = this._mcHintsContainer[loc5].attachMovie(loc10.gfx,"hint" + loc9,loc9,{_xscale:this._nMapScale,_yscale:this._nMapScale});
					loc12._x = loc7 * loc10.x + loc7 / 2;
					loc12._y = loc8 * loc10.y + loc8 / 2;
					loc12.oHint = loc10;
					loc12.gapi = this.gapi;
					loc12.onRollOver = function()
					{
						this.gapi.showTooltip(this.oHint.x + "," + this.oHint.y + " (" + this.oHint.name + ")",this,-20,{bXLimit:false,bYLimit:false});
					};
					loc12.onRollOut = function()
					{
						this.gapi.hideTooltip();
					};
				}
				else
				{
					this._mcHintsContainer[loc5]["hint" + loc9].removeMovieClip();
				}
			}
		}
		else
		{
			this._ldrHints.content[loc5].removeMovieClip();
		}
	}
	function getConquestAreaList()
	{
		var loc2 = this.api.datacenter.Conquest.worldDatas;
		var loc3 = new Array();
		var loc4 = new String();
		var loc5 = 0;
		while(loc5 < loc2.areas.length)
		{
			if(loc2.areas[loc5].alignment == 1)
			{
				var loc7 = this.api.lang.getText("BONTARIAN_PRISM");
				var loc6 = 420;
			}
			else
			{
				loc7 = this.api.lang.getText("BRAKMARIAN_PRISM");
				loc6 = 421;
			}
			loc3.push({g:loc6,m:loc2.areas[loc5].prism,n:loc7,superAreaID:this.api.lang.getMapAreaText(loc2.areas[loc5].id).a});
			loc5 = loc5 + 1;
		}
		return loc3;
	}
	function updateDataMap()
	{
		if(_global.isNaN(this.dungeonID))
		{
			this._oMap = this.api.datacenter.Map;
			this._mcHintsContainer._visible = true;
			this._mcFlagsContainer._visible = true;
		}
		else
		{
			this._oMap = this.dungeonCurrentMap;
			this._mcHintsContainer._visible = false;
			this._mcFlagsContainer._visible = false;
		}
		this._mcCursor.oMap = this._oMap;
	}
	function updateMap()
	{
		this.updateDataMap();
		this.updateHints();
		var loc2 = this._nMapScale / 100 * this._nTileWidth;
		var loc3 = this._nMapScale / 100 * this._nTileHeight;
		this._mcBitmapContainer._x = (- loc2) * this._oMap.x - loc2 / 2;
		this._mcBitmapContainer._y = (- loc3) * this._oMap.y - loc3 / 2;
		this._mcHintsContainer._x = this._mcBitmapContainer._x;
		this._mcHintsContainer._y = this._mcBitmapContainer._y;
		this._mcFlagsContainer._x = this._mcBitmapContainer._x;
		this._mcFlagsContainer._y = this._mcBitmapContainer._y;
		this.drawMap();
		for(var i in this._aFlags)
		{
			var loc4 = this._aFlags[i].x - this._oMap.x;
			var loc5 = this._aFlags[i].y - this._oMap.y;
			if(!(_global.isNaN(loc5) || _global.isNaN(loc4)))
			{
				if(dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE[loc5 + 6][loc4 + 3] == undefined || dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE[loc5 + 6][loc4 + 3] == 1)
				{
					this._aFlags[i].mcDirection._visible = true;
					var loc6 = Math.floor(Math.atan2(loc5,loc4) / Math.PI * 180);
					if(loc6 < 0)
					{
						loc6 = loc6 + 360;
					}
					if(loc6 > 360)
					{
						loc6 = loc6 - 360;
					}
					this._aFlags[i].mcDirection.gotoAndStop(loc6 + 1);
					this._aFlags[i].mcDirection._mcCursor.gotoAndStop(loc6 + 1);
				}
				else
				{
					this._aFlags[i].mcDirection._visible = false;
				}
			}
		}
		this._mcBitmapContainer._visible = true;
	}
	function onClickTimer(loc2)
	{
		ank.utils.Timer.removeTimer(this,"minimap");
		this._bTimerEnable = false;
		if(loc2)
		{
			this.click();
		}
	}
	function getCoordinatesFromReal(loc2, loc3)
	{
		var loc4 = this._nMapScale / 100 * this._nTileWidth;
		var loc5 = this._nMapScale / 100 * this._nTileHeight;
		var loc6 = Math.floor(loc2 / loc4);
		var loc7 = Math.floor(loc3 / loc5);
		return {x:loc6,y:loc7};
	}
	function mapLoaded(loc2)
	{
		this.updateDataMap();
		if(!this.loadMap())
		{
			this.updateMap();
		}
	}
	function initialization(loc2)
	{
		this.initMap();
	}
	function click()
	{
		var loc2 = new Object();
		loc2.target = _global.API.ui.getUIComponent("Banner").illustration;
		_global.API.ui.getUIComponent("Banner").click(loc2);
	}
	function doubleClick(loc2)
	{
		if(!this.api.datacenter.Game.isFight && _global.isNaN(this.dungeonID))
		{
			var loc3 = loc2.coordinates.x;
			var loc4 = loc2.coordinates.y;
			if(loc3 != undefined && loc4 != undefined)
			{
				this.api.network.Basics.autorisedMoveCommand(loc3,loc4);
			}
		}
	}
	function onMouseUp()
	{
		if(this._mcBg.hitTest(_root._xmouse,_root._ymouse,true))
		{
			if(this._bTimerEnable != true)
			{
				this._bTimerEnable = true;
				ank.utils.Timer.setTimer(this,"minimap",this,this.onClickTimer,ank.gapi.Gapi.DBLCLICK_DELAY,[true]);
			}
			else
			{
				this.onClickTimer(false);
				var loc2 = this._mcBitmapContainer._xmouse;
				var loc3 = this._mcBitmapContainer._ymouse;
				var loc4 = this.getCoordinatesFromReal(loc2,loc3);
				this.doubleClick({coordinates:loc4});
			}
		}
	}
}
