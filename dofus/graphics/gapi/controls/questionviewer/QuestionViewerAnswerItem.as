class dofus.graphics.gapi.controls.questionviewer.QuestionViewerAnswerItem extends ank.gapi.core.UIBasicComponent
{
	function QuestionViewerAnswerItem()
	{
		super();
	}
	function setValue(loc2, loc3, loc4)
	{
		if(loc2)
		{
			this._mcRound._visible = true;
			this._txtResponse.text = loc4.label;
		}
		else if(this._txtResponse.text != undefined)
		{
			this._mcRound._visible = false;
			this._txtResponse.text = "";
		}
	}
	function init()
	{
		super.init(false);
		this._mcRound._visible = false;
	}
	function size()
	{
		super.size();
	}
}
