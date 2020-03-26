class ank.battlefield.Battlefield extends MovieClip
{
   var _bJumpActivate = false;
   static var FRAMELOADTIMOUT = 500;
   var _bUseCustomGroundGfxFile = false;
   var bGhostView = false;
   var bCustomFileLoaded = false;
   function Battlefield()
   {
      super();
   }
   function __get__isMapBuild()
   {
      if(this._bMapBuild)
      {
         return true;
      }
      ank.utils.Logger.err("[isMapBuild] Carte non chargée");
      return false;
   }
   function __set__screenWidth(nScreenWidth)
   {
      this._nScreenWidth = nScreenWidth;
      return this.__get__screenWidth();
   }
   function __get__screenWidth()
   {
      return this._nScreenWidth != undefined?this._nScreenWidth:ank.battlefield.Constants.DISPLAY_WIDTH;
   }
   function __set__screenHeight(nScreenHeight)
   {
      this._nScreenHeight = nScreenHeight;
      return this.__get__screenHeight();
   }
   function __get__screenHeight()
   {
      return this._nScreenHeight != undefined?this._nScreenHeight:ank.battlefield.Constants.DISPLAY_HEIGHT;
   }
   function __set__isJumpActivate(bJumpActivate)
   {
      this._bJumpActivate = bJumpActivate;
      return this.__get__isJumpActivate();
   }
   function __get__isJumpActivate()
   {
      return this._bJumpActivate;
   }
   function __get__container()
   {
      return this._mcMainContainer;
   }
   function __get__datacenter()
   {
      return this._oDatacenter;
   }
   function initialize(oDatacenter, sGroundFile, sObjectFile, sAccessoriesPath)
   {
      this._oDatacenter = oDatacenter;
      this._sGroundFile = sGroundFile;
      if(!this.initializeDatacenter())
      {
         ank.utils.Logger.err("BattleField -> Init datacenter impossible");
         this.onInitError();
      }
      ank.utils.Extensions.addExtensions();
      if(_global.GAC == undefined)
      {
         _global.GAC = new ank.battlefield.GlobalSpriteHandler();
         _global.GAC.setAccessoriesRoot(sAccessoriesPath);
      }
      this.attachClassMovie(ank.battlefield.mc.Container,"_mcMainContainer",10,[this,this._oDatacenter,sObjectFile]);
      this._bMapBuild = false;
      this.loadManager = new ank.battlefield.LoadManager(this.createEmptyMovieClip("LoadManager",this.getNextHighestDepth()));
   }
   function setStreaming(status, objectsDir, groundsDir)
   {
      ank.battlefield.Constants.USE_STREAMING_FILES = status;
      ank.battlefield.Constants.STREAMING_OBJECTS_DIR = objectsDir;
      ank.battlefield.Constants.STREAMING_GROUNDS_DIR = groundsDir;
   }
   function setStreamingMethod(sName)
   {
      ank.battlefield.Constants.STREAMING_METHOD = sName;
   }
   function setCustomGfxFile(sPathGfxGround, sPathGfxObject)
   {
      if(sPathGfxGround && (sPathGfxGround != "" && this._sGroundFile != sPathGfxGround))
      {
         this._sGroundFile = sPathGfxGround;
         this._bUseCustomGroundGfxFile = true;
         this.bCustomFileLoaded = false;
      }
      if(sPathGfxObject && (sPathGfxObject != "" && this._sObjectFile != sPathGfxObject))
      {
         this._mcMainContainer.initialize(this._mcMainContainer,this._oDatacenter,sPathGfxObject);
         this.bCustomFileLoaded = false;
         this._sObjectFile = sPathGfxObject;
      }
   }
   function activateTacticMode(bOrig)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.mapHandler.tacticMode(bOrig);
   }
   function clear()
   {
      this._mcMainContainer.clear();
      this._sGroundFile = "";
      this._sObjectFile = "";
      ank.utils.Timer.clear("battlefield");
      ank.utils.CyclicTimer.clear();
      this.initializeDatacenter();
      this.createHandlers();
      this._bMapBuild = false;
   }
   function setColor(t)
   {
      this._mcMainContainer.setColor(t);
   }
   function cleanMap(nPermanentLevel, bKeepData)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      if(nPermanentLevel == undefined)
      {
         nPermanentLevel = Number.POSITIVE_INFINITY;
      }
      else
      {
         nPermanentLevel = Number(nPermanentLevel);
      }
      this.mapHandler.initializeMap(nPermanentLevel);
      this.unSelect(true);
      this.clearAllZones();
      this.clearPointer();
      this.removeGrid();
      this.clearAllSprites(bKeepData);
      this.overHeadHandler.clear();
      this.textHandler.clear();
      this.pointsHandler.clear();
      ank.utils.Timer.clean();
      ank.utils.CyclicTimer.clear();
   }
   function getZoom()
   {
      return this._mcMainContainer.getZoom();
   }
   function showContainer(bool)
   {
      this._mcMainContainer._visible = bool;
   }
   function zoom(nFactor)
   {
      this._mcMainContainer.zoom(nFactor);
   }
   function buildMapFromObject(oMap, bBuildAll)
   {
      this.clear();
      if(oMap == undefined)
      {
         return undefined;
      }
      this.onMapBuilding();
      this.mapHandler.build(oMap,undefined,bBuildAll);
      if(this.mapHandler.LoaderRequestLeft == 0)
      {
         this.DispatchMapLoaded();
      }
      else
      {
         this._nFrameLoadTimeOut = ank.battlefield.Battlefield.FRAMELOADTIMOUT;
         var ref = this;
         this.onEnterFrame = function()
         {
            ref._nFrameLoadTimeOut--;
            if(ref._nFrameLoadTimeOut <= 0 || ref.mapHandler.LoaderRequestLeft <= 0)
            {
               delete ref.onEnterFrame;
               ref.DispatchMapLoaded();
            }
         };
      }
   }
   function DispatchMapLoaded()
   {
      this._bMapBuild = true;
      this.onMapLoaded();
   }
   function buildMap(nID, sName, nWidth, nHeight, nBackID, sCompressedData, oMap, bBuildAll)
   {
      if(oMap == undefined)
      {
         oMap = new ank.battlefield.datacenter.Map();
      }
      ank.battlefield.utils.Compressor.uncompressMap(nID,sName,nWidth,nHeight,nBackID,sCompressedData,oMap,bBuildAll);
      this.buildMapFromObject(oMap,bBuildAll);
   }
   function updateCell(nCellNum, sCompressData, sMaskHexStr, nPermanentLevel)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      if(sCompressData == undefined)
      {
         this.mapHandler.initializeCell(nCellNum,Number.POSITIVE_INFINITY,true);
      }
      else
      {
         var _loc6_ = ank.battlefield.utils.Compressor.uncompressCell(sCompressData,true);
         this.mapHandler.updateCell(nCellNum,_loc6_,sMaskHexStr,nPermanentLevel);
      }
   }
   function setObject2Frame(nCellNum, frame)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.mapHandler.setObject2Frame(nCellNum,frame);
   }
   function setObject2Interactive(nCellNum, bInteractive, nPermanentLevel)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.mapHandler.setObject2Interactive(nCellNum,bInteractive,nPermanentLevel);
   }
   function updateCellObjectExternalWithExternalClip(nCellNum, sFile, nPermanentLevel, bInteractive, bAutoSize, oExternalData)
   {
      var _loc8_ = new ank.battlefield.datacenter.Cell();
      _loc8_.layerObjectExternal = sFile;
      _loc8_.layerObjectExternalInteractive = bInteractive != undefined?bInteractive:true;
      _loc8_.layerObjectExternalAutoSize = bAutoSize;
      _loc8_.layerObjectExternalData = oExternalData;
      this.mapHandler.updateCell(nCellNum,_loc8_,"1C000",nPermanentLevel);
   }
   function setObjectExternalFrame(nCellNum, frame)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.mapHandler.setObjectExternalFrame(nCellNum,frame);
   }
   function initializeCell(nCellNum, nPermanentLevel)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.mapHandler.initializeCell(nCellNum,nPermanentLevel);
   }
   function select(cellList, nColor, sLayer, nAlpha)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      if(typeof cellList == "object")
      {
         this.selectionHandler.selectMultiple(true,cellList,nColor,sLayer,nAlpha);
      }
      else if(typeof cellList == "number")
      {
         this.selectionHandler.select(true,cellList,nColor,sLayer,nAlpha);
      }
   }
   function unSelect(bAll, cellList, sLayer)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      if(bAll)
      {
         this.selectionHandler.clear();
      }
      else if(typeof cellList == "object")
      {
         this.selectionHandler.selectMultiple(false,cellList,undefined,sLayer);
      }
      else if(typeof cellList == "number")
      {
         this.selectionHandler.select(false,cellList,undefined,sLayer);
      }
      else if(sLayer != undefined)
      {
         this.selectionHandler.clearLayer(sLayer);
      }
   }
   function unSelectAllButOne(sLayer)
   {
      var _loc3_ = this.selectionHandler.getLayers();
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.length)
      {
         if(_loc3_[_loc4_] != sLayer)
         {
            this.selectionHandler.clearLayer(_loc3_[_loc4_]);
         }
         _loc4_ = _loc4_ + 1;
      }
   }
   function setInteraction(nState)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.interactionHandler.setEnabled(nState);
   }
   function setInteractionOnCell(nCellNum, nState)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.interactionHandler.setEnabledCell(nCellNum,nState);
   }
   function setInteractionOnCells(aCells, nState)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      for(var k in aCells)
      {
         this.interactionHandler.setEnabledCell(aCells[k],nState);
      }
   }
   function drawZone(nCellNum, nRadiusIn, nRadiusOut, sLayer, nColor, sShape)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.zoneHandler.drawZone(nCellNum,nRadiusIn,nRadiusOut,sLayer,nColor,sShape);
   }
   function clearZone(nCellNum, nRadius, sLayer)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.zoneHandler.clearZone(nCellNum,nRadius,sLayer);
   }
   function clearZoneLayer(sLayer)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.zoneHandler.clearZoneLayer(sLayer);
   }
   function clearAllZones(Void)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.zoneHandler.clear();
   }
   function clearPointer(Void)
   {
      this.pointerHandler.clear();
   }
   function hidePointer(Void)
   {
      this.pointerHandler.hide();
   }
   function addPointerShape(sShape, mSize, nColor, nCellNumRef)
   {
      this.pointerHandler.addShape(sShape,mSize,nColor,nCellNumRef);
   }
   function drawPointer(nCellNum)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.pointerHandler.draw(nCellNum);
   }
   function getSprite(sID)
   {
      return this.spriteHandler.getSprite(sID);
   }
   function getSprites()
   {
      return this.spriteHandler.getSprites();
   }
   function addSprite(sID, spriteData)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.addSprite(sID,spriteData);
   }
   function addLinkedSprite(sID, sParentID, nChildIndex, oSprite)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.addLinkedSprite(sID,sParentID,nChildIndex,oSprite);
   }
   function carriedSprite(sID, sParentID)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.carriedSprite(sID,sParentID);
   }
   function uncarriedSprite(sID, nCellNum, bWithAnimation, oSeq)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.uncarriedSprite(sID,nCellNum,bWithAnimation,oSeq);
   }
   function mountSprite(sID, oMount)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.mountSprite(sID,oMount);
   }
   function unmountSprite(sID)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.unmountSprite(sID);
   }
   function clearAllSprites(bKeepData)
   {
      this.spriteHandler.clear(bKeepData);
   }
   function removeSprite(sID, bKeepData)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.removeSprite(sID,bKeepData);
   }
   function hideSprite(sID, bool)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.hideSprite(sID,bool);
   }
   function setSpritePosition(sID, nCellNum, dir)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpritePosition(sID,nCellNum,dir);
   }
   function setSpriteDirection(sID, nDir)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteDirection(sID,nDir);
   }
   function stopSpriteMove(sID, oSeq, nCellNum)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.stopSpriteMove(sID,oSeq,nCellNum);
   }
   function moveSprite(sID, compressedPath, oSeq, bClearSequencer, bForcedRun, bForcedWalk, nRunLimit)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      var _loc9_ = ank.battlefield.utils.Compressor.extractFullPath(this.mapHandler,compressedPath);
      this.moveSpriteWithUncompressedPath(sID,_loc9_,oSeq,bClearSequencer,bForcedRun,bForcedWalk,nRunLimit);
   }
   function moveSpriteWithUncompressedPath(sID, aPath, oSeq, bClearSequencer, bForcedRun, bForcedWalk, nRunLimit, sAnimation)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      if(aPath != undefined)
      {
         this.spriteHandler.moveSprite(sID,aPath,oSeq,bClearSequencer,sAnimation,bForcedRun,bForcedWalk,nRunLimit);
      }
   }
   function slideSprite(sID, nCellNum, oSeq, sAnimation)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.slideSprite(sID,nCellNum,oSeq,sAnimation);
   }
   function autoCalculateSpriteDirection(sID, nCellNum)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.autoCalculateSpriteDirection(sID,nCellNum);
   }
   function convertHeightToFourSpriteDirection(sID)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.convertHeightToFourSpriteDirection(sID);
   }
   function setForcedSpriteAnim(sID, sAnim)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteAnim(sID,sAnim,true);
   }
   function setSpriteAnim(sID, sAnim)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteAnim(sID,sAnim);
   }
   function setSpriteLoopAnim(sID, sAnim, nTimer)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteLoopAnim(sID,sAnim,nTimer);
   }
   function setSpriteTimerAnim(sID, sAnim, bForced, nTimer)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteTimerAnim(sID,sAnim,bForced,nTimer);
   }
   function setSpriteGfx(sID, sFile)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteGfx(sID,sFile);
   }
   function setSpriteColorTransform(sID, oTransform)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteColorTransform(sID,oTransform);
   }
   function setSpriteAlpha(sID, nAlpha)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteAlpha(sID,nAlpha);
   }
   function spriteLaunchVisualEffect(sID, oEffectData, nCellNum, nDisplayType, mSpriteAnimation, sTargetID, oSpriteToHideDuringAnimation, bForceVisible, bBlocking)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.launchVisualEffect(sID,oEffectData,nCellNum,nDisplayType,mSpriteAnimation,sTargetID,oSpriteToHideDuringAnimation,bForceVisible,bBlocking);
   }
   function spriteLaunchCarriedSprite(sID, oEffectData, nCellNum, nDisplayType)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.launchCarriedSprite(sID,oEffectData,nCellNum,nDisplayType);
   }
   function selectSprite(sID, bSelect)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.selectSprite(sID,bSelect);
   }
   function addSpriteBubble(sID, sText, nType)
   {
      var _loc5_ = this._oDatacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         ank.utils.Logger.err("[addSpriteBubble] Sprite inexistant (sprite Id : " + sID + ")");
         return undefined;
      }
      if(_loc5_.isInMove)
      {
         return undefined;
      }
      if(!_loc5_.isVisible)
      {
         return undefined;
      }
      var _loc6_ = _loc5_.mc;
      var _loc7_ = _loc6_._x;
      var _loc8_ = _loc6_._y;
      if(nType == undefined)
      {
         nType = ank.battlefield.TextHandler.BUBBLE_TYPE_CHAT;
      }
      if(_loc7_ == 0 || _loc8_ == 0)
      {
         ank.utils.Logger.err("[addSpriteBubble] le sprite n\'est pas encore placé");
         return undefined;
      }
      this.textHandler.addBubble(sID,_loc7_,_loc8_,sText,nType);
   }
   function removeSpriteBubble(sID)
   {
      var _loc3_ = this._oDatacenter.Sprites.getItemAt(sID);
      if(_loc3_ == undefined)
      {
         return undefined;
      }
      this.textHandler.removeBubble(sID);
   }
   function addSpritePoints(sID, sValue, nColor)
   {
      var _loc5_ = this._oDatacenter.Sprites.getItemAt(sID);
      if(_loc5_ == undefined)
      {
         ank.utils.Logger.err("[addSpritePoints] Sprite inexistant");
         return undefined;
      }
      if(!_loc5_.isVisible)
      {
         return undefined;
      }
      var _loc6_ = _loc5_.mc;
      var _loc7_ = _loc6_._x;
      var _loc8_ = _loc6_._y - ank.battlefield.Constants.DEFAULT_SPRITE_HEIGHT;
      if(_loc7_ == 0 || _loc8_ == 0)
      {
         ank.utils.Logger.err("[addSpritePoints] le sprite n\'est pas encore placé");
         return undefined;
      }
      this.pointsHandler.addPoints(sID,_loc7_,_loc8_,sValue,nColor);
   }
   function addSpriteOverHeadItem(sID, sLayerName, className, aArgs, nDelay, bEvenInMove)
   {
      var _loc8_ = this._oDatacenter.Sprites.getItemAt(sID);
      if(_loc8_ == undefined)
      {
         ank.utils.Logger.err("[addSpriteOverHeadItem] Sprite inexistant");
         return undefined;
      }
      if(_loc8_.isInMove && !bEvenInMove)
      {
         return undefined;
      }
      if(!_loc8_.isVisible)
      {
         return undefined;
      }
      var _loc9_ = _loc8_.mc;
      this.overHeadHandler.addOverHeadItem(sID,_loc9_._x,_loc9_._y,_loc9_,sLayerName,className,aArgs,nDelay);
   }
   function removeSpriteOverHeadLayer(sID, sLayerName)
   {
      this.overHeadHandler.removeOverHeadLayer(sID,sLayerName);
   }
   function hideSpriteOverHead(sID)
   {
      this.overHeadHandler.removeOverHead(sID);
   }
   function addSpriteExtraClipOnTimer(sID, sFile, nColor, bTop, nDuration)
   {
      this.addSpriteExtraClip(sID,sFile,nColor,bTop);
      var _loc7_ = new Object();
      _loc7_.timerId = _global.setInterval(this,"removeSpriteExtraClipOnTimer",nDuration,_loc7_,sID,bTop);
   }
   function removeSpriteExtraClipOnTimer(oTimer, sID, bTop)
   {
      _global.clearInterval(oTimer.timerId);
      this.removeSpriteExtraClip(sID,bTop);
   }
   function addSpriteExtraClip(sID, sFile, nColor, bTop)
   {
      this.spriteHandler.addSpriteExtraClip(sID,sFile,nColor,bTop);
   }
   function removeSpriteExtraClip(sID, bTop)
   {
      this.spriteHandler.removeSpriteExtraClip(sID,bTop);
   }
   function showSpritePoints(sID, nValue, nColor)
   {
      this.spriteHandler.showSpritePoints(sID,nValue,nColor);
   }
   function setSpriteGhostView(bool)
   {
      this.bGhostView = bool;
      this.spriteHandler.setSpriteGhostView(bool);
   }
   function setSpriteScale(sID, nScaleX, nScaleY)
   {
      this.spriteHandler.setSpriteScale(sID,nScaleX,nScaleY);
   }
   function drawGrid(bAll)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      if(this.gridHandler.bGridVisible)
      {
         this.removeGrid();
      }
      else
      {
         this.gridHandler.draw(bAll);
      }
   }
   function removeGrid(Void)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.gridHandler.clear();
   }
   function addVisualEffectOnSprite(sID, oEffectData, nCellNum, nDisplayType, sTargetID)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      var _loc7_ = this._oDatacenter.Sprites.getItemAt(sID);
      var _loc8_ = this._oDatacenter.Sprites.getItemAt(sTargetID);
      this.visualEffectHandler.addEffect(_loc7_,oEffectData,nCellNum,nDisplayType,_loc8_);
   }
   function initializeDatacenter(Void)
   {
      if(this._oDatacenter == undefined)
      {
         return false;
      }
      this._oDatacenter.Map.cleanSpritesOn();
      this._oDatacenter.Map = new ank.battlefield.datacenter.Map();
      this._oDatacenter.Sprites = new ank.utils.ExtendedObject();
      return true;
   }
   function createHandlers(Void)
   {
      this.mapHandler = new ank.battlefield.MapHandler(this,this._mcMainContainer,this._oDatacenter);
      this.spriteHandler = new ank.battlefield.SpriteHandler(this,this._mcMainContainer.ExternalContainer.Object2,this._oDatacenter.Sprites);
      this.interactionHandler = new ank.battlefield.InteractionHandler(this._mcMainContainer.ExternalContainer.InteractionCell,this._oDatacenter);
      this.zoneHandler = new ank.battlefield.ZoneHandler(this,this._mcMainContainer.ExternalContainer.Zone);
      this.pointerHandler = new ank.battlefield.PointerHandler(this,this._mcMainContainer.ExternalContainer.Pointer);
      this.selectionHandler = new ank.battlefield.SelectionHandler(this,this._mcMainContainer.ExternalContainer,this._oDatacenter);
      this.gridHandler = new ank.battlefield.GridHandler(this._mcMainContainer.ExternalContainer.Grid,this._oDatacenter);
      this.visualEffectHandler = new ank.battlefield.VisualEffectHandler(this,this._mcMainContainer.ExternalContainer.Object2);
      this.textHandler = new ank.battlefield.TextHandler(this,this._mcMainContainer.Text,this._oDatacenter);
      this.pointsHandler = new ank.battlefield.PointsHandler(this,this._mcMainContainer.Points,this._oDatacenter);
      this.overHeadHandler = new ank.battlefield.OverHeadHandler(this,this._mcMainContainer.OverHead);
   }
   function onLoadInit(mc)
   {
      if((var _loc0_ = mc._name) !== "Ground")
      {
         mc.__proto__ = ank.battlefield.mc.ExternalContainer.prototype;
         mc.initialize(this._sGroundFile);
         this.createHandlers();
      }
      else
      {
         mc._parent.useCustomGroundGfxFile(this._bUseCustomGroundGfxFile);
         this.bCustomFileLoaded = true;
         this.onInitComplete();
      }
   }
   function onLoadError(mc)
   {
      this.onInitError();
   }
   function onLoadProgress(mc, nBL, nBT)
   {
      this.onInitProgress(nBL,nBT);
   }
}
