class dofus.graphics.gapi.ui.DocumentRoadSign extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DocumentRoadSign";
	function DocumentRoadSign()
	{
		super();
	}
	function __set__document(loc2)
	{
		this._oDoc = loc2;
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
	function setCssStyle(loc2)
	{
		var loc3 = new TextField.StyleSheet();
		loc3.owner = this;
		loc3.onLoad = function()
		{
			this.owner.layoutContent(this);
		};
		loc3.load(loc2);
	}
	function layoutContent(loc2)
	{
		this._txtCore.styleSheet = loc2;
		this._txtCore.htmlText = this._oDoc.getPage(0).text;
	}
	function click(loc2)
	{
		switch(loc2.target._name)
		{
			case "_bgHidder":
			case "_btnClose":
				this.callClose();
		}
	}
}
