class dofus.graphics.gapi.ui.ChallengeMenu extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "ChallengeMenu";
	static var X_OFFSET = 90;
	function ChallengeMenu()
	{
		super();
	}
	function __set__labelReady(loc2)
	{
		this._sLabelReady = loc2;
		return this.__get__labelReady();
	}
	function __set__labelCancel(loc2)
	{
		this._sLabelCancel = loc2;
		return this.__get__labelCancel();
	}
	function __set__cancelButton(loc2)
	{
		this._bCancelButton = loc2;
		this._btnCancel._visible = loc2;
		this._lblCancel._visible = loc2;
		if(!loc2)
		{
			this._mcBackground._x = this._mcBackground._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
			this._btnReady._x = this._btnReady._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
			this._lblReady._x = this._lblReady._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
			this._mcTick._x = this._mcTick._x + dofus.graphics.gapi.ui.ChallengeMenu.X_OFFSET;
		}
		return this.__get__cancelButton();
	}
	function __set__ready(loc2)
	{
		this._bReady = loc2;
		this._mcTick._visible = loc2;
		return this.__get__ready();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.ChallengeMenu.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.setLabels});
	}
	function setLabels()
	{
		this._lblReady.text = this._sLabelReady;
		if(this._bCancelButton)
		{
			this._lblCancel.text = this._sLabelCancel;
		}
	}
	function sendReadyState()
	{
		this.api.network.Game.ready(!this._bReady);
		this.ready = !this._bReady;
	}
	function sendCancel()
	{
		this.api.network.Game.leave();
	}
}
