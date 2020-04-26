class dofus.managers.DebugManager extends dofus.utils.ApiElement
{
	static var _sSelf = null;
	function DebugManager(loc3)
	{
		super();
		dofus.managers.DebugManager._sSelf = this;
		this.initialize(loc3);
	}
	static function getInstance()
	{
		return dofus.managers.DebugManager._sSelf;
	}
	function initialize(loc2)
	{
		super.initialize(loc3);
		this.setDebug(dofus.Constants.DEBUG == true);
	}
	function setDebug(loc2)
	{
		this._bDebugEnabled = loc2;
		this.print("Debug mode " + (!loc2?"OFF":"ON"),5,true);
	}
	function toggleDebug()
	{
		this.setDebug(!this._bDebugEnabled);
	}
	function print(loc2, loc3, loc4)
	{
		if(!loc4 && !this._bDebugEnabled)
		{
			return undefined;
		}
		var loc5 = this.getTimestamp() + " ";
		loc5 = loc5 + loc2;
		var loc6 = "DEBUG_INFO";
		switch(loc3)
		{
			case 5:
				loc6 = "ERROR_CHAT";
				break;
			case 4:
				loc6 = "MESSAGE_CHAT";
				break;
			case 3:
				loc6 = "DEBUG_ERROR";
				break;
			default:
				if(loc0 !== 2)
				{
					loc6 = "DEBUG_INFO";
					break;
				}
				loc6 = "DEBUG_LOG";
				break;
		}
		this.api.kernel.showMessage(undefined,loc5,loc6);
	}
	function getFormattedMessage(loc2)
	{
		var loc3 = "";
		while(true)
		{
			var loc4 = loc2.indexOf("#");
			if(loc4 != -1)
			{
				loc3 = loc3 + loc2.substring(0,loc4);
				loc2 = loc2.substring(loc4 + 1);
				var loc5 = loc2.split("|");
				loc5.splice(2);
				var loc6 = null;
				if(loc5 != undefined && loc5.length > 1)
				{
					switch(loc5[0])
					{
						case "getioname":
							var loc7 = Number(loc5[1]);
							if(loc7 != undefined && !_global.isNaN(loc7))
							{
								loc6 = this.api.lang.getInteractiveObjectDataText(loc7).n;
								if(loc6 == undefined)
								{
									loc6 = "-";
								}
							}
							break;
						case "getitemname":
							var loc8 = Number(loc5[1]);
							if(loc8 != undefined && !_global.isNaN(loc8))
							{
								loc6 = this.api.lang.getItemUnics()[loc8].n;
								if(loc6 == undefined)
								{
									loc6 = "-";
								}
							}
							break;
						case "getsubareaname":
							var loc9 = Number(loc5[1]);
							if(loc9 != undefined && !_global.isNaN(loc9))
							{
								loc6 = this.api.lang.getMapSubAreaText(loc9).n;
								if(loc6 == undefined)
								{
									loc6 = "-";
								}
							}
							break;
						case "getcelliogfxname":
							var loc10 = Number(loc5[1]);
							if(loc10 != undefined && !_global.isNaN(loc10))
							{
								var loc11 = this.api.gfx.mapHandler.getCellData(loc10).layerObject2Num;
								if(!_global.isNaN(loc11))
								{
									loc6 = this.api.lang.getInteractiveObjectDataByGfxText(loc11).n;
								}
								if(loc6 == undefined)
								{
									loc6 = "-";
								}
							}
							break;
						case "getmonstername":
							var loc12 = Number(loc5[1]);
							if(loc12 != undefined && !_global.isNaN(loc12))
							{
								loc6 = this.api.lang.getMonstersText(loc12).n;
								if(loc6 == undefined)
								{
									loc6 = "-";
									break;
								}
								break;
							}
					}
				}
				if(loc6 != null && loc6.length > 0)
				{
					loc3 = loc3 + loc6;
					loc2 = loc2.substring(loc5.join("|").length + 1);
				}
				else
				{
					loc3 = loc3 + "#";
				}
			}
			if(loc4 == undefined || loc4 != -1)
			{
				continue;
			}
			break;
		}
		loc3 = loc3 + loc2;
		return loc3;
	}
	function getTimestamp()
	{
		var loc2 = new Date();
		return "[" + new ank.utils.(loc2.getHours()).addLeftChar("0",2) + ":" + new ank.utils.(loc2.getMinutes()).addLeftChar("0",2) + ":" + new ank.utils.(loc2.getSeconds()).addLeftChar("0",2) + ":" + new ank.utils.(loc2.getMilliseconds()).addLeftChar("0",3) + "]";
	}
}
