class dofus.graphics.gapi.ui.AskCancel extends ank.gapi.ui.FlyWindow
{
	static var CLASS_NAME = "AskCancel";
	function AskCancel()
	{
		super();
	}
	function __set__text(loc2)
	{
		this._sText = loc2;
		return this.__get__text();
	}
	function __get__text()
	{
		return this._sText;
	}
	function initWindowContent()
	{
		var loc2 = this._winBackground.content;
		loc2._txtText.text = this._sText;
		loc2._btnCancel.label = this.api.lang.getText("CANCEL_SMALL");
		loc2._btnCancel.addEventListener("click",this);
		loc2._txtText.addEventListener("change",this);
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target._name) === "_btnCancel")
		{
			this.dispatchEvent({type:"cancel",params:this.params});
		}
		this.unloadThis();
	}
	function change(loc2)
	{
		var loc3 = this._winBackground.content;
		loc3._btnCancel._y = loc3._txtText._y + loc3._txtText.height + 20;
		this._winBackground.setPreferedSize();
	}
}
