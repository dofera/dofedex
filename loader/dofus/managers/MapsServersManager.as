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
	function __set__isBuilding(var2)
	{
		this._bBuildingMap = var2;
		return this.__get__isBuilding();
	}
	static function getInstance()
	{
		return dofus.managers.MapsServersManager._sSelf;
	}
	function initialize(oAPI)
	{
		super.initialize(oAPI,"maps","maps/");
	}
	function loadMap(sID, §\x1e\x13\x03§, §\x1e\x11\x03§)
	{
		this._lastLoadedMap = undefined;
		if(!_global.isNaN(Number(sID)))
		{
			if(var4 != undefined && var4.length > 0)
			{
				this._aKeys[Number(sID)] = dofus.aks.Aks.prepareKey(var4);
			}
			else
			{
				delete this._aKeys[Number(sID)];
			}
		}
		this.loadData(sID + "_" + var3 + (this._aKeys[Number(sID)] == undefined?"":"X") + ".swf");
	}
	function getMapName(var2)
	{
		var var3 = this.api.lang.getMapText(var2);
		var var4 = this.api.lang.getMapAreaInfos(var3.sa);
		var var5 = this.api.lang.getMapAreaText(var4.areaID).n;
		var var6 = this.api.lang.getMapSubAreaText(var3.sa).n;
		var var7 = var5 + (var6.indexOf("//") != -1?"":" (" + var6 + ")");
		if(dofus.Constants.DEBUG)
		{
			var7 = var7 + (" (" + var2 + ")");
		}
		return var7;
	}
	function parseMap(var2)
	{
		if(this.api.network.Game.isBusy)
		{
			this.addToQueue({object:this,method:this.parseMap,params:[var2]});
			return undefined;
		}
		var var3 = Number(var2.id);
		if(this.api.config.isStreaming && this.api.config.streamingMethod == "compact")
		{
			var var4 = this.api.lang.getConfigText("INCARNAM_CLASS_MAP");
			var var5 = false;
			var var6 = 0;
			while(var6 < var4.length && !var5)
			{
				if(var4[var6] == var3)
				{
					var5 = true;
				}
				var6 = var6 + 1;
			}
			if(var5)
			{
				var var7 = [dofus.Constants.GFX_ROOT_PATH + "g" + this.api.datacenter.Player.Guild + ".swf",dofus.Constants.GFX_ROOT_PATH + "o" + this.api.datacenter.Player.Guild + ".swf"];
			}
			else
			{
				var7 = [dofus.Constants.GFX_ROOT_PATH + "g0.swf",dofus.Constants.GFX_ROOT_PATH + "o0.swf"];
			}
			if(!this.api.gfx.loadManager.areRegister(var7))
			{
				this.api.gfx.loadManager.loadFiles(var7);
				this.api.gfx.bCustomFileLoaded = false;
			}
			if(this.api.gfx.loadManager.areLoaded(var7))
			{
				this.api.gfx.setCustomGfxFile(var7[0],var7[1]);
			}
			if(!this.api.gfx.bCustomFileLoaded || !this.api.gfx.loadManager.areLoaded(var7))
			{
				var var8 = this.api.ui.getUIComponent("CenterTextMap");
				if(!var8)
				{
					var8 = this.api.ui.loadUIComponent("CenterText","CenterTextMap",{text:this.api.lang.getText("LOADING_MAP"),timer:40000},{bForceLoad:true});
				}
				this.api.ui.getUIComponent("CenterTextMap").updateProgressBar("Downloading",this.api.gfx.loadManager.getProgressions(var7),100);
				this.addToQueue({object:this,method:this.parseMap,params:[var2]});
				return undefined;
			}
			if(var5 && !this._bPreloadCall)
			{
				this._bPreloadCall = true;
				this.api.gfx.loadManager.loadFiles([dofus.Constants.CLIPS_PERSOS_PATH + (this.api.datacenter.Player.Guild * 10 + this.api.datacenter.Player.Sex) + ".swf",dofus.Constants.CLIPS_PERSOS_PATH + "9059.swf",dofus.Constants.CLIPS_PERSOS_PATH + "9091.swf",dofus.Constants.CLIPS_PERSOS_PATH + "1219.swf",dofus.Constants.CLIPS_PERSOS_PATH + "101.swf",dofus.Constants.GFX_ROOT_PATH + "g0.swf",dofus.Constants.GFX_ROOT_PATH + "o0.swf"]);
			}
		}
		this._bCustomFileCall = false;
		if(this.api.network.Game.nLastMapIdReceived != var3 && (this.api.network.Game.nLastMapIdReceived != -1 && this.api.lang.getConfigText("CHECK_MAP_FILE_ID")))
		{
			this.api.gfx.onMapLoaded();
			return undefined;
		}
		this._bBuildingMap = true;
		this._lastLoadedMap = var2;
		var var9 = this.getMapName(var3);
		var var10 = Number(var2.width);
		var var11 = Number(var2.height);
		var var12 = Number(var2.backgroundNum);
		var var13 = this._aKeys[var3] == undefined?var2.mapData:dofus.aks.Aks.decypherData(var2.mapData,this._aKeys[var3],_global.parseInt(dofus.aks.Aks.checksum(this._aKeys[var3]),16) * 2);
		var var14 = var2.ambianceId;
		var var15 = var2.musicId;
		var var16 = var2.bOutdoor != 1?false:true;
		var var17 = (var2.capabilities & 1) == 0;
		var var18 = (var2.capabilities >> 1 & 1) == 0;
		var var19 = (var2.capabilities >> 2 & 1) == 0;
		var var20 = (var2.capabilities >> 3 & 1) == 0;
		this.api.datacenter.Basics.aks_current_map_id = var3;
		this.api.kernel.TipsManager.onNewMap(var3);
		this.api.kernel.StreamingDisplayManager.onNewMap(var3);
		var var21 = new dofus.datacenter.(var3);
		var21.bCanChallenge = var17;
		var21.bCanAttack = var18;
		var21.bSaveTeleport = var19;
		var21.bUseTeleport = var20;
		var21.bOutdoor = var16;
		var21.ambianceID = var14;
		var21.musicID = var15;
		this.api.gfx.buildMap(var3,var9,var10,var11,var12,var13,var21);
		this._bBuildingMap = false;
	}
	function onComplete(var2)
	{
		var var3 = var2;
		this.parseMap(var3);
	}
	function onFailed()
	{
		this.api.kernel.showMessage(undefined,this.api.lang.getText("NO_MAPDATA_FILE"),"ERROR_BOX",{name:"NoMapData"});
	}
}
