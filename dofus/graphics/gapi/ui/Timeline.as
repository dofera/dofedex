class dofus.graphics.gapi.ui.Timeline extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "Timeline";
	static var bTimelineUpPosition = false;
	static var OPTION_BUTTONS_MOVE_DISTANCE = 40;
	static var UI_TIMELINE_MOVE_DISTANCE = 350;
	static var UI_PARTY_MOVE_DISTANCE = 39;
	function Timeline()
	{
		super();
	}
	static function __get__isTimelineUpPosition()
	{
		return dofus.graphics.gapi.ui.Timeline.bTimelineUpPosition;
	}
	function update()
	{
		this._tl.update();
	}
	function nextTurn(loc2, loc3)
	{
		this._tl.nextTurn(loc2,loc3);
	}
	function __get__timelineControl()
	{
		return this._tl;
	}
	function hideItem(loc2)
	{
		this._tl.hideItem(loc2);
	}
	function showItem(loc2)
	{
		this._tl.showItem(loc2);
	}
	function startChrono(loc2)
	{
		this._tl.startChrono(loc2);
	}
	function stopChrono()
	{
		this._tl.stopChrono();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.Timeline.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		if(dofus.graphics.gapi.ui.Timeline.bTimelineUpPosition)
		{
			this.moveTimeline(- dofus.graphics.gapi.ui.Timeline.UI_TIMELINE_MOVE_DISTANCE);
			var loc2 = this.api.ui.getUIComponent("FightOptionButtons");
			if(loc2 != undefined && loc2._btnFlag._y == 370)
			{
				loc2.moveButtons(dofus.graphics.gapi.ui.Timeline.OPTION_BUTTONS_MOVE_DISTANCE);
			}
			var loc3 = this.api.ui.getUIComponent("Party");
			if(loc3 != undefined && loc3._btnBlockJoinerExceptParty._y == 41)
			{
				loc3.moveUI(dofus.graphics.gapi.ui.Timeline.UI_PARTY_MOVE_DISTANCE);
			}
			this._btnUp._visible = false;
		}
		else
		{
			this._btnDown._visible = false;
		}
	}
	function addListeners()
	{
		this._btnUp.addEventListener("click",this);
		this._btnDown.addEventListener("click",this);
	}
	function click(loc2)
	{
		var loc3 = loc2.target._name;
		switch(loc3)
		{
			case "_btnUp":
				dofus.graphics.gapi.ui.Timeline.bTimelineUpPosition = true;
				this._btnUp._visible = false;
				this._btnDown._visible = true;
				this.moveTimeline(- dofus.graphics.gapi.ui.Timeline.UI_TIMELINE_MOVE_DISTANCE);
				this.api.ui.getUIComponent("FightOptionButtons").moveButtons(dofus.graphics.gapi.ui.Timeline.OPTION_BUTTONS_MOVE_DISTANCE);
				this.api.ui.getUIComponent("Party").moveUI(dofus.graphics.gapi.ui.Timeline.UI_PARTY_MOVE_DISTANCE);
				break;
			case "_btnDown":
				dofus.graphics.gapi.ui.Timeline.bTimelineUpPosition = false;
				this._btnUp._visible = true;
				this._btnDown._visible = false;
				this.moveTimeline(dofus.graphics.gapi.ui.Timeline.UI_TIMELINE_MOVE_DISTANCE);
				this.api.ui.getUIComponent("FightOptionButtons").moveButtons(- dofus.graphics.gapi.ui.Timeline.OPTION_BUTTONS_MOVE_DISTANCE);
				this.api.ui.getUIComponent("Party").moveUI(- dofus.graphics.gapi.ui.Timeline.UI_PARTY_MOVE_DISTANCE);
		}
	}
	function destroy()
	{
		if(dofus.graphics.gapi.ui.Timeline.bTimelineUpPosition)
		{
			var loc2 = this.api.ui.getUIComponent("FightOptionButtons");
			if(loc2 != undefined && loc2._btnFlag._y == 370 + dofus.graphics.gapi.ui.Timeline.OPTION_BUTTONS_MOVE_DISTANCE)
			{
				loc2.moveButtons(- dofus.graphics.gapi.ui.Timeline.OPTION_BUTTONS_MOVE_DISTANCE);
			}
			var loc3 = this.api.ui.getUIComponent("Party");
			if(loc3 != undefined && loc3._btnBlockJoinerExceptParty._y == 41 + dofus.graphics.gapi.ui.Timeline.UI_PARTY_MOVE_DISTANCE)
			{
				loc3.moveUI(- dofus.graphics.gapi.ui.Timeline.UI_PARTY_MOVE_DISTANCE);
			}
		}
	}
	function moveTimeline(loc2)
	{
		this._tl._y = this._tl._y + loc2;
		this._btnUp._y = this._btnUp._y + loc2;
		this._btnDown._y = this._btnDown._y + loc2;
	}
}
