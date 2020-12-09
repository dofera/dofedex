class dofus.graphics.gapi.controls.TaxCollectorsViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "TaxCollectorsViewer";
	function TaxCollectorsViewer()
	{
		super();
	}
	function __set__taxCollectors(§\x0f\x1a§)
	{
		this.updateData(var2);
		return this.__get__taxCollectors();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.TaxCollectorsViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
	}
	function initTexts()
	{
		this._dgTaxCollectors.columnsNames = ["",this.api.lang.getText("NAME_BIG") + " / " + this.api.lang.getText("LOCALISATION"),this.api.lang.getText("ATTACKERS_SMALL"),this.api.lang.getText("DEFENDERS")];
		this._lblDescription.text = this.api.lang.getText("GUILD_TAXCOLLECTORS_LIST");
		this._lblHowDefend.text = this.api.lang.getText("HELP_HOW_DEFEND_TAX");
	}
	function updateData(§\x0f\x1a§)
	{
		this._lblCount.text = String(var2.length) + " " + ank.utils.PatternDecoder.combine(this.api.lang.getText("TAXCOLLECTORS"),"m",var2.length < 2);
		var2.sortOn("state",Array.NUMERIC | Array.DESCENDING);
		this._dgTaxCollectors.dataProvider = var2;
	}
}
