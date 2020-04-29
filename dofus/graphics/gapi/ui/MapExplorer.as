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
	function __set__mapID(var2)
	{
		this._dmMap = new dofus.datacenter.(var2);
		return this.__get__mapID();
	}
	function __set__pointer(var2)
	{
		this._sPointer = var2;
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
	function multipleSelect(var2)
	{
		this._mnMap.clear("highlight");
		for(var k in var2)
		{
			var var3 = var2[k];
			if(var3 != undefined)
			{
				var var4 = var3.type;
				var var5 = var3.x;
				var var6 = var3.y;
				var var7 = var3.mapID;
				var var8 = var3.label;
				var var9 = Number(this.api.lang.getMapText(var7).d);
				if(var9 == this.dungeonID || _global.isNaN(this.dungeonID))
				{
					if(!_global.isNaN(this.dungeonID))
					{
						var var10 = this.dungeon.m[var7];
						var var11 = this.dungeonCurrentMap;
						if(var11.z != var10.z)
						{
							continue;
						}
						var5 = var10.x;
						var6 = var10.y;
					}
					switch(var4)
					{
						case 1:
							var var12 = dofus.Constants.FLAG_MAP_PHOENIX;
							break;
						case 2:
							var12 = dofus.Constants.FLAG_MAP_GROUP;
							var8 = var5 + "," + var6 + " (" + _global.API.ui.getUIComponent("Party").getMemberById(var2[k].playerID).name + ")";
							if(var8 == undefined)
							{
								delete register2.k;
								continue;
							}
							break;
						default:
							if(var0 !== 3)
							{
								var12 = dofus.Constants.FLAG_MAP_OTHERS;
								break;
							}
							var12 = dofus.Constants.FLAG_MAP_SEEK;
							var8 = var5 + "," + var6 + " (" + var2[k].playerName + ")";
							break;
					}
					var var13 = this._mnMap.addXtraClip("UI_MapExplorerFlag","highlight",var5,var6,var12,100,false,true);
					if(var8 != undefined)
					{
						var13.label = var13.label == undefined?var8:var13.label + "\n" + var8;
						var13.gapi = this.gapi;
						var13.onRollOver = function()
						{
							this.gapi.showTooltip(this.label,this,10);
						};
						var13.onRollOut = function()
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
			var var2 = this.api.lang.getHintsCategories();
			var2[-1] = {n:this.api.lang.getText("OPTION_GRID"),c:"Yellow"};
			var var3 = this.api.kernel.OptionsManager.getOption("MapFilters");
			var var4 = 0;
			var var5 = -1;
			while(var5 < var2.length)
			{
				if(var2[var5] != undefined)
				{
					var var6 = new Object();
					var6._y = this._mcFilterPlacer._y;
					var6._x = this._mcFilterPlacer._x + var4;
					var6.backgroundDown = "ButtonCheckDown";
					var6.backgroundUp = "ButtonCheckUp";
					var6.styleName = var2[var5].c + "MapHintCheckButton";
					var6.toggle = true;
					var6.selected = false;
					var6.enabled = true;
					var var7 = (ank.gapi.controls.Button)this.attachMovie("Button","_mcFilter" + var5,this.getNextHighestDepth(),var6);
					var7.setSize(12,12);
					var7.addEventListener("click",this);
					var7.addEventListener("over",this);
					var7.addEventListener("out",this);
					var4 = var4 + 17;
				}
				if(var5 != -1)
				{
					this.showHintsCategory(var5,var3[var5] == 1);
				}
				var5 = var5 + 1;
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
			var var2 = this.api.datacenter.Basics.mapExplorer_coord;
		}
		this.showMapSuperArea(this._dmMap.superarea);
		if(var2 != undefined)
		{
			this._mnMap.setMapPosition(var2.x,var2.y);
		}
		this._mnMap.zoom = this.api.datacenter.Basics.mapExplorer_zoom;
	}
	function showMapSuperArea(var2)
	{
		if(var2 == undefined)
		{
			return undefined;
		}
		this._mnMap.contentPath = dofus.Constants.LOCAL_MAPS_PATH + var2 + ".swf";
		this._mnMap.clear();
		this._mnMap.setMapPosition(this._dmMap.x,this._dmMap.y);
		var var3 = this.api.datacenter.Map;
		this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle","rectangle",var3.x,var3.y,dofus.Constants.MAP_CURRENT_POSITION,50);
		if(this._dmMap != var3)
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
	function hideArrows(var2)
	{
		this._mcTriangleNW._visible = this._mcTriangleN._visible = this._mcTriangleNE._visible = this._mcTriangleW._visible = this._mcTriangleE._visible = this._mcTriangleSW._visible = this._mcTriangleS._visible = this._mcTriangleSE._visible = !var2;
	}
	function showHintsCategory(categoryID, §\x16\x05§)
	{
		var var4 = this.api.kernel.OptionsManager.getOption("MapFilters");
		var4[categoryID] = var3;
		this.api.kernel.OptionsManager.setOption("MapFilters",var4);
		this["_mcFilter" + categoryID].selected = var3;
		var var5 = "hints" + categoryID;
		if(var3)
		{
			this._mnMap.loadXtraLayer(dofus.Constants.MAP_HINTS_FILE,var5);
		}
		else
		{
			this._mnMap.clear(var5);
		}
	}
	function drawHintsOnCategoryLayer(categoryID)
	{
		var var3 = "hints" + categoryID;
		if(dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID == categoryID)
		{
			var var4 = this.getConquestAreaList();
		}
		else
		{
			var4 = this.api.lang.getHintsByCategory(categoryID);
		}
		var var5 = 0;
		while(var5 < var4.length)
		{
			var var6 = new dofus.datacenter.(var4[var5]);
			if((var6.superAreaID == this._dmMap.superarea || dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID == categoryID && categoryID != 5) && var6.y != undefined)
			{
				var var7 = this._mnMap.addXtraClip(var6.gfx,var3,var6.x,var6.y,undefined,undefined,true);
				var7.oHint = var6;
				var7.gapi = this.gapi;
				var7.onRollOver = function()
				{
					this.gapi.showTooltip(this.oHint.x + "," + this.oHint.y + " (" + this.oHint.name + ")",this,-20);
				};
				var7.onRollOut = function()
				{
					this.gapi.hideTooltip();
				};
			}
			var5 = var5 + 1;
		}
	}
	function getConquestAreaList()
	{
		var var2 = this.api.datacenter.Conquest.worldDatas;
		if(!var2.areas.length)
		{
			this.addToQueue({object:this,method:this.drawHintsOnCategoryLayer,params:[dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID]});
		}
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
			if(var2.areas[var5].alignment == 2)
			{
				var7 = this.api.lang.getText("BRAKMARIAN_PRISM");
				var6 = 421;
			}
			var3.push({g:var6,m:var2.areas[var5].prism,n:var7,superAreaID:this.api.lang.getMapAreaText(var2.areas[var5].id).a});
			var5 = var5 + 1;
		}
		return var3;
	}
	function initDungeonMap(var2)
	{
		var var3 = this.api.datacenter.Map;
		this._mnMap.clear();
		this._mnMap.createXtraLayer("dungeonParchment");
		this._mnMap.createXtraLayer("dungeonMap");
		this._mnMap.createXtraLayer("highlight");
		var var4 = this.dungeon.m;
		var var5 = this.dungeonCurrentMap;
		for(var var6 in var4)
		{
			if(var5.z == var6.z)
			{
				var var7 = this._mnMap.addXtraClip("UI_MapExplorerRectangle","dungeonMap",var6.x,var6.y);
				if(var6.n != undefined)
				{
					var7.label = var6.n + " (" + var6.x + "," + var6.y + ")";
					var7.gapi = this.gapi;
					var7.onRollOver = function()
					{
						this.gapi.showTooltip(this.label,this,-20);
					};
					var7.onRollOut = function()
					{
						this.gapi.hideTooltip();
					};
				}
			}
		}
		var var8 = this.dungeonCurrentMap;
		this._mnMap.addXtraClip("UI_MapExplorerSelectRectangle","dungeonMap",var8.x,var8.y,dofus.Constants.MAP_CURRENT_POSITION,50);
		this._mnMap.setMapPosition(var8.x,var8.y);
		this._mnMap.loadXtraLayer(dofus.Constants.MAP_HINTS_FILE,"dungeonHints");
		this._mnMap.loadXtraLayer(dofus.Constants.LOCAL_MAPS_PATH + "dungeon.swf","dungeonParchment");
	}
	function initDungeonParchment()
	{
		var var2 = this._mnMap.getXtraLayer("dungeonParchment");
		var var3 = this._mnMap.getXtraLayer("dungeonMap");
		var var4 = var3._width;
		var var5 = var3._height;
		var var6 = var2.view._x;
		var var7 = var2.view._y;
		var var8 = var2.view._width;
		var var9 = var2.view._height;
		var var10 = 100;
		if(var4 > var8 || var5 > var9)
		{
			var var11 = var8 / var4;
			var var12 = var9 / var5;
			if(var12 > var11)
			{
				var10 = 100 * var4 / var8;
			}
			else
			{
				var10 = 100 * var5 / var9;
			}
			var2._xscale = var2._yscale = var10;
		}
		var var13 = var6 * var10 / 100 + (var8 * var10 / 100 - var4) / 2;
		var var14 = var7 * var10 / 100 + (var9 * var10 / 100 - var5) / 2;
		var2.parchment._x = (- var13) * 100 / var10;
		var2.parchment._y = (- var14) * 100 / var10;
		var var15 = var2._parent._xscale;
		var var16 = var2._width * var10 / 100 * var15 / 100;
		var var17 = var2._height * var10 / 100 * var15 / 100;
		var var18 = this._mnMap._width;
		var var19 = this._mnMap._height;
		if(var16 > var17)
		{
			this._mnMap.zoom = this._mnMap.zoom * var18 / var16;
		}
		else
		{
			this._mnMap.zoom = this._mnMap.zoom * var19 / var17;
		}
		this._mnMap.setMapPosition(this.dungeonCurrentMap.x,this.dungeonCurrentMap.y);
	}
	function drawHintsDungeon()
	{
		var var2 = this.dungeon.m;
		for(var a in var2)
		{
			var var3 = var2[a];
			if(var3.i != undefined)
			{
				var var4 = this._mnMap.addXtraClip(var3.i,"dungeonHints",var3.x,var3.y,undefined,undefined,true);
				if(var3.n != undefined)
				{
					var4.label = var3.n + " (" + var3.x + "," + var3.y + ")";
					var4.gapi = this.gapi;
					var4.onRollOver = function()
					{
						this.gapi.showTooltip(this.label,this,-20);
					};
					var4.onRollOut = function()
					{
						this.gapi.hideTooltip();
					};
				}
			}
		}
	}
	function onMouseWheel(var2, var3)
	{
		if(var3._target.indexOf("_mnMap",0) != -1)
		{
			this._mnMap.zoom = this._mnMap.zoom + (var2 >= 0?5:-5);
		}
	}
	function click(var2)
	{
		loop0:
		switch(var2.target._name)
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
				break;
			default:
				switch(null)
				{
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
							var var3 = this.dungeonCurrentMap;
							this._mnMap.setMapPosition(var3.x,var3.y);
						}
						else
						{
							this._mnMap.setMapPosition(this.api.datacenter.Map.x,this.api.datacenter.Map.y);
						}
						break loop0;
					default:
						var var4 = var2.target._name;
						var var5 = Number(var4.substr(9,var4.length));
						if(var5 != -1)
						{
							this.showHintsCategory(var5,!this.api.kernel.OptionsManager.getOption("MapFilters")[var5]);
							this.api.ui.getUIComponent("Banner").illustration.updateHints();
							break loop0;
						}
						var var6 = !this.api.datacenter.Basics.mapExplorer_grid;
						this.api.datacenter.Basics.mapExplorer_grid = var6;
						this._mnMap.showGrid = var6;
						break loop0;
				}
		}
	}
	function over(var2)
	{
		loop0:
		switch(var2.target)
		{
			case this._mnMap:
				var var3 = var2.target._name.substr(4);
				this.setMovieClipTransform(this["_mcTriangle" + var3],dofus.graphics.gapi.ui.MapExplorer.OVER_TRIANGLE_TRANSFORM);
				break;
			case this._btnZoomPlus:
				this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_ZOOM_PLUS"),var2.target,-20);
				break;
			default:
				switch(null)
				{
					case this._btnZoomMinous:
						this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_ZOOM_MINOUS"),var2.target,-20);
						break loop0;
					case this._btnMove:
						this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_MOVE"),var2.target,-20);
						break loop0;
					case this._btnSelect:
						this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_SELECT"),var2.target,-20);
						break loop0;
					case this._btnCenterOnMe:
						this.gapi.showTooltip(this.api.lang.getText("MAP_EXPLORER_CENTER"),var2.target,-20);
						break loop0;
					default:
						var var4 = var2.target._name;
						this.gapi.showTooltip(this.api.lang.getHintsCategory(Number(var4.substr(9,var4.length))).n,var2.target,-20);
				}
		}
	}
	function out(var2)
	{
		if((var var0 = var2.target) !== this._mnMap)
		{
			this.gapi.hideTooltip();
		}
		else
		{
			var var3 = 0;
			while(var3 < dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS.length)
			{
				this.setMovieClipTransform(this["_mcTriangle" + dofus.graphics.gapi.ui.MapExplorer.DIRECTIONS[var3]],dofus.graphics.gapi.ui.MapExplorer.OUT_TRIANGLE_TRANSFORM);
				var3 = var3 + 1;
			}
		}
	}
	function change(var2)
	{
		this._mnMap.zoom = var2.target.value;
	}
	function zoom(var2)
	{
		this._vsZoom.value = var2.target.zoom;
	}
	function select(var2)
	{
		this.api.sounds.events.onMapFlag();
		var var3 = var2.coordinates;
		this._mnMap.clear("flag");
		if(this.api.kernel.GameManager.updateCompass(var3.x,var3.y,false))
		{
			this._mnMap.addXtraClip("UI_MapExplorerFlag","flag",var3.x,var3.y,255);
		}
	}
	function overMap(var2)
	{
		if(this.dungeon == undefined)
		{
			var var3 = this.api.kernel.AreasManager.getAreaIDFromCoordinates(var2.coordinates.x,var2.coordinates.y,this._dmMap.superarea);
			var var4 = this.api.kernel.AreasManager.getSubAreaIDFromCoordinates(var2.coordinates.x,var2.coordinates.y,this._dmMap.superarea);
			if(var4 != undefined)
			{
				var var5 = this.api.lang.getMapSubAreaText(var4).n;
				var var6 = (dofus.datacenter.Subarea)this.api.datacenter.Subareas.getItemAt(var4);
				if(var6 != undefined)
				{
					var var7 = var6.color;
					var var8 = this.api.lang.getMapAreaText(var3).n + (var5.substr(0,2) != "//"?" (" + var5 + ") - ":" - ") + var6.alignment.name;
				}
				else
				{
					var7 = dofus.Constants.AREA_NO_ALIGNMENT_COLOR;
					var8 = this.api.lang.getMapAreaText(var3).n + (var5.substr(0,2) != "//"?" (" + var5 + ")":"");
				}
				if(this._vsZoom.value != 2)
				{
					this._mnMap.addSubareaClip(var4,var7 == -1?dofus.Constants.AREA_NO_ALIGNMENT_COLOR:var7,20);
				}
				this._lblAreaName.text = var8;
				this._lblArea._visible = true;
			}
			else
			{
				this.outMap();
			}
		}
	}
	function outMap(var2)
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
	function doubleClick(var2)
	{
		if(!this.api.datacenter.Game.isFight && this.dungeon == undefined)
		{
			var var3 = var2.coordinates.x;
			var var4 = var2.coordinates.y;
			if(var3 != undefined && var4 != undefined)
			{
				this.api.network.Basics.autorisedMoveCommand(var3,var4);
			}
		}
	}
	function xtraLayerLoad(var2)
	{
		switch(var2.mc._name)
		{
			case "dungeonHints":
				this.drawHintsDungeon();
				break;
			case "dungeonParchment":
				this.initDungeonParchment();
				break;
			default:
				var var3 = var2.mc._name;
				this.drawHintsOnCategoryLayer(Number(var3.substr(5,var3.length)));
		}
	}
	function worldDataChanged(var2)
	{
		if(this["_mcFilter" + dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID].selected)
		{
			this.addToQueue({object:this,method:this.drawHintsOnCategoryLayer,params:[dofus.graphics.gapi.ui.MapExplorer.FILTER_CONQUEST_ID]});
		}
	}
}
