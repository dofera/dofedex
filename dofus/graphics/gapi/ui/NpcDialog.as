class dofus.graphics.gapi.ui.NpcDialog extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "NpcDialog";
	var _bFirstQuestion = true;
	function NpcDialog()
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
	function __set__customArtwork(loc2)
	{
		this._nCustomArtwork = loc2;
		return this.__get__customArtwork();
	}
	function __set__colors(loc2)
	{
		this._aColors = loc2;
		return this.__get__colors();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.NpcDialog.CLASS_NAME);
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
		this._mcPic._visible = false;
		this._ldrArtwork.addEventListener("initialization",this);
		this._ldrArtwork.addEventListener("complete",this);
		if(this._nCustomArtwork != undefined && (!_global.isNaN(this._nCustomArtwork) && this._nCustomArtwork > 0))
		{
			this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._nCustomArtwork + ".swf";
		}
		else
		{
			this._ldrArtwork.contentPath = dofus.Constants.ARTWORKS_BIG_PATH + this._sGfx + ".swf";
		}
		this._winBackgroundUp.title = this._sName;
	}
	function setPause()
	{
		this.showElements(false);
	}
	function showElements(loc2)
	{
		this._ldrArtwork._visible = loc2;
		this._mcPic._visible = loc2;
		this._winBackground._visible = loc2;
		this._winBackgroundUp._visible = loc2;
		this._qvQuestionViewer._visible = loc2;
	}
	function setQuestion(loc2)
	{
		this._oQuestion = loc2;
		if(this._qvQuestionViewer == undefined)
		{
			this.attachMovie("QuestionViewer","_qvQuestionViewer",10,{_x:this._mcQuestionViewer._x,_y:this._mcQuestionViewer._y,question:loc2,isFirstQuestion:this._bFirstQuestion});
			this._qvQuestionViewer.addEventListener("response",this);
			this._qvQuestionViewer.addEventListener("resize",this);
		}
		else
		{
			this._qvQuestionViewer.isFirstQuestion = this._bFirstQuestion;
			this._qvQuestionViewer.question = loc2;
		}
		this.showElements(true);
	}
	function applyColor(loc2, loc3)
	{
		var loc4 = this._aColors[loc3];
		if(loc4 == -1 || loc4 == undefined)
		{
			return undefined;
		}
		var loc5 = (loc4 & 16711680) >> 16;
		var loc6 = (loc4 & 65280) >> 8;
		var loc7 = loc4 & 255;
		var loc8 = new Color(loc2);
		var loc9 = new Object();
		loc9 = {ra:0,ga:0,ba:0,rb:loc5,gb:loc6,bb:loc7};
		loc8.setTransform(loc9);
	}
	function closeDialog()
	{
		this.callClose();
	}
	function response(loc2)
	{
		if(loc2.response.id == -1)
		{
			this.api.network.Dialog.leave();
		}
		else
		{
			this.api.network.Dialog.response(this._oQuestion.id,loc2.response.id);
			this._bFirstQuestion = false;
		}
	}
	function complete(loc2)
	{
		var ref = this;
		this._ldrArtwork.content.stringCourseColor = function(loc2, loc3)
		{
			ref.applyColor(loc2,loc3);
		};
	}
	function resize(loc2)
	{
		this._winBackground.setSize(undefined,loc2.target.height + (loc2.target._y - this._winBackground._y) + 12);
		this._winBackgroundUp.setSize(undefined,loc2.target.height + (loc2.target._y - this._winBackground._y) + 10);
	}
	function initialization(loc2)
	{
		this._mcPic._visible = true;
	}
}
