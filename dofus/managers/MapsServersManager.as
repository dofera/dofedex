class dofus.managers.MapsServersManager extends dofus.managers.ServersManager
{
	static var _sSelf = null;
	var _lastLoadedMap = undefined;
	var _aKeys = new Array();
	var _bBuildingMap = false;
	var _bCustomFileCall = false;
	var _bPreloadCall = false;
	function MapsServersManager()
	{
		super();
		dofus.managers.MapsServersManager._sSelf = this;
	}
	function __get__isBuilding()
	{
		return this._bBuildingMap;
	}
	function __set__isBuilding(loc2)
	{
		this._bBuildingMap = loc2;
		return this.__get__isBuilding();
	}
	static function getInstance()
	{
		return dofus.managers.MapsServersManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3,"maps","maps/");
	}
	function loadMap(sID, §\x1e\x14\x18§, §\x1e\x12\x1c§)
	{
		this._lastLoadedMap = undefined;
		if(!_global.isNaN(Number(sID)))
		{
			if(loc4 != undefined && loc4.length > 0)
			{
				this._aKeys[Number(sID)] = dofus.aks.Aks.prepareKey(loc4);
			}
			else
			{
				delete this._aKeys[Number(sID)];
			}
		}
		this.loadData(sID + "_" + loc3 + (this._aKeys[Number(sID)] == undefined?"":"X") + ".swf");
	}
	function getMapName(loc2)
	{
		var loc3 = this.api.lang.getMapText(loc2);
		var loc4 = this.api.lang.getMapAreaInfos(loc3.sa);
		var loc5 = this.api.lang.getMapAreaText(loc4.areaID).n;
		var loc6 = this.api.lang.getMapSubAreaText(loc3.sa).n;
		var loc7 = loc5 + (loc6.indexOf("//") != -1?"":" (" + loc6 + ")");
		if(dofus.Constants.DEBUG)
		{
			loc7 = loc7 + (" (" + loc2 + ")");
		}
		return loc7;
	}
	function parseMap(loc2)
	{
		if(this.api.network.Game.isBusy)
		{
			this.addToQueue({object:this,method:this.parseMap,params:[loc2]});
			return undefined;
		}
		var loc3 = Number(loc2.id);
		if(this.api.config.isStreaming && this.api.config.streamingMethod == "compact")
		{
			var loc4 = this.api.lang.getConfigText("INCARNAM_CLASS_MAP");
			var loc5 = false;
			var loc6 = 0;
			while(loc6 < loc4.length && !loc5)
			{
				if(loc4[loc6] == loc3)
				{
					loc5 = true;
				}
				loc6 = loc6 + 1;
			}
			if(loc5)
			{
				var loc7 = [dofus.Constants.GFX_ROOT_PATH + "g" + this.api.datacenter.Player.Guild + ".swf",dofus.Constants.GFX_ROOT_PATH + "o" + this.api.datacenter.Player.Guild + ".swf"];
			}
			else
			{
				loc7 = [dofus.Constants.GFX_ROOT_PATH + "g0.swf",dofus.Constants.GFX_ROOT_PATH + "o0.swf"];
			}
			if(!this.api.gfx.loadManager.areRegister(loc7))
			{
				this.api.gfx.loadManager.loadFiles(loc7);
				this.api.gfx.bCustomFileLoaded = false;
			}
			if(this.api.gfx.loadManager.areLoaded(loc7))
			{
				this.api.gfx.setCustomGfxFile(loc7[0],loc7[1]);
			}
			if(!this.api.gfx.bCustomFileLoaded || !this.api.gfx.loadManager.areLoaded(loc7))
			{
				var loc8 = this.api.ui.getUIComponent("CenterTextMap");
				if(!loc8)
				{
					loc8 = this.api.ui.loadUIComponent("CenterText","CenterTextMap",{text:this.api.lang.getText("LOADING_MAP"),timer:40000},{bForceLoad:true});
				}
				this.api.ui.getUIComponent("CenterTextMap").updateProgressBar("Downloading",this.api.gfx.loadManager.getProgressions(loc7),100);
				this.addToQueue({object:this,method:this.parseMap,params:[loc2]});
				return undefined;
			}
			if(loc5 && !this._bPreloadCall)
			{
				this._bPreloadCall = true;
				this.api.gfx.loadManager.loadFiles([dofus.Constants.CLIPS_PERSOS_PATH + (this.api.datacenter.Player.Guild * 10 + this.api.datacenter.Player.Sex) + ".swf",dofus.Constants.CLIPS_PERSOS_PATH + "9059.swf",dofus.Constants.CLIPS_PERSOS_PATH + "9091.swf",dofus.Constants.CLIPS_PERSOS_PATH + "1219.swf",dofus.Constants.CLIPS_PERSOS_PATH + "101.swf",dofus.Constants.GFX_ROOT_PATH + "g0.swf",dofus.Constants.GFX_ROOT_PATH + "o0.swf"]);
			}
		}
		this._bCustomFileCall = false;
		if(this.api.network.Game.nLastMapIdReceived != loc3 && (this.api.network.Game.nLastMapIdReceived != -1 && this.api.lang.getConfigText("CHECK_MAP_FILE_ID")))
		{
			this.api.gfx.onMapLoaded();
			return undefined;
		}
		this._bBuildingMap = true;
		this._lastLoadedMap = loc2;
		var loc9 = this.getMapName(loc3);
		var loc10 = Number(loc2.width);
		var loc11 = Number(loc2.height);
		var loc12 = Number(loc2.backgroundNum);
		var loc13 = this._aKeys[loc3] == undefined?loc2.mapData:dofus.aks.Aks.decypherData(loc2.mapData,this._aKeys[loc3],_global.parseInt(dofus.aks.Aks.checksum(this._aKeys[loc3]),16) * 2);
		var loc14 = loc2.ambianceId;
		var loc15 = loc2.musicId;
		var loc16 = loc2.bOutdoor != 1?false:true;
		var loc17 = (loc2.capabilities & 1) == 0;
		var loc18 = (loc2.capabilities >> 1 & 1) == 0;
		var loc19 = (loc2.capabilities >> 2 & 1) == 0;
		var loc20 = (loc2.capabilities >> 3 & 1) == 0;
		this.api.datacenter.Basics.aks_current_map_id = loc3;
		this.api.kernel.TipsManager.onNewMap(loc3);
		this.api.kernel.StreamingDisplayManager.onNewMap(loc3);
		var loc21 = new dofus.datacenter.(loc3);
		loc21.bCanChallenge = loc17;
		loc21.bCanAttack = loc18;
		loc21.bSaveTeleport = loc19;
		loc21.bUseTeleport = loc20;
		loc21.bOutdoor = loc16;
		loc21.ambianceID = loc14;
		loc21.musicID = loc15;
		this.api.gfx.buildMap(loc3,loc9,loc10,loc11,loc12,loc13,loc21);
		this._bBuildingMap = false;
	}
	function onComplete(loc2)
	{
		var loc3 = loc2;
		this.parseMap(loc3);
	}
	function onFailed()
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("NO_MAPDATA_FILE"),"ERROR_BOX",{name:"NoMapData"});
	}
}
