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
	function click(var2)
	{
		if((var var0 = var2.target._name) === "_btnCancel")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("LEAVE_TUTORIAL"),"CAUTION_YESNO",{name:"Tutorial",listener:this});
		}
	}
	function over(var2)
	{
		this.gapi.showTooltip(this.api.lang.getText("CANCEL_TUTORIAL"),var2.target,-20);
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function yes(var2)
	{
		this.api.kernel.TutorialManager.cancel();
	}
}
