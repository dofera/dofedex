class dofus.graphics.gapi.controls.alignmentviewer.SpecializationViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "SpecializationViewer";
	function SpecializationViewer()
	{
		super();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.alignmentviewer.SpecializationViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
	}
	function initTexts()
	{
		this._lblFeats.text = this.api.lang.getText("FEATS");
		this._lblNoSpecialization.text = this.api.lang.getText("NO_SPECIALIZATION");
	}
	function addListeners()
	{
		this.api.datacenter.Player.addEventListener("specializationChanged",this);
	}
	function initData()
	{
		this.specializationChanged({specialization:this.api.datacenter.Player.specialization});
	}
	function setFeatsFromSpecialization(loc2)
	{
		if(loc2 != undefined)
		{
			this._lblFeats.text = this.api.lang.getText("FEATS") + " (" + loc2.name + ")";
			this._lstFeats.dataProvider = loc2.feats;
		}
		else
		{
			this._lblFeats.text = this.api.lang.getText("FEATS");
			this._lstFeats.dataProvider = new ank.utils.();
		}
	}
	function specializationChanged(loc2)
	{
		this._mcTree.removeMovieClip();
		this._mcOrder.removeMovieClip();
		var loc3 = loc2.specialization;
		if(loc3 != undefined)
		{
			this._lblNoSpecialization._visible = false;
			this._lblFeats._visible = true;
			this._lstFeats._visible = true;
			this.attachMovie("AlignmentViewerTree","_mcTree",this.getNextHighestDepth(),{_x:this._mcTreePlacer._x,_y:this._mcTreePlacer._y});
			this._mcTree.addEventListener("specializationSelected",this);
			this._mcTree.addEventListener("orderSelected",this);
			this.specializationSelected();
		}
		else
		{
			this._lblNoSpecialization._visible = true;
			this._lblFeats._visible = false;
			this._lstFeats._visible = false;
		}
	}
	function specializationSelected(loc2)
	{
		this._mcOrder.removeMovieClip();
		this.setFeatsFromSpecialization(loc2.specialization);
	}
	function orderSelected(loc2)
	{
		this._mcOrder.removeMovieClip();
		this.attachMovie("AlignmentViewerOrder","_mcOrder",this.getNextHighestDepth(),{_x:this._mcOrderPlacer._x,_y:this._mcOrderPlacer._y,specialization:this.api.datacenter.Player.specialization});
	}
}
