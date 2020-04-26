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
	function click(loc2)
	{
		if((var loc0 = loc2.target._name) === "_btnCancel")
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("LEAVE_TUTORIAL"),"CAUTION_YESNO",{name:"Tutorial",listener:this});
		}
	}
	function over(loc2)
	{
		this.gapi.showTooltip(this.api.lang.getText("CANCEL_TUTORIAL"),loc2.target,-20);
	}
	function out(loc2)
	{
		this.gapi.hideTooltip();
	}
	function yes(loc2)
	{
		this.api.kernel.TutorialManager.cancel();
	}
}
