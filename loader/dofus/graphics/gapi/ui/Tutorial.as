class dofus.graphics.gapi.ui.Tutorial extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Tutorial";
	function Tutorial()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Tutorial.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
	}
	function addListeners()
	{
		this._btnCancel.addEventListener("click",this);
		this._btnCancel.addEventListener("over",this);
		this._btnCancel.addEventListener("out",this);
	}
	function click(§\x1e\x19\x18§)
	{
		if((var var0 = var2.target._name) === "_btnCancel")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("LEAVE_TUTORIAL"),"CAUTION_YESNO",{name:"Tutorial",listener:this});
		}
	}
	function over(§\x1e\x19\x18§)
	{
		this.gapi.showTooltip(this.api.lang.getText("CANCEL_TUTORIAL"),var2.target,-20);
	}
	function out(§\x1e\x19\x18§)
	{
		this.gapi.hideTooltip();
	}
	function yes(§\x1e\x19\x18§)
	{
		this.api.kernel.TutorialManager.cancel();
	}
}
