class ank.utils.QueueEmbedMovieClip extends MovieClip
{
	static var _aQueue = new Array();
	static var _mcEnterFrame = _root.createEmptyMovieClip("_mcQueueEnterFrame",_root.getNextHighestDepth());
	function QueueEmbedMovieClip()
	{
		super();
	}
	function addToQueue(var2)
	{
		ank.utils.QueueEmbedMovieClip._aQueue.push(var2);
		if(ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame == undefined)
		{
			ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame = this.runQueue;
		}
	}
	function runQueue()
	{
		for(var var2 in ank.utils.QueueEmbedMovieClip._aQueue)
		{
			var2.method.apply(var2.object,var2.params);
			if(ank.utils.QueueEmbedMovieClip._aQueue.length == 0)
			{
				delete ank.utils.QueueEmbedMovieClip._mcEnterFrame.onEnterFrame;
			}
		}
	}
}
