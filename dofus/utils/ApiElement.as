class dofus.utils.ApiElement extends Object
{
	static var _aQueue = new Array();
	function ApiElement()
	{
		super();
	}
	function __get__api()
	{
		return _global.API;
	}
	function __set__api(loc2)
	{
		this._oAPI = loc2;
		return this.__get__api();
	}
	function initialize(loc2)
	{
		this._oAPI = loc2;
	}
	function addToQueue(loc2)
	{
		dofus.utils.ApiElement._aQueue.push(loc2);
		if(_root.onEnterFrame == undefined)
		{
			_root.onEnterFrame = this.runQueue;
		}
	}
	function runQueue()
	{
		var loc2 = dofus.utils.ApiElement._aQueue.shift();
		loc2.method.apply(loc2.object,loc2.params);
		if(dofus.utils.ApiElement._aQueue.length == 0)
		{
			delete _root.onEnterFrame;
		}
	}
}
