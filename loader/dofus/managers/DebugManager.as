class dofus.managers.DebugManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	function DebugManager(var2)
	{
		super();
		dofus.managers.DebugManager._sSelf = this;
		this.initialize(var3);
	}
	static function getInstance()
	{
		return dofus.managers.DebugManager._sSelf;
	}
	function initialize(var2)
	{
		super.initialize(var3);
		this.setDebug(dofus.Constants.DEBUG == true);
	}
	function setDebug(var2)
	{
		this._bDebugEnabled = var2;
		this.print("Debug mode " + (!var2?"OFF":"ON"),5,true);
	}
	function toggleDebug()
	{
		this.setDebug(!this._bDebugEnabled);
	}
	function print(var2, var3, var4)
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
			case 2:
				var6 = "DEBUG_LOG";
				break;
			default:
				var6 = "DEBUG_INFO";
		}
		this.api.kernel.showMessage(undefined,var5,var6);
	}
	function getFormattedMessage(var2)
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
					if((var var0 = var5[0]) !== "getioname")
					{
						switch(null)
						{
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
							case "getcelliogfxname":
								var var10 = Number(var5[1]);
								if(var10 != undefined && !_global.isNaN(var10))
								{
									var var11 = this.api.gfx.mapHandler.getCellData(var10).layerObject2Num;
									if(!_global.isNaN(var11))
									{
										var6 = this.api.lang.getInteractiveObjectDataByGfxText(var11).n;
									}
									if(var6 == undefined)
									{
										var6 = "-";
									}
								}
								break;
							case "getmonstername":
								var var12 = Number(var5[1]);
								if(var12 != undefined && !_global.isNaN(var12))
								{
									var6 = this.api.lang.getMonstersText(var12).n;
									if(var6 == undefined)
									{
										var6 = "-";
										break;
									}
									break;
								}
						}
					}
					else
					{
						var var7 = Number(var5[1]);
						if(var7 != undefined && !_global.isNaN(var7))
						{
							var6 = this.api.lang.getInteractiveObjectDataText(var7).n;
							if(var6 == undefined)
							{
								var6 = "-";
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
		return "[" + new ank.utils.(var2.getHours()).addLeftChar("0",2) + ":" + new ank.utils.(var2.getMinutes()).addLeftChar("0",2) + ":" + new ank.utils.(var2.getSeconds()).addLeftChar("0",2) + ":" + new ank.utils.(var2.getMilliseconds()).addLeftChar("0",3) + "]";
	}
}
