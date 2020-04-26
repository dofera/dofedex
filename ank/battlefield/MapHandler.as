class ank.battlefield.MapHandler
{
	static var OBJECT_TYPE_BACKGROUND = 1;
	static var OBJECT_TYPE_GROUND = 2;
	static var OBJECT_TYPE_OBJECT1 = 3;
	static var OBJECT_TYPE_OBJECT2 = 4;
	static var TIME_BEFORE_AJUSTING_MAP = 500;
	var _oLoadingCells = new Object();
	var _oSettingFrames = new Object();
	var _mclLoader = new MovieClipLoader();
	var _nMaxMapRender = 1;
	function MapHandler(loc3, loc4, loc5)
	{
		if(loc2 != undefined)
		{
			this.initialize(loc2,loc3,loc4);
		}
		this._mclLoader.addListener(this);
	}
	function __get__LoaderRequestLeft()
	{
		return this._nLoadRequest;
	}
	function initialize(loc2, loc3, loc4)
	{
		this._mcBattlefield = loc2;
		this._oDatacenter = loc4;
		this._mcContainer = loc3;
		this.api = _global.API;
	}
	function build(loc2, loc3, loc4)
	{
		this._oDatacenter.Map = loc2;
		var loc5 = ank.battlefield.Constants.CELL_WIDTH;
		var loc6 = ank.battlefield.Constants.CELL_HALF_WIDTH;
		var loc7 = ank.battlefield.Constants.CELL_HALF_HEIGHT;
		var loc8 = ank.battlefield.Constants.LEVEL_HEIGHT;
		var loc9 = -1;
		var loc10 = 0;
		var loc11 = 0;
		var loc12 = loc2.data;
		var loc13 = loc12.length;
		var loc14 = loc2.width - 1;
		var loc15 = this._mcContainer.ExternalContainer;
		var loc16 = loc3 != undefined;
		var loc17 = false;
		var loc18 = this._nLastCellCount == loc13;
		this._nLoadRequest = 0;
		if(!loc16 && (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod"))
		{
			this._mcContainer.applyMask(false);
		}
		if(loc2.backgroundNum != 0)
		{
			if(ank.battlefield.Constants.USE_STREAMING_FILES && (ank.battlefield.Constants.STREAMING_METHOD == "explod" && !loc16))
			{
				var loc19 = loc15.Ground.createEmptyMovieClip("background",-1);
				loc19.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
				this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_GROUNDS_DIR + loc2.backgroundNum + ".swf",loc19);
				this._nLoadRequest++;
			}
			else if(ank.battlefield.Constants.STREAMING_METHOD != "")
			{
				loc15.Ground.attachMovie(loc2.backgroundNum,"background",-1).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
			}
			else
			{
				loc15.Ground.attach(loc2.backgroundNum,"background",-1).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
			}
		}
		var loc20 = -1;
		while((loc20 = loc20 + 1) < loc13)
		{
			if(loc9 == loc14)
			{
				loc9 = 0;
				loc10 = loc10 + 1;
				if(loc11 == 0)
				{
					loc11 = loc6;
					loc14 = loc14 - 1;
				}
				else
				{
					loc11 = 0;
					loc14 = loc14 + 1;
				}
			}
			else
			{
				loc9 = loc9 + 1;
			}
			if(loc16)
			{
				if(loc20 < loc3)
				{
					continue;
				}
				if(loc20 > loc3)
				{
					return undefined;
				}
			}
			var loc21 = loc12[loc20];
			if(loc21.active)
			{
				var loc22 = loc9 * loc5 + loc11;
				var loc23 = loc10 * loc7 - loc8 * (loc21.groundLevel - 7);
				loc21.x = loc22;
				loc21.y = loc23;
				if(loc21.movement || loc4)
				{
					if(!loc18 && !loc15.InteractionCell["cell" + loc20])
					{
						if(!loc17)
						{
							if(ank.battlefield.Constants.STREAMING_METHOD != "")
							{
								var loc24 = loc15.InteractionCell.attachMovie("i" + loc21.groundSlope,"cell" + loc20,loc20,{_x:loc22,_y:loc23});
							}
							else
							{
								loc24 = loc15.InteractionCell.attachMovie("i" + loc21.groundSlope,"cell" + loc20,loc20,{_x:loc22,_y:loc23});
							}
						}
						else
						{
							loc24 = loc15.InteractionCell.createEmptyMovieClip("cell" + loc20,loc20,{_x:loc22,_y:loc23});
						}
						loc24.__proto__ = ank.battlefield.mc.Cell.prototype;
						loc24.initialize(this._mcBattlefield);
					}
					else
					{
						loc24 = loc15.InteractionCell["cell" + loc20];
					}
					loc21.mc = loc24;
					loc24.data = loc21;
				}
				else
				{
					loc15.InteractionCell["cell" + loc20].removeMovieClip();
				}
				if(loc21.layerGroundNum != 0)
				{
					if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
					{
						var loc26 = true;
						if(loc16)
						{
							var loc25 = loc15.Ground["cell" + loc20];
							if(loc25 != undefined && loc25.lastGroundID == loc21.layerGroundNum)
							{
								loc25.fullLoaded = loc26 = false;
								this._oLoadingCells[loc25] = loc21;
								this.onLoadInit(loc25);
							}
						}
						if(loc26)
						{
							loc25 = loc15.Ground.createEmptyMovieClip("cell" + loc20,loc20);
							loc25.fullLoaded = false;
							this._oLoadingCells[loc25] = loc21;
							this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_GROUNDS_DIR + loc21.layerGroundNum + ".swf",loc25);
							this._nLoadRequest++;
						}
					}
					else
					{
						if(!loc17)
						{
							if(ank.battlefield.Constants.STREAMING_METHOD != "")
							{
								loc25 = loc15.Ground.attachMovie(loc21.layerGroundNum,"cell" + loc20,loc20);
							}
							else
							{
								loc25 = loc15.Ground.attach(loc21.layerGroundNum,"cell" + loc20,loc20);
							}
						}
						else
						{
							loc25 = new MovieClip();
						}
						loc25.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Ground"];
						loc25._x = loc22;
						loc25._y = loc23;
						if(loc21.groundSlope != 1)
						{
							loc25.gotoAndStop(loc21.groundSlope);
						}
						else if(loc21.layerGroundRot != 0)
						{
							loc25._rotation = loc21.layerGroundRot * 90;
							if(loc25._rotation % 180)
							{
								loc25._yscale = 192.86;
								loc25._xscale = 51.85;
							}
						}
						if(loc21.layerGroundFlip)
						{
							loc25._xscale = loc25._xscale * -1;
						}
					}
				}
				else
				{
					loc15.Ground["cell" + loc20].removeMovieClip();
				}
				if(loc21.layerObject1Num != 0)
				{
					if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
					{
						var loc28 = true;
						if(loc16)
						{
							var loc27 = loc15.Object1["cell" + loc20];
							if(loc27 != undefined && loc27.lastObject1ID == loc21.layerObject1Num)
							{
								loc27.fullLoaded = loc28 = false;
								this._oLoadingCells[loc27] = loc21;
								this.onLoadInit(loc27);
							}
						}
						if(loc28)
						{
							loc27 = loc15.Object1.createEmptyMovieClip("cell" + loc20,loc20);
							loc27.fullLoaded = false;
							this._oLoadingCells[loc27] = loc21;
							this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_OBJECTS_DIR + loc21.layerObject1Num + ".swf",loc27);
							this._nLoadRequest++;
						}
					}
					else
					{
						if(!loc17)
						{
							loc27 = loc15.Object1.attachMovie(loc21.layerObject1Num,"cell" + loc20,loc20);
						}
						else
						{
							loc27 = new MovieClip();
						}
						loc27.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object1"];
						loc27._x = loc22;
						loc27._y = loc23;
						if(loc21.groundSlope == 1 && loc21.layerObject1Rot != 0)
						{
							loc27._rotation = loc21.layerObject1Rot * 90;
							if(loc27._rotation % 180)
							{
								loc27._yscale = 192.86;
								loc27._xscale = 51.85;
							}
						}
						if(loc21.layerObject1Flip)
						{
							loc27._xscale = loc27._xscale * -1;
						}
					}
					loc21.mcObject1 = loc27;
				}
				else
				{
					loc15.Object1["cell" + loc20].removeMovieClip();
				}
				if(loc21.layerObjectExternal != "")
				{
					if(!loc17)
					{
						var loc29 = loc15.Object2.attachClassMovie(ank.battlefield.mc.InteractiveObject,"cellExt" + loc20,loc20 * 100 + 1);
					}
					loc29.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/ObjectExternal"];
					loc29.initialize(this._mcBattlefield,loc21,loc21.layerObjectExternalInteractive);
					loc29.loadExternalClip(loc21.layerObjectExternal,loc21.layerObjectExternalAutoSize);
					loc29._x = loc22;
					loc29._y = loc23;
					loc21.mcObjectExternal = loc29;
				}
				else
				{
					loc15.Object2["cellExt" + loc20].removeMovieClip();
					delete register21.mcObjectExternal;
				}
				if(loc21.layerObject2Num != 0)
				{
					if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
					{
						var loc31 = true;
						if(loc16)
						{
							var loc30 = loc15.Object2["cell" + loc20];
							if(loc30 != undefined && loc30.lastObject2ID == loc21.layerObject2Num)
							{
								loc30.fullLoaded = loc31 = false;
								this._oLoadingCells[loc30] = loc21;
								this.onLoadInit(loc30);
							}
						}
						if(loc31)
						{
							loc30 = loc15.Object2.createEmptyMovieClip("cell" + loc20,loc20 * 100);
							loc30.fullLoaded = false;
							this._oLoadingCells[loc30] = loc21;
							this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_OBJECTS_DIR + loc21.layerObject2Num + ".swf",loc30);
							this._nLoadRequest++;
						}
					}
					else
					{
						if(!loc17)
						{
							loc30 = loc15.Object2.attachMovie(loc21.layerObject2Num,"cell" + loc20,loc20 * 100);
						}
						else
						{
							loc30 = new MovieClip();
						}
						loc30.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object2"];
						if(loc21.layerObject2Interactive)
						{
							loc30.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
							loc30.initialize(this._mcBattlefield,loc21,true);
						}
						loc30._x = loc22;
						loc30._y = loc23;
						if(loc21.layerObject2Flip)
						{
							loc30._xscale = -100;
						}
					}
					loc21.mcObject2 = loc30;
				}
				else
				{
					loc15.Object2["cell" + loc20].removeMovieClip();
					delete register21.mcObject2;
				}
			}
			else if(loc4)
			{
				var loc32 = loc9 * loc5 + loc11;
				var loc33 = loc10 * loc7;
				loc21.x = loc32;
				loc21.y = loc33;
				var loc34 = loc15.InteractionCell.attachMovie("i1","cell" + loc20,loc20,{_x:loc32,_y:loc33});
				loc34.__proto__ = ank.battlefield.mc.Cell.prototype;
				loc34.initialize(this._mcBattlefield);
				loc21.mc = loc34;
				loc34.data = loc21;
			}
		}
		if(!loc16)
		{
			if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
			{
				if(this._nAdjustTimer != undefined)
				{
					return undefined;
				}
				this._nAdjustTimer = _global.setInterval(this,"adjustAndMaskMap",ank.battlefield.MapHandler.TIME_BEFORE_AJUSTING_MAP);
			}
			else
			{
				this.adjustAndMaskMap();
			}
		}
	}
	function tacticMode(loc2)
	{
		var loc3 = this._oDatacenter.Map;
		var loc4 = loc3.data;
		if(loc2)
		{
			this._mcContainer.ExternalContainer.clearGround();
			if(loc3.savedBackgroundNum == undefined && loc3.backgroundNum != 631)
			{
				loc3.savedBackgroundNum = loc3.backgroundNum;
			}
			loc3.backgroundNum = 631;
		}
		else if(loc3.savedBackgroundNum != undefined)
		{
			if(loc3.savedBackgroundNum == 0)
			{
				loc3.backgroundNum = 632;
			}
			else
			{
				loc3.backgroundNum = loc3.savedBackgroundNum;
			}
		}
		for(var mapCell in loc4)
		{
			this.tacticModeRefreshCell(Number(mapCell),loc2);
		}
	}
	function tacticModeRefreshCell(loc2, loc3)
	{
		if(loc2 > this.getCellCount())
		{
			ank.utils.Logger.err("[updateCell] Cellule " + loc2 + " inexistante");
			return undefined;
		}
		var loc4 = this._oDatacenter.Map;
		var loc5 = loc4.data[loc2];
		if(!loc5.active)
		{
			return undefined;
		}
		if(!loc3)
		{
			var loc6 = (ank.battlefield.datacenter.Cell)loc4.originalsCellsBackup.getItemAt(String(loc2));
			if(loc6 == undefined)
			{
				ank.utils.Logger.err("La case est déjà dans son état init");
				return undefined;
			}
			loc5.layerGroundNum = loc6.layerGroundNum;
			loc5.groundSlope = loc6.groundSlope;
			loc5.layerObject1Rot = loc6.layerObject1Rot;
			loc5.layerObject1Num = loc6.layerObject1Num;
			if(loc5.layerObject2Num != 25)
			{
				loc5.layerObject2Num = loc6.layerObject2Num;
			}
		}
		else
		{
			if(loc5.nPermanentLevel == 0)
			{
				var loc7 = new ank.battlefield.datacenter.();
				for(var cellData in loc5)
				{
					loc7[cellData] = loc5[cellData];
				}
				loc4.originalsCellsBackup.addItemAt(String(loc2),loc7);
			}
			loc5.turnTactic();
		}
		this.build(loc4,loc2);
	}
	function updateCell(§\b\x1a§, §\x1e\x1a\x07§, §\x1e\x12\x02§, nPermanentLevel)
	{
		if(loc2 > this.getCellCount())
		{
			ank.utils.Logger.err("[updateCell] Cellule " + loc2 + " inexistante");
			return undefined;
		}
		if(nPermanentLevel == undefined || _global.isNaN(nPermanentLevel))
		{
			nPermanentLevel = 0;
		}
		else
		{
			nPermanentLevel = Number(nPermanentLevel);
		}
		var loc6 = _global.parseInt(loc4,16);
		var loc7 = (loc6 & 65536) != 0;
		var loc8 = (loc6 & 32768) != 0;
		var loc9 = (loc6 & 16384) != 0;
		var loc10 = (loc6 & 8192) != 0;
		var loc11 = (loc6 & 4096) != 0;
		var loc12 = (loc6 & 2048) != 0;
		var loc13 = (loc6 & 1024) != 0;
		var loc14 = (loc6 & 512) != 0;
		var loc15 = (loc6 & 256) != 0;
		var loc16 = (loc6 & 128) != 0;
		var loc17 = (loc6 & 64) != 0;
		var loc18 = (loc6 & 32) != 0;
		var loc19 = (loc6 & 16) != 0;
		var loc20 = (loc6 & 8) != 0;
		var loc21 = (loc6 & 4) != 0;
		var loc22 = (loc6 & 2) != 0;
		var loc23 = (loc6 & 1) != 0;
		var loc24 = this._oDatacenter.Map.data[loc2];
		if(nPermanentLevel > 0)
		{
			if(loc24.nPermanentLevel == 0)
			{
				var loc25 = new ank.battlefield.datacenter.();
				for(var k in loc24)
				{
					loc25[k] = loc24[k];
				}
				this._oDatacenter.Map.originalsCellsBackup.addItemAt(loc2,loc25);
				loc24.nPermanentLevel = nPermanentLevel;
			}
		}
		if(loc10)
		{
			loc24.active = loc3.active;
		}
		if(loc11)
		{
			loc24.lineOfSight = loc3.lineOfSight;
		}
		if(loc12)
		{
			loc24.movement = loc3.movement;
		}
		if(loc13)
		{
			loc24.groundLevel = loc3.groundLevel;
		}
		if(loc14)
		{
			loc24.groundSlope = loc3.groundSlope;
		}
		if(loc15)
		{
			loc24.layerGroundNum = loc3.layerGroundNum;
		}
		if(loc16)
		{
			loc24.layerGroundFlip = loc3.layerGroundFlip;
		}
		if(loc17)
		{
			loc24.layerGroundRot = loc3.layerGroundRot;
		}
		if(loc18)
		{
			loc24.layerObject1Num = loc3.layerObject1Num;
		}
		if(loc20)
		{
			loc24.layerObject1Rot = loc3.layerObject1Rot;
		}
		if(loc19)
		{
			loc24.layerObject1Flip = loc3.layerObject1Flip;
		}
		if(loc22)
		{
			loc24.layerObject2Flip = loc3.layerObject2Flip;
		}
		if(loc23)
		{
			loc24.layerObject2Interactive = loc3.layerObject2Interactive;
		}
		if(loc21)
		{
			loc24.layerObject2Num = loc3.layerObject2Num;
		}
		if(loc9)
		{
			loc24.layerObjectExternal = loc3.layerObjectExternal;
		}
		if(loc8)
		{
			loc24.layerObjectExternalInteractive = loc3.layerObjectExternalInteractive;
		}
		if(loc7)
		{
			loc24.layerObjectExternalAutoSize = loc3.layerObjectExternalAutoSize;
		}
		loc24.layerObjectExternalData = loc3.layerObjectExternalData;
		this.build(this._oDatacenter.Map,loc2);
	}
	function initializeMap(nPermanentLevel)
	{
		if(nPermanentLevel == undefined)
		{
			nPermanentLevel = Number.POSITIVE_INFINITY;
		}
		else
		{
			nPermanentLevel = Number(nPermanentLevel);
		}
		var loc3 = this._oDatacenter.Map;
		if(loc3.savedBackgroundNum != undefined)
		{
			if(loc3.savedBackgroundNum == 0)
			{
				loc3.backgroundNum = 632;
			}
			else
			{
				loc3.backgroundNum = loc3.savedBackgroundNum;
			}
		}
		var loc4 = loc3.data;
		var loc5 = loc3.originalsCellsBackup.getItems();
		for(var k in loc5)
		{
			this.initializeCell(Number(k),nPermanentLevel);
		}
	}
	function initializeCell(loc2, loc3, loc4)
	{
		if(nPermanentLevel == undefined)
		{
			nPermanentLevel = Number.POSITIVE_INFINITY;
		}
		else
		{
			nPermanentLevel = Number(nPermanentLevel);
		}
		var loc5 = this._oDatacenter.Map;
		var loc6 = loc5.data;
		var loc7 = loc5.originalsCellsBackup.getItemAt(String(loc2));
		if(loc7 == undefined)
		{
			ank.utils.Logger.err("La case est déjà dans son état init");
			return undefined;
		}
		if(loc6[loc2].nPermanentLevel <= nPermanentLevel)
		{
			if(loc4 == true)
			{
				var loc8 = loc6[loc2].isTactic;
				var loc9 = new ank.battlefield.datacenter.();
				for(var cellData in loc7)
				{
					loc9[cellData] = loc7[cellData];
				}
				if(loc8)
				{
					loc9.turnTactic();
				}
				loc6[loc2] = loc9;
				this.build(loc5,loc2);
				if(!loc8)
				{
					loc5.originalsCellsBackup.removeItemAt(String(loc2));
				}
			}
			else
			{
				loc6[loc2] = loc7;
				this.build(loc5,loc2);
				loc5.originalsCellsBackup.removeItemAt(String(loc2));
			}
		}
	}
	function setObject2Frame(loc2, loc3)
	{
		if(typeof loc3 == "number" && loc3 < 1)
		{
			ank.utils.Logger.err("[setObject2Frame] frame " + loc3 + " incorecte");
			return undefined;
		}
		if(loc2 > this.getCellCount())
		{
			ank.utils.Logger.err("[setObject2Frame] Cellule " + loc2 + " inexistante");
			return undefined;
		}
		var loc4 = this._oDatacenter.Map.data[loc2];
		var loc5 = loc4.mcObject2;
		if(ank.battlefield.Constants.USE_STREAMING_FILES && (ank.battlefield.Constants.STREAMING_METHOD == "explod" && !loc5.fullLoaded))
		{
			this._oSettingFrames[loc2] = loc3;
		}
		else if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
		{
			for(var s in loc5)
			{
				if(loc5[s] instanceof MovieClip)
				{
					loc5[s].gotoAndStop(loc3);
				}
			}
		}
		else
		{
			loc5.gotoAndStop(loc3);
		}
	}
	function setObjectExternalFrame(loc2, loc3)
	{
		if(typeof loc3 == "number" && loc3 < 1)
		{
			ank.utils.Logger.err("[setObject2Frame] frame " + loc3 + " incorecte");
			return undefined;
		}
		if(loc2 > this.getCellCount())
		{
			ank.utils.Logger.err("[setObject2Frame] Cellule " + loc2 + " inexistante");
			return undefined;
		}
		var loc4 = this._oDatacenter.Map.data[loc2];
		var loc5 = loc4.mcObjectExternal._mcExternal;
		loc5.gotoAndStop(loc3);
	}
	function setObject2Interactive(§\b\x1a§, §\x19\x06§, nPermanentLevel)
	{
		if(loc2 > this.getCellCount())
		{
			ank.utils.Logger.err("[setObject2State] Cellule " + loc2 + " inexistante");
			return undefined;
		}
		var loc5 = this._oDatacenter.Map.data[loc2];
		loc5.mcObject2.select(false);
		var loc6 = new ank.battlefield.datacenter.();
		loc6.layerObject2Interactive = loc3;
		this.updateCell(loc2,loc6,"1",nPermanentLevel);
	}
	function getCellCount(loc2)
	{
		return this._oDatacenter.Map.data.length;
	}
	function getCellData(loc2)
	{
		return this._oDatacenter.Map.data[loc2];
	}
	function getCellsData(loc2)
	{
		return this._oDatacenter.Map.data;
	}
	function getWidth(loc2)
	{
		return this._oDatacenter.Map.width;
	}
	function getHeight(loc2)
	{
		return this._oDatacenter.Map.height;
	}
	function getCaseNum(loc2, loc3)
	{
		var loc4 = this.getWidth();
		return loc2 * loc4 + loc3 * (loc4 - 1);
	}
	function getCellHeight(loc2)
	{
		var loc3 = this.getCellData(loc2);
		var loc4 = !(loc3.groundSlope == undefined || loc3.groundSlope == 1)?0.5:0;
		var loc5 = loc3.groundLevel != undefined?loc3.groundLevel - 7:0;
		return loc5 + loc4;
	}
	function getLayerByCellPropertyName(loc2)
	{
		var loc3 = new Array();
		for(var i in this._oDatacenter.Map.data)
		{
			loc3.push(this._oDatacenter.Map.data[i][loc2]);
		}
		return loc3;
	}
	function resetEmptyCells()
	{
		var loc2 = this._mcBattlefield.spriteHandler.getSprites().getItems();
		var loc3 = new Array();
		for(var k in loc2)
		{
			loc3[loc2[k].cellNum] = true;
		}
		var loc4 = this.getCellCount();
		var loc5 = 0;
		var loc6 = 0;
		while(loc6 < loc4)
		{
			if(loc3[loc6] != true)
			{
				var loc7 = this._mcBattlefield.mapHandler.getCellData(loc6);
				loc5 = loc5 + loc7.spriteOnCount;
				loc7.removeAllSpritesOnID();
			}
			loc6 = loc6 + 1;
		}
		if(loc5 > 0)
		{
		}
	}
	function adjustAndMaskMap()
	{
		if(this._nAdjustTimer != undefined)
		{
			_global.clearInterval(this._nAdjustTimer);
			this._nAdjustTimer = undefined;
		}
		this._mcContainer.applyMask(true);
		this._mcContainer.adjusteMap();
	}
	function onLoadInit(loc2)
	{
		this._nLoadRequest--;
		if(this._oLoadingCells[loc2] == undefined)
		{
			return undefined;
		}
		var loc3 = String(loc2).split(".");
		var loc4 = loc3[loc3.length - 2];
		var loc5 = this._oLoadingCells[loc2];
		switch(loc4)
		{
			case "Ground":
				loc2.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Ground"];
				loc2._x = Number(loc5.x);
				loc2._y = Number(loc5.y);
				if(loc5.groundSlope == 1 && loc5.layerGroundRot != 0)
				{
					loc2._rotation = loc5.layerGroundRot * 90;
					if(loc2._rotation % 180)
					{
						loc2._yscale = 192.86;
						loc2._xscale = 51.85;
					}
					else
					{
						loc2._xscale = loc0 = 100;
						loc2._yscale = loc0;
					}
				}
				else
				{
					loc2._rotation = 0;
					loc2._xscale = loc0 = 100;
					loc2._yscale = loc0;
				}
				if(loc5.layerGroundFlip)
				{
					loc2._xscale = loc2._xscale * -1;
				}
				else
				{
					loc2._xscale = loc2._xscale * 1;
				}
				if(loc5.groundSlope != 1)
				{
					loc2.gotoAndStop(loc5.groundSlope);
				}
				loc2.lastGroundID = loc5.layerGroundNum;
				break;
			case "Object1":
				loc2.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object1"];
				loc2._x = Number(loc5.x);
				loc2._y = Number(loc5.y);
				if(loc5.groundSlope == 1 && loc5.layerObject1Rot != 0)
				{
					loc2._rotation = loc5.layerObject1Rot * 90;
					if(loc2._rotation % 180)
					{
						loc2._yscale = 192.86;
						loc2._xscale = 51.85;
					}
					else
					{
						loc2._xscale = loc0 = 100;
						loc2._yscale = loc0;
					}
				}
				else
				{
					loc2._rotation = 0;
					loc2._xscale = loc0 = 100;
					loc2._yscale = loc0;
				}
				if(loc5.layerObject1Flip)
				{
					loc2._xscale = loc2._xscale * -1;
				}
				else
				{
					loc2._xscale = loc2._xscale * 1;
				}
				loc2.lastObject1ID = loc5.layerObject1Num;
				break;
			case "Object2":
				loc2.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object2"];
				loc2._x = Number(loc5.x);
				loc2._y = Number(loc5.y);
				if(loc5.layerObject2Interactive)
				{
					loc2.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
					loc2.initialize(this._mcBattlefield,loc5,true);
				}
				else
				{
					loc2.__proto__ = MovieClip.prototype;
				}
				if(loc5.layerObject2Flip)
				{
					loc2._xscale = -100;
				}
				else
				{
					loc2._xscale = 100;
				}
				loc2.lastObject2ID = loc5.layerObject2Num;
		}
		if(this._oSettingFrames[loc5.num] != undefined)
		{
			var loc6 = this._oDatacenter.Map.data[loc5.num].mcObject2;
			§§enumerate(loc6);
			while((loc0 = §§enumeration()) != null)
			{
				if(loc6[s] instanceof MovieClip)
				{
					loc6[s].gotoAndStop(this._oSettingFrames[loc5.num]);
				}
			}
			delete this._oSettingFrames[loc5.num];
		}
		loc2.fullLoaded = true;
		delete this._oLoadingCells.register2;
	}
	function showTriggers()
	{
		var loc2 = this.getCellsData();
		for(var i in loc2)
		{
			var loc3 = loc2[i];
			var loc4 = loc3.isTrigger;
			if(loc4)
			{
				this.flagCellNonBlocking(loc3.num);
			}
		}
	}
	function flagCellNonBlocking(loc2)
	{
		var loc3 = this.api.datacenter.Player.ID;
		var loc4 = new ank.battlefield.datacenter.
();
		loc4.file = dofus.Constants.CLIPS_PATH + "flag.swf";
		loc4.bInFrontOfSprite = true;
		loc4.bTryToBypassContainerColor = true;
		this.api.gfx.spriteLaunchVisualEffect(loc3,loc4,loc2,11,undefined,undefined,undefined,true,false);
	}
}
