class dofus.graphics.gapi.ui.Cinematic extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Cinematic";
	function Cinematic()
	{
		super();
	}
	function __set__file(var2)
	{
		this._sFile = var2;
		return this.__get__file();
	}
	function __set__sequencer(var2)
	{
		this._oSequencer = var2;
		return this.__get__sequencer();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Cinematic.CLASS_NAME);
	}
	function destroy()
	{
		_root._quality = this._sOldQuality;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.loadFile});
	}
	function startCinematic(var2)
	{
		var2.gotoAndPlay(1);
	}
	function addListeners()
	{
		this._ldrLoader.addEventListener("initialization",this);
		this._ldrLoader.addEventListener("complete",this);
		this._btnCancel.addEventListener("click",this);
		this._btnCancel.addEventListener("over",this);
		this._btnCancel.addEventListener("out",this);
	}
	function loadFile()
	{
		this._ldrLoader.contentPath = this._sFile;
		this._sOldQuality = _root._quality;
		_root._quality = "MEDIUM";
		this._lblWhite.text = this.api.lang.getText("LOADING");
	}
	function initialization(var2)
	{
		this._lblWhite._visible = false;
		var2.target.content.cinematic = this;
		this.addToQueue({object:this,method:this.startCinematic,params:[var2.target.content]});
	}
	function complete(var2)
	{
		var2.target.stop();
		var2.target.content.stop();
		var2.target.content.cinematic.stop();
	}
	function click(var2)
	{
		if((var var0 = var2.target) === this._btnCancel)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("LEAVE_CINEMATIC"),"CAUTION_YESNO",{name:"Cinematic",listener:this});
		}
	}
	function over(var2)
	{
		if((var var0 = var2.target) === this._btnCancel)
		{
			this.gapi.showTooltip(this.api.lang.getText("CANCEL_CINEMATIC"),var2.target,-20);
		}
	}
	function out(var2)
	{
		this.gapi.hideTooltip();
	}
	function onCinematicFinished()
	{
		this.dispatchEvent({type:"cinematicFinished"});
		this._oSequencer.onActionEnd();
		_root._quality = this._sOldQuality;
		this.unloadThis();
	}
	function onSubtitle(var2, var3)
	{
		var var4 = this._sFile.substring(0,this._sFile.toLowerCase().indexOf(".swf"));
		while(var4.indexOf("/") > -1)
		{
			var4 = var4.substr(var4.indexOf("/") + 1);
		}
		var var5 = Number(var4);
		var var6 = this.api.lang.getSubtitle(var5,var3);
		if(var6 != undefined)
		{
			var2.text = var6;
		}
	}
	function yes(var2)
	{
		this.onCinematicFinished();
	}
}
