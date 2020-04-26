class dofus.graphics.gapi.controls.QuestionViewer extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "QuestionViewer";
	static var RESPONSE_HEIGHT = 30;
	static var QUESTION_RESPONSE_SPACE = 20;
	function QuestionViewer()
	{
		super();
	}
	function __set__question(loc2)
	{
		this._oQuestion = loc2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__question();
	}
	function __set__isFirstQuestion(loc2)
	{
		this._bFirstQuestion = loc2;
		return this.__get__isFirstQuestion();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.QuestionViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this._lstResponses._visible = false;
		this.addToQueue({object:this,method:this.addListeners});
	}
	function draw()
	{
		var loc2 = this.getStyle();
	}
	function layoutContent()
	{
		if(this._bFirstQuestion)
		{
			var loc2 = this._oQuestion.responses;
		}
		else if(this._oQuestion.responses.length == 0)
		{
			var loc3 = new ank.utils.();
			loc3.push({label:this._parent.api.lang.getText("CONTINUE_TO_SPEAK"),id:-1});
			loc2 = loc3;
		}
		else
		{
			loc2 = this._oQuestion.responses;
		}
		var loc4 = loc2.length;
		this._lstResponses.removeAll();
		this._lstResponses.setSize(undefined,dofus.graphics.gapi.controls.QuestionViewer.RESPONSE_HEIGHT * loc4);
		this.addToQueue({object:this,method:this.addResponses,params:[loc2]});
		this._txtQuestion.text = this._oQuestion.label;
	}
	function addListeners()
	{
		this._lstResponses.addEventListener("itemSelected",this);
		this._txtQuestion.addEventListener("change",this);
	}
	function addResponses(loc2)
	{
		this._lstResponses.dataProvider = loc2;
	}
	function change(loc2)
	{
		this._lstResponses._y = this._txtQuestion._y + dofus.graphics.gapi.controls.QuestionViewer.QUESTION_RESPONSE_SPACE + this._txtQuestion.height;
		this._lstResponses._visible = true;
		this.setSize(undefined,this._lstResponses._y + this._lstResponses.height);
		this.dispatchEvent({type:"resize"});
	}
	function itemSelected(loc2)
	{
		this.dispatchEvent({type:"response",response:loc2.row.item});
	}
}
