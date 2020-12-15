class dofus.graphics.gapi.controls.QuestionViewer extends ank.gapi.core.UIBasicComponent
{
	static var CLASS_NAME = "QuestionViewer";
	static var RESPONSE_HEIGHT = 30;
	static var QUESTION_RESPONSE_SPACE = 20;
	function QuestionViewer()
	{
		super();
	}
	function __set__question(var2)
	{
		this._oQuestion = var2;
		this.addToQueue({object:this,method:this.layoutContent});
		return this.__get__question();
	}
	function __set__isFirstQuestion(var2)
	{
		this._bFirstQuestion = var2;
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
		var var2 = this.getStyle();
	}
	function layoutContent()
	{
		if(this._bFirstQuestion)
		{
			var var2 = this._oQuestion.responses;
		}
		else if(this._oQuestion.responses.length == 0)
		{
			var var3 = new ank.utils.();
			var3.push({label:this._parent.api.lang.getText("CONTINUE_TO_SPEAK"),id:-1});
			var2 = var3;
		}
		else
		{
			var2 = this._oQuestion.responses;
		}
		var var4 = var2.length;
		this._lstResponses.removeAll();
		this._lstResponses.setSize(undefined,dofus.graphics.gapi.controls.QuestionViewer.RESPONSE_HEIGHT * var4);
		this.addToQueue({object:this,method:this.addResponses,params:[var2]});
		this._txtQuestion.text = this._oQuestion.label;
	}
	function addListeners()
	{
		this._lstResponses.addEventListener("itemSelected",this);
		this._txtQuestion.addEventListener("change",this);
	}
	function addResponses(var2)
	{
		this._lstResponses.dataProvider = var2;
	}
	function change(var2)
	{
		this._lstResponses._y = this._txtQuestion._y + dofus.graphics.gapi.controls.QuestionViewer.QUESTION_RESPONSE_SPACE + this._txtQuestion.height;
		this._lstResponses._visible = true;
		this.setSize(undefined,this._lstResponses._y + this._lstResponses.height);
		this.dispatchEvent({type:"resize"});
	}
	function itemSelected(var2)
	{
		this.dispatchEvent({type:"response",response:var2.row.item});
	}
}
