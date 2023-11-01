class ank.battlefield.datacenter.Map extends Object
{
	function Map(var2)
	{
		super();
		this.initialize(var3);
	}
	function initialize(var2)
	{
		this.id = var2;
		this.originalsCellsBackup = new ank.utils.();
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
