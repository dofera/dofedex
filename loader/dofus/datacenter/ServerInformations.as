class dofus.datacenter.ServerInformations extends Object
{
	function ServerInformations()
	{
		super();
		this.initialize();
	}
	function __get__problems()
	{
		return this._pProblems;
	}
	function __get__isOnFocus()
	{
		return this._bOnFocus;
	}
	function load()
	{
		this.dispatchEvent({type:"onLoadStarted"});
		this.dispatchEvent({type:"onLoadError"});
	}
	function initialize()
	{
		this.api = _global.API;
		mx.events.EventDispatcher.initialize(this);
	}
	function parseXml(var2)
	{
		this._pProblems = new Array();
		var var3 = var2.firstChild;
		var var4 = 0;
		while(var4 < var3.childNodes.length)
		{
			var var5 = var3.childNodes[var4];
			var var6 = Number(var5.attributes.id);
			var var7 = Number(var5.attributes.date);
			var var8 = Number(var5.attributes.type);
			var var9 = Number(var5.attributes.state);
			var var10 = var5.attributes.visible == "true";
			this._bOnFocus = this._bOnFocus || var10;
			var var11 = var5.childNodes[0];
			var var12 = new Array();
			if(var11.attributes.cnx == "true")
			{
				var12.push(this.api.lang.getText("CONNECTION_SERVER"));
			}
			if(var11.attributes.all == "true")
			{
				var12.push(this.api.lang.getText("EVERY_SERVERS"));
			}
			else
			{
				var var13 = 0;
				while(var13 < var11.childNodes.length)
				{
					var12.push(var11.childNodes[var13].attributes.name);
					var13 = var13 + 1;
				}
			}
			var var14 = var5.childNodes[1];
			var var15 = new Array();
			var var16 = 0;
			while(var16 < var14.childNodes.length)
			{
				var var17 = var14.childNodes[var16];
				var var18 = Number(var17.attributes.timestamp);
				var var19 = Number(var17.attributes.id);
				var var20 = var17.attributes.translated == "true";
				var var21 = var17.firstChild.nodeValue;
				var var22 = new dofus.datacenter.(var18,var19,var20,var21);
				var15.push(var22);
				var16 = var16 + 1;
			}
			var var23 = new dofus.datacenter.(var6,var7,var8,var9,var12,var15);
			this._pProblems.push(var23);
			var4 = var4 + 1;
		}
		this.dispatchEvent({type:"onData"});
	}
	function onXMLLoadComplete(var2)
	{
		var var3 = var2.value;
		this.parseXml(var3);
	}
	function onXMLLoadError()
	{
		this.dispatchEvent({type:"onLoadError"});
	}
}
