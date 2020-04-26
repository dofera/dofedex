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
		ank.utils.SharedObjectFix.err("[isMapBuild] Carte non chargée");
		return false;
	}
	function __set__screenWidth(_loc2_)
	{
		this._nScreenWidth = _loc2_;
		return this.__get__screenWidth();
	}
	function __get__screenWidth()
	{
		return this._nScreenWidth != undefined?this._nScreenWidth:ank.battlefield.Constants.DISPLAY_WIDTH;
	}
	function __set__screenHeight(_loc2_)
	{
		this._nScreenHeight = _loc2_;
		return this.__get__screenHeight();
	}
	function __get__screenHeight()
	{
		return this._nScreenHeight != undefined?this._nScreenHeight:ank.battlefield.Constants.DISPLAY_HEIGHT;
	}
	function __set__isJumpActivate(_loc2_)
	{
		this._bJumpActivate = _loc2_;
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
	function __get__isContainerVisible()
	{
		return this._mcMainContainer._visible;
	}
	function __get__datacenter()
	{
		return this._oDatacenter;
	}
	function initialize(_loc2_, _loc3_, _loc4_, _loc5_)
	{
		this._oDatacenter = _loc2_;
		this._sGroundFile = _loc3_;
		if(!this.initializeDatacenter())
		{
			ank.utils.SharedObjectFix.err("BattleField -> Init datacenter impossible");
			this.onInitError();
		}
		ank.utils.Extensions.addExtensions();
		if(_global.GAC == undefined)
		{
			_global.GAC = new ank.battlefield.();
			_global.GAC.setAccessoriesRoot(_loc5_);
		}
		this.attachClassMovie(ank.battlefield.mc.Container,"_mcMainContainer",10,[this,this._oDatacenter,_loc4_]);
		this._bMapBuild = false;
		this.loadManager = new ank.battlefield.LoadManager(this.createEmptyMovieClip("LoadManager",this.getNextHighestDepth()));
	}
	function setStreaming(_loc2_, _loc3_, _loc4_)
	{
		ank.battlefield.Constants.USE_STREAMING_FILES = _loc2_;
		ank.battlefield.Constants.STREAMING_OBJECTS_DIR = _loc3_;
		ank.battlefield.Constants.STREAMING_GROUNDS_DIR = _loc4_;
	}
	function setStreamingMethod(_loc2_)
	{
		ank.battlefield.Constants.STREAMING_METHOD = _loc2_;
	}
	function setCustomGfxFile(_loc2_, _loc3_)
	{
		if(_loc2_ && (_loc2_ != "" && this._sGroundFile != _loc2_))
		{
			this._sGroundFile = _loc2_;
			this._bUseCustomGroundGfxFile = true;
			this.bCustomFileLoaded = false;
		}
		if(_loc3_ && (_loc3_ != "" && this._sObjectFile != _loc3_))
		{
			this._mcMainContainer.initialize(this._mcMainContainer,this._oDatacenter,_loc3_);
			this.bCustomFileLoaded = false;
			this._sObjectFile = _loc3_;
		}
	}
	function activateTacticMode(_loc2_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.tacticMode(_loc2_);
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
	function setColor(_loc2_)
	{
		this._mcMainContainer.setColor(_loc2_);
	}
	function cleanMap(nPermanentLevel, §\x18\x14§)
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
		this.clearAllSprites(_loc3_);
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
	function showContainer(_loc2_)
	{
		this._mcMainContainer._visible = _loc2_;
	}
	function zoom(_loc2_)
	{
		this._mcMainContainer.zoom(_loc2_);
	}
	function buildMapFromObject(_loc2_, _loc3_)
	{
		this.clear();
		if(_loc2_ == undefined)
		{
			return undefined;
		}
		this.onMapBuilding();
		this.mapHandler.build(_loc2_,undefined,_loc3_);
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
	function buildMap(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_)
	{
		if(_loc8_ == undefined)
		{
			_loc8_ = new ank.battlefield.datacenter.Map();
		}
		ank.battlefield.utils.Compressor.uncompressMap(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
		this.buildMapFromObject(_loc8_,_loc9_);
	}
	function updateCell(§\b\x1a§, §\x1e\x15\f§, §\x1e\x12\x01§, nPermanentLevel)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(_loc3_ == undefined)
		{
			this.mapHandler.initializeCell(_loc2_,Number.POSITIVE_INFINITY,true);
		}
		else
		{
			var _loc6_ = ank.battlefield.utils.Compressor.uncompressCell(_loc3_,true);
			this.mapHandler.updateCell(_loc2_,_loc6_,_loc4_,nPermanentLevel);
		}
	}
	function setObject2Frame(_loc2_, _loc3_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.setObject2Frame(_loc2_,_loc3_);
	}
	function setObject2Interactive(§\b\x1a§, §\x19\x06§, nPermanentLevel)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.setObject2Interactive(_loc2_,_loc3_,nPermanentLevel);
	}
	function updateCellObjectExternalWithExternalClip(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_)
	{
		var _loc8_ = new ank.battlefield.datacenter.();
		_loc8_.layerObjectExternal = _loc3_;
		_loc8_.layerObjectExternalInteractive = _loc5_ != undefined?_loc5_:true;
		_loc8_.layerObjectExternalAutoSize = _loc6_;
		_loc8_.layerObjectExternalData = _loc7_;
		this.mapHandler.updateCell(_loc2_,_loc8_,"1C000",nPermanentLevel);
	}
	function setObjectExternalFrame(_loc2_, _loc3_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.setObjectExternalFrame(_loc2_,_loc3_);
	}
	function initializeCell(§\b\x1a§, nPermanentLevel)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.initializeCell(_loc2_,nPermanentLevel);
	}
	function select(_loc2_, _loc3_, _loc4_, _loc5_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(typeof _loc2_ == "object")
		{
			this.selectionHandler.selectMultiple(true,_loc2_,_loc3_,_loc4_,_loc5_);
		}
		else if(typeof _loc2_ == "number")
		{
			this.selectionHandler.select(true,_loc2_,_loc3_,_loc4_,_loc5_);
		}
	}
	function unSelect(_loc2_, _loc3_, _loc4_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(_loc2_)
		{
			this.selectionHandler.clear();
		}
		else if(typeof _loc3_ == "object")
		{
			this.selectionHandler.selectMultiple(false,_loc3_,undefined,_loc4_);
		}
		else if(typeof _loc3_ == "number")
		{
			this.selectionHandler.select(false,_loc3_,undefined,_loc4_);
		}
		else if(_loc4_ != undefined)
		{
			this.selectionHandler.clearLayer(_loc4_);
		}
	}
	function unSelectAllButOne(_loc2_)
	{
		var _loc3_ = this.selectionHandler.getLayers();
		var _loc4_ = 0;
		while(_loc4_ < _loc3_.length)
		{
			if(_loc3_[_loc4_] != _loc2_)
			{
				this.selectionHandler.clearLayer(_loc3_[_loc4_]);
			}
			_loc4_ = _loc4_ + 1;
		}
	}
	function setInteraction(_loc2_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.interactionHandler.setEnabled(_loc2_);
	}
	function setInteractionOnCell(_loc2_, _loc3_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.interactionHandler.setEnabledCell(_loc2_,_loc3_);
	}
	function setInteractionOnCells(_loc2_, _loc3_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		for(var k in _loc2_)
		{
			this.interactionHandler.setEnabledCell(_loc2_[k],_loc3_);
		}
	}
	function drawZone(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.zoneHandler.drawZone(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_);
	}
	function clearZone(_loc2_, _loc3_, _loc4_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.zoneHandler.clearZone(_loc2_,_loc3_,_loc4_);
	}
	function clearZoneLayer(_loc2_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.zoneHandler.clearZoneLayer(_loc2_);
	}
	function clearAllZones(_loc2_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.zoneHandler.clear();
	}
	function clearPointer(_loc2_)
	{
		this.pointerHandler.clear();
	}
	function hidePointer(_loc2_)
	{
		this.pointerHandler.hide();
	}
	function addPointerShape(_loc2_, _loc3_, _loc4_, _loc5_)
	{
		this.pointerHandler.addShape(_loc2_,_loc3_,_loc4_,_loc5_);
	}
	function drawPointer(_loc2_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.pointerHandler.draw(_loc2_);
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
	function addLinkedSprite(sID, §\x1e\x11\x04§, §\b\f§, oSprite)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.addLinkedSprite(sID,_loc3_,_loc4_,oSprite);
	}
	function carriedSprite(sID, §\x1e\x11\x04§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.carriedSprite(sID,_loc3_);
	}
	function uncarriedSprite(sID, §\b\x1a§, §\x14\x12§, §\x1e\x19\x11§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.uncarriedSprite(sID,_loc3_,_loc4_,_loc5_);
	}
	function mountSprite(sID, §\x1e\x1a\t§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.mountSprite(sID,_loc3_);
	}
	function unmountSprite(sID)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.unmountSprite(sID);
	}
	function clearAllSprites(_loc2_)
	{
		this.spriteHandler.clear(_loc2_);
	}
	function removeSprite(sID, §\x18\x14§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.removeSprite(sID,_loc3_);
	}
	function hideSprite(sID, §\x17\x0b§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.hideSprite(sID,_loc3_);
	}
	function setSpritePosition(sID, §\b\x1a§, §\x11\x1d§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpritePosition(sID,_loc3_,_loc4_);
	}
	function setSpriteDirection(sID, §\x07\x12§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteDirection(sID,_loc3_);
	}
	function stopSpriteMove(sID, §\x1e\x19\x11§, §\b\x1a§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.stopSpriteMove(sID,_loc3_,_loc4_);
	}
	function moveSprite(sID, §\x13\r§, §\x1e\x19\x11§, §\x1b\x17§, §\x1a\x05§, §\x1a\x04§, §\x01\x11§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		var _loc9_ = ank.battlefield.utils.Compressor.extractFullPath(this.mapHandler,_loc3_);
		this.moveSpriteWithUncompressedPath(sID,_loc9_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
	}
	function moveSpriteWithUncompressedPath(sID, §\x1d\x1d§, §\x1e\x19\x11§, §\x1b\x17§, §\x1a\x05§, §\x1a\x04§, §\x01\x11§, §\x1e\x16\r§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(_loc3_ != undefined)
		{
			this.spriteHandler.moveSprite(sID,_loc3_,_loc4_,_loc5_,_loc9_,_loc6_,_loc7_,_loc8_);
		}
	}
	function slideSprite(sID, §\b\x1a§, §\x1e\x19\x11§, §\x1e\x16\r§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.slideSprite(sID,_loc3_,_loc4_,_loc5_);
	}
	function autoCalculateSpriteDirection(sID, §\b\x1a§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.autoCalculateSpriteDirection(sID,_loc3_);
	}
	function convertHeightToFourSpriteDirection(sID)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.convertHeightToFourSpriteDirection(sID);
	}
	function setForcedSpriteAnim(sID, §\x1e\x16\x0e§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteAnim(sID,_loc3_,true);
	}
	function setSpriteAnim(sID, §\x1e\x16\x0e§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteAnim(sID,_loc3_);
	}
	function setSpriteLoopAnim(sID, §\x1e\x16\x0e§, §\x1e\x1d\x0f§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteLoopAnim(sID,_loc3_,_loc4_);
	}
	function setSpriteTimerAnim(sID, §\x1e\x16\x0e§, §\x1a\x07§, §\x1e\x1d\x0f§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteTimerAnim(sID,_loc3_,_loc4_,_loc5_);
	}
	function setSpriteGfx(sID, §\x1e\x14\x04§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteGfx(sID,_loc3_);
	}
	function setSpriteColorTransform(sID, §\x1e\x19\x03§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteColorTransform(sID,_loc3_);
	}
	function setSpriteAlpha(sID, §\n\x03§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteAlpha(sID,_loc3_);
	}
	function spriteLaunchVisualEffect(sID, §\x1e\x1b\x06§, §\b\x1a§, §\x07\r§, §\n\x12§, §\x1e\x0f\x02§, §\x1e\x19\b§, §\x19\x19§, §\x1c\b§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.launchVisualEffect(sID,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
	}
	function spriteLaunchCarriedSprite(sID, §\x1e\x1b\x06§, §\b\x1a§, §\x07\r§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.launchCarriedSprite(sID,_loc3_,_loc4_,_loc5_);
	}
	function selectSprite(sID, §\x16\x0e§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.selectSprite(sID,_loc3_);
	}
	function addSpriteBubble(sID, §\x1e\x0e\x19§, §\x1e\x1d\b§)
	{
		var _loc5_ = this._oDatacenter.Sprites.getItemAt(sID);
		if(_loc5_ == undefined)
		{
			ank.utils.SharedObjectFix.err("[addSpriteBubble] Sprite inexistant (sprite Id : " + sID + ")");
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
		if(_loc4_ == undefined)
		{
			_loc4_ = ank.battlefield.TextHandler.BUBBLE_TYPE_CHAT;
		}
		if(_loc7_ == 0 || _loc8_ == 0)
		{
			ank.utils.SharedObjectFix.err("[addSpriteBubble] le sprite n\'est pas encore placé");
			return undefined;
		}
		this.textHandler.addBubble(sID,_loc7_,_loc8_,_loc3_,_loc4_);
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
	function addSpritePoints(sID, §\x1e\x0e\x04§, §\b\t§)
	{
		var _loc5_ = this._oDatacenter.Sprites.getItemAt(sID);
		if(_loc5_ == undefined)
		{
			ank.utils.SharedObjectFix.err("[addSpritePoints] Sprite inexistant");
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
			ank.utils.SharedObjectFix.err("[addSpritePoints] le sprite n\'est pas encore placé");
			return undefined;
		}
		this.pointsHandler.addPoints(sID,_loc7_,_loc8_,_loc3_,_loc4_);
	}
	function addSpriteOverHeadItem(sID, §\x1e\x12\x0f§, className, §\x17§, §\x07\x16§, §\x1a\x14§)
	{
		var _loc8_ = this._oDatacenter.Sprites.getItemAt(sID);
		if(_loc8_ == undefined)
		{
			ank.utils.SharedObjectFix.err("[addSpriteOverHeadItem] Sprite inexistant");
			return undefined;
		}
		if(_loc8_.isInMove && !_loc7_)
		{
			return undefined;
		}
		if(!_loc8_.isVisible)
		{
			return undefined;
		}
		var _loc9_ = _loc8_.mc;
		this.overHeadHandler.addOverHeadItem(sID,_loc9_._x,_loc9_._y,_loc9_,_loc3_,className,_loc5_,_loc6_);
	}
	function removeSpriteOverHeadLayer(sID, §\x1e\x12\x0f§)
	{
		this.overHeadHandler.removeOverHeadLayer(sID,_loc3_);
	}
	function hideSpriteOverHead(sID)
	{
		this.overHeadHandler.removeOverHead(sID);
	}
	function addSpriteExtraClipOnTimer(sID, §\x1e\x14\x04§, §\b\t§, §\x15\x07§, §\x07\x07§)
	{
		this.addSpriteExtraClip(sID,_loc3_,_loc4_,_loc5_);
		var _loc7_ = new Object();
		_loc7_.timerId = _global.setInterval(this,"removeSpriteExtraClipOnTimer",_loc6_,_loc7_,sID,_loc5_);
	}
	function removeSpriteExtraClipOnTimer(_loc2_, _loc3_, _loc4_)
	{
		_global.clearInterval(_loc2_.timerId);
		this.removeSpriteExtraClip(sID,_loc4_);
	}
	function addSpriteExtraClip(sID, §\x1e\x14\x04§, §\b\t§, §\x15\x07§)
	{
		this.spriteHandler.addSpriteExtraClip(sID,_loc3_,_loc4_,_loc5_);
	}
	function removeSpriteExtraClip(sID, §\x15\x07§)
	{
		this.spriteHandler.removeSpriteExtraClip(sID,_loc3_);
	}
	function showSpritePoints(sID, §\x1e\x1c\x1c§, §\b\t§)
	{
		this.spriteHandler.showSpritePoints(sID,_loc3_,_loc4_);
	}
	function setSpriteGhostView(_loc2_)
	{
		this.bGhostView = _loc2_;
		this.spriteHandler.setSpriteGhostView(_loc2_);
	}
	function setSpriteScale(sID, §\x01\r§, §\x01\f§)
	{
		this.spriteHandler.setSpriteScale(sID,_loc3_,_loc4_);
	}
	function drawGrid(_loc2_)
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
			this.gridHandler.draw(_loc2_);
		}
	}
	function removeGrid(_loc2_)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.gridHandler.clear();
	}
	function addVisualEffectOnSprite(sID, §\x1e\x1b\x06§, §\b\x1a§, §\x07\r§, §\x1e\x0f\x02§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		var _loc7_ = this._oDatacenter.Sprites.getItemAt(sID);
		var _loc8_ = this._oDatacenter.Sprites.getItemAt(_loc6_);
		this.visualEffectHandler.addEffect(_loc7_,_loc3_,_loc4_,_loc5_,_loc8_);
	}
	function initializeDatacenter(_loc2_)
	{
		if(this._oDatacenter == undefined)
		{
			return false;
		}
		this._oDatacenter.Map.cleanSpritesOn();
		this._oDatacenter.Map = new ank.battlefield.datacenter.Map();
		this._oDatacenter.Sprites = new ank.utils.();
		return true;
	}
	function createHandlers(_loc2_)
	{
		this.mapHandler = new ank.battlefield.(this,this._mcMainContainer,this._oDatacenter);
		this.spriteHandler = new ank.battlefield.(this,this._mcMainContainer.ExternalContainer.Object2,this._oDatacenter.Sprites);
		this.interactionHandler = new ank.battlefield.
(this._mcMainContainer.ExternalContainer.InteractionCell,this._oDatacenter);
		this.zoneHandler = new ank.battlefield.(this,this._mcMainContainer.ExternalContainer.Zone);
		this.pointerHandler = new ank.battlefield.(this,this._mcMainContainer.ExternalContainer.Pointer);
		this.selectionHandler = new ank.battlefield.(this,this._mcMainContainer.ExternalContainer,this._oDatacenter);
		this.gridHandler = new ank.battlefield.(this._mcMainContainer.ExternalContainer.Grid,this._oDatacenter);
		this.visualEffectHandler = new ank.battlefield.	(this,this._mcMainContainer.ExternalContainer.Object2);
		this.textHandler = new ank.battlefield.
(this,this._mcMainContainer.Text,this._oDatacenter);
		this.pointsHandler = new ank.battlefield.(this,this._mcMainContainer.Points,this._oDatacenter);
		this.overHeadHandler = new ank.battlefield.(this,this._mcMainContainer.OverHead);
	}
	function onLoadInit(_loc2_)
	{
		if((var _loc0_ = _loc2_._name) !== "Ground")
		{
			_loc2_.__proto__ = ank.battlefield.mc.ExternalContainer.prototype;
			_loc2_.initialize(this._sGroundFile);
			this.createHandlers();
		}
		else
		{
			_loc2_._parent.useCustomGroundGfxFile(this._bUseCustomGroundGfxFile);
			this.bCustomFileLoaded = true;
			this.onInitComplete();
		}
	}
	function onLoadError(_loc2_)
	{
		this.onInitError();
	}
	function onLoadProgress(_loc2_, _loc3_, _loc4_)
	{
		this.onInitProgress(_loc3_,_loc4_);
	}
}
