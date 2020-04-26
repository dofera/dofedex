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
	function parseXml(loc2)
	{
		this._pProblems = new Array();
		var loc3 = loc2.firstChild;
		var loc4 = 0;
		while(loc4 < loc3.childNodes.length)
		{
			var loc5 = loc3.childNodes[loc4];
			var loc6 = Number(loc5.attributes.id);
			var loc7 = Number(loc5.attributes.date);
			var loc8 = Number(loc5.attributes.type);
			var loc9 = Number(loc5.attributes.state);
			var loc10 = loc5.attributes.visible == "true";
			this._bOnFocus = this._bOnFocus || loc10;
			var loc11 = loc5.childNodes[0];
			var loc12 = new Array();
			if(loc11.attributes.cnx == "true")
			{
				loc12.push(this.api.lang.getText("CONNECTION_SERVER"));
			}
			if(loc11.attributes.all == "true")
			{
				loc12.push(this.api.lang.getText("EVERY_SERVERS"));
			}
			else
			{
				var loc13 = 0;
				while(loc13 < loc11.childNodes.length)
				{
					loc12.push(loc11.childNodes[loc13].attributes.name);
					loc13 = loc13 + 1;
				}
			}
			var loc14 = loc5.childNodes[1];
			var loc15 = new Array();
			var loc16 = 0;
			while(loc16 < loc14.childNodes.length)
			{
				var loc17 = loc14.childNodes[loc16];
				var loc18 = Number(loc17.attributes.timestamp);
				var loc19 = Number(loc17.attributes.id);
				var loc20 = loc17.attributes.translated == "true";
				var loc21 = loc17.firstChild.nodeValue;
				var loc22 = new dofus.datacenter.	(loc18,loc19,loc20,loc21);
				loc15.push(loc22);
				loc16 = loc16 + 1;
			}
			var loc23 = new dofus.datacenter.
(loc6,loc7,loc8,loc9,loc12,loc15);
			this._pProblems.push(loc23);
			loc4 = loc4 + 1;
		}
		this.dispatchEvent({type:"onData"});
	}
	function onXMLLoadComplete(loc2)
	{
		var loc3 = loc2.value;
		this.parseXml(loc3);
	}
	function onXMLLoadError()
	{
		this.dispatchEvent({type:"onLoadError"});
	}
}
