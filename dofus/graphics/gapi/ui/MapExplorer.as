class dofus.graphics.gapi.ui.MapExplorer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "MapExplorer";
	static var OVER_TRIANGLE_TRANSFORM = {ra:0,rb:255,ga:0,gb:102,ba:0,bb:0};
	static var OUT_TRIANGLE_TRANSFORM = {ra:0,rb:184,ga:0,gb:177,ba:0,bb:143};
	static var DIRECTIONS = new Array("NW","N","NE","W","E","SW","S","SE");
	static var FILTER_CONQUEST_ID = 5;
	function MapExplorer()
	{
		super();
	}
	function __set__mapID(loc2)
	{
		this._dmMap = new dofus.datacenter.(loc2);
		return this.__get__mapID();
	}
	function __set__pointer(loc2)
	{
		this._sPointer = loc2;
		return this.__get__pointer();
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
	function multipleSelect(loc2)
	{
		this._mnMap.clear("highlight");
		for(var k in loc2)
		{
			var loc3 = loc2[k];
			if(loc3 != undefined)
			{
				var loc4 = loc3.type;
				var loc5 = loc3.x;
				var loc6 = loc3.y;
				var loc7 = loc3.mapID;
				var loc8 = loc3.label;
				var loc9 = Number(this.api.lang.getMapText(loc7).d);
				if(loc9 == this.dungeonID || _global.isNaN(this.dungeonID))
				{
					if(!_global.isNaN(this.dungeonID))
					{
						var loc10 = this.dungeon.m[loc7];
						var loc11 = this.dungeonCurrentMap;
						if(loc11.z != loc10.z)
						{
							continue;
						}
						loc5 = loc10.x;
						loc6 = loc10.y;
					}
					switch(loc4)
					{
						case 1:
							var loc12 = dofus.Constants.FLAG_MAP_PHOENIX;
							break;
						case 2:
							loc12 = dofus.Constants.FLAG_MAP_GROUP;
							loc8 = loc5 + "," + loc6 + " (" + _global.API.ui.getUIComponent("Party").getMemberById(loc2[k].playerID).name + ")";
							if(loc8 == undefined)
							{
								delete register2.k;
								continue;
							}
							break;
						case 3:
							loc12 = dofus.Constants.FLAG_MAP_SEEK;
							loc8 = loc5 + "," + loc6 + " (" + loc2[k].playerName + ")";
							break;
						default:
							loc12 = dofus.Constants.FLAG_MAP_OTHERS;
					}
					var loc13 = this._mnMap.addXtraClip("UI_MapExplorerFlag","highlight",loc5,loc6,loc12,100,false,true);
					if(loc8 != undefined)
					{
						loc13.label = loc13.label == undefined?loc8:loc13.label + "\n" + loc8;
						loc13.gapi = this.gapi;
						loc13.onRollOver = function()
						{
							this.gapi.showTooltip(this.label,this,10);
						};
						loc13.onRollOut = function()
						{
							this.gapi.hideTooltip();
						};
					}
				}
			}
		}
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.MapExplorer.CLASS_NAME);
		this.api.gfx._visible = false;
		ank.utils.MouseEvents.addListener(this);
		this.gapi.removeCursor(true);
	}
	function destroy()
	{
		if(this.dungeon == undefined)
		{
			this.api.datacenter.Basics.mapExplorer_zoom = this._mnMap.zoom;
			this.api.datacenter.Basics.mapExplorer_coord = {x:this._mnMap.currentX,y:this._mnMap.currentY};
		}
		this.gapi.hideTooltip();
		this.gapi.removeCursor(true);
		this.api.gfx._visible = true;
		this.api.network.Conquest.worldInfosLeave();
	}
	function callClose()
	{
		this.unloadThis();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.layoutContent});
		this._lblArea._visible = false;
	}
	function initTexts()
	{
		this._winBg.title = this.api.lang.getText("WORLD_MAP");
		this._lblZoom.text = this.api.lang.getText("ZOOM");
		if(this.dungeon != undefined)
		{
			this._lblArea._visible = true;
			this._lblArea.text = this.dungeon.n;
		}
		else
		{
			this._lblArea.text = this.api.lang.getText("AREA");
		}
		this._lblHints.text = this.api.lang.getText("HINTS_FILTER");
	}
	function layoutContent()
	{
		if(this.dungeon == undefined)
		{
			var loc2 = this.api.lang.getHintsCategories();
			loc2[-1] = {n:this.api.lang.getText("OPTION_GRID"),c:"Yellow"};
			var loc3 = this.api.kernel.OptionsManager.getOption("MapFilters");
			var loc4 = 0;
			var loc5 = -1;
			while(loc5 < loc2.length)
			{
				if(loc2[loc5] != undefined)
				{
					var loc6 = new Object();
					loc6._y = this._mcFilterPlacer._y;
					loc6._x = this._mcFilterPlacer._x + loc4;
					loc6.backgroundDown = "ButtonCheckDown";
					loc6.backgroundUp = "ButtonCheckUp";
					loc6.styleName = loc2[loc5].c + "MapHintCheckButton";
					loc6.toggle = true;
					loc6.selected = false;
					loc6.enabled = true;
					var loc7 = (ank.gapi.controls.Button)this.attachMovie("Button","_mcFilter" + loc5,this.getNextHighestDepth(),loc6);
					loc7.setSize(12,12);
					loc7.addEventListener("click",this);
					loc7.addEventListener("over",this);
					loc7.addEventListener("out",this);
					loc4 = loc4 + 17;
				}
				if(loc5 != -1)
				{
					this.showHintsCategory(loc5,loc3[loc5] == 1);
				}
				loc5 = loc5 + 1;
			}
			this._mnMap.showGrid = this.api.datacenter.Basics.mapExplorer_grid;
			this["_mcFilter-1"].selected = this.api.datacenter.Basics.mapExplorer_grid;
		}
		else
		{
			this._lblHints._visible = false;
			this._mnMap.showGrid = false;
		}
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._btnZoomPlus.addEventListener("click",this);
		this._btnZoomMinous.addEventListener("click",this);
		this._btnMove.addEventListener("click",this);
		this._btnSelect.addEventListener("click",this);
		this._btnCenterOnMe.addEventListener("click",this);
		this._btnZoomPlus.addEventListener("over",this);
		this._btnZoomMinous.addEventListener("over",this);
		this._btnMove.addEventListener("over",this);
		this._btnSelect.addEventListener("over",this);
		this._btnCenterOnMe.addEventListener("over",this);
		this._btnZoomPlus.addEventListener("out",this);
		this._btnZoomMinous.addEventListener("out",this);
		this._btnMove.addEventListener("out",this);
		this._btnSelect.addEventListener("out",this);
		this._btnCenterOnMe.addEventListener("out",this);
		this._mnMap.addEventListener("overMap",this);
		this._mnMap.addEventListener("outMap",this);
		this._mnMap.addEventListener("over",this);
		this._mnMap.addEventListener("out",this);
		this._mnMap.addEventListener("zoom",this);
		this._mnMap.addEventListener("select",this);
		this._mnMap.addEventListener("xtraLayerLoad",this);
		if(this.api.datacenter.Player.isAuthorized)
		{
			this._mnMap.addEventListener("doubleClick",this);
		}
		this._vsZoom.addEventListener("change",this);
		this.api.datacenter.Conquest.addEventListener("worldDataChanged",this);
	}
	function initData()
	{
		if(this.dungeon != undefined)
		{
			this.initDungeonMap();
		}
		else
		{
			this.api.network.Conquest.worldInfosJoin();
			this.initWorldMap();
		}
	}
	function initWorldMap()
	{
		if(this._dmMap == undefined)
		{
			this._dmMap = this.api.datacenter.Map;
			var loc2 = this.api.datacenter.Basics.mapExplorer_coord;
		}
		this.showMapSuperArea(this._dmMap.superarea);
		if(loc2 != undefined)
		{
			this._mnMap.setMapPosition(loc2.x,loc2.y);
		}
		this._mnMap.zoom = this.api.datacenter.Basics.mapExplorer_zoom;
	}
	function showMapSuperArea(loc2)
	{
		if(loc2 == undefined)
		{
			return undefined;
		}
		this._mnMap.contentPath = dofus.Constants.LOCAL_MAPS_PATH + loc2 + ".swf";
		this._mnMap.clear();
		this._mnMap.setMapPosition(this._dmMap.x,this._dmMap.y);
		var loc3 = this.api.datacenter.Map;
		this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle","rectangle",loc3.x,loc3.y,dofus.Constants.MAP_CURRENT_POSITION,50);
		if(this._dmMap != loc3)
		{
			this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle","rectangle",this._dmMap.x,this._dmMap.y,dofus.Constants.MAP_WAYPOINT_POSITION,50);
		}
		if(this.api.datacenter.Basics.banner_targetCoords != undefined)
		{
			this._mnMap.addXtraClip("UI_MapExplorerFlag","flag",this.api.datacenter.Basics.banner_targetCoords[0],this.api.datacenter.Basics.banner_targetCoords[1],255);
		}
		if(this.api.datacenter.Basics.aks_infos_highlightCoords != undefined)
		{
			this.multipleSelect(this.api.datacenter.Basics.aks_infos_highlightCoords);
		}
	}
	function hideArrows(loc2)
	{
		this._mcTriangleNW._visible = this._mcTriangleN._visible = this._mcTriangleNE._visible = this._mcTriangleW._visible = this._mcTriangleE._visible = this._mcTriangleSW._visible = this._mcTriangleS._visible = this._mcTriangleSE._visible = !loc2;
	}
	function showHintsCategory(categoryID, §\x16\x06§)
	{
		var loc4 = this.api.kernel.OptionsManager.getOption("MapFilters");
		loc4[categoryID] = loc3;
		this.api.kernel.OptionsManager.setOption("MapFilters",loc4);
		this["_mcFilter" + categoryID].selected = loc3;
		var loc5 = "hints" + categoryID;
		if(loc3)
		{
			this._mnMap.loadXtraLayer(dofus.Constants.MAP_HINTS_FILE,loc5);
		}
		else
		{
			this._mnMap.clear(loc5);
		}
	}
	function drawHintsOnCategoryLayer(categoryID)
	{
		var loc3 = "hints" + categoryID;
		if(dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID == categoryID)
		{
			var loc4 = this.getConquestAreaList();
		}
		else
		{
			loc4 = this.api.lang.getHintsByCategory(categoryID);
		}
		var loc5 = 0;
		while(loc5 < loc4.length)
		{
			var loc6 = new dofus.datacenter.(loc4[loc5]);
			if((loc6.superAreaID == this._dmMap.superarea || dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID == categoryID && categoryID != 5) && loc6.y != undefined)
			{
				var loc7 = this._mnMap.addXtraClip(loc6.gfx,loc3,loc6.x,loc6.y,undefined,undefined,true);
				loc7.oHint = loc6;
				loc7.gapi = this.gapi;
				loc7.onRollOver = function()
				{
					this.gapi.showTooltip(this.oHint.x + "," + this.oHint.y + " (" + this.oHint.name + ")",this,-20);
				};
				loc7.onRollOut = function()
				{
					this.gapi.hideTooltip();
				};
			}
			loc5 = loc5 + 1;
		}
	}
	function getConquestAreaList()
	{
		var loc2 = this.api.datacenter.Conquest.worldDatas;
		if(!loc2.areas.length)
		{
			this.addToQueue({object:this,method:this.drawHintsOnCategoryLayer,params:[dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID]});
		}
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
			if(loc2.areas[loc5].alignment == 2)
			{
				loc7 = this.api.lang.getText("BRAKMARIAN_PRISM");
				loc6 = 421;
			}
			loc3.push({g:loc6,m:loc2.areas[loc5].prism,n:loc7,superAreaID:this.api.lang.getMapAreaText(loc2.areas[loc5].id).a});
			loc5 = loc5 + 1;
		}
		return loc3;
	}
	function initDungeonMap(loc2)
	{
		var loc3 = this.api.datacenter.Map;
		this._mnMap.clear();
		this._mnMap.createXtraLayer("dungeonParchment");
		this._mnMap.createXtraLayer("dungeonMap");
		this._mnMap.createXtraLayer("highlight");
		var loc4 = this.dungeon.m;
		var loc5 = this.dungeonCurrentMap;
		for(var a in loc4)
		{
			var loc6 = loc4[a];
			if(loc5.z == loc6.z)
			{
				var loc7 = this._mnMap.addXtraClip("UI_MapExplorerRectangle","dungeonMap",loc6.x,loc6.y);
				if(loc6.n != undefined)
				{
					loc7.label = loc6.n + " (" + loc6.x + "," + loc6.y + ")";
					loc7.gapi = this.gapi;
					loc7.onRollOver = function()
					{
						this.gapi.showTooltip(this.label,this,-20);
					};
					loc7.onRollOut = function()
					{
						this.gapi.hideTooltip();
					};
				}
			}
		}
		var loc8 = this.dungeonCurrentMap;
		this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle","dungeonMap",loc8.x,loc8.y,dofus.Constants.MAP_CURRENT_POSITION,50);
		this._mnMap.setMapPosition(loc8.x,loc8.y);
		this._mnMap.loadXtraLayer(dofus.Constants.MAP_HINTS_FILE,"dungeonHints");
		this._mnMap.loadXtraLayer(dofus.Constants.LOCAL_MAPS_PATH + "dungeon.swf","dungeonParchment");
	}
	function initDungeonParchment()
	{
		var loc2 = this._mnMap.getXtraLayer("dungeonParchment");
		var loc3 = this._mnMap.getXtraLayer("dungeonMap");
		var loc4 = loc3._width;
		var loc5 = loc3._height;
		var loc6 = loc2.view._x;
		var loc7 = loc2.view._y;
		var loc8 = loc2.view._width;
		var loc9 = loc2.view._height;
		var loc10 = 100;
		if(loc4 > loc8 || loc5 > loc9)
		{
			var loc11 = loc8 / loc4;
			var loc12 = loc9 / loc5;
			if(loc12 > loc11)
			{
				loc10 = 100 * loc4 / loc8;
			}
			else
			{
				loc10 = 100 * loc5 / loc9;
			}
			loc2._xscale = loc2._yscale = loc10;
		}
		var loc13 = loc6 * loc10 / 100 + (loc8 * loc10 / 100 - loc4) / 2;
		var loc14 = loc7 * loc10 / 100 + (loc9 * loc10 / 100 - loc5) / 2;
		loc2.parchment._x = (- loc13) * 100 / loc10;
		loc2.parchment._y = (- loc14) * 100 / loc10;
		var loc15 = loc2._parent._xscale;
		var loc16 = loc2._width * loc10 / 100 * loc15 / 100;
		var loc17 = loc2._height * loc10 / 100 * loc15 / 100;
		var loc18 = this._mnMap._width;
		var loc19 = this._mnMap._height;
		if(loc16 > loc17)
		{
			this._mnMap.zoom = this._mnMap.zoom * loc18 / loc16;
		}
		else
		{
			this._mnMap.zoom = this._mnMap.zoom * loc19 / loc17;
		}
		this._mnMap.setMapPosition(this.dungeonCurrentMap.x,this.dungeonCurrentMap.y);
	}
	function drawHintsDungeon()
	{
		var loc2 = this.dungeon.m;
		for(var a in loc2)
		{
			var loc3 = loc2[a];
			if(loc3.i != undefined)
			{
				var loc4 = this._mnMap.addXtraClip(loc3.i,"dungeonHints",loc3.x,loc3.y,undefined,undefined,true);
				if(loc3.n != undefined)
				{
					loc4.label = loc3.n + " (" + loc3.x + "," + loc3.y + ")";
					loc4.gapi = this.gapi;
					loc4.onRollOver = function()
					{
						this.gapi.showTooltip(this.label,this,-20);
					};
					loc4.onRollOut = function()
					{
						this.gapi.hideTooltip();
					};
				}
			}
		}
	}
	function onMouseWheel(loc2, loc3)
	{
		if(loc3._target.indexOf("_mnMap",0) != -1)
		{
			this._mnMap.zoom = this._mnMap.zoom + (loc2 >= 0?5:-5);
		}
	}
	function click(loc2)
	{
		loop0:
		switch(loc2.target._name)
		{
			case "_btnClose":
				this.callClose();
				break;
			case "_btnZoomPlus":
				this.api.sounds.events.onMapButtonClick();
				this._mnMap.interactionMode = "zoom+";
				this._btnZoomMinous.selected = false;
				this._btnMove.selected = false;
				this._btnSelect.selected = false;
				this._btnZoomPlus.enabled = false;
				this._btnZoomMinous.enabled = true;
				this._btnMove.enabled = true;
				this._btnSelect.enabled = true;
				this.hideArrows(true);
				break;
			default:
				switch(null)
				{
					case "_btnZoomMinous":
						this.api.sounds.events.onMapButtonClick();
						this._mnMap.interactionMode = "zoom-";
						this._btnZoomPlus.selected = false;
						this._btnMove.selected = false;
						this._btnSelect.selected = false;
						this._btnZoomPlus.enabled = true;
						this._btnZoomMinous.enabled = false;
						this._btnMove.enabled = true;
						this._btnSelect.enabled = true;
						this.hideArrows(true);
						break loop0;
					case "_btnMove":
						this.api.sounds.events.onMapButtonClick();
						this._mnMap.interactionMode = "move";
						this._btnZoomMinous.selected = false;
						this._btnZoomPlus.selected = false;
						this._btnSelect.selected = false;
						this._btnZoomPlus.enabled = true;
						this._btnZoomMinous.enabled = true;
						this._btnMove.enabled = false;
						this._btnSelect.enabled = true;
						this.hideArrows(false);
						break loop0;
					case "_btnSelect":
						this.api.sounds.events.onMapButtonClick();
						this._mnMap.interactionMode = "select";
						this._btnZoomMinous.selected = false;
						this._btnZoomPlus.selected = false;
						this._btnMove.selected = false;
						this._btnZoomPlus.enabled = true;
						this._btnZoomMinous.enabled = true;
						this._btnMove.enabled = true;
						this._btnSelect.enabled = false;
						this.hideArrows(true);
						break loop0;
					case "_btnCenterOnMe":
						if(this.dungeon != undefined)
						{
							var loc3 = this.dungeonCurrentMap;
							this._mnMap.setMapPosition(loc3.x,loc3.y);
						}
						else
						{
							this._mnMap.setMapPosition(this.api.datacenter.Map.x,this.api.datacenter.Map.y);
						}
						break loop0;
					default:
						var loc4 = loc2.target._name;
						var loc5 = Number(loc4.substr(9,loc4.length));
						if(loc5 != -1)
						{
							this.showHintsCategory(loc5,!this.api.kernel.OptionsManager.getOption("MapFilters")[loc5]);
							this.api.ui.getUIComponent("Banner").illustration.updateHints();
							break loop0;
						}
						var loc6 = !this.api.datacenter.Basics.mapExplorer_grid;
						this.api.datacenter.Basics.mapExplorer_grid = loc6;
						this._mnMap.showGrid = loc6;
						break loop0;
				}
		}
	}
	function over(loc2)
	{
		loop0:
		switch(loc2.target)
		{
			case this._mnMap:
				var loc3 = loc2.target._name.substr(4);
				this.setMovieClipTransform(this["_mcTriangle" + loc3],dofus.graphics.gapi.ui.MapExplorer.OVER_TRIANGLE_TRANSFORM);
				break;
			case this._btnZoomPlus:
				this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_ZOOM_PLUS"),loc2.target,-20);
				break;
			case this._btnZoomMinous:
				this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_ZOOM_MINOUS"),loc2.target,-20);
				break;
			default:
				switch(null)
				{
					case this._btnMove:
						this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_MOVE"),loc2.target,-20);
						break loop0;
					case this._btnSelect:
						this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_SELECT"),loc2.target,-20);
						break loop0;
					case this._btnCenterOnMe:
						this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_CENTER"),loc2.target,-20);
						break loop0;
					default:
						var loc4 = loc2.target._name;
						this.gapi.showTooltip(this.api.lang.getHintsCategory(Number(loc4.substr(9,loc4.length))).n,loc2.target,-20);
				}
		}
	}
	function out(loc2)
	{
		if((var loc0 = loc2.target) !== this._mnMap)
		{
			this.gapi.hideTooltip();
		}
		else
		{
			var loc3 = 0;
			while(loc3 < dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS.length)
			{
				this.setMovieClipTransform(this["_mcTriangle" + dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS[loc3]],dofus.graphics.gapi.ui.MapExplorer.OUT_TRIANGLE_TRANSFORM);
				loc3 = loc3 + 1;
			}
		}
	}
	function change(loc2)
	{
		this._mnMap.zoom = loc2.target.value;
	}
	function zoom(loc2)
	{
		this._vsZoom.value = loc2.target.zoom;
	}
	function select(loc2)
	{
		this.api.sounds.events.onMapFlag();
		var loc3 = loc2.coordinates;
		this._mnMap.clear("flag");
		if(this.api.kernel.GameManager.updateCompass(loc3.x,loc3.y,false))
		{
			this._mnMap.addXtraClip("UI_MapExplorerFlag","flag",loc3.x,loc3.y,255);
		}
	}
	function overMap(loc2)
	{
		if(this.dungeon == undefined)
		{
			var loc3 = this.api.kernel.AreasManager.getAreaIDFromCoordinates(loc2.coordinates.x,loc2.coordinates.y,this._dmMap.superarea);
			var loc4 = this.api.kernel.AreasManager.getSubAreaIDFromCoordinates(loc2.coordinates.x,loc2.coordinates.y,this._dmMap.superarea);
			if(loc4 != undefined)
			{
				var loc5 = this.api.lang.getMapSubAreaText(loc4).n;
				var loc6 = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(loc4);
				if(loc6 != undefined)
				{
					var loc7 = loc6.color;
					var loc8 = this.api.lang.getMapAreaText(loc3).n + (loc5.substr(0,2) != "//"?" (" + loc5 + ") - ":" - ") + loc6.alignment.name;
				}
				else
				{
					loc7 = dofus.Constants.AREA_NO_ALIGNMENT_COLOR;
					loc8 = this.api.lang.getMapAreaText(loc3).n + (loc5.substr(0,2) != "//"?" (" + loc5 + ")":"");
				}
				if(this._vsZoom.value != 2)
				{
					this._mnMap.addSubareaClip(loc4,loc7 == -1?dofus.Constants.AREA_NO_ALIGNMENT_COLOR:loc7,20);
				}
				this._lblAreaName.text = loc8;
				this._lblArea._visible = true;
			}
			else
			{
				this.outMap();
			}
		}
	}
	function outMap(loc2)
	{
		if(this.dungeon == undefined)
		{
			this._mnMap.removeAreaClip();
			if(this._lblAreaName.text != undefined)
			{
				this._lblAreaName.text = "";
			}
			this._lblArea._visible = false;
		}
	}
	function doubleClick(loc2)
	{
		if(!this.api.datacenter.Game.isFight && this.dungeon == undefined)
		{
			var loc3 = loc2.coordinates.x;
			var loc4 = loc2.coordinates.y;
			if(loc3 != undefined && loc4 != undefined)
			{
				this.api.network.Basics.autorisedMoveCommand(loc3,loc4);
			}
		}
	}
	function xtraLayerLoad(loc2)
	{
		switch(loc2.mc._name)
		{
			case "dungeonHints":
				this.drawHintsDungeon();
				break;
			case "dungeonParchment":
				this.initDungeonParchment();
				break;
			default:
				var loc3 = loc2.mc._name;
				this.drawHintsOnCategoryLayer(Number(loc3.substr(5,loc3.length)));
		}
	}
	function worldDataChanged(loc2)
	{
		if(this["_mcFilter" + dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID].selected)
		{
			this.addToQueue({object:this,method:this.drawHintsOnCategoryLayer,params:[dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID]});
		}
	}
}
