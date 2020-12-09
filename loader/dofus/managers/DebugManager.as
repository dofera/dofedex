class dofus.managers.DebugManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	function DebugManager(§\x1e\x1a\x16§)
	{
		super();
		dofus.managers.DebugManager._sSelf = this;
		this.initialize(var3);
	}
	static function getInstance()
	{
		return dofus.managers.DebugManager._sSelf;
	}
	function initialize(§\x1e\x1a\x16§)
	{
		super.initialize(var3);
		this.setDebug(dofus.Constants.DEBUG == true);
	}
	function setDebug(§\x17\x02§)
	{
		this._bDebugEnabled = var2;
		this.print("Debug mode " + (!var2?"OFF":"ON"),5,true);
	}
	function toggleDebug()
	{
		this.setDebug(!this._bDebugEnabled);
	}
	function print(§\x1e\x10\x07§, §\x04\x01§, §\x1a\x0f§)
	{
		if(!var4 && !this._bDebugEnabled)
		{
			return undefined;
		}
		var var5 = this.getTimestamp() + " ";
		var5 = var5 + var2;
		var var6 = "DEBUG_INFO";
		switch(var3)
		{
			case 5:
				var6 = "ERROR_CHAT";
				break;
			case 4:
				var6 = "MESSAGE_CHAT";
				break;
			case 3:
				var6 = "DEBUG_ERROR";
				break;
			default:
				if(var0 !== 2)
				{
					var6 = "DEBUG_INFO";
					break;
				}
				var6 = "DEBUG_LOG";
				break;
		}
		org.flashdevelop.utils.FlashConnect.mtrace("[" + var6 + "] " + var5,"dofus.managers.DebugManager::print","C:\\Users\\Azlino\\Projects\\dofus-retro\\client\\src\\core\\classes/dofus/managers/DebugManager.as",96);
		this.api.kernel.showMessage(undefined,var5,var6);
	}
	function getFormattedMessage(§\x1e\x10\x07§)
	{
		var var3 = "";
		while(true)
		{
			var var4 = var2.indexOf("#");
			if(var4 != -1)
			{
				var3 = var3 + var2.substring(0,var4);
				var2 = var2.substring(var4 + 1);
				var var5 = var2.split("|");
				var5.splice(2);
				var var6 = null;
				if(var5 != undefined && var5.length > 1)
				{
					switch(var5[0])
					{
						case "getioname":
							var var7 = Number(var5[1]);
							if(var7 != undefined && !_global.isNaN(var7))
							{
								var6 = this.api.lang.getInteractiveObjectDataText(var7).n;
								if(var6 == undefined)
								{
									var6 = "-";
								}
							}
							break;
						case "getitemname":
							var var8 = Number(var5[1]);
							if(var8 != undefined && !_global.isNaN(var8))
							{
								var6 = this.api.lang.getItemUnics()[var8].n;
								if(var6 == undefined)
								{
									var6 = "-";
								}
							}
							break;
						default:
							switch(null)
							{
								case "getsubareaname":
									var var9 = Number(var5[1]);
									if(var9 != undefined && !_global.isNaN(var9))
									{
										var6 = this.api.lang.getMapSubAreaText(var9).n;
										if(var6 == undefined)
										{
											var6 = "-";
										}
									}
									break;
								case "getiogfxname":
									var var10 = Number(var5[1]);
									if(var10 != undefined && !_global.isNaN(var10))
									{
										var6 = this.api.lang.getInteractiveObjectDataByGfxText(var10).n;
										if(var6 == undefined)
										{
											var6 = "-";
										}
									}
									break;
								case "getcelliogfxname":
									var var11 = Number(var5[1]);
									if(var11 != undefined && !_global.isNaN(var11))
									{
										var var12 = this.api.gfx.mapHandler.getCellData(var11).layerObject2Num;
										if(!_global.isNaN(var12))
										{
											var6 = this.api.lang.getInteractiveObjectDataByGfxText(var12).n;
										}
										if(var6 == undefined)
										{
											var6 = "-";
										}
									}
									break;
								case "getmonstername":
									var var13 = Number(var5[1]);
									if(var13 != undefined && !_global.isNaN(var13))
									{
										var6 = this.api.lang.getMonstersText(var13).n;
										if(var6 == undefined)
										{
											var6 = "-";
											break;
										}
										break;
									}
							}
					}
				}
				if(var6 != null && var6.length > 0)
				{
					var3 = var3 + var6;
					var2 = var2.substring(var5.join("|").length + 1);
				}
				else
				{
					var3 = var3 + "#";
				}
			}
			if(var4 == undefined || var4 != -1)
			{
				continue;
			}
			break;
		}
		var3 = var3 + var2;
		return var3;
	}
	function getTimestamp()
	{
		var var2 = new Date();
		return "[" + new ank.utils.(var2.getHours()).addLeftChar("0",2) + ":" + new ank.utils.(var2.getMinutes()).addLeftChar("0",2) + ":" + new ank.utils.(var2.getSeconds()).addLeftChar("0",2) + ":" + new ank.utils.(var2.getMilliseconds()).addLeftChar("0",3) + "]";
	}
}
