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
	function __set__api(var2)
	{
		this._oAPI = var2;
		return this.__get__api();
	}
	function initialize(var2)
	{
		this._oAPI = var2;
	}
	function addToQueue(var2)
	{
		dofus.utils.ApiElement._aQueue.push(var2);
		if(_root.onEnterFrame == undefined)
		{
			_root.onEnterFrame = this.runQueue;
		}
	}
	function runQueue()
	{
		var var2 = dofus.utils.ApiElement._aQueue.shift();
		var2.method.apply(var2.object,var2.params);
		if(dofus.utils.ApiElement._aQueue.length == 0)
		{
			delete _root.onEnterFrame;
		}
	}
}
