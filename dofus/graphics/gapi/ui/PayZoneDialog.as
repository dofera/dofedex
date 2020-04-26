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
	function __set__id(loc2)
	{
		this._nNpcID = loc2;
		return this.__get__id();
	}
	function __set__name(loc2)
	{
		this._sName = loc2;
		return this.__get__name();
	}
	function __set__gfx(loc2)
	{
		this._sGfx = loc2;
		return this.__get__gfx();
	}
	function __set__dialogID(loc2)
	{
		this._nDialogID = loc2;
		this.addToQueue({object:this,method:this.setDialog,params:[loc2]});
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
		var loc2 = this.getStyle();
	}
	function setNpcCharacteristics()
	{
		this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._sGfx + ".swf";
		this._winBackgroundUp.title = this._sName;
	}
	function setDialog(loc2)
	{
		var loc3 = new Object();
		loc3.responses = new ank.utils.();
		if((var loc0 = loc2) !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_INFOS)
		{
			if(loc0 !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_DETAILS)
			{
				loc3.label = this.api.lang.getText("PAYZONE_MSG_" + this._nDialogID) + "\n\n" + this.api.lang.getText("PAYZONE_BASE");
				loc3.responses.push({label:this.api.lang.getText("PAYZONE_MORE_INFOS"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_MORE_INFOS});
			}
			else
			{
				loc3.label = this.api.lang.getText("PAYZONE_DETAILS");
				loc3.responses.push({label:this.api.lang.getText("PAYZONE_BE_MEMBER"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_BE_MEMBER});
			}
		}
		else
		{
			loc3.label = this.api.lang.getText("PAYZONE_INFOS");
			loc3.responses.push({label:this.api.lang.getText("YES"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_YES});
			loc3.responses.push({label:this.api.lang.getText("NO"),id:dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_NO});
		}
		this.setQuestion(loc3);
	}
	function setQuestion(loc2)
	{
		if(this._qvQuestionViewer == undefined)
		{
			this.attachMovie("QuestionViewer","_qvQuestionViewer",10,{_x:this._mcQuestionViewer._x,_y:this._mcQuestionViewer._y,question:loc2,isFirstQuestion:true});
			this._qvQuestionViewer.addEventListener("response",this);
			this._qvQuestionViewer.addEventListener("resize",this);
		}
		else
		{
			this._qvQuestionViewer.isFirstQuestion = true;
			this._qvQuestionViewer.question = loc2;
		}
	}
	function closeDialog()
	{
		this.callClose();
	}
	function response(loc2)
	{
		if((var loc0 = loc2.response.id) !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_YES)
		{
			if(loc0 !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_NO)
			{
				if(loc0 !== dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_BE_MEMBER)
				{
					if(loc0 === dofus.graphics.gapi.ui.PayZoneDialog.PAYZONE_MORE_INFOS)
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
	function resize(loc2)
	{
		this._winBackground.setSize(undefined,loc2.target.height + (loc2.target._y - this._winBackground._y) + 12);
		this._winBackgroundUp.setSize(undefined,loc2.target.height + (loc2.target._y - this._winBackground._y) + 10);
	}
}
