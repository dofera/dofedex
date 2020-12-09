class dofus.graphics.gapi.ui.DocumentRoadSign extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DocumentRoadSign";
	function DocumentRoadSign()
	{
		super();
	}
	function __set__document(§\x1e\x19\x1d§)
	{
		this._oDoc = var2;
		return this.__get__document();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.DocumentRoadSign.CLASS_NAME);
	}
	function callClose()
	{
		this.api.network.Documents.leave();
		return true;
	}
	function createChildren()
	{
		this._txtCore.wordWrap = true;
		this._txtCore.multiline = true;
		this._txtCore.embedFonts = true;
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.updateData});
		this._mcSmall._visible = false;
	}
	function addListeners()
	{
		this._btnClose.addEventListener("click",this);
		this._bgHidder.addEventListener("click",this);
	}
	function updateData()
	{
		this.setCssStyle(this._oDoc.getPage(0).cssFile);
		if(this._lblTitle.text == undefined)
		{
			return undefined;
		}
		if(this._oDoc.title.substr(0,2) == "//")
		{
			this._mcSmall._visible = false;
			this._lblTitle.text = "";
		}
		else
		{
			this._mcSmall._visible = true;
			this._lblTitle.text = this._oDoc.title;
		}
	}
	function setCssStyle(§\x1e\x13\x14§)
	{
		var var3 = new TextField.StyleSheet();
		var3.owner = this;
		var3.onLoad = function()
		{
			this.owner.layoutContent(this);
		};
		var3.load(var2);
	}
	function layoutContent(§\x1e\r\x17§)
	{
		this._txtCore.styleSheet = var2;
		this._txtCore.htmlText = this._oDoc.getPage(0).text;
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_bgHidder":
			case "_btnClose":
				this.callClose();
		}
	}
}
