class dofus.graphics.gapi.ui.PayZoneDialog extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PayZoneDialog";
	static var PAYZONE_INFOS = 1;
	static var PAYZONE_DETAILS = 2;
	static var PAYZONE_YES = 0;
	static var PAYZONE_NO = 1;
	static var PAYZONE_BE_MEMBER = 2;
	static var PAYZONE_MORE_INFOS = 4;
	function PayZoneDialog()
	{
		super();
	}
	function __set__id(var2)
	{
		this._nNpcID = var2;
		return this.__get__id();
	}
	function __set__name(var2)
	{
		this._sName = var2;
		return this.__get__name();
	}
	function __set__gfx(var2)
	{
		this._sGfx = var2;
		return this.__get__gfx();
	}
	function __set__dialogID(var2)
	{
		this._nDialogID = var2;
		this.addToQueue({object:this,method:this.setDialog,params:[var2]});
		return this.__get__dialogID();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.PayZoneDialog.CLASS_NAME);
	}
	function callClose()
	{
		this.api.network.Dialog.leave();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.setNpcCharacteristics});
		this.gapi.unloadLastUIAutoHideComponent();
	}
	function draw()
	{
		var var2 = this.getStyle();
	}
	function setNpcCharacteristics()
	{
		this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._sGfx + ".swf";
		this._winBackgroundUp.title = this._sName;
	}
	function setDialog(var2)
	{
		var var3 = new Object();
		var3.responses = new ank.utils.();
		if((var var0 = var2) !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_INFOS)
		{
			if(var0 !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS)
			{
				var3.label = this.api.lang.getText("PAYZONE_MSG_" + this._nDialogID) + "\n\n" + this.api.lang.getText("PAYZONE_BASE");
				var3.responses.push({label:this.api.lang.getText("PAYZONE_MORE_INFOS"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_MORE_INFOS});
			}
			else
			{
				var3.label = this.api.lang.getText("PAYZONE_DETAILS");
				var3.responses.push({label:this.api.lang.getText("PAYZONE_BE_MEMBER"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_BE_MEMBER});
			}
		}
		else
		{
			var3.label = this.api.lang.getText("PAYZONE_INFOS");
			var3.responses.push({label:this.api.lang.getText("YES"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_YES});
			var3.responses.push({label:this.api.lang.getText("NO"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_NO});
		}
		this.setQuestion(var3);
	}
	function setQuestion(var2)
	{
		if(this._qvQuestionViewer == undefined)
		{
			this.attachMovie("QuestionViewer","_qvQuestionViewer",10,{_x:this._mcQuestionViewer._x,_y:this._mcQuestionViewer._y,question:var2,isFirstQuestion:true});
			this._qvQuestionViewer.addEventListener("response",this);
			this._qvQuestionViewer.addEventListener("resize",this);
		}
		else
		{
			this._qvQuestionViewer.isFirstQuestion = true;
			this._qvQuestionViewer.question = var2;
		}
	}
	function closeDialog()
	{
		this.callClose();
	}
	function response(var2)
	{
		if((var var0 = var2.response.id) !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_YES)
		{
			if(var0 !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_NO)
			{
				if(var0 !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_BE_MEMBER)
				{
					if(var0 === dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_MORE_INFOS)
					{
						this.getURL(this.api.lang.getConfigText("MEMBERS_LINK"),"_blank");
						this.unloadThis();
					}
				}
				else
				{
					this.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
					this.unloadThis();
				}
			}
			else
			{
				this.unloadThis();
			}
		}
		else
		{
			this.setDialog(dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS);
		}
	}
	function resize(var2)
	{
		this._winBackground.setSize(undefined,var2.target.height + (var2.target._y - this._winBackground._y) + 12);
		this._winBackgroundUp.setSize(undefined,var2.target.height + (var2.target._y - this._winBackground._y) + 10);
	}
}
