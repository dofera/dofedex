class dofus.graphics.gapi.ui.AskCancel extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskCancel";
	function AskCancel()
	{
		super();
	}
	function __set__text(§\x1e\r\x02§)
	{
		this._sText = var2;
		return this.__get__text();
	}
	function __get__text()
	{
		return this._sText;
	}
	function initWindowContent()
	{
		var var2 = this._winBackground.content;
		var2._txtText.text = this._sText;
		var2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		var2._btnCancel.addEventListener("click",this);
		var2._txtText.addEventListener("change",this);
	}
	function click(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "_btnCancel")
		{
			this.dispatchEvent({type:"cancel",params:this.params});
		}
		this.unloadThis();
	}
	function change(§\x1e\x19\x18§)
	{
		var var3 = this._winBackground.content;
		var3._btnCancel._y = var3._txtText._y + var3._txtText.height + 20;
		this._winBackground.setPreferedSize();
	}
}
