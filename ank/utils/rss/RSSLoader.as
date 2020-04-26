class ank.utils.rss.RSSLoader extends XML
{
	function RSSLoader()
	{
		super();
		eval("\n\x0b").events.EventDispatcher.initialize(this);
		this.ignoreWhite = true;
		this.initialize();
	}
	function __get__data()
	{
		return this._oData;
	}
	function getChannels()
	{
		return this._aChannels;
	}
	function load(loc2, loc3)
	{
		super.load(loc3);
		this._oData = loc4;
	}
	function initialize()
	{
		this._aChannels = new Array();
	}
	function parse()
	{
		this.initialize();
		if(this.childNodes.length == 0)
		{
			return false;
		}
		var loc2 = this.firstChild;
		if(loc2.nodeName.toLowerCase() != "rss")
		{
			return false;
		}
		var loc3 = loc2.firstChild;
		while(loc3 != null)
		{
			if(loc3.nodeName.toLowerCase() == "channel")
			{
				var loc4 = new ank.utils.rss.();
				if(loc4.parse(loc3))
				{
					this._aChannels.push(loc4);
				}
			}
			loc3 = loc3.nextSibling;
		}
		return true;
	}
	function onLoad(loc2)
	{
		if(loc2)
		{
			if(this.parse())
			{
				this.dispatchEvent({type:"onRSSLoaded",data:this._oData});
			}
			else
			{
				this.dispatchEvent({type:"onBadRSSFile",data:this._oData});
			}
		}
		else
		{
			this.dispatchEvent({type:"onRSSLoadError",data:this._oData});
		}
	}
}
