class ank.battlefield.datacenter.Map extends Object
{
	function Map(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function initialize(loc2)
	{
		this.id = loc2;
		this.originalsCellsBackup = new ank.utils.();
	}
	function cleanSpritesOn()
	{
		if(this.data != undefined)
		{
			for(var k in this.data)
			{
				this.data[k].removeAllSpritesOnID();
			}
		}
	}
}
