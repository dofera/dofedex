class dofus.graphics.gapi.controls.MiniMap extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MiniMap";
	static var MAP_IMG_WIDTH = 15;
	static var MAP_IMG_HEIGHT = 15;
	static var SCALE_SMALL = 0;
	static var SCALE_NORMAL = 1;
	static var SCALE_BIG = 2;
	var _aFlags = new Array();
	var _nMapScale = 40;
	var _nTileWidth = 40;
	var _nTileHeight = 23;
	var _nLastDoubleClick = 0;
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
			var var2 = this.api.datacenter.Basics.aks_infos_highlightCoords;
			§§enumerate(var2);
			while((var var0 = §§enumeration()) != null)
			{
				if(var2[i])
				{
					if(var2[i].miniMapTagId == undefined)
					{
						var2[i].miniMapTagId = this._nRandomTag;
					}
					if(var2[i].miniMapTagId != this._nRandomTag)
					{
						delete register2.i;
					}
					else
					{
						switch(var2[i].type)
						{
							case 1:
								if(!var3)
								{
									var var3 = var2[i];
								}
								else
								{
									var var4 = Math.sqrt(Math.pow(var3.x - this._oMap.x,2) + Math.pow(var3.y - this._oMap.y,2));
									var var5 = Math.sqrt(Math.pow(var2[i].x - this._oMap.x,2) + Math.pow(var2[i].y - this._oMap.y,2));
									if(var5 < var4)
									{
										var3 = var2[i];
									}
								}
								break;
							case 2:
								var var6 = _global.API.ui.getUIComponent("Party").getMemberById(var2[i].playerID).name;
								if(var6 == undefined)
								{
									delete register2.i;
									continue;
								}
								this.addFlag(var2[i].x,var2[i].y,dofus.Constants.FLAG_MAP_GROUP,var6);
								break;
							default:
								if(var0 !== 3)
								{
									break;
								}
								this.addFlag(var2[i].x,var2[i].y,dofus.Constants.FLAG_MAP_SEEK,var2[i].playerName);
								break;
						}
					}
				}
			}
			if(var3)
			{
				this.addFlag(var3.x,var3.y,dofus.Constants.FLAG_MAP_PHOENIX,this.api.lang.getText("BANNER_MAP_PHOENIX"));
			}
		}
	}
	function setScale(var2, var3)
	{
		if(this._nScale == var2)
		{
			return undefined;
		}
		this._nScale = var2;
		this.showScaledBackground();
		if((var var0 = var2) !== dofus.graphics.gapi.controls.MiniMap.SCALE_SMALL)
		{
			if(var0 !== dofus.graphics.gapi.controls.MiniMap.SCALE_NORMAL)
			{
				if(var0 === dofus.graphics.gapi.controls.MiniMap.SCALE_BIG)
				{
					dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE = [[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,0,0,0,0,0,1],[1,0,0,0,0,0,1],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[1,0,0,0,0,0,1],[1,0,0,0,0,0,1],[1,1,0,0,0,1,1]];
				}
			}
			else
			{
				dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE = [[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,0,1,1,0,0,1],[1,0,0,0,0,0,1],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,1],[1,0,0,0,0,0,1],[1,1,0,0,0,1,1]];
			}
		}
		else
		{
			dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE = [[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,1,1,1,1,1,1],[1,1,0,0,0,1,1],[1,1,0,0,0,1,1],[1,1,0,0,0,1,1],[1,1,0,0,0,1,1],[1,1,0,0,0,1,1],[1,1,0,0,0,1,1],[1,1,0,0,0,1,1],[1,1,1,1,1,1,1],[1,1,1,1,1,1,1]];
		}
		if(var3)
		{
			this.updateFlagsDirections();
		}
	}
	function clearFlag()
	{
		§§enumerate(this._mcFlagsDirection);
		while((var var0 = §§enumeration()) != null)
		{
			this._mcFlagsDirection[i].removeMovieClip();
		}
		§§enumerate(this._mcFlagsContainer);
		while((var var0 = §§enumeration()) != null)
		{
			this._mcFlagsContainer[i].removeMovieClip();
		}
		this._aFlags = new Array();
	}
	function addFlag(nX, nY, §\x06\x1d§, §\x1e\x10\x1b§)
	{
		if(_global.isNaN(nX) || _global.isNaN(nY))
		{
			return undefined;
		}
		var var6 = (var4 & 16711680) >> 16;
		var var7 = (var4 & 65280) >> 8;
		var var8 = var4 & 255;
		var var9 = nX + "," + nY + (!var5.length?"":" (" + var5 + ")");
		var var10 = new Array();
		var var11 = function()
		{
			thisMiniMap.dispatchEvent({type:"over"});
			this.gapi.showTooltip(this.tooltipText,this,-20,{bXLimit:false,bYLimit:false});
		};
		var var12 = function()
		{
			this.gapi.hideTooltip();
		};
		var var13 = 0;
		while(var13 <= 2)
		{
			var var14 = this._mcFlagsDirection.getNextHighestDepth();
			var var15 = this._mcFlagsDirection.attachMovie(this.getDirectionLinkageByScale(var13),"dir" + var14,var14);
			var15.stop();
			var var16 = new Color(var15._mcCursor._mc._mcColor);
			var var17 = new Object();
			var17 = {ra:0,ga:0,ba:0,rb:var6,gb:var7,bb:var8};
			var16.setTransform(var17);
			var15.tooltipText = var9;
			var15.gapi = this.gapi;
			var15.mcTarget = var15._mcCursor;
			var15.onRollOver = var11;
			var15.onRollOut = var12;
			var15._visible = false;
			var10.push(var15);
			var13 = var13 + 1;
		}
		if(!this._mcFlagsContainer)
		{
			this._mcFlagsContainer = this._mcFlags.createEmptyMovieClip("_mcFlagsContainer",1);
		}
		var var18 = this._nMapScale / 100 * this._nTileWidth;
		var var19 = this._nMapScale / 100 * this._nTileHeight;
		var var20 = this._mcFlagsContainer.getNextHighestDepth();
		var var21 = this._mcFlagsContainer.attachMovie("UI_MapExplorerFlag","flag" + var20,var20);
		var21._x = var18 * nX + var18 / 2;
		var21._y = var19 * nY + var19 / 2;
		var21._xscale = this._nMapScale;
		var21._yscale = this._nMapScale;
		var var22 = new Color(var21._mcColor);
		var var23 = new Object();
		var23 = {ra:0,ga:0,ba:0,rb:var6,gb:var7,bb:var8};
		var22.setTransform(var23);
		this._aFlags.push({x:nX,y:nY,color:var4,aDirections:var10});
		var21.tooltipText = var9;
		var21.gapi = this.gapi;
		var21.mcTarget = var21;
		var21.onRollOver = var11;
		var21.onRollOut = var12;
		this.updateMap();
	}
	function updateHints()
	{
		if(_global.isNaN(this.dungeonID))
		{
			var var2 = this.api.lang.getHintsCategories();
			var2[-1] = {n:this.api.lang.getText("OPTION_GRID"),c:"Yellow"};
			var var3 = this.api.kernel.OptionsManager.getOption("MapFilters");
			this._mcHintsContainer = this._ldrHints.content;
			var var4 = -1;
			while(var4 < var2.length)
			{
				if(var4 != -1)
				{
					this.showHintsCategory(var4,var3[var4] == 1);
				}
				var4 = var4 + 1;
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
		this.setScale(dofus.graphics.gapi.controls.MiniMap.SCALE_NORMAL,false);
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
		this._mcBitmapContainer.onRollOut = function()
		{
			this.gapi.hideTooltip();
		};
		this._mcBitmapContainer.onRollOver = function()
		{
			thisMiniMap.dispatchEvent({type:"over"});
		};
		this._mcCursor._xscale = this._nMapScale;
		this._mcCursor._yscale = this._nMapScale;
		this._mcCursor.oMap = this._oMap;
		this._mcCursor.gapi = this.gapi;
		this._mcCursor.onRollOver = function()
		{
			thisMiniMap.dispatchEvent({type:"over"});
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
		var var2 = -10;
		while(var2 < 10)
		{
			var var3 = -10;
			while(var3 < 10)
			{
				var var4 = Math.floor(this._oMap.x / dofus.graphics.gapi.controls.MiniMap.MAP_IMG_WIDTH);
				var var5 = Math.floor(this._oMap.y / dofus.graphics.gapi.controls.MiniMap.MAP_IMG_HEIGHT);
				if(var4 < var2 - 2 || (var4 > var2 + 2 || (var5 < var3 - 2 || var5 > var3 + 2)))
				{
					if(this._mcBitmapContainer[var2 + "_" + var3] != undefined)
					{
						this._mcBitmapContainer[var2 + "_" + var3].removeMovieClip();
					}
				}
				else if(this._mcBitmapContainer[var2 + "_" + var3] == undefined)
				{
					var var6 = this._mcBitmapContainer.attachMovie(var2 + "_" + var3,var2 + "_" + var3,this._mcBitmapContainer.getNextHighestDepth());
					var6._xscale = this._nMapScale;
					var6._yscale = this._nMapScale;
					var6._x = var6._width * var2;
					var6._y = var6._height * var3;
				}
				var3 = var3 + 1;
			}
			var2 = var2 + 1;
		}
	}
	function getDirectionLinkageByScale(var2)
	{
		if((var var0 = var2) !== dofus.graphics.gapi.controls.MiniMap.SCALE_SMALL)
		{
			if(var0 !== dofus.graphics.gapi.controls.MiniMap.SCALE_NORMAL)
			{
				if(var0 !== dofus.graphics.gapi.controls.MiniMap.SCALE_BIG)
				{
					return undefined;
				}
				return "FlagDirectionBig";
			}
			return "FlagDirection";
		}
		return "FlagDirectionSmall";
	}
	function initDungeon()
	{
		this._mcBitmapContainer.removeMovieClip();
		this._mcBitmapContainer = this._ldrBitmapMap.createEmptyMovieClip("_mcDongeonContainer",1);
		this._mcCursor._xscale = this._nMapScale;
		this._mcCursor._yscale = this._nMapScale;
		var var2 = this.dungeon.m;
		var var3 = this.dungeonCurrentMap;
		var var4 = 0;
		for(var a in var2)
		{
			var var5 = var2[a];
			if(var3.z == var5.z)
			{
				var4;
				var var6 = this._mcBitmapContainer.attachMovie("UI_MapExplorerRectangle","dungeonMap" + var4,var4++);
				var6._xscale = this._nMapScale;
				var6._yscale = this._nMapScale;
				var6._x = var6._width * var5.x + var6._width / 2 + 1;
				var6._y = var6._height * var5.y + var6._height / 2 + 1;
				if(var5.n != undefined)
				{
					var6.label = var5.n + " (" + var5.x + "," + var5.y + ")";
					var6.gapi = this.gapi;
					var thisMiniMap = this;
					var6.onRollOver = function()
					{
						thisMiniMap.dispatchEvent({type:"over"});
						this.gapi.showTooltip(this.label,this,-20,{bXLimit:false,bYLimit:false});
					};
					var6.onRollOut = function()
					{
						this.gapi.hideTooltip();
					};
				}
			}
		}
	}
	function loadMap(var2)
	{
		if(this._oMap.superarea == undefined)
		{
			this.addToQueue({object:this,method:this.loadMap,params:[var2]});
			return false;
		}
		if(_global.isNaN(this.dungeonID))
		{
			if(this._oMap.superarea !== this._nCurrentArea || var2)
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
	function showHintsCategory(categoryID, §\x15\x0e§)
	{
		var var4 = this.api.kernel.OptionsManager.getOption("MapFilters");
		var4[categoryID] = var3;
		this.api.kernel.OptionsManager.setOption("MapFilters",var4);
		var var5 = "hints" + categoryID;
		if(!this._mcHintsContainer[var5])
		{
			this._mcHintsContainer.createEmptyMovieClip(var5,categoryID);
		}
		if(var3)
		{
			var var6 = this.api.lang.getHintsByCategory(categoryID);
			var var7 = this._nMapScale / 100 * this._nTileWidth;
			var var8 = this._nMapScale / 100 * this._nTileHeight;
			var var9 = 0;
			for(; var9 < var6.length; var9 = var9 + 1)
			{
				var var10 = new dofus.datacenter.(var6[var9]);
				if(var10.superAreaID === this._oMap.superarea)
				{
					var var11 = Math.sqrt(Math.pow(var10.x - this._oMap.x,2) + Math.pow(var10.y - this._oMap.y,2));
					if(var11 > 6)
					{
						this._mcHintsContainer[var5]["hint" + var9].removeMovieClip();
						continue;
					}
					if(this._mcHintsContainer[var5]["hint" + var9] != undefined)
					{
						continue;
					}
					var thisMiniMap = this;
					var var12 = this._mcHintsContainer[var5].attachMovie(var10.gfx,"hint" + var9,var9,{_xscale:this._nMapScale,_yscale:this._nMapScale});
					var12._x = var7 * var10.x + var7 / 2;
					var12._y = var8 * var10.y + var8 / 2;
					var12.oHint = var10;
					var12.gapi = this.gapi;
					var12.onRollOver = function()
					{
						thisMiniMap.dispatchEvent({type:"over"});
						this.gapi.showTooltip(this.oHint.x + "," + this.oHint.y + " (" + this.oHint.name + ")",this,-20,{bXLimit:false,bYLimit:false});
					};
					var12.onRollOut = function()
					{
						this.gapi.hideTooltip();
					};
				}
				else
				{
					this._mcHintsContainer[var5]["hint" + var9].removeMovieClip();
				}
			}
		}
		else
		{
			this._ldrHints.content[var5].removeMovieClip();
		}
	}
	function getConquestAreaList()
	{
		var var2 = this.api.datacenter.Conquest.worldDatas;
		var var3 = new Array();
		var var4 = new String();
		var var5 = 0;
		while(var5 < var2.areas.length)
		{
			if(var2.areas[var5].alignment == 1)
			{
				var var7 = this.api.lang.getText("BONTARIAN_PRISM");
				var var6 = 420;
			}
			else
			{
				var7 = this.api.lang.getText("BRAKMARIAN_PRISM");
				var6 = 421;
			}
			var3.push({g:var6,m:var2.areas[var5].prism,n:var7,superAreaID:this.api.lang.getMapAreaText(var2.areas[var5].id).a});
			var5 = var5 + 1;
		}
		return var3;
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
		var var2 = this._nMapScale / 100 * this._nTileWidth;
		var var3 = this._nMapScale / 100 * this._nTileHeight;
		this._mcBitmapContainer._x = (- var2) * this._oMap.x - var2 / 2;
		this._mcBitmapContainer._y = (- var3) * this._oMap.y - var3 / 2;
		this._mcHintsContainer._x = this._mcBitmapContainer._x;
		this._mcHintsContainer._y = this._mcBitmapContainer._y;
		this._mcFlagsContainer._x = this._mcBitmapContainer._x;
		this._mcFlagsContainer._y = this._mcBitmapContainer._y;
		this.drawMap();
		this.updateFlagsDirections();
		this._mcBitmapContainer._visible = true;
	}
	function updateFlagsDirections()
	{
		for(var var2 in this._aFlags)
		{
			var var3 = this._aFlags[i].y - this._oMap.y;
			if(!(_global.isNaN(var3) || _global.isNaN(var2)))
			{
				var var4 = this._aFlags[i].aDirections;
				if(dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE[var3 + 6][var2 + 3] == undefined || dofus.graphics.gapi.controls.MiniMap.HIDE_FLAG_ZONE[var3 + 6][var2 + 3] == 1)
				{
					var var5 = 0;
					while(var5 < var4.length)
					{
						var var6 = var4[var5];
						if(var5 != this._nScale)
						{
							var6._visible = false;
						}
						else
						{
							var6._visible = true;
							var var7 = Math.floor(Math.atan2(var3,var2) / Math.PI * 180);
							if(var7 < 0)
							{
								var7 = var7 + 360;
							}
							if(var7 > 360)
							{
								var7 = var7 - 360;
							}
							var6.gotoAndStop(var7 + 1);
							var6._mcCursor.gotoAndStop(var7 + 1);
						}
						var5 = var5 + 1;
					}
				}
				else
				{
					var var8 = 0;
					while(var8 < var4.length)
					{
						var var9 = var4[var8];
						var9._visible = false;
						var8 = var8 + 1;
					}
				}
			}
		}
	}
	function onClickTimer(var2)
	{
		ank.utils.Timer.removeTimer(this,"minimap");
		this._bTimerEnable = false;
		if(var2)
		{
			this.click();
		}
	}
	function getCoordinatesFromReal(var2, var3)
	{
		var var4 = this._nMapScale / 100 * this._nTileWidth;
		var var5 = this._nMapScale / 100 * this._nTileHeight;
		var var6 = Math.floor(var2 / var4);
		var var7 = Math.floor(var3 / var5);
		return {x:var6,y:var7};
	}
	function mapLoaded(var2)
	{
		this.updateDataMap();
		if(!this.loadMap())
		{
			this.updateMap();
		}
	}
	function initialization(var2)
	{
		this.initMap();
	}
	function showScaledBackground()
	{
		var var2 = [this._mcBgSmall,this._mcBg,this._mcBgBig];
		var var3 = 0;
		while(var3 < var2.length)
		{
			var var4 = var2[var3];
			if(this._nScale == var3)
			{
				var4._visible = true;
				var4.onRelease = this.click;
			}
			else
			{
				var4._visible = false;
				delete register4.onRelease;
			}
			var3 = var3 + 1;
		}
	}
	function click()
	{
		if(getTimer() - ank.gapi.controls.PopupMenu.LAST_POPUP_VALIDATION < ank.gapi.controls.PopupMenu.LAST_POPUP_VALIDATION_WAIT_DELAY)
		{
			return undefined;
		}
		if(getTimer() - this._nLastDoubleClick < 750)
		{
			return undefined;
		}
		var var2 = new Object();
		var2.target = _global.API.ui.getUIComponent("Banner").illustration;
		_global.API.ui.getUIComponent("Banner").click(var2);
	}
	function doubleClick(var2)
	{
		this._nLastDoubleClick = getTimer();
		if(!this.api.datacenter.Game.isFight && _global.isNaN(this.dungeonID))
		{
			var var3 = var2.coordinates.x;
			var var4 = var2.coordinates.y;
			if(var3 != undefined && var4 != undefined)
			{
				this.api.network.Basics.autorisedMoveCommand(var3,var4);
			}
		}
	}
	function getMcBg()
	{
		if((var var0 = this._nScale) !== dofus.graphics.gapi.controls.MiniMap.SCALE_BIG)
		{
			if(var0 !== dofus.graphics.gapi.controls.MiniMap.SCALE_NORMAL)
			{
				if(var0 !== dofus.graphics.gapi.controls.MiniMap.SCALE_SMALL)
				{
					return undefined;
				}
				return this._mcBgSmall;
			}
			return this._mcBg;
		}
		return this._mcBgBig;
	}
	function isHittingBackground()
	{
		return this.getMcBg().hitTest(_root._xmouse,_root._ymouse,true);
	}
	function onMouseUp()
	{
		if(!this.isHittingBackground())
		{
			return undefined;
		}
		if(this._bTimerEnable != true)
		{
			this._bTimerEnable = true;
			ank.utils.Timer.setTimer(this,"minimap",this,this.onClickTimer,ank.gapi.Gapi.DBLCLICK_DELAY,[true]);
		}
		else
		{
			this.onClickTimer(false);
			var var2 = this._mcBitmapContainer._xmouse;
			var var3 = this._mcBitmapContainer._ymouse;
			var var4 = this.getCoordinatesFromReal(var2,var3);
			this.doubleClick({coordinates:var4});
		}
	}
}
