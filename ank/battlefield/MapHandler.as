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
	function MapHandler(var3, var4, var5)
	{
		if(var2 != undefined)
		{
			this.initialize(var2,var3,var4);
		}
		this._mclLoader.addListener(this);
	}
	function __get__LoaderRequestLeft()
	{
		return this._nLoadRequest;
	}
	function initialize(var2, var3, var4)
	{
		this._mcBattlefield = var2;
		this._oDatacenter = var4;
		this._mcContainer = var3;
		this.api = _global.API;
	}
	function build(var2, var3, var4)
	{
		this._oDatacenter.Map = var2;
		var var5 = ank.battlefield.Constants.CELL_WIDTH;
		var var6 = ank.battlefield.Constants.CELL_HALF_WIDTH;
		var var7 = ank.battlefield.Constants.CELL_HALF_HEIGHT;
		var var8 = ank.battlefield.Constants.LEVEL_HEIGHT;
		var var9 = -1;
		var var10 = 0;
		var var11 = 0;
		var var12 = var2.data;
		var var13 = var12.length;
		var var14 = var2.width - 1;
		var var15 = this._mcContainer.ExternalContainer;
		var var16 = var3 != undefined;
		var var17 = false;
		var var18 = this._nLastCellCount == var13;
		this._nLoadRequest = 0;
		if(!var16 && (ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod"))
		{
			this._mcContainer.applyMask(false);
		}
		if(var2.backgroundNum != 0)
		{
			if(ank.battlefield.Constants.USE_STREAMING_FILES && (ank.battlefield.Constants.STREAMING_METHOD == "explod" && !var16))
			{
				var var19 = var15.Ground.createEmptyMovieClip("background",-1);
				var19.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
				this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_GROUNDS_DIR + var2.backgroundNum + ".swf",var19);
				this._nLoadRequest++;
			}
			else if(ank.battlefield.Constants.STREAMING_METHOD != "")
			{
				var15.Ground.attachMovie(var2.backgroundNum,"background",-1).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
			}
			else
			{
				var15.Ground.attach(var2.backgroundNum,"background",-1).cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/BACKGROUND"];
			}
		}
		var var20 = -1;
		while((var20 = var20 + 1) < var13)
		{
			if(var9 == var14)
			{
				var9 = 0;
				var10 = var10 + 1;
				if(var11 == 0)
				{
					var11 = var6;
					var14 = var14 - 1;
				}
				else
				{
					var11 = 0;
					var14 = var14 + 1;
				}
			}
			else
			{
				var9 = var9 + 1;
			}
			if(var16)
			{
				if(var20 < var3)
				{
					continue;
				}
				if(var20 > var3)
				{
					return undefined;
				}
			}
			var var21 = var12[var20];
			if(var21.active)
			{
				var var22 = var9 * var5 + var11;
				var var23 = var10 * var7 - var8 * (var21.groundLevel - 7);
				var21.x = var22;
				var21.y = var23;
				if(var21.movement || var4)
				{
					if(!var18 && !var15.InteractionCell["cell" + var20])
					{
						if(!var17)
						{
							if(ank.battlefield.Constants.STREAMING_METHOD != "")
							{
								var var24 = var15.InteractionCell.attachMovie("i" + var21.groundSlope,"cell" + var20,var20,{_x:var22,_y:var23});
							}
							else
							{
								var24 = var15.InteractionCell.attachMovie("i" + var21.groundSlope,"cell" + var20,var20,{_x:var22,_y:var23});
							}
						}
						else
						{
							var24 = var15.InteractionCell.createEmptyMovieClip("cell" + var20,var20,{_x:var22,_y:var23});
						}
						var24.__proto__ = ank.battlefield.mc.Cell.prototype;
						var24.initialize(this._mcBattlefield);
					}
					else
					{
						var24 = var15.InteractionCell["cell" + var20];
					}
					var21.mc = var24;
					var24.data = var21;
				}
				else
				{
					var15.InteractionCell["cell" + var20].removeMovieClip();
				}
				if(var21.layerGroundNum != 0)
				{
					if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
					{
						var var26 = true;
						if(var16)
						{
							var var25 = var15.Ground["cell" + var20];
							if(var25 != undefined && var25.lastGroundID == var21.layerGroundNum)
							{
								var25.fullLoaded = var26 = false;
								this._oLoadingCells[var25] = var21;
								this.onLoadInit(var25);
							}
						}
						if(var26)
						{
							var25 = var15.Ground.createEmptyMovieClip("cell" + var20,var20);
							var25.fullLoaded = false;
							this._oLoadingCells[var25] = var21;
							this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_GROUNDS_DIR + var21.layerGroundNum + ".swf",var25);
							this._nLoadRequest++;
						}
					}
					else
					{
						if(!var17)
						{
							if(ank.battlefield.Constants.STREAMING_METHOD != "")
							{
								var25 = var15.Ground.attachMovie(var21.layerGroundNum,"cell" + var20,var20);
							}
							else
							{
								var25 = var15.Ground.attach(var21.layerGroundNum,"cell" + var20,var20);
							}
						}
						else
						{
							var25 = new MovieClip();
						}
						var25.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Ground"];
						var25._x = var22;
						var25._y = var23;
						if(var21.groundSlope != 1)
						{
							var25.gotoAndStop(var21.groundSlope);
						}
						else if(var21.layerGroundRot != 0)
						{
							var25._rotation = var21.layerGroundRot * 90;
							if(var25._rotation % 180)
							{
								var25._yscale = 192.86;
								var25._xscale = 51.85;
							}
						}
						if(var21.layerGroundFlip)
						{
							var25._xscale = var25._xscale * -1;
						}
					}
				}
				else
				{
					var15.Ground["cell" + var20].removeMovieClip();
				}
				if(var21.layerObject1Num != 0)
				{
					if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
					{
						var var28 = true;
						if(var16)
						{
							var var27 = var15.Object1["cell" + var20];
							if(var27 != undefined && var27.lastObject1ID == var21.layerObject1Num)
							{
								var27.fullLoaded = var28 = false;
								this._oLoadingCells[var27] = var21;
								this.onLoadInit(var27);
							}
						}
						if(var28)
						{
							var27 = var15.Object1.createEmptyMovieClip("cell" + var20,var20);
							var27.fullLoaded = false;
							this._oLoadingCells[var27] = var21;
							this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_OBJECTS_DIR + var21.layerObject1Num + ".swf",var27);
							this._nLoadRequest++;
						}
					}
					else
					{
						if(!var17)
						{
							var27 = var15.Object1.attachMovie(var21.layerObject1Num,"cell" + var20,var20);
						}
						else
						{
							var27 = new MovieClip();
						}
						var27.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object1"];
						var27._x = var22;
						var27._y = var23;
						if(var21.groundSlope == 1 && var21.layerObject1Rot != 0)
						{
							var27._rotation = var21.layerObject1Rot * 90;
							if(var27._rotation % 180)
							{
								var27._yscale = 192.86;
								var27._xscale = 51.85;
							}
						}
						if(var21.layerObject1Flip)
						{
							var27._xscale = var27._xscale * -1;
						}
					}
					var21.mcObject1 = var27;
				}
				else
				{
					var15.Object1["cell" + var20].removeMovieClip();
				}
				if(var21.layerObjectExternal != "")
				{
					if(!var17)
					{
						var var29 = var15.Object2.attachClassMovie(ank.battlefield.mc.InteractiveObject,"cellExt" + var20,var20 * 100 + 1);
					}
					var29.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/ObjectExternal"];
					var29.initialize(this._mcBattlefield,var21,var21.layerObjectExternalInteractive);
					var29.loadExternalClip(var21.layerObjectExternal,var21.layerObjectExternalAutoSize);
					var29._x = var22;
					var29._y = var23;
					var21.mcObjectExternal = var29;
				}
				else
				{
					var15.Object2["cellExt" + var20].removeMovieClip();
					delete register21.mcObjectExternal;
				}
				if(var21.layerObject2Num != 0)
				{
					if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
					{
						var var31 = true;
						if(var16)
						{
							var var30 = var15.Object2["cell" + var20];
							if(var30 != undefined && var30.lastObject2ID == var21.layerObject2Num)
							{
								var30.fullLoaded = var31 = false;
								this._oLoadingCells[var30] = var21;
								this.onLoadInit(var30);
							}
						}
						if(var31)
						{
							var30 = var15.Object2.createEmptyMovieClip("cell" + var20,var20 * 100);
							var30.fullLoaded = false;
							this._oLoadingCells[var30] = var21;
							this._mclLoader.loadClip(ank.battlefield.Constants.STREAMING_OBJECTS_DIR + var21.layerObject2Num + ".swf",var30);
							this._nLoadRequest++;
						}
					}
					else
					{
						if(!var17)
						{
							var30 = var15.Object2.attachMovie(var21.layerObject2Num,"cell" + var20,var20 * 100);
						}
						else
						{
							var30 = new MovieClip();
						}
						var30.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object2"];
						if(var21.layerObject2Interactive)
						{
							var30.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
							var30.initialize(this._mcBattlefield,var21,true);
						}
						var30._x = var22;
						var30._y = var23;
						if(var21.layerObject2Flip)
						{
							var30._xscale = -100;
						}
					}
					var21.mcObject2 = var30;
				}
				else
				{
					var15.Object2["cell" + var20].removeMovieClip();
					delete register21.mcObject2;
				}
			}
			else if(var4)
			{
				var var32 = var9 * var5 + var11;
				var var33 = var10 * var7;
				var21.x = var32;
				var21.y = var33;
				var var34 = var15.InteractionCell.attachMovie("i1","cell" + var20,var20,{_x:var32,_y:var33});
				var34.__proto__ = ank.battlefield.mc.Cell.prototype;
				var34.initialize(this._mcBattlefield);
				var21.mc = var34;
				var34.data = var21;
			}
		}
		if(!var16)
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
	function tacticMode(var2)
	{
		var var3 = this._oDatacenter.Map;
		var var4 = var3.data;
		if(var2)
		{
			this._mcContainer.ExternalContainer.clearGround();
			if(var3.savedBackgroundNum == undefined && var3.backgroundNum != 631)
			{
				var3.savedBackgroundNum = var3.backgroundNum;
			}
			var3.backgroundNum = 631;
		}
		else if(var3.savedBackgroundNum != undefined)
		{
			if(var3.savedBackgroundNum == 0)
			{
				var3.backgroundNum = 632;
			}
			else
			{
				var3.backgroundNum = var3.savedBackgroundNum;
			}
		}
		for(var mapCell in var4)
		{
			this.tacticModeRefreshCell(Number(mapCell),var2);
		}
	}
	function tacticModeRefreshCell(var2, var3)
	{
		if(var2 > this.getCellCount())
		{
			ank.utils.Logger.err("[updateCell] Cellule " + var2 + " inexistante");
			return undefined;
		}
		var var4 = this._oDatacenter.Map;
		var var5 = var4.data[var2];
		if(!var5.active)
		{
			return undefined;
		}
		if(!var3)
		{
			var var6 = (ank.battlefield.datacenter.Cell)var4.originalsCellsBackup.getItemAt(String(var2));
			if(var6 == undefined)
			{
				ank.utils.Logger.err("La case est déjà dans son état init");
				return undefined;
			}
			var5.layerGroundNum = var6.layerGroundNum;
			var5.groundSlope = var6.groundSlope;
			var5.layerObject1Rot = var6.layerObject1Rot;
			var5.layerObject1Num = var6.layerObject1Num;
			if(var5.layerObject2Num != 25)
			{
				var5.layerObject2Num = var6.layerObject2Num;
			}
		}
		else
		{
			if(var5.nPermanentLevel == 0)
			{
				var var7 = new ank.battlefield.datacenter.();
				for(var cellData in var5)
				{
					var7[cellData] = var5[cellData];
				}
				var4.originalsCellsBackup.addItemAt(String(var2),var7);
			}
			var5.turnTactic();
		}
		this.build(var4,var2);
	}
	function updateCell(§\b\x18§, §\x1e\x1a\x05§, §\x1e\x11\x1d§, nPermanentLevel)
	{
		if(var2 > this.getCellCount())
		{
			ank.utils.Logger.err("[updateCell] Cellule " + var2 + " inexistante");
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
		var var6 = _global.parseInt(var4,16);
		var var7 = (var6 & 65536) != 0;
		var var8 = (var6 & 32768) != 0;
		var var9 = (var6 & 16384) != 0;
		var var10 = (var6 & 8192) != 0;
		var var11 = (var6 & 4096) != 0;
		var var12 = (var6 & 2048) != 0;
		var var13 = (var6 & 1024) != 0;
		var var14 = (var6 & 512) != 0;
		var var15 = (var6 & 256) != 0;
		var var16 = (var6 & 128) != 0;
		var var17 = (var6 & 64) != 0;
		var var18 = (var6 & 32) != 0;
		var var19 = (var6 & 16) != 0;
		var var20 = (var6 & 8) != 0;
		var var21 = (var6 & 4) != 0;
		var var22 = (var6 & 2) != 0;
		var var23 = (var6 & 1) != 0;
		var var24 = this._oDatacenter.Map.data[var2];
		if(nPermanentLevel > 0)
		{
			if(var24.nPermanentLevel == 0)
			{
				var var25 = new ank.battlefield.datacenter.();
				for(var k in var24)
				{
					var25[k] = var24[k];
				}
				this._oDatacenter.Map.originalsCellsBackup.addItemAt(var2,var25);
				var24.nPermanentLevel = nPermanentLevel;
			}
		}
		if(var10)
		{
			var24.active = var3.active;
		}
		if(var11)
		{
			var24.lineOfSight = var3.lineOfSight;
		}
		if(var12)
		{
			var24.movement = var3.movement;
		}
		if(var13)
		{
			var24.groundLevel = var3.groundLevel;
		}
		if(var14)
		{
			var24.groundSlope = var3.groundSlope;
		}
		if(var15)
		{
			var24.layerGroundNum = var3.layerGroundNum;
		}
		if(var16)
		{
			var24.layerGroundFlip = var3.layerGroundFlip;
		}
		if(var17)
		{
			var24.layerGroundRot = var3.layerGroundRot;
		}
		if(var18)
		{
			var24.layerObject1Num = var3.layerObject1Num;
		}
		if(var20)
		{
			var24.layerObject1Rot = var3.layerObject1Rot;
		}
		if(var19)
		{
			var24.layerObject1Flip = var3.layerObject1Flip;
		}
		if(var22)
		{
			var24.layerObject2Flip = var3.layerObject2Flip;
		}
		if(var23)
		{
			var24.layerObject2Interactive = var3.layerObject2Interactive;
		}
		if(var21)
		{
			var24.layerObject2Num = var3.layerObject2Num;
		}
		if(var9)
		{
			var24.layerObjectExternal = var3.layerObjectExternal;
		}
		if(var8)
		{
			var24.layerObjectExternalInteractive = var3.layerObjectExternalInteractive;
		}
		if(var7)
		{
			var24.layerObjectExternalAutoSize = var3.layerObjectExternalAutoSize;
		}
		var24.layerObjectExternalData = var3.layerObjectExternalData;
		this.build(this._oDatacenter.Map,var2);
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
		var var3 = this._oDatacenter.Map;
		if(var3.savedBackgroundNum != undefined)
		{
			if(var3.savedBackgroundNum == 0)
			{
				var3.backgroundNum = 632;
			}
			else
			{
				var3.backgroundNum = var3.savedBackgroundNum;
			}
		}
		var var4 = var3.data;
		var var5 = var3.originalsCellsBackup.getItems();
		for(var k in var5)
		{
			this.initializeCell(Number(k),nPermanentLevel);
		}
	}
	function initializeCell(var2, var3, var4)
	{
		if(nPermanentLevel == undefined)
		{
			nPermanentLevel = Number.POSITIVE_INFINITY;
		}
		else
		{
			nPermanentLevel = Number(nPermanentLevel);
		}
		var var5 = this._oDatacenter.Map;
		var var6 = var5.data;
		var var7 = var5.originalsCellsBackup.getItemAt(String(var2));
		if(var7 == undefined)
		{
			ank.utils.Logger.err("La case est déjà dans son état init");
			return undefined;
		}
		if(var6[var2].nPermanentLevel <= nPermanentLevel)
		{
			if(var4 == true)
			{
				var var8 = var6[var2].isTactic;
				var var9 = new ank.battlefield.datacenter.();
				for(var cellData in var7)
				{
					var9[cellData] = var7[cellData];
				}
				if(var8)
				{
					var9.turnTactic();
				}
				var6[var2] = var9;
				this.build(var5,var2);
				if(!var8)
				{
					var5.originalsCellsBackup.removeItemAt(String(var2));
				}
			}
			else
			{
				var6[var2] = var7;
				this.build(var5,var2);
				var5.originalsCellsBackup.removeItemAt(String(var2));
			}
		}
	}
	function setObject2Frame(var2, var3)
	{
		if(typeof var3 == "number" && var3 < 1)
		{
			ank.utils.Logger.err("[setObject2Frame] frame " + var3 + " incorecte");
			return undefined;
		}
		if(var2 > this.getCellCount())
		{
			ank.utils.Logger.err("[setObject2Frame] Cellule " + var2 + " inexistante");
			return undefined;
		}
		var var4 = this._oDatacenter.Map.data[var2];
		var var5 = var4.mcObject2;
		if(ank.battlefield.Constants.USE_STREAMING_FILES && (ank.battlefield.Constants.STREAMING_METHOD == "explod" && !var5.fullLoaded))
		{
			this._oSettingFrames[var2] = var3;
		}
		else if(ank.battlefield.Constants.USE_STREAMING_FILES && ank.battlefield.Constants.STREAMING_METHOD == "explod")
		{
			for(var s in var5)
			{
				if(var5[s] instanceof MovieClip)
				{
					var5[s].gotoAndStop(var3);
				}
			}
		}
		else
		{
			var5.gotoAndStop(var3);
		}
	}
	function setObjectExternalFrame(var2, var3)
	{
		if(typeof var3 == "number" && var3 < 1)
		{
			ank.utils.Logger.err("[setObject2Frame] frame " + var3 + " incorecte");
			return undefined;
		}
		if(var2 > this.getCellCount())
		{
			ank.utils.Logger.err("[setObject2Frame] Cellule " + var2 + " inexistante");
			return undefined;
		}
		var var4 = this._oDatacenter.Map.data[var2];
		var var5 = var4.mcObjectExternal._mcExternal;
		var5.gotoAndStop(var3);
	}
	function setObject2Interactive(§\b\x18§, §\x19\x05§, nPermanentLevel)
	{
		if(var2 > this.getCellCount())
		{
			ank.utils.Logger.err("[setObject2State] Cellule " + var2 + " inexistante");
			return undefined;
		}
		var var5 = this._oDatacenter.Map.data[var2];
		var5.mcObject2.select(false);
		var var6 = new ank.battlefield.datacenter.();
		var6.layerObject2Interactive = var3;
		this.updateCell(var2,var6,"1",nPermanentLevel);
	}
	function getCellCount(var2)
	{
		return this._oDatacenter.Map.data.length;
	}
	function getCellData(var2)
	{
		return this._oDatacenter.Map.data[var2];
	}
	function getCellsData(var2)
	{
		return this._oDatacenter.Map.data;
	}
	function getWidth(var2)
	{
		return this._oDatacenter.Map.width;
	}
	function getHeight(var2)
	{
		return this._oDatacenter.Map.height;
	}
	function getCaseNum(var2, var3)
	{
		var var4 = this.getWidth();
		return var2 * var4 + var3 * (var4 - 1);
	}
	function getCellHeight(var2)
	{
		var var3 = this.getCellData(var2);
		var var4 = !(var3.groundSlope == undefined || var3.groundSlope == 1)?0.5:0;
		var var5 = var3.groundLevel != undefined?var3.groundLevel - 7:0;
		return var5 + var4;
	}
	function getLayerByCellPropertyName(var2)
	{
		var var3 = new Array();
		for(var i in this._oDatacenter.Map.data)
		{
			var3.push(this._oDatacenter.Map.data[i][var2]);
		}
		return var3;
	}
	function resetEmptyCells()
	{
		var var2 = this._mcBattlefield.spriteHandler.getSprites().getItems();
		var var3 = new Array();
		for(var k in var2)
		{
			var3[var2[k].cellNum] = true;
		}
		var var4 = this.getCellCount();
		var var5 = 0;
		var var6 = 0;
		while(var6 < var4)
		{
			if(var3[var6] != true)
			{
				var var7 = this._mcBattlefield.mapHandler.getCellData(var6);
				var5 = var5 + var7.spriteOnCount;
				var7.removeAllSpritesOnID();
			}
			var6 = var6 + 1;
		}
		if(var5 > 0)
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
	function onLoadInit(var2)
	{
		this._nLoadRequest--;
		if(this._oLoadingCells[var2] == undefined)
		{
			return undefined;
		}
		var var3 = String(var2).split(".");
		var var4 = var3[var3.length - 2];
		var var5 = this._oLoadingCells[var2];
		switch(var4)
		{
			case "Ground":
				var2.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Ground"];
				var2._x = Number(var5.x);
				var2._y = Number(var5.y);
				if(var5.groundSlope == 1 && var5.layerGroundRot != 0)
				{
					var2._rotation = var5.layerGroundRot * 90;
					if(var2._rotation % 180)
					{
						var2._yscale = 192.86;
						var2._xscale = 51.85;
					}
					else
					{
						var2._xscale = var0 = 100;
						var2._yscale = var0;
					}
				}
				else
				{
					var2._rotation = 0;
					var2._xscale = var0 = 100;
					var2._yscale = var0;
				}
				if(var5.layerGroundFlip)
				{
					var2._xscale = var2._xscale * -1;
				}
				else
				{
					var2._xscale = var2._xscale * 1;
				}
				if(var5.groundSlope != 1)
				{
					var2.gotoAndStop(var5.groundSlope);
				}
				var2.lastGroundID = var5.layerGroundNum;
				break;
			case "Object1":
				var2.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object1"];
				var2._x = Number(var5.x);
				var2._y = Number(var5.y);
				if(var5.groundSlope == 1 && var5.layerObject1Rot != 0)
				{
					var2._rotation = var5.layerObject1Rot * 90;
					if(var2._rotation % 180)
					{
						var2._yscale = 192.86;
						var2._xscale = 51.85;
					}
					else
					{
						var2._xscale = var0 = 100;
						var2._yscale = var0;
					}
				}
				else
				{
					var2._rotation = 0;
					var2._xscale = var0 = 100;
					var2._yscale = var0;
				}
				if(var5.layerObject1Flip)
				{
					var2._xscale = var2._xscale * -1;
				}
				else
				{
					var2._xscale = var2._xscale * 1;
				}
				var2.lastObject1ID = var5.layerObject1Num;
				break;
			case "Object2":
				var2.cacheAsBitmap = _global.CONFIG.cacheAsBitmap["mapHandler/Cell/Object2"];
				var2._x = Number(var5.x);
				var2._y = Number(var5.y);
				if(var5.layerObject2Interactive)
				{
					var2.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
					var2.initialize(this._mcBattlefield,var5,true);
				}
				else
				{
					var2.__proto__ = MovieClip.prototype;
				}
				if(var5.layerObject2Flip)
				{
					var2._xscale = -100;
				}
				else
				{
					var2._xscale = 100;
				}
				var2.lastObject2ID = var5.layerObject2Num;
		}
		if(this._oSettingFrames[var5.num] != undefined)
		{
			var var6 = this._oDatacenter.Map.data[var5.num].mcObject2;
			for(var s in var6)
			{
				if(var6[s] instanceof MovieClip)
				{
					var6[s].gotoAndStop(this._oSettingFrames[var5.num]);
				}
			}
			delete this._oSettingFrames[var5.num];
		}
		var2.fullLoaded = true;
		delete this._oLoadingCells.register2;
	}
	function showTriggers()
	{
		var var2 = this.getCellsData();
		for(var i in var2)
		{
			var var3 = var2[i];
			var var4 = var3.isTrigger;
			if(var4)
			{
				this.flagCellNonBlocking(var3.num);
			}
		}
	}
	function flagCellNonBlocking(var2)
	{
		var var3 = this.api.datacenter.Player.ID;
		var var4 = new ank.battlefield.datacenter.();
		var4.file = dofus.Constants.CLIPS_PATH + "flag.swf";
		var4.bInFrontOfSprite = true;
		var4.bTryToBypassContainerColor = true;
		this.api.gfx.spriteLaunchVisualEffect(var3,var4,var2,11,undefined,undefined,undefined,true,false);
	}
}
