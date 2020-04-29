class dofus.graphics.gapi.ui.NpcDialog extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "NpcDialog";
	var _bFirstQuestion = true;
	function NpcDialog()
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
	function __set__customArtwork(var2)
	{
		this._nCustomArtwork = var2;
		return this.__get__customArtwork();
	}
	function __set__colors(var2)
	{
		this._aColors = var2;
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
		var var2 = this.getStyle();
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
	function showElements(var2)
	{
		this._ldrArtwork._visible = var2;
		this._mcPic._visible = var2;
		this._winBackground._visible = var2;
		this._winBackgroundUp._visible = var2;
		this._qvQuestionViewer._visible = var2;
	}
	function setQuestion(var2)
	{
		this._oQuestion = var2;
		if(this._qvQuestionViewer == undefined)
		{
			this.attachMovie("QuestionViewer","_qvQuestionViewer",10,{_x:this._mcQuestionViewer._x,_y:this._mcQuestionViewer._y,question:var2,isFirstQuestion:this._bFirstQuestion});
			this._qvQuestionViewer.addEventListener("response",this);
			this._qvQuestionViewer.addEventListener("resize",this);
		}
		else
		{
			this._qvQuestionViewer.isFirstQuestion = this._bFirstQuestion;
			this._qvQuestionViewer.question = var2;
		}
		this.showElements(true);
	}
	function applyColor(var2, var3)
	{
		var var4 = this._aColors[var3];
		if(var4 == -1 || var4 == undefined)
		{
			return undefined;
		}
		var var5 = (var4 & 16711680) >> 16;
		var var6 = (var4 & 65280) >> 8;
		var var7 = var4 & 255;
		var var8 = new Color(var2);
		var var9 = new Object();
		var9 = {ra:0,ga:0,ba:0,rb:var5,gb:var6,bb:var7};
		var8.setTransform(var9);
	}
	function closeDialog()
	{
		this.callClose();
	}
	function response(var2)
	{
		if(var2.response.id == -1)
		{
			this.api.network.Dialog.leave();
		}
		else
		{
			this.api.network.Dialog.response(this._oQuestion.id,var2.response.id);
			this._bFirstQuestion = false;
		}
	}
	function complete(var2)
	{
		this._ldrArtwork.content.stringCourseColor = function(var2, var3)
		{
			ref.applyColor(var2,var3);
		};
	}
	function resize(var2)
	{
		this._winBackground.setSize(undefined,var2.target.height + (var2.target._y - this._winBackground._y) + 12);
		this._winBackgroundUp.setSize(undefined,var2.target.height + (var2.target._y - this._winBackground._y) + 10);
	}
	function initialization(var2)
	{
		this._mcPic._visible = true;
	}
}
