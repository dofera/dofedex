class dofus.datacenter.Datacenter extends Object
{
	function Datacenter(loc3)
	{
		super();
		this.initialize(loc3);
	}
	function initialize(loc2)
	{
		this._oAPI = loc2;
		this.Player = new dofus.datacenter.(loc2);
		this.Basics = new dofus.datacenter.Basics();
		this.Challenges = new ank.utils.();
		this.Sprites = new ank.utils.();
		this.Houses = new ank.utils.();
		this.Storages = new ank.utils.();
		this.Game = new dofus.datacenter.Game();
		this.Conquest = new dofus.datacenter.Conquest();
		this.Subareas = new ank.utils.();
		this.Map = new dofus.datacenter.();
		this.Temporary = new Object();
	}
	function clear()
	{
		this.Player = new dofus.datacenter.(this._oAPI);
		this.Basics.initialize();
		this.Challenges = new ank.utils.();
		this.Sprites = new ank.utils.();
		this.Houses = new ank.utils.();
		this.Storages = new ank.utils.();
		this.Game = new dofus.datacenter.Game();
		this.Conquest = new dofus.datacenter.Conquest();
		this.Subareas = new ank.utils.();
		this.Map = new dofus.datacenter.();
		this.Temporary = new Object();
		delete this.Exchange;
	}
	function clearGame()
	{
		this.Game = new dofus.datacenter.Game();
	}
}
