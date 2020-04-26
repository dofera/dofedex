class dofus.graphics.gapi.controls.GuildMountParkViewer extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "GuildMountParkViewer";
	function GuildMountParkViewer()
	{
		super();
	}
	function __set__mountParks(loc2)
	{
		this.updateData(loc2);
		return this.__get__mountParks();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.controls.GuildMountParkViewer.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.initTexts});
	}
	function initTexts()
	{
		this._dgMountParks.columnsNames = [this.api.lang.getText("LOCALISATION"),this.api.lang.getText("MOUTPARK_ITEM"),this.api.lang.getText("MOUNTS")];
		this._lblDescription.text = this.api.lang.getText("GUILD_MOUNTPARKS_LIST");
	}
	function updateData(loc2)
	{
		this._lblCount.text = this.api.lang.getText("GUILD_MOUNTPARKS_COUNT",[loc2.length,this.api.datacenter.Player.guildInfos.maxMountParks]);
		loc2.sortOn("size",Array.NUMERIC | Array.DESCENDING);
		this._dgMountParks.dataProvider = loc2;
	}
}
