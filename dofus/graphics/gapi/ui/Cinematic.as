class dofus.graphics.gapi.ui.Cinematic extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Cinematic";
	function Cinematic()
	{
		super();
	}
	function __set__file(loc2)
	{
		this._sFile = loc2;
		return this.__get__file();
	}
	function __set__sequencer(loc2)
	{
		this._oSequencer = loc2;
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
	function startCinematic(loc2)
	{
		loc2.gotoAndPlay(1);
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
	function initialization(loc2)
	{
		this._lblWhite._visible = false;
		loc2.target.content.cinematic = this;
		this.addToQueue({object:this,method:this.startCinematic,params:[loc2.target.content]});
	}
	function complete(loc2)
	{
		loc2.target.stop();
		loc2.target.content.stop();
		loc2.target.content.cinematic.stop();
	}
	function click(loc2)
	{
		if((var loc0 = loc2.target) === this._btnCancel)
		{
			this.api.kernel.showMessage(undefined,this.api.lang.getText("LEAVE_CINEMATIC"),"CAUTION_YESNO",{name:"Cinematic",listener:this});
		}
	}
	function over(loc2)
	{
		if((var loc0 = loc2.target) === this._btnCancel)
		{
			this.gapi.showTooltip(this.api.lang.getText("CANCEL_CINEMATIC"),loc2.target,-20);
		}
	}
	function out(loc2)
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
	function onSubtitle(loc2, loc3)
	{
		var loc4 = this._sFile.substring(0,this._sFile.toLowerCase().indexOf(".swf"));
		while(loc4.indexOf("/") > -1)
		{
			loc4 = loc4.substr(loc4.indexOf("/") + 1);
		}
		var loc5 = Number(loc4);
		var loc6 = this.api.lang.getSubtitle(loc5,loc3);
		if(loc6 != undefined)
		{
			loc2.text = loc6;
		}
	}
	function yes(loc2)
	{
		this.onCinematicFinished();
	}
}
