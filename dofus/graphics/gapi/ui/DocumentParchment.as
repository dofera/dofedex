class dofus.graphics.gapi.ui.DocumentParchment extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "DocumentParchment";
	function DocumentParchment()
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
		super.init(false,dofus.graphics.gapi.ui.DocumentParchment.CLASS_NAME);
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
			this._lblTitle.text = "";
		}
		else
		{
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
	function onHref(loc2)
	{
		var loc3 = loc2.split("|");
		var loc4 = Number(loc3[0]);
		var loc5 = loc3[1].split(";");
		if(!_global.isNaN(loc4))
		{
			this.api.network.GameActions.sendActions(loc4,loc5);
			this.api.network.Documents.leave();
		}
	}
}
